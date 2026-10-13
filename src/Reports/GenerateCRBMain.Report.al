Report 50428 "Generate CRB Main"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where(Posted = filter(= true), Installments = filter(> 0), "Approved Amount" = filter(> 0));
            RequestFilterFields = "Loan No.", "Member No.", "Loan Product Type", "Disbursement Date", "Total Outstanding Balance";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            var
                d: Integer;
                m: Integer;
                y: Integer;
                ExpectedAmt: Decimal;
                AmtPaid: Decimal;
                DefAmount: Decimal;
                DaysInArrear: Integer;
                ArrearsDate: Date;
                GracePeriod: DateFormula;
                SaccoActivities: Codeunit "Sacco Activities";
            begin

                CurrentRecordNo += 1;

                Loans.SetFilter(Loans."Date Filter", '..%1', AsatDate);
                Loans.CalcFields(Loans."Outstanding Principal", "Schedule Principal", "Last Paid Amount", "Last Principal Pay Date");


                if (Loans."Outstanding Principal" < 1) then begin
                    CurrReport.Skip;
                end
                else begin

                    if "Disbursement Date" = 0D then
                        "Disbursement Date" := Loans."Application Date";

                    //IF "Disbursement Date" = 0D THEN
                    //  CurrReport.SKIP;


                    CurrRep := 0;
                    SchRep := Loans."Schedule Principal";
                    MRepay := 0;
                    PRepay := 0;

                    CurrRep := ROUND((Loans."Approved Amount") - Loans."Outstanding Principal", 1, '=');


                    Cust.Reset;
                    Cust.SetRange(Cust."No.", Loans."Member No.");
                    if Cust.Find('-') then begin
                        NoLine := NoLine + 1;

                        CRBA.Init;

                        CRBA."No." := NoLine;

                        MyString := Cust.Name;
                        String1 := '';  // Returns 'ABC' and changes string to '111-124'
                        String2 := '';  // Returns '111' and changes string to '124'
                        String3 := '';
                        String4 := '';
                        String5 := '';


                        String1 := Token(MyString, ' ');  // Returns 'ABC' and changes string to '111-124'
                        String2 := Token(MyString, ' ');  // Returns '111' and changes string to '124'
                        String3 := Token(MyString, ' ');
                        String4 := Token(MyString, ' ');
                        String5 := Token(MyString, ' ');

                        //CRBA.Surname:=String3;
                        //CRBA."Name 2":=String1;
                        //CRBA."Name 3":=String2;

                        CRBA.Surname := Cust.Surname;
                        CRBA."Name 2" := Cust."Middle Name";
                        CRBA."Name 3" := Cust."First Name";

                        //IF CRBA.Surname='' THEN BEGIN
                        //  CRBA.Surname:=String2;
                        //  CRBA."Name 3":='';
                        //END;


                        CRBA."Date of Birth" := SetCRBDate(Cust."Date of Birth", true);
                        CRBA."Update Date of Birth" := SetCRBDate(Cust."Date of Birth", false);

                        CRBA."Client Code" := Cust."No.";
                        CRBA."Account No." := "Loan No.";
                        if Cust.Gender <> Cust.Gender::"  " then
                            CRBA.Gender := CopyStr(Format(Cust.Gender), 1, 1);

                        CRBA.Nationality := 'KE';

                        CRBA."PIN No." := Cust."KRA PIN";

                        //VALARIE: CLIENT REQUESTED FOR FIELD TO BE EMPTY
                        /*if Cust."Marital Status" = Cust."marital status"::" " then
                            CRBA."Marital Status" := 'U'
                        else
                          CRBA."Marital Status" := CopyStr(Format(Cust."Marital Status"), 1, 1);
                          */
                        CRBA."Marital Status" := ' ';


                        CRBA."Primary Identification Code" := '001';
                        CRBA."Primary Identification 1" := Cust."ID No.";
                        CRBA."Secondary Identification 1" := Cust."Passport";
                        //VALARIE: CLIENT REQUESTED FOR THE FIELD TO BE EMPTY UNLESS "Secondary Identification 1" HAS A VALUE
                        if CRBA."Secondary Identification 1" > '' then
                            CRBA."Secondary Identification Code" := '002'
                        else
                            CRBA."Secondary Identification Code" := '';

                        CRBA."Mobile No." := Cust."Phone No.";
                        CRBA."Work Telephone" := Cust."Phone Number 2";
                        CRBA."Postal Address 1" := Cust."Address";
                        CRBA."Postal Address 2" := '';
                        CRBA."Postal Location Town" := Cust.City;
                        CRBA."Postal Location Country" := 'KE';
                        CRBA."Post Code" := Cust."Post Code";
                        CRBA."Physical Address 1" := CRBA."Postal Address 1";
                        CRBA."Physical Address 2" := '';
                        CRBA."Location Town" := '';
                        //CRBA."Location Country":=Cust."Country/Region Code";
                        CRBA."Location Country" := 'KE';
                        CRBA."Date of Physical Address" := '';
                        CRBA."Customer Work Email" := Cust."E-Mail";
                        if EMPLOYER.Get(Cust."Employer Code") then
                            CRBA."Employer Name" := EMPLOYER.Name;
                        CRBA."Employment Type" := '';
                        CRBA."Employer Industry Type" := '006';

                        if Cust.Type = Cust.Type::Member then
                            CRBA."Account Type" := 'S'
                        else
                            CRBA."Account Type" := '';


                        MRepay := Loans."Loan Principle Repayment";

                        if MRepay = 0 then
                            MRepay := GetInitialRepayment(Loans, true);


                        RSchedule.Reset;
                        RSchedule.SetRange("Loan No.", Loans."Loan No.");
                        RSchedule.SetFilter("Monthly Principal", '>0');
                        if RSchedule.FindFirst() then
                            MRepay := ROUND(RSchedule."Monthly Principal", 0.01, '=');

                        DefInst := 0;
                        AmtDef := 0;

                        SaccoActivities.GetDefaultedAmount(Loans."Loan No.", AsatDate, ExpectedAmt, AmtPaid, DefAmount, DaysInArrear, ArrearsDate, false, GracePeriod);

                        if (DaysInArrear > 0) and (DaysInArrear < 30) then
                            DefInst := 1
                        else
                            if DefAmount > 0 then
                                DefInst := ROUND(DaysInArrear / 30, 1, '=');

                        AmtDef := DefAmount;

                        if DefInst > 0 then begin
                            CRBA."Overdue Balance" := SetCRBAmount(AmtDef, true);
                            CRBA."Update Overdue Balance" := SetCRBAmount(AmtDef, false);
                        end
                        else begin
                            CRBA."Overdue Balance" := '';
                            CRBA."Update Overdue Balance" := '';
                        end;

                        CRBA."Scheduled Payment" := SetCRBAmount(SchRep, true);
                        CRBA."Update Scheduled Payment" := SetCRBAmount(SchRep, false);
                        CRBA."Amount Paid" := SetCRBAmount(CurrRep, true);
                        CRBA."Update Amount Paid" := SetCRBAmount(CurrRep, false);

                        if DefInst > 0 then begin
                            ExpAmount := 0;
                            RSchedule.Reset;
                            RSchedule.SetRange(RSchedule."Loan No.", "Loan No.");
                            RSchedule.SetFilter(RSchedule."Repayment Date", '..%1', AsatDate);
                            if RSchedule.Find('-') then begin
                                repeat
                                    ExpAmount += RSchedule."Monthly Principal";
                                    OverDDate := RSchedule."Repayment Date";
                                until (RSchedule.Next = 0) or (CurrRep < ExpAmount);
                                CRBA."Overdue Date" := SetCRBDate(OverDDate, true);
                            end;
                        end;

                        if MRepay <= 0 then
                            CurrReport.Skip;
                        //  MESSAGE('SchRep %1/CurrRep %2',SchRep,CurrRep);
                        if DefInst > 0 then begin
                            CRBA."No. of Installments in Arrears" := ROUND(DefInst);

                            CRBA."No. of Days in Arrears" := DaysInArrear;//CRBA."No. of Installments in Arrears" * 30;
                            /*
                            IF Loans."Repayment Frequency"=Loans."Repayment Frequency"::Daily THEN
                              CRBA."No. of Days in Arrears":=CRBA."No. of Installments in Arrears";
                            IF Loans."Repayment Frequency"=Loans."Repayment Frequency"::Weekly THEN
                              CRBA."No. of Days in Arrears":=CRBA."No. of Installments in Arrears"*7;
                            IF Loans."Repayment Frequency"=Loans."Repayment Frequency"::Monthly THEN
                              CRBA."No. of Days in Arrears":=CRBA."No. of Installments in Arrears"*30;
                            IF Loans."Repayment Frequency"=Loans."Repayment Frequency"::Quarterly THEN
                              CRBA."No. of Days in Arrears":=CRBA."No. of Installments in Arrears"*90;
                            IF Loans."Repayment Frequency"=Loans."Repayment Frequency"::Yearly THEN
                              CRBA."No. of Days in Arrears":=CRBA."No. of Installments in Arrears"*365;
                            IF Loans."Repayment Frequency"=Loans."Repayment Frequency"::Bonus THEN
                              CRBA."No. of Days in Arrears":=CRBA."No. of Installments in Arrears"*365
                            */
                        end;
                        //Include Principal + Installment
                        if MRepay = 0 then
                            MRepay := Loans.Repayment;


                        // Get the product setup for the current loan before reading its CRB code. Mwende

                        Clear(LoanType);
                        if LoanType.Get(Loans."Loan Product Type") then
                            CRBA."Account Product Type" := LoanType."CRB Product Code";

                        CRBA."Date Account Opened" := SetCRBDate(Loans."Disbursement Date", true);

                        if Loans."Last Principal Pay Date" = 0D then
                            Loans."Last Principal Pay Date" := Loans."Old Last Pay Date";

                        if Loans."Last Principal Pay Date" <> 0D then begin
                            d := Date2dmy(Loans."Disbursement Date", 1);
                            TestD := Date2dmy(CalcDate('1M+CM', Loans."Last Principal Pay Date"), 1);
                            if d > TestD then
                                d := TestD;
                            m := Date2dmy(CalcDate('1M', Loans."Last Principal Pay Date"), 2);
                            y := Date2dmy(CalcDate('1M', Loans."Last Principal Pay Date"), 3);
                            //VALARIE COMMENTED SEARCH FOR CRBA."Installment Due Date" := WITHOUT COMMENT
                            // CRBA."Installment Due Date" := SetCRBDate(Dmy2date(d, m, y), true)
                        end;
                        //else
                        //VALARIE COMMENTED SEARCH FOR CRBA."Installment Due Date" := WITHOUT COMMENT
                        //CRBA."Installment Due Date" := SetCRBDate(Loans."Repayment Start Date", true);

                        CRBA."Original Amount" := SetCRBAmount(Loans."Approved Amount", true);
                        CRBA."Update Original Amount" := SetCRBAmount(Loans."Approved Amount", false);


                        CRBA."Currency of Facilty" := 'KES';
                        CRBA."Amount in KSHs" := SetCRBAmount(Loans."Outstanding Principal", true);
                        CRBA."Current Balance" := SetCRBAmount(Loans."Outstanding principal", true);
                        CRBA."Update Current Balance" := SetCRBAmount(Loans."Outstanding principal", false);

                        CompInfo.Get;

                        CRBA."Lenders Registered Name" := CompInfo.Name;
                        CRBA."Lenders Trading Name" := CompInfo.Name;
                        CRBA."Lenders Branch Name" := Cust."Global Dimension 2 Code";
                        CRBA."Lenders Branch Code" := 'N1175001';

                        Loans.CalcFields("Loans Category-SASRA");


                        //VALARIE: ADDED FOR FIELD TO PICK UP THE CORRECT CLASSES
                        CRBA."Performing/NPL Indicator" := ' ';

                        if Loans."Loans Category-SASRA" = Loans."loans category-sasra"::Performing then
                            CRBA."Performing/NPL Indicator" := 'A';

                        if Loans."Loans Category-SASRA" = Loans."loans category-sasra"::Watch then
                            CRBA."Performing/NPL Indicator" := 'B';

                        if Loans."Loans Category-SASRA" = Loans."loans category-sasra"::Substandard
                         then
                            CRBA."Performing/NPL Indicator" := 'C';

                        if Loans."Loans Category-SASRA" = Loans."loans category-sasra"::Doubtful
                        then
                            CRBA."Performing/NPL Indicator" := 'D';

                        if Loans."Loans Category-SASRA" = Loans."loans category-sasra"::Loss
                        then
                            CRBA."Performing/NPL Indicator" := 'E';





                        CRBA."Account Status" := 'F';//Active


                        if Loans."Last Principal Pay Date" < CalcDate('-6M', Today) then
                            CRBA."Account Status" := 'B';//Dormant


                        if (Loans."Outstanding Principal" <= 0)
                            and (Loans."Last Principal Pay Date" < CalcDate(Format(Loans.Installments) + 'M', Loans."Disbursement Date")) then
                            CRBA."Account Status" := 'H';

                        if (Loans."Outstanding Principal" <= 0)
                            and (Loans."Last Principal Pay Date" > CalcDate('-CM', Today)) then
                            CRBA."Account Status" := 'I';

                        if Cust."Member Status" = Cust."Member Status"::Deceased then
                            CRBA."Account Status" := 'L';


                        CRBA."Account Status Date" := SetCRBDate(AsatDate, true);//xxx
                        CRBA."Repayment Period" := Loans.Installments;
                        CRBA."Payment Frequency" := CopyStr(Format(Loans."Repayment Frequency"), 1, 1);

                        CRBA."Disbursement Date" := SetCRBDate(Loans."Disbursement Date", true);

                        CRBA."Installment Amount" := SetCRBAmount(MRepay, true);

                        CRBA."Salary Band" := CRBA."Installment Amount";

                        if Loans."Last Principal Pay Date" <> 0D then begin
                            CRBA."Date of Latest Payment" := SetCRBDate(Loans."Last Principal Pay Date", true);
                            CRBA."Update Date of Last Payment" := SetCRBDate(Loans."Last Principal Pay Date", false);


                            Loans.CalcFields(Loans."Last Principal Pay Date");
                            Evaluate(ToDate, Format(Loans."Last Principal Pay Date"));
                            DateFilter := ToDate;

                            //LoansR.CalcFields(LoansR.Repayment);
                            CRBA."Last Payment Amount" := SetCRBAmount(Loans."Last Paid Amount", true);

                        end
                        else begin

                            LastPayDate := 0D;
                            CLedger.Reset();
                            CLedger.SetRange("Loan No.", Loans."Loan No.");
                            CLedger.SetFilter(
                                "Transaction Type",
                                '%1|%2|%3|%4',
                                CLedger."Transaction Type"::"Appraisal Paid",
                                CLedger."Transaction Type"::"Interest Paid",
                                CLedger."Transaction Type"::"Principal Repayment",
                                CLedger."Transaction Type"::"Insurance Paid");
                            CLedger.SetFilter("Amount (LCY)", '<0');
                            CLedger.SetRange(Reversed, false);
                            CLedger.SetRange("Posting Date", LastPayDate);
                            CLedger.CalcSums("Amount (LCY)");
                            if CLedger.FindLast then begin
                                LastPayDate := CLedger."Posting Date";
                                CRBA."Last Payment Amount" := SetCRBAmount(CLedger."Amount (LCY)" * -1, true);
                            end;
                            Loans.CalcFields(Loans."Last Pay Date");

                            if LastPayDate = 0D then
                                LastPayDate := Loans."Last Pay Date";

                            if LastPayDate = 0D then
                                LastPayDate := Loans."Old Last Pay Date";

                        end;

                        if CRBA."Overdue Balance" = '' then begin
                            //VALARIE: CLIENT REQUESTED FOR THIS TO BE CHANGED TO THE DATE THAT MEMBER FELL INTO AREARS BASED ON THE SCHEDULE
                            //CRBA."Installment Due Date" := Format(CalcDate('CM', Today));
                            CRBA."Installment Due Date" := SetCRBDate(OverDDate, true);
                        end;


                        CRBA."Type of Security" := 'S';

                        CRBA.HeaderNo := Header;

                        CRBA.Insert;

                        LGuar.Reset;
                        LGuar.SetRange(LGuar."Loan No.", "Loan No.");
                        LGuar.SetRange("Guarantor Type", LGuar."guarantor type"::Guarantor);
                        LGuar.SetRange(LGuar.Substituted, false);
                        if LGuar.Find('-') then begin
                            repeat
                                if Member.Get(LGuar."Member No") then
                                    InsertGuarantor(Member, Loans."Member No.", "Loan No.");
                            until LGuar.Next = 0;
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


                CRBA.DeleteAll;
                if AsatDate = 0D then
                    AsatDate := Today;

                dWindow.Open('Generating Schedules:     @1@@@@@@@@@\'
                                            + 'Counter   #2#########'
                                            + 'Total     #3#########'
                                            + 'Press Esc to abort');

                NoOfRecords := Loans.Count;

                GoLiveDate := Dmy2date(5, 8, 2018);
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

    procedure SetHeader(HNo: Integer)
    var
        myInt: Integer;
    begin
        Header := HNo;
    end;

    var
        Header: Integer;
        CRBA: Record "CRB Main Data";
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
        Member: Record Members;
        //LoanProcess: Codeunit ;
        CompInfo: Record "Company Information";
        DefInst: Integer;
        AmtDef: Decimal;
        dWindow: Dialog;
        NoOfRecords: Integer;
        CurrentRecordNo: Integer;
        TestD: Integer;
        GoLiveDate: Date;
        CLedger: Record "Credit Ledger Entry";
        LastPayDate: Date;
        LastPayAmt: Decimal;


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


    procedure InsertGuarantor(Cust: Record Members; Loanee: Code[30]; LoanNo: Code[30])
    begin


        NoLine := NoLine + 1;

        CRBA.Init;
        CRBA."No." := NoLine;

        MyString := Cust.Name;

        String1 := Token(MyString, ' ');  // Returns 'ABC' and changes string to '111-124'
        String2 := Token(MyString, ' ');  // Returns '111' and changes string to '124'
        String3 := Token(MyString, ' ');
        String4 := Token(MyString, ' ');
        String5 := Token(MyString, ' ');

        //CRBA.Surname:=String3;
        //CRBA."Name 2":=String1;
        //CRBA."Name 3":=String2;


        CRBA.Surname := Cust."First Name";
        CRBA."Name 2" := Cust."Middle Name";
        CRBA."Name 3" := Cust.Surname;

        CRBA."Guarantee Type" := 'B';
        CRBA."Group Name" := '';
        CRBA."Guarantor Relationship" := 'C';
        CRBA."Guarantee Limit" := '';
        CRBA."Client Type" := CRBA."client type"::Guarantor;
        CRBA."Date of Birth" := SetCRBDate(Cust."Date of Birth", true);

        CRBA."Client Code" := Loanee;
        CRBA."Account No." := LoanNo;
        if Cust.Gender <> Cust.Gender::"  " then
            CRBA.Gender := CopyStr(Format(Cust.Gender), 1, 1);

        CRBA.Nationality := 'KE';

        if Cust."Marital Status" = Cust."marital status"::" " then
            CRBA."Marital Status" := 'U'
        else
            CRBA."Marital Status" := CopyStr(Format(Cust."Marital Status"), 1, 1);
        ;

        CRBA."Primary Identification Code" := '001';
        CRBA."Primary Identification 1" := Cust."ID No.";
        CRBA."Secondary Identification Code" := '002';
        CRBA."Secondary Identification 1" := Cust."Passport";
        CRBA."Mobile No." := Cust."Phone No.";
        CRBA."Work Telephone" := Cust."Phone Number 2";
        CRBA."Postal Address 1" := Cust.Address;
        CRBA."Postal Address 2" := '';
        CRBA."Postal Location Town" := Cust.City;
        CRBA."Postal Location Country" := 'KE';
        CRBA."Post Code" := Cust."Post Code";
        CRBA."Physical Address 1" := '';
        CRBA."Physical Address 2" := '';
        CRBA."Location Town" := '';
        //CRBA."Location Country":=Cust."Country/Region Code";
        CRBA."Location Country" := 'KE';
        CRBA."Date of Physical Address" := '';
        CRBA."Customer Work Email" := Cust."E-Mail";
        if EMPLOYER.Get(Cust."Employer Code") then
            CRBA."Employer Name" := EMPLOYER.Name;


        CRBA."Employment Type" := '';

        CRBA."Account Type" := 'S';
        //TESTLoans.CALCFIELDS(Loans."Schedule Repayments",Loans."Last Credit Pay Date");
        CRBA."Date Account Opened" := SetCRBDate(Loans."Application Date", true);
        CRBA."Lenders Registered Name" := CompInfo.Name;
        CRBA."Lenders Trading Name" := CompInfo.Name;
        CRBA."Lenders Branch Name" := Cust."Global Dimension 2 Code";
        CRBA."Lenders Branch Code" := 'N1175001';
        CRBA.Insert;
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
            /*
            Day:=DATE2DMY(Date,1);
            Month:=DATE2DMY(Date,2);
            Year:=DATE2DMY(Date,3);
        
            IF Month<10 THEN
            m:='0'
            ELSE
            m:='';
        
            IF Day<10 THEN
            d:='0'
            ELSE
            d:='';
        
            //
        
            {
            IF Main THEN
              DateFor:=d+FORMAT(Day)+'/'+m+FORMAT(Month)+'/'+COPYSTR(FORMAT(Year),3,2)
            ELSE
              DateFor:=FORMAT(Year)+m+FORMAT(Month)+d+FORMAT(Day);
            }
            DateFor:=d+FORMAT(Day)+'/'+m+FORMAT(Month)+'/'+COPYSTR(FORMAT(Year),3,2);
            */

            DateFor := Format(Date, 0, '<Year4><Month,2><Day,2>');
        end;

        exit(DateFor);

    end;

    local procedure SetCRBAmount(Amount: Decimal; Main: Boolean): Text
    begin

        //
        if Main then
            exit(DelChr(Format(ROUND(Amount, 1, '=')) + '00', '=', ','))
        else
            exit(Format(Amount));
    end;
}

