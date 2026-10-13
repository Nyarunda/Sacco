Report 50515 "Generate CRB Submission"
{

    ProcessingOnly = true;

    dataset
    {
        dataitem("CRBSubmissionHeader"; "CRB Submission Header")
        {

            dataitem(Loans; Loans)
            {
                DataItemTableView = where(Posted = filter(= true), Installments = filter(> 0), "Approved Amount" = filter(> 0));
                RequestFilterFields = "Last Principal Pay Date", "Loan No.", "Member No.", "Loan Product Type", "Disbursement Date";

                column(ReportForNavId_1; 1)
                {
                }

                trigger OnAfterGetRecord()
                var
                    d: Integer;
                    m: Integer;
                    y: Integer;
                    MailManagement: codeunit "Mail Management";
                    DimVal: Record "Dimension Value";
                    Source: Record "Source Account Transfer";
                    Destination: Record "Destination Account Transfers";
                    ATHeader: Record "Account Transfers";
                    Legacy: Codeunit Legacy;
                    CLedger: Record "Detailed Cust. Ledg. Entry";
                begin
                    if Loans."Loan Product Type" = 'L99' then
                        CurrReport.skip;

                    CurrentRecordNo += 1;


                    if CurrentRecordNo = 1 then begin
                        Bat := 1;
                        batCounter := 1;
                    end;



                    Loans.CalcFields(Loans."Outstanding Principal", "Schedule Principal", "Last Principal Pay Date");

                    if Loans."Outstanding Principal" < 0 then
                        Loans."Outstanding Principal" := 0;

                    if CRBType = CRBType::ClosureHeader then begin

                        if (Loans."Outstanding Principal" < 1) then begin

                            if not loans."Recovered from Savings" then begin

                                Destination.reset;
                                Destination.SetRange("Destination Loan No.", Loans."Loan No.");
                                if Destination.FindFirst() then begin
                                    Source.Reset();
                                    Source.SetRange("No.", Destination."No.");
                                    Source.SetRange("Member No.", Loans."Member No.");
                                    Source.SetRange("Source Account No.", Legacy.GetDepositAccounts(Loans."Member No."));
                                    if Source.FindFirst() then begin
                                        if ATHeader.get(Source."No.") then begin
                                            if ATHeader.Posted then begin
                                                Loans."Recovered from Savings" := true;
                                                Loans.Modify();
                                                Commit();
                                            end;
                                        end;
                                    end
                                end;

                            end;
                        end;


                        if loans."Recovered from Savings" then
                            CurrReport.skip;
                        if loans."Recovered from Guarantors" then
                            CurrReport.skip;
                        if (Loans."Outstanding Principal" >= 1) then
                            CurrReport.Skip();



                    end
                    else begin

                    end;


                    if (CRBType <> CRBType::ClosureHeader) and (Loans."Outstanding Principal" < 1) then begin

                        CurrReport.Skip;
                    end;
                    begin

                        if "Disbursement Date" = 0D then
                            "Disbursement Date" := Loans."Application Date";

                        CurrRep := 0;
                        SchRep := Loans."Schedule Principal";
                        MRepay := 0;
                        PRepay := 0;

                        CurrRep := ROUND((Loans."Approved Amount") - Loans."Outstanding Principal", 1, '=');

                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Loans."Member No.");
                        Cust.SetRange(Type, Cust.TYpe::Member);
                        if Cust.Find('-') then begin
                            NoLine := NoLine + 1;

                            if CRBSubmissionHeader.Category <> Cust."Account Category" then
                                CurrReport.Skip();

                            if Cust."Account Category" = Cust."Account Category"::Individual then
                                AddEntry(Cust."No.", Loans."Member Name")

                            else if Cust."Account Category" = Cust."Account Category"::Business then
                                AddEntry(Cust."No.", Loans."Member Name")
                            else begin

                                signatories.reset;
                                signatories.setrange(code, cust."No.");
                                signatories.SetFilter("Member No.", '<>%1', '');
                                if signatories.FindFirst() then begin
                                    repeat
                                        if Cust.get(signatories."Member No.") then
                                            AddEntry(Cust."No.", Loans."Member Name")
                                        else
                                            AddNonMemberEntry(signatories."ID No.", signatories.Name, signatories."ID No.", signatories."Phone No.", signatories."Date Of Birth");

                                    until signatories.next = 0;
                                end;
                            end;

                        end;



                    end;

                    dWindow.Update(2, CurrentRecordNo);
                    dWindow.Update(3, NoOfRecords);
                    dWindow.Update(1, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));

                end;


                trigger OnPostDataItem()
                begin

                    dWindow.Close;
                    Message('Completed');
                end;

                trigger OnPreDataItem()
                begin

                    CRBA.SetRange(HeaderNo, Header);
                    CRBA.DeleteAll;

                    if AsatDate = 0D then
                        AsatDate := Today;

                    dWindow.Open('Generating Entries:     @1@@@@@@@@@\'
                                                + 'Counter   #2#########'
                                                + 'Total     #3#########'
                                                + 'Press Esc to abort');



                    Loans.SetFilter(Loans."Date Filter", '..%1', AsatDate);

                    if LoanFilter <> '' then
                        Loans.SetRange("Loan No.", LoanFilter);
                    if MemberNoFilter <> '' then
                        Loans.SetRange("Member No.", MemberNoFilter);

                    if RepDateFilter <> '' then
                        Loans.Setfilter("Last Principal Pay Date", RepDateFilter);

                    if CRBType = CRBType::ClosureHeader then begin
                        Loans.SetRange(Posted, true);
                        Loans.SetFilter("Last Principal Pay Date", CompletionDateFilter);
                        Loans.setfilter("Outstanding Principal", '<1');
                    end
                    else if CRBType = CRBType::Update then begin
                        Loans.SetRange(Posted, true);
                        Loans.SetFilter("Last Principal Pay Date", CompletionDateFilter);
                        Loans.setfilter("Outstanding Principal", '>=1');
                    end
                    else
                        Loans.setfilter("Outstanding Principal", '>=1');


                    NoOfRecords := Loans.Count;

                    GoLiveDate := Dmy2date(5, 8, 2018);
                end;
            }



            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                SDate: Date;
                EDate: Date;
            begin
                Header := CRBSubmissionHeader."Entry No.";
                CRBType := CRBSubmissionHeader.Type;
                SDate := CRBSubmissionHeader."Repayment Start Date";
                EDate := CRBSubmissionHeader."Repayment End Date";
                RepDateFilter := '';
                If (SDate <> 0D) and (EDate <> 0D) then
                    RepDateFilter := Format(SDate) + '..' + format(EDAte);
                If (SDate = 0D) and (EDate <> 0D) then
                    RepDateFilter := '..' + format(EDAte);
                If (SDate <> 0D) and (EDate = 0D) then
                    RepDateFilter := Format(SDate) + '..';

                CompletionDateFilter := '';
                If (CRBSubmissionHeader.Type = CRBSubmissionHeader.Type::Closure) then
                    CompletionDateFilter := Format(CRBSubmissionHeader."Completion Start Date") + '..' + format(CRBSubmissionHeader."Completion End Date");


                Loanfilter := CRBSubmissionHeader."Loan No. Filter";
                MemberNoFilter := CRBSubmissionHeader."Member No. Filter";
                LoanProductFilter := CRBSubmissionHeader."Loan Product Filter";

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("As At "; AsatDate)
                {
                    ApplicationArea = Basic;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }



    var
        DF: DateFormula;
        signatories: Record "Account Signatories.";
        bat: Integer;
        batCounter: Integer;
        RepDateFilter: Text;
        CompletionDateFilter: Text;
        LoanFilter: Text;
        LoanProductFilter: Text;
        MemberNoFilter: Text;

        CRBType: Option Normal,Update,ClosureHeader;
        Header: integer;
        CRBA: Record "CRB Monthly Submission CE";
        AsatDate: Date;
        CurrRep: Decimal;
        SchRep: Decimal;
        MRepay: Decimal;
        PRepay: Decimal;
        LoanType: Record "Product Setup";
        Cust: Record Members;
        NoLine: Integer;
        EMPLOYER: Record Customer;
        MyString: Text;
        String1: Text;
        String2: Text;
        String3: Text;
        String4: Text;
        String5: Text;
        DateFor: Text;
        Day: Integer;
        Month: Integer;
        Year: Integer;
        m: Text;
        d: Text;
        RSchedule: Record "Loan Repayment Schedule";
        ExpAmount: Decimal;
        OverDDate: Date;
        ToDate: Text;
        DateFilter: Text;
        LoansR: Record Loans;
        LGuar: Record "Loan Security";
        Member: Record Customer;
        SaccoActivities: Codeunit "Sacco Activities";
        AmtDefaulted: Decimal;
        UserSetup: Record "User Setup";
        ExpectedAmt: Decimal;
        AmtPaid: Decimal;
        DefAmount: Decimal;
        DaysInArrear: Integer;
        ArrearsDate: Date;

        //LoanProcess: Codeunit ;
        CompInfo: Record "Company Information";
        DefInst: Integer;
        AmtDef: Decimal;
        dWindow: Dialog;
        NoOfRecords: Integer;
        CurrentRecordNo: Integer;
        TestD: Integer;
        GoLiveDate: Date;
        CLedger: Record "Detailed Cust. Ledg. Entry";
        LastPayDate: Date;
        LastPayAmt: Decimal;


    procedure AddEntry(MNo: Code[20]; BizName: Text[100])
    var
        myInt: Integer;

        d: Integer;
        m: Integer;
        y: Integer;
        MailManagement: codeunit "Mail Management";
        DimVal: Record "Dimension Value";
        Source: Record "Source Account Transfer";
        Destination: Record "Destination Account Transfers";
        ATHeader: Record "Account Transfers";
        Legacy: Codeunit Legacy;
        CLedger: Record "Credit Ledger Entry";
    begin

        Cust.Reset;
        Cust.SetRange(Cust."No.", MNo);
        Cust.SetRange(Type, Cust.TYpe::Member);
        if Cust.Find('-') then begin
            NoLine := NoLine + 1;

            CRBA.Init;

            CRBA."entryno" := CreateGuid();

            CRBA.Batch_No := bat;

            if batCounter > 20000 then begin
                batCounter := 0;
                bat := bat + 1;
            end;
            //Message('bat: %1', bat);
            batCounter += 1;

            MyString := Cust.Name;
            String1 := '';
            String2 := '';
            String3 := '';
            String4 := '';
            String5 := '';

            String1 := Token(MyString, ' ');
            String2 := Token(MyString, ' ');
            String3 := Token(MyString, ' ');
            String4 := Token(MyString, ' ');
            String5 := Token(MyString, ' ');

            CRBA.forename1 := Cust."First Name";
            CRBA.forename2 := Cust."Middle Name";
            CRBA.surname := Cust.Surname;
            if CRBA.surname = '' then
                CRBA.surname := Cust."Middle Name";

            CRBA.dob := SetCRBDate(DMY2Date(01, 01, 1980), true);
            if Cust."Date of Birth" <> 0D then
                CRBA.dob := SetCRBDate(Cust."Date of Birth", true);
            //CRBA.update_date_of_birth := SetCRBDate(Cust."Date of Birth", false);

            //CRBA.client_code := Cust."No.";
            CRBA.account_number := Loans."Loan No.";
            if Cust.Gender <> Cust.Gender::"  " then
                CRBA.gender := CopyStr(Format(Cust.Gender), 1, 1);

            CRBA.nationality := 'KE';

            //CRBA.pin_number := Cust."KRA PIN";

            if Cust."Marital Status" = Cust."marital status"::" " then
                CRBA.marital_status := 'S'
            else
                CRBA.marital_status := CopyStr(Format(Cust."Marital Status"), 1, 1);

            CRBA.client_number := Cust."No.";
            CRBA.primary_id_doc_type := '001';
            CRBA.primary_id_doc_no := Cust."ID No.";
            if Cust."Passport" <> '' then begin
                CRBA.secondary_id_doc_type := '002';
                CRBA.secondary_id_doc_no := Cust."Passport";
            end;

            IF COPYSTR(Cust."Mobile Phone No.", 1, 1) = '+' THEN
                CRBA.mobile_telephone_number := COPYSTR(Cust."Mobile Phone No.", 2, STRLEN(Cust."Mobile Phone No."))
            ELSE
                CRBA.mobile_telephone_number := Cust."Mobile Phone No.";


            IF Cust."Account Category" = Cust."Account Category"::Joint THEN
                CRBA.account_indicator := 'J'
            ELSE
                CRBA.account_indicator := 'S';


            //CRBA.work_telephone_number := Cust."Phone Number 2";
            CRBA.postal_address1 := Cust."Address";
            CRBA.postal_address2 := '';
            CRBA.postal_location_town := Cust.City;
            CRBA.postal_location_country := 'KE';
            CRBA.post_code := Cust."Post Code";
            CRBA.physical_address1 := CRBA.postal_address1;
            CRBA.physical_address2 := '';
            CRBA.location_town := '';
            CRBA.location_country := 'KE';
            CRBA.date_at_physical_address := '';

            if CheckValidEmailAddress(Cust."E-Mail") then
                CRBA.consumer_email := Cust."E-Mail";


            if EMPLOYER.Get(Cust."Employer Code") then
                CRBA.employer_name := EMPLOYER.Name;
            CRBA.employment_type := '';
            CRBA.industry_type := '011';
            if EMPLOYER."CRB Employer Industry Type" <> '' then
                CRBA.industry_type := EMPLOYER."CRB Employer Industry Type";

            if Cust.Type = Cust.Type::Member then
                CRBA.account_product_type := 'S'
            else
                CRBA.account_product_type := '';

            MRepay := Loans."Loan Principle Repayment";

            if MRepay = 0 then
                MRepay := GetInitialRepayment(Loans, true);

            if MRepay = 0 then begin
                RSchedule.Reset;
                RSchedule.SetRange(RSchedule."Loan No.", Loans."Loan No.");
                RSchedule.SetFilter("Monthly Principal", '>0');
                if RSchedule.Find('-') then
                    MRepay := ROUND(RSchedule."Monthly Principal", 0.01, '=');
            end;

            DefInst := 0;
            AmtDef := 0;
            ExpectedAmt := 0;
            AmtPaid := 0;
            DefAmount := 0;
            DaysInArrear := 0;
            ArrearsDate := 0D;


            SaccoActivities.GetDefaultedAmount(Loans."Loan No.", AsatDate, ExpectedAmt, AmtPaid, DefAmount, DaysInArrear, ArrearsDate, true, DF);
            if ArrearsDate > AsatDate then begin
                ArrearsDate := 0D;
                DefAmount := 0;
            end;
            if DefAmount > Loans."Outstanding Principal" then
                DefAmount := loans."Outstanding Principal";


            CRBA.Prudential_Risk_Classification := 'A';


            CRBA.performing_npl_indicator := 'A';

            if DefAmount > 1 then begin
                CRBA.performing_npl_indicator := 'B';
                CRBA.overdue_balance := SetCRBAmount(DefAmount, true);

                CRBA.overdue_date := SetCRBDate(ArrearsDate, true);
                //CRBA.update_overdue_balance := SetCRBAmount(AmtDef, false);


                RSchedule.Reset();
                RSchedule.SetRange("Loan No.", Loans."Loan No.");
                RSchedule.SetFilter("Repayment Date", '>=%1', ArrearsDate);
                if RSchedule.FindFirst() then begin
                    CRBA.installment_arrears := format(RSchedule.Count);
                end
                else begin
                    CRBA.installment_arrears := format(round(DaysInArrear / 30, 1, '>'));
                end;

                CRBA.days_arrears := DaysInArrear;


                IF DaysInArrear <= 30 THEN
                    CRBA.Prudential_Risk_Classification := 'A';
                IF (DaysInArrear > 30) AND (DaysInArrear <= 90) THEN
                    CRBA.Prudential_Risk_Classification := 'B';
                IF (DaysInArrear > 90) AND (DaysInArrear <= 180) THEN
                    CRBA.Prudential_Risk_Classification := 'C';
                IF (DaysInArrear > 180) AND (DaysInArrear <= 360) THEN
                    CRBA.Prudential_Risk_Classification := 'D';
                IF (DaysInArrear > 360) THEN
                    CRBA.Prudential_Risk_Classification := 'E';

            end
            else begin
                CRBA.overdue_balance := '0';
                CRBA.installment_arrears := '0';
                //CRBA.update_overdue_balance := '';
            end;





            //CRBA.scheduled_payment := SetCRBAmount(SchRep, true);
            //CRBA.update_scheduled_payment := SetCRBAmount(SchRep, false);
            //CRBA.amount_paid := SetCRBAmount(CurrRep, true);
            //CRBA.update_amount_paid := SetCRBAmount(CurrRep, false);


            CRBA.account_product_type := LoanType."CRB Product Code";

            IF CRBA.account_product_type = '' THEN
                CRBA.account_product_type := 'H';

            CRBA.date_account_opened := SetCRBDate(Loans."Disbursement Date", true);

            if DefAmount > 1 then begin
                RSchedule.Reset();
                RSchedule.SetRange("Loan No.", Loans."Loan No.");
                RSchedule.SetFilter("Repayment Date", '>=%1', ArrearsDate);
                if RSchedule.FindFirst() then begin
                    if RSchedule."Repayment Date" < AsatDate then
                        CRBA.installment_due_date := SetCRBDate(RSchedule."Repayment Date", true)
                    else
                        CRBA.installment_due_date := SetCRBDate(ArrearsDate, true);
                end
                else begin

                    RSchedule.Reset();
                    RSchedule.SetRange("Loan No.", Loans."Loan No.");
                    RSchedule.SetFilter("Repayment Date", '<%1', ArrearsDate);
                    if RSchedule.FindLast() then begin

                        CRBA.installment_due_date := SetCRBDate(RSchedule."Repayment Date", true);
                    end
                    else
                        CRBA.installment_due_date := SetCRBDate(ArrearsDate, true);

                end;

            end
            else begin

                RSchedule.Reset();
                RSchedule.SetRange("Loan No.", Loans."Loan No.");
                RSchedule.SetFilter("Repayment Date", '>%1', AsatDate);
                if RSchedule.FindFirst() then begin

                    CRBA.installment_due_date := SetCRBDate(RSchedule."Repayment Date", true);
                end;
            end;
            if CRBA.installment_due_date = '' then begin
                d := Date2dmy(Loans."Disbursement Date", 1);
                TestD := Date2dmy(CalcDate('1M+CM', AsatDate), 1);
                if d > TestD then
                    d := TestD;
                m := Date2dmy(CalcDate('1M', AsatDate), 2);
                y := Date2dmy(CalcDate('1M', AsatDate), 3);
                CRBA.installment_due_date := SetCRBDate(Dmy2date(d, m, y), true)
            end;

            CRBA.original_amount := SetCRBAmount(Loans."Approved Amount", true);

            CRBA.currency_facility := 'KES';
            CRBA.original_amount := SetCRBAmount(Loans."Approved Amount", true);
            CRBA.current_balance := SetCRBAmount(Loans."Outstanding principal", true);

            CRBA.current_balance_kes := SetCRBAmount(Loans."Outstanding principal", true);

            CompInfo.Get;

            CRBA.lenders_registered_name := CompInfo.Name;
            CRBA.lenders_trading_name := CompInfo.Name;
            CRBA.lenders_branch_name := 'PORTS SACCO HQ';
            CRBA.lenders_branch_code := 'N591001';
            if DimVal.get('BRANCH', Cust."Global Dimension 2 Code") then Begin
                IF DimVal."CRB Code" <> '' then
                    CRBA.lenders_branch_code := DimVal."CRB Code";
            End;


            CRBA.account_status := 'F';

            if Loans."Last Principal Pay Date" < CalcDate('-6M', AsatDate) then
                CRBA.account_status := 'B';

            if (Loans."Outstanding Principal" <= 0)
                and (Loans."Last Principal Pay Date" < CalcDate(Format(Loans.Installments) + 'M', Loans."Disbursement Date")) then
                CRBA.account_status := 'H';

            if (Loans."Outstanding Principal" < 1) then
                CRBA.account_status := 'I';

            if Cust."Member Status" = Cust."Member Status"::Deceased then
                CRBA.account_status := 'L';

            CRBA.repayment_period := Format(Loans.Installments);
            CRBA.payment_frequency := CopyStr(Format(Loans."Repayment Frequency"), 1, 1);

            CRBA.disbursement_date := SetCRBDate(Loans."Disbursement Date", true);
            CRBA.installment_amount := SetCRBAmount(MRepay, true);
            CRBA.latest_payment_amount := '';
            if Loans."Last Principal Pay Date" <> 0D then begin
                CRBA.latest_payment_date := SetCRBDate(Loans."Last Principal Pay Date", true);
                //CRBA.update_date_of_last_payment := SetCRBDate(Loans."Last Principal Pay Date", false);

                Loans.CalcFields(Loans."Last Principal Pay Date");
                Evaluate(ToDate, Format(Loans."Last Principal Pay Date"));
                DateFilter := ToDate;
                CLedger.Reset;
                CLedger.SetRange(CLedger."Loan No.", Loans."Loan No.");
                CLedger.SetFilter(CLedger."Posting Date", DateFilter);
                CLedger.SetRange("Transaction Type", CLedger."Transaction Type"::"Principal Repayment");
                CLedger.SetFilter("Amount (LCY)", '<0');
                if CLedger.Find('-') then begin
                    CLedger.CalcSums("Amount (LCY)");
                    CRBA.latest_payment_amount := SetCRBAmount(CLedger."Amount (LCY)" * -1, true);
                end
            end;
            if CRBA.latest_payment_amount = '' then begin

                CRBA.latest_payment_amount := SetCRBAmount(0, true);
                CRBA.latest_payment_date := '';
            end;


            CRBA.security_type := 'S';

            CRBA.headerno := Header;

            CRBA.account_status_date := SetCRBDate(AsatDate, true);

            //Business Accounts
            CRBA.account_holder_type := '';
            CRBA.annual_turnover_band := '';
            CRBA.company_type := cust."CRB Company Type";
            CRBA.country := CRBA.location_country;
            CRBA.industry_code := Cust."CRB Industry Code";
            CRBA.main_telephone_number := CRBA.mobile_telephone_number;
            CRBA.number_of_shares := '';
            CRBA.other_telephone_number := '';
            CRBA.physical_location_country := CRBA.location_country;
            CRBA.physical_location_town := CRBA.location_town;
            CRBA.previous_registration_number := '';
            CRBA.registered_name := Cust.Name;
            CRBA.registration_date := SetCRBDate(Cust."Date of Bus. Reg.", true);
            CRBA.registration_number := cust."Business Reg. No.";
            CRBA.town := CRBA.location_town;
            CRBA.trading_name := Cust.Name + ' ' + BizName;
            CRBA.trading_status := '002';
            CRBA.trading_status_date := SetCRBDate(today, true);

            CRBA.vat_number := Cust."KRA PIN";


            CRBA.Insert;

            /*LGuar.Reset;
            LGuar.SetRange(LGuar."Loan No.", "Loan No.");
            LGuar.SetRange("Guarantor Type", LGuar."guarantor type"::Guarantor);
            LGuar.SetRange(LGuar.Substituted, false);
            if LGuar.Find('-') then begin
                repeat
                //if Member.Get(LGuar."Member No") then
                //InsertGuarantor(Member, Loans."Member No.", "Loan No.");
                until LGuar.Next = 0;
            end;
            */

        end;


    end;




    procedure AddNonMemberEntry(MNo: Code[20]; MName: Text[100]; IdNo: Text[100]; MobileNo: Text[100]; DOB: Date)
    var
        myInt: Integer;

        d: Integer;
        m: Integer;
        y: Integer;
        MailManagement: codeunit "Mail Management";
        DimVal: Record "Dimension Value";
        Source: Record "Source Account Transfer";
        Destination: Record "Destination Account Transfers";
        ATHeader: Record "Account Transfers";
        Legacy: Codeunit Legacy;
        CLedger: Record "Credit Ledger Entry";
    begin

        NoLine := NoLine + 1;

        CRBA.Init;

        CRBA."entryno" := CreateGuid();

        CRBA.Batch_No := bat;

        if batCounter > 20000 then begin
            batCounter := 0;
            bat := bat + 1;
        end;
        //Message('bat: %1', bat);
        batCounter += 1;

        MyString := MName;
        String1 := '';
        String2 := '';
        String3 := '';
        String4 := '';
        String5 := '';

        String1 := Token(MyString, ' ');
        String2 := Token(MyString, ' ');
        String3 := Token(MyString, ' ');
        String4 := Token(MyString, ' ');
        String5 := Token(MyString, ' ');

        CRBA.forename1 := String1;
        CRBA.forename2 := String2;
        CRBA.surname := String3;

        CRBA.dob := SetCRBDate(DMY2Date(01, 01, 1980), true);
        if DOB <> 0D then
            CRBA.dob := SetCRBDate(DOB, true);

        CRBA.account_number := Loans."Loan No.";
        //if Cust.Gender <> Cust.Gender::"  " then
        //CRBA.gender := CopyStr(Format(Cust.Gender), 1, 1);

        CRBA.nationality := 'KE';

        //CRBA.pin_number := Cust."KRA PIN";

        //if Cust."Marital Status" = Cust."marital status"::" " then
        //CRBA.marital_status := 'S'
        //else
        //CRBA.marital_status := CopyStr(Format(Cust."Marital Status"), 1, 1);

        CRBA.client_number := IDno;
        CRBA.primary_id_doc_type := '001';
        CRBA.primary_id_doc_no := IDno;

        //if Cust."Passport" <> '' then begin
        //CRBA.secondary_id_doc_type := '002';
        //CRBA.secondary_id_doc_no := Cust."Passport";
        //end;

        IF COPYSTR(MobileNo, 1, 1) = '+' THEN
            CRBA.mobile_telephone_number := COPYSTR(MobileNo, 2, STRLEN(MobileNo))
        ELSE
            CRBA.mobile_telephone_number := MobileNo;


        CRBA.account_indicator := 'J';


        //CRBA.work_telephone_number := Cust."Phone Number 2";
        CRBA.postal_address1 := '';
        CRBA.postal_address2 := '';
        CRBA.postal_location_town := '';
        CRBA.postal_location_country := 'KE';
        CRBA.post_code := '';
        CRBA.physical_address1 := '';
        CRBA.physical_address2 := '';
        CRBA.location_town := '';
        CRBA.location_country := 'KE';
        CRBA.date_at_physical_address := '';

        //if CheckValidEmailAddress(Cust."E-Mail") then
        //CRBA.consumer_email := Cust."E-Mail";


        //if EMPLOYER.Get(Cust."Employer Code") then
        //CRBA.employer_name := EMPLOYER.Name;
        CRBA.employment_type := '';
        CRBA.industry_type := '011';
        //if EMPLOYER."CRB Employer Industry Type" <> '' then
        //CRBA.industry_type := EMPLOYER."CRB Employer Industry Type";

        CRBA.account_product_type := '';

        MRepay := Loans."Loan Principle Repayment";

        if MRepay = 0 then
            MRepay := GetInitialRepayment(Loans, true);

        if MRepay = 0 then begin
            RSchedule.Reset;
            RSchedule.SetRange(RSchedule."Loan No.", Loans."Loan No.");
            RSchedule.SetFilter("Monthly Principal", '>0');
            if RSchedule.Find('-') then
                MRepay := ROUND(RSchedule."Monthly Principal", 0.01, '=');
        end;

        DefInst := 0;
        AmtDef := 0;
        ExpectedAmt := 0;
        AmtPaid := 0;
        DefAmount := 0;
        DaysInArrear := 0;
        ArrearsDate := 0D;


        SaccoActivities.GetDefaultedAmount(Loans."Loan No.", AsatDate, ExpectedAmt, AmtPaid, DefAmount, DaysInArrear, ArrearsDate, true, df);
        if ArrearsDate > AsatDate then begin
            ArrearsDate := 0D;
            DefAmount := 0;
        end;
        if DefAmount > Loans."Outstanding Principal" then
            DefAmount := loans."Outstanding Principal";


        CRBA.Prudential_Risk_Classification := 'A';


        CRBA.performing_npl_indicator := 'A';

        if DefAmount > 1 then begin
            CRBA.performing_npl_indicator := 'B';
            CRBA.overdue_balance := SetCRBAmount(DefAmount, true);

            CRBA.overdue_date := SetCRBDate(ArrearsDate, true);
            //CRBA.update_overdue_balance := SetCRBAmount(AmtDef, false);


            RSchedule.Reset();
            RSchedule.SetRange("Loan No.", Loans."Loan No.");
            RSchedule.SetFilter("Repayment Date", '>=%1', ArrearsDate);
            if RSchedule.FindFirst() then begin
                CRBA.installment_arrears := format(RSchedule.Count);
            end
            else begin
                CRBA.installment_arrears := format(round(DaysInArrear / 30, 1, '>'));
            end;

            CRBA.days_arrears := DaysInArrear;


            IF DaysInArrear <= 30 THEN
                CRBA.Prudential_Risk_Classification := 'A';
            IF (DaysInArrear > 30) AND (DaysInArrear <= 90) THEN
                CRBA.Prudential_Risk_Classification := 'B';
            IF (DaysInArrear > 90) AND (DaysInArrear <= 180) THEN
                CRBA.Prudential_Risk_Classification := 'C';
            IF (DaysInArrear > 180) AND (DaysInArrear <= 360) THEN
                CRBA.Prudential_Risk_Classification := 'D';
            IF (DaysInArrear > 360) THEN
                CRBA.Prudential_Risk_Classification := 'E';

        end
        else begin
            CRBA.overdue_balance := '0';
            CRBA.installment_arrears := '0';
            //CRBA.update_overdue_balance := '';
        end;





        //CRBA.scheduled_payment := SetCRBAmount(SchRep, true);
        //CRBA.update_scheduled_payment := SetCRBAmount(SchRep, false);
        //CRBA.amount_paid := SetCRBAmount(CurrRep, true);
        //CRBA.update_amount_paid := SetCRBAmount(CurrRep, false);


        CRBA.account_product_type := LoanType."CRB Product Code";

        IF CRBA.account_product_type = '' THEN
            CRBA.account_product_type := 'H';

        CRBA.date_account_opened := SetCRBDate(Loans."Disbursement Date", true);

        if DefAmount > 1 then begin
            RSchedule.Reset();
            RSchedule.SetRange("Loan No.", Loans."Loan No.");
            RSchedule.SetFilter("Repayment Date", '>=%1', ArrearsDate);
            if RSchedule.FindFirst() then begin
                if RSchedule."Repayment Date" < AsatDate then
                    CRBA.installment_due_date := SetCRBDate(RSchedule."Repayment Date", true)
                else
                    CRBA.installment_due_date := SetCRBDate(ArrearsDate, true);
            end
            else begin

                RSchedule.Reset();
                RSchedule.SetRange("Loan No.", Loans."Loan No.");
                RSchedule.SetFilter("Repayment Date", '<%1', ArrearsDate);
                if RSchedule.FindLast() then begin

                    CRBA.installment_due_date := SetCRBDate(RSchedule."Repayment Date", true);
                end
                else
                    CRBA.installment_due_date := SetCRBDate(ArrearsDate, true);

            end;

        end
        else begin

            RSchedule.Reset();
            RSchedule.SetRange("Loan No.", Loans."Loan No.");
            RSchedule.SetFilter("Repayment Date", '>%1', AsatDate);
            if RSchedule.FindFirst() then begin

                CRBA.installment_due_date := SetCRBDate(RSchedule."Repayment Date", true);
            end;
        end;
        if CRBA.installment_due_date = '' then begin
            d := Date2dmy(Loans."Disbursement Date", 1);
            TestD := Date2dmy(CalcDate('1M+CM', AsatDate), 1);
            if d > TestD then
                d := TestD;
            m := Date2dmy(CalcDate('1M', AsatDate), 2);
            y := Date2dmy(CalcDate('1M', AsatDate), 3);
            CRBA.installment_due_date := SetCRBDate(Dmy2date(d, m, y), true)
        end;

        CRBA.original_amount := SetCRBAmount(Loans."Approved Amount", true);

        CRBA.currency_facility := 'KES';
        CRBA.original_amount := SetCRBAmount(Loans."Approved Amount", true);
        CRBA.current_balance := SetCRBAmount(Loans."Outstanding principal", true);

        CRBA.current_balance_kes := SetCRBAmount(Loans."Outstanding principal", true);

        CompInfo.Get;

        CRBA.lenders_registered_name := CompInfo.Name;
        CRBA.lenders_trading_name := CompInfo.Name;
        CRBA.lenders_branch_name := 'WANANDEGE SACCO HQ';
        CRBA.lenders_branch_code := 'N591000001';
        //if DimVal.get('BRANCH', Cust."Global Dimension 2 Code") then Begin
        //IF DimVal."CRB Code" <> '' then
        //CRBA.lenders_branch_code := DimVal."CRB Code";
        //End;


        CRBA.account_status := 'F';

        if Loans."Last Principal Pay Date" < CalcDate('-6M', AsatDate) then
            CRBA.account_status := 'B';

        if (Loans."Outstanding Principal" <= 0)
            and (Loans."Last Principal Pay Date" < CalcDate(Format(Loans.Installments) + 'M', Loans."Disbursement Date")) then
            CRBA.account_status := 'H';

        if (Loans."Outstanding Principal" < 1) then
            CRBA.account_status := 'I';

        //if Cust."Member Status" = Cust."Member Status"::Deceased then
        //CRBA.account_status := 'L';

        CRBA.repayment_period := Format(Loans.Installments);
        CRBA.payment_frequency := CopyStr(Format(Loans."Repayment Frequency"), 1, 1);

        CRBA.disbursement_date := SetCRBDate(Loans."Disbursement Date", true);
        CRBA.installment_amount := SetCRBAmount(MRepay, true);
        CRBA.latest_payment_amount := '';
        if Loans."Last Principal Pay Date" <> 0D then begin
            CRBA.latest_payment_date := SetCRBDate(Loans."Last Principal Pay Date", true);
            //CRBA.update_date_of_last_payment := SetCRBDate(Loans."Last Principal Pay Date", false);

            Loans.CalcFields(Loans."Last Principal Pay Date");
            Evaluate(ToDate, Format(Loans."Last Principal Pay Date"));
            DateFilter := ToDate;
            CLedger.Reset;
            CLedger.SetRange(CLedger."Loan No.", Loans."Loan No.");
            CLedger.SetFilter(CLedger."Posting Date", DateFilter);
            CLedger.SetRange("Transaction Type", CLedger."Transaction Type"::"Principal Repayment");
            CLedger.SetFilter("Amount (LCY)", '<0');
            if CLedger.Find('-') then begin
                CLedger.CalcSums("Amount (LCY)");
                CRBA.latest_payment_amount := SetCRBAmount(CLedger."Amount (LCY)" * -1, true);
            end
        end;
        if CRBA.latest_payment_amount = '' then begin

            CRBA.latest_payment_amount := SetCRBAmount(0, true);
            CRBA.latest_payment_date := '';
        end;


        CRBA.security_type := 'S';

        CRBA.headerno := Header;

        CRBA.account_status_date := SetCRBDate(AsatDate, true);

        //Business Accounts
        CRBA.account_holder_type := '';
        CRBA.annual_turnover_band := '';
        CRBA.company_type := '';
        CRBA.country := CRBA.location_country;
        CRBA.industry_code := '';
        CRBA.main_telephone_number := CRBA.mobile_telephone_number;
        CRBA.number_of_shares := '';
        CRBA.other_telephone_number := '';
        CRBA.physical_location_country := CRBA.location_country;
        CRBA.physical_location_town := CRBA.location_town;
        CRBA.previous_registration_number := '';
        CRBA.registered_name := MName;
        CRBA.registration_date := SetCRBDate(Cust."Date of Bus. Reg.", true);
        CRBA.registration_number := '';
        CRBA.town := CRBA.location_town;
        CRBA.trading_name := MName;
        CRBA.trading_status := '002';
        CRBA.trading_status_date := SetCRBDate(today, true);

        CRBA.vat_number := '';


        CRBA.Insert;

        /*LGuar.Reset;
        LGuar.SetRange(LGuar."Loan No.", "Loan No.");
        LGuar.SetRange("Guarantor Type", LGuar."guarantor type"::Guarantor);
        LGuar.SetRange(LGuar.Substituted, false);
        if LGuar.Find('-') then begin
            repeat
            //if Member.Get(LGuar."Member No") then
            //InsertGuarantor(Member, Loans."Member No.", "Loan No.");
            until LGuar.Next = 0;
        end;
        */



    end;










    procedure Token(var Text: Text[100]; Separator: Text[1]) Token: Text[100]
    var
        Pos: Integer;
    begin
        Pos := StrPos(Text, Separator);

        if Pos > 0 then begin
            Token := CopyStr(Text, 1, Pos - 1);
            if Pos + 1 <= StrLen(Text) then
                Text := CopyStr(Text, Pos + 1)
            else
                Text := '';
        end else begin
            Token := Text;
            Text := '';
        end;
    end;

    procedure GetInitialRepayment(LRec: Record Loans; TMonthly: Boolean): Decimal
    var
        LoanAmount: Decimal;
        LBalance: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        TotalMRepay: Decimal;
        LPrincipal: Decimal;
        LInterest: Decimal;
    begin
        LoanAmount := LRec."Approved Amount";
        LBalance := LoanAmount;
        InterestRate := LRec."Annual Interest %";
        RepayPeriod := LRec.Installments;

        if InterestRate = 0 then
            InterestRate := 1;

        case LRec."Interest Calculation Method" of
            LRec."Interest Calculation Method"::Amortised:
                CalcAmortised(LoanAmount, InterestRate, RepayPeriod, LBalance, TotalMRepay, LPrincipal, LInterest);

            LRec."Interest Calculation Method"::"Straight Line":
                CalcStraightLine(LoanAmount, InterestRate, RepayPeriod, TotalMRepay, LPrincipal, LInterest);

            LRec."Interest Calculation Method"::"Reducing Balance":
                CalcReducingBalance(LoanAmount, InterestRate, RepayPeriod, LBalance, TotalMRepay, LPrincipal, LInterest);

            LRec."Interest Calculation Method"::"Reducing Flat":
                CalcReducingFlat(LoanAmount, InterestRate, RepayPeriod, TotalMRepay, LPrincipal, LInterest);

            else
                Error('Unsupported interest calculation method: %1', LRec."Interest Calculation Method");
        end;

        if TMonthly then
            exit(TotalMRepay)
        else
            exit(LPrincipal);
    end;

    procedure CalcAmortised(LoanAmount: Decimal; InterestRate: Decimal; RepayPeriod: Integer; LBalance: Decimal; var TotalMRepay: Decimal; var LPrincipal: Decimal; var LInterest: Decimal)
    begin
        if RepayPeriod <= 0 then
            Error('Installments must be greater than zero.');

        if InterestRate <= 0 then
            InterestRate := 1; // or raise an error if required


        TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount, 1, '>');
        LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.05, '>');
        LPrincipal := TotalMRepay - LInterest;
    end;

    procedure CalcStraightLine(LoanAmount: Decimal; InterestRate: Decimal; RepayPeriod: Integer;
                               var TotalMRepay: Decimal; var LPrincipal: Decimal; var LInterest: Decimal)
    begin
        if RepayPeriod <= 0 then
            Error('Installments must be greater than zero.');

        if InterestRate <= 0 then
            InterestRate := 1; // or raise an error if required

        LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '>');
        LInterest := ROUND((InterestRate / 12 / 100) * LoanAmount, 1, '>');
        TotalMRepay := LPrincipal + LInterest;
    end;

    procedure CalcReducingBalance(LoanAmount: Decimal; InterestRate: Decimal; RepayPeriod: Integer; LBalance: Decimal;
                                  var TotalMRepay: Decimal; var LPrincipal: Decimal; var LInterest: Decimal)
    begin

        LPrincipal := LoanAmount / RepayPeriod;
        LInterest := (InterestRate / 12 / 100) * LBalance;
        TotalMRepay := LPrincipal + LInterest;
    end;

    procedure CalcReducingFlat(LoanAmount: Decimal; InterestRate: Decimal; RepayPeriod: Integer; var TotalMRepay: Decimal; var LPrincipal: Decimal; var LInterest: Decimal)
    begin
        LPrincipal := ROUND(LoanAmount / RepayPeriod, 1.0, '>');
        LInterest := ROUND(((LoanAmount * InterestRate / 12 / 100) + (LPrincipal * InterestRate / 12 / 100)) / 2, 1.0, '>');
        TotalMRepay := LPrincipal + LInterest;
    end;

    local procedure SetCRBDate(Date: Date; Main: Boolean): Text
    begin

        DateFor := '';
        if Date <> 0D then begin

            Day := DATE2DMY(Date, 1);
            Month := DATE2DMY(Date, 2);
            Year := DATE2DMY(Date, 3);

            IF Month < 10 THEN
                m := '0'
            ELSE
                m := '';

            IF Day < 10 THEN
                d := '0'
            ELSE
                d := '';




            DateFor := FORMAT(Year) + m + FORMAT(Month) + d + FORMAT(Day);
        end;

        exit(DateFor);

    end;

    local procedure SetCRBAmount(Amount: Decimal; Main: Boolean): Text
    begin

        //
        //if Main then
        //exit(DelChr(Format(ROUND(Amount, 1, '=')) + '00', '=', ','))
        exit(DelChr(Format(ROUND(Amount, 0.01, '=') * 100), '=', ','))
        //else
        //exit(Format(Amount));
    end;

    procedure CheckValidEmailAddress(EmailAddress: Text) Valid: Boolean
    var
        IsHandled: Boolean;
    begin
        Valid := true;
        EmailAddress := DelChr(EmailAddress, '<>');

        if EmailAddress.StartsWith('@') or EmailAddress.EndsWith('@') then
            Valid := False;

        if EmailAddress.Contains(' ') then
            Valid := False;

        if EmailAddress.Contains(',') then
            Valid := False;

        if EmailAddress.Split('@').Count() <> 2 then
            Valid := False;

        if StrPos(EmailAddress, '.') = 0 then
            Valid := False;

    end;
}

