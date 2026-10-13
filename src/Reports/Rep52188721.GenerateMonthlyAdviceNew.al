/// <summary>
/// Report Generate Monthly Advice New (ID 50384).
/// </summary>
report 50384 "Generate Monthly Advice New"
{
    Caption = 'Generate Monthly Advice New';
    ApplicationArea = All;
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
        dataitem(MonthlyAdviceHeader; "Monthly Advice Header")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(No; "No.")
            {
            }
            column(EmployerCode; "Employer Code")
            {
            }
            column(EmployerName; "Employer Name")
            {
            }
            column(StartDate; "Start Date")
            {
            }
            column(EndDate; "End Date")
            {
            }
            column(Description; Description)
            {
            }
            trigger onpredataItem()
            var
                myInt: Integer;
            begin

            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin

                StartDate := "Start Date";
                EndDate := "End Date";
                MonthlyCheckoffAdvice("No.", "Employer Code");

            end;



            trigger OnPostDataItem()
            var
                myInt: Integer;
            begin

            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }


    var
        Employer: Record Customer;
        StartDate: Date;
        EndDate: Date;
        Memb: Record Members;
        Loans: Record Loans;
        MemberActivities: Codeunit "Member Activities";
        SaccoActivities: Codeunit "Sacco Activities";
        AsAt: Date;
        ExpectedAmt: Decimal;
        AmtPaid: Decimal;
        DefAmount: Decimal;
        DaysInArrear: Integer;
        ArrearsDate: Date;
        RSchedule: Record "Loan Repayment Schedule";
        dWindow: Dialog;
        CurrentRecordNo: Integer;
        NoOfRecords: Integer;


    /// <summary>
    /// MonthlyCheckoffAdvice.
    /// </summary>
    /// <param name="HeaderNo">Code[20].</param>
    /// <param name="EmpCode">Code[20].</param>
    procedure MonthlyCheckoffAdvice(HeaderNo: Code[20]; EmpCode: Code[20])
    var
        Loans: Record Loans;
        LRec: Record Loans;
        LSchedule: Record "Loan Repayment Schedule";

        Employer: Record Customer;
        iEntryNo: Integer;
        SavingsAccounts: Record "Savings Accounts";
        Memb: Record Members;
        InterestAmount: Decimal;
        Mdays: Integer;
        CheckoffLoan: Boolean;
        CheckoffAdvice: Record "Monthly Advice";
        MHeader: Record "Monthly Advice Header";
        PSetup: Record "Product Setup";
        VLedger: Record "Savings Ledger Entry";
        j: Integer;
        GracePeriod: DateFormula;
        EmployerFroup: Record "Employer Group";
    begin

        if (Employer.Get(EmpCode)) or (EmpCode = '') then begin

            if EmpCode <> '' then
                if Employer."Advice Method" = Employer."advice method"::" " then
                    Error('Kindly Specify Employer Advice Type');


            //Delete Records
            CheckoffAdvice.Reset;
            CheckoffAdvice.SetRange("Employer Code", EmpCode);
            //CheckoffAdvice.SetRange(Processed, false);
            //CheckoffAdvice.SetRange("Advice Date", EndDate);
            CheckoffAdvice.SetRange("Advice Header No.", HeaderNo);
            if CheckoffAdvice.Find('-') then begin
                CheckoffAdvice.DeleteAll;
            end;

            EmployerFroup.Reset();
            EmployerFroup.SetRange("Advice No.", HeaderNo);
            if EmployerFroup.FindSet() then
                repeat
                    CheckoffAdvice.Reset;
                    CheckoffAdvice.SetRange("Employer Code", EmployerFroup."Employer Code");
                    CheckoffAdvice.SetRange("Advice Header No.", HeaderNo);
                    if CheckoffAdvice.Find('-') then begin
                        CheckoffAdvice.DeleteAll;
                    end;
                until EmployerFroup.Next() = 0;

            AsAt := StartDate - 1;
            MHeader.get(HeaderNo);

            EmployerFroup.Reset();
            EmployerFroup.SetRange("Advice No.", HeaderNo);
            if not EmployerFroup.FindSet() then begin
                If (MHeader."Advice Type" = MHeader."Advice Type"::"Full Advice") then begin


                    Loans.Reset;
                    //Loans.SetRange("Member No.", '07758');
                    if EmpCode <> '' then
                        Loans.SetRange("Employer Code", EmpCode);
                    Loans.SetFilter("Disbursement Date", '..%1', EndDate);
                    Loans.SetFilter(Loans."Outstanding Principal", '>0');
                    Loans.SetRange("Repay Mode", Loans."Repay Mode"::"Check Off");
                    if Loans.Find('-') then begin
                        dWindow.Open('Generating Advice:                  #1#########\'
                                            + 'Total Loans:              #2#########\'
                                            + 'Counter:                    #3#########\'
                                            + 'Progress:                   @4@@@@@@@@@\'
                                            + 'Press Esc to abort');


                        NoOfRecords := Loans.Count;
                        repeat

                            dWindow.Update(2, NoOfRecords);
                            dWindow.Update(1, Loans."Member Name");
                            CurrentRecordNo += 1;
                            dWindow.Update(3, CurrentRecordNo);
                            dWindow.Update(4, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));


                            Memb.Get(Loans."Member No.");
                            if (Memb."Member Status" <> Memb."Member Status"::Closed) and (Memb."Member Status" <> Memb."Member Status"::Deceased) then begin


                                CheckoffLoan := false;
                                Loans.CalcFields("Schedule Interest", "Schedule Principal");
                                Loans.CalcFields("Outstanding Principal", "Outstanding Interest", "Outstanding Penalty", "Outstanding Appraisal", "Total Outstanding Balance");

                                ExpectedAmt := 0;
                                AmtPaid := 0;
                                DefAmount := 0;
                                DaysInArrear := 0;
                                ArrearsDate := 0D;

                                SaccoActivities.GetDefaultedAmount(Loans."Loan No.", AsAt, ExpectedAmt, AmtPaid, DefAmount, DaysInArrear, ArrearsDate, false, GracePeriod);

                                CheckoffAdvice.Init;
                                //CheckoffAdvice."No." := iEntryNo;
                                CheckoffAdvice."Advice Header No." := HeaderNo;
                                CheckoffAdvice."Account No." := Loans."Member No.";
                                CheckoffAdvice."Product Type" := Loans."Loan Product Type";
                                CheckoffAdvice."Product Name" := Loans."Loan Product Type Name";
                                CheckoffAdvice.Validate("Product Type");
                                CheckoffAdvice."Loan No." := Loans."Loan No.";
                                CheckoffAdvice."ID No." := Memb."ID No.";
                                CheckoffAdvice."Member No." := Loans."Member No.";
                                CheckoffAdvice."Employer Code" := Memb."Employer Code";
                                CheckoffAdvice.Validate(CheckoffAdvice."Member No.");
                                CheckoffAdvice.Name := Memb.Name;
                                CheckoffAdvice."Principal Arrears" := 0;
                                CheckoffAdvice."Sort Order" := CheckoffAdvice."Member No." + '-01';
                                CheckoffAdvice."Schedule Balance" := Loans."Schedule Interest" + Loans."Schedule Principal";

                                //Loans.TestField(Repayment);
                                if Loans."Outstanding Appraisal" > 0 then
                                    CheckoffAdvice.Appraisal := Loans."Outstanding Appraisal";

                                if Loans."Outstanding Penalty" > 0 then
                                    CheckoffAdvice.Penalty := Loans."Outstanding Penalty";

                                if Loans."Outstanding Interest" > 0 then
                                    CheckoffAdvice.Interest := Loans."Outstanding Interest";


                                CheckoffAdvice.Principal := Loans."Loan Principle Repayment";
                                CheckoffAdvice.Interest := Loans."Loan Interest Repayment";
                                CheckoffAdvice.Amount := Round(Loans.Repayment, 1, '>');

                                if Loans."Adjusted Repayment" > 0 then begin
                                    CheckoffAdvice.Amount := Loans."Adjusted Repayment";
                                    CheckoffAdvice.Principal := CheckoffAdvice.Amount - CheckoffAdvice.Interest;
                                end;

                                CheckoffAdvice."Advice Type" := CheckoffAdvice."Advice Type"::"New Loans";
                                CheckoffAdvice."Loan Period" := Loans.Installments;
                                CheckoffAdvice."Principal Arrears" := DefAmount;

                                CheckoffAdvice."Amount On" := CheckoffAdvice.Amount;
                                CheckoffAdvice."Amount Off" := 0;

                                CheckoffAdvice."Advice Date" := EndDate;
                                CheckoffAdvice."Payroll No" := Memb."Payroll/Staff No.";
                                CheckoffAdvice."Loan Balance" := Loans."Total Outstanding Balance";

                                LSchedule.Reset();
                                LSchedule.SetRange("Loan No.", Loans."Loan No.");
                                LSchedule.Setfilter("Repayment Date", '>%1', EndDate);
                                if LSchedule.FindFirst() then begin
                                    LSchedule.CalcSums("Monthly Interest");
                                    CheckoffAdvice."Loan Balance" += LSchedule."Monthly Interest";
                                end;

                                if Employer."Advice Method" = Employer."advice method"::Everything then
                                    CheckoffAdvice."Advice Method" := CheckoffAdvice."advice method"::Everything
                                else
                                    if Employer."Advice Method" = Employer."advice method"::Changes then
                                        CheckoffAdvice."Advice Method" := CheckoffAdvice."advice method"::Changes;


                                if MHeader."Loan Source" <> MHeader."Loan Source"::" " then begin

                                    PSetup.Get(Loans."Loan Product Type");
                                    if MHeader."Loan Source" = MHeader."Loan Source"::BOSA then
                                        If PSetup."Loan Source" <> PSetup."Loan Source"::BOSA then
                                            CheckoffAdvice.Amount := 0;
                                    if MHeader."Loan Source" = MHeader."Loan Source"::FOSA then
                                        If PSetup."Loan Source" <> PSetup."Loan Source"::FOSA then
                                            CheckoffAdvice.Amount := 0;
                                    if MHeader."Loan Source" = MHeader."Loan Source"::MICRO then
                                        If PSetup."Loan Source" <> PSetup."Loan Source"::MICRO then
                                            CheckoffAdvice.Amount := 0;
                                end;



                                if CheckoffAdvice.Amount > 0 then begin

                                    CheckoffAdvice.Insert;

                                    If (MHeader."Advice Type" = MHeader."Advice Type"::"External Members") then begin
                                        //Get Cleared Loans
                                        LRec.Reset;
                                        // LRec.SetRange("Member No.", '07758');
                                        if EmpCode <> '' then
                                            LRec.SetRange("Employer Code", EmpCode);
                                        // LRec.SetRange("Member No.", Loans."Member No.");
                                        //LRec.SetFilter("Disbursement Date", '%1..%2', StartDate, EndDate);
                                        // LRec.SetFilter("Disbursement Date", '<%1', StartDate);

                                        LRec.SetFilter(LRec."Outstanding Principal", '<=0');
                                        LRec.SetFilter("Last Pay Date", '%1..%2', StartDate, EndDate);
                                        LRec.SetRange("Repay Mode", LRec."Repay Mode"::"Check Off");
                                        if LRec.Find('-') then begin
                                            repeat


                                                //Delete Records
                                                CheckoffAdvice.Reset;
                                                //CheckoffAdvice.SetRange("Employer Code", EmpCode);
                                                //CheckoffAdvice.SetRange(Processed, false);
                                                CheckoffAdvice.SetRange("Loan No.", LRec."Loan No.");
                                                CheckoffAdvice.SetRange("Advice Header No.", HeaderNo);
                                                if not CheckoffAdvice.Find('-') then begin


                                                    Memb.Get(LRec."Member No.");
                                                    if (Memb."Member Status" <> Memb."Member Status"::Closed) and (Memb."Member Status" <> Memb."Member Status"::Deceased) then begin


                                                        CheckoffLoan := false;
                                                        LRec.CalcFields("Schedule Interest", "Schedule Principal");
                                                        LRec.CalcFields("Outstanding Principal", "Outstanding Interest", "Outstanding Penalty", "Outstanding Appraisal", "Total Outstanding Balance");

                                                        DefAmount := 0;

                                                        CheckoffAdvice.Init;
                                                        //CheckoffAdvice."No." := iEntryNo;
                                                        CheckoffAdvice."Advice Header No." := HeaderNo;
                                                        CheckoffAdvice."Account No." := LRec."Member No.";
                                                        CheckoffAdvice."Product Type" := LRec."Loan Product Type";
                                                        CheckoffAdvice."Product Name" := LRec."Loan Product Type Name";
                                                        CheckoffAdvice.Validate("Product Type");
                                                        CheckoffAdvice."Loan No." := LRec."Loan No.";
                                                        CheckoffAdvice."ID No." := Memb."ID No.";
                                                        CheckoffAdvice."Member No." := LRec."Member No.";
                                                        CheckoffAdvice."Employer Code" := Memb."Employer Code";
                                                        CheckoffAdvice.Validate(CheckoffAdvice."Member No.");
                                                        CheckoffAdvice.Name := Memb.Name;
                                                        CheckoffAdvice."Principal Arrears" := 0;
                                                        CheckoffAdvice."Schedule Balance" := LRec."Schedule Interest" + LRec."Schedule Principal";
                                                        CheckoffAdvice."Sort Order" := CheckoffAdvice."Member No." + '-02';


                                                        //LRec.TestField(Repayment);
                                                        if LRec."Outstanding Appraisal" > 0 then
                                                            CheckoffAdvice.Appraisal := LRec."Outstanding Appraisal";

                                                        if LRec."Outstanding Penalty" > 0 then
                                                            CheckoffAdvice.Penalty := LRec."Outstanding Penalty";

                                                        if LRec."Outstanding Interest" > 0 then
                                                            CheckoffAdvice.Interest := LRec."Outstanding Interest";


                                                        CheckoffAdvice.Principal := 0;//LRec."Loan Principle Repayment";
                                                        CheckoffAdvice.Interest := 0;//LRec."Loan Interest Repayment";
                                                        CheckoffAdvice.Amount := Round(LRec.Repayment, 1, '>');

                                                        if LRec."Adjusted Repayment" > 0 then begin
                                                            CheckoffAdvice.Amount := LRec."Adjusted Repayment";
                                                            CheckoffAdvice.Principal := 0;//CheckoffAdvice.Amount - CheckoffAdvice.Interest;
                                                        end;


                                                        CheckoffAdvice."Advice Type" := CheckoffAdvice."Advice Type"::" ";
                                                        //CheckoffAdvice."Loan Period" := LRec.Installments;

                                                        CheckoffAdvice."Amount On" := 0;
                                                        CheckoffAdvice."Amount Off" := LRec.Repayment;
                                                        CheckoffAdvice.Amount := 0;


                                                        CheckoffAdvice."Advice Date" := EndDate;
                                                        CheckoffAdvice."Payroll No" := Memb."Payroll/Staff No.";
                                                        CheckoffAdvice."Loan Balance" := 0;//LRec."Total Outstanding Balance";

                                                        LSchedule.Reset();
                                                        LSchedule.SetRange("Loan No.", LRec."Loan No.");
                                                        LSchedule.Setfilter("Repayment Date", '>%1', EndDate);
                                                        if LSchedule.FindFirst() then begin
                                                            LSchedule.CalcSums("Monthly Interest");
                                                            CheckoffAdvice."Loan Balance" := 0;//+= LSchedule."Monthly Interest";
                                                        end;

                                                        if Employer."Advice Method" = Employer."advice method"::Everything then
                                                            CheckoffAdvice."Advice Method" := CheckoffAdvice."advice method"::Everything
                                                        else
                                                            if Employer."Advice Method" = Employer."advice method"::Changes then
                                                                CheckoffAdvice."Advice Method" := CheckoffAdvice."advice method"::Changes;



                                                        if MHeader."Loan Source" <> MHeader."Loan Source"::" " then begin

                                                            PSetup.Get(LRec."Loan Product Type");
                                                            if MHeader."Loan Source" = MHeader."Loan Source"::BOSA then
                                                                If PSetup."Loan Source" <> PSetup."Loan Source"::BOSA then
                                                                    CheckoffAdvice.Amount := 0;
                                                            if MHeader."Loan Source" = MHeader."Loan Source"::FOSA then
                                                                If PSetup."Loan Source" <> PSetup."Loan Source"::FOSA then
                                                                    CheckoffAdvice.Amount := 0;
                                                            if MHeader."Loan Source" = MHeader."Loan Source"::MICRO then
                                                                If PSetup."Loan Source" <> PSetup."Loan Source"::MICRO then
                                                                    CheckoffAdvice.Amount := 0;
                                                        end;



                                                        // if CheckoffAdvice.Amount > 0 then
                                                        CheckoffAdvice.Insert;

                                                    end;
                                                end;


                                                //Savings
                                                SavingsAccounts.Reset;
                                                SavingsAccounts.SetRange("Member No.", LRec."Member No.");
                                                SavingsAccounts.SetFilter("Product Category", '%1', SavingsAccounts."product category"::"Deposit Contribution");
                                                //SavingsAccounts.SetRange("Repay Mode", SavingsAccounts."Repay Mode"::"Check Off");
                                                if SavingsAccounts.Find('-') then begin

                                                    repeat


                                                        Memb.Get(SavingsAccounts."Member No.");

                                                        //Delete Records
                                                        CheckoffAdvice.Reset;

                                                        CheckoffAdvice.SetRange("Member No.", LRec."Member No.");
                                                        CheckoffAdvice.SetRange("Product Type", SavingsAccounts."Product Type");
                                                        CheckoffAdvice.SetRange("Advice Header No.", HeaderNo);
                                                        if not CheckoffAdvice.Find('-') then begin



                                                            if (Memb."Member Status" <> Memb."Member Status"::Closed) and (Memb."Member Status" <> Memb."Member Status"::Deceased) then begin


                                                                SavingsAccounts.CalcFields("Balance (LCY)");



                                                                iEntryNo := 0;
                                                                CheckoffAdvice.Reset;
                                                                if CheckoffAdvice.Find('+') then
                                                                    iEntryNo := CheckoffAdvice."No.";

                                                                iEntryNo += 1;

                                                                CheckoffAdvice.Init;
                                                                //CheckoffAdvice."No." := iEntryNo;
                                                                CheckoffAdvice."Advice Header No." := HeaderNo;
                                                                CheckoffAdvice."Account No." := SavingsAccounts."No.";
                                                                CheckoffAdvice."Product Type" := SavingsAccounts."Product Type";
                                                                CheckoffAdvice.Validate("Product Type");
                                                                CheckoffAdvice."Product Name" := SavingsAccounts."Product Name";
                                                                CheckoffAdvice."Loan No." := '';
                                                                CheckoffAdvice."ID No." := Memb."ID No.";
                                                                CheckoffAdvice."Member No." := Memb."No.";
                                                                CheckoffAdvice."Employer Code" := Memb."Employer Code";
                                                                CheckoffAdvice.Validate(CheckoffAdvice."Member No.");
                                                                CheckoffAdvice.Name := Memb.Name;

                                                                If (MHeader."Advice Type" = MHeader."Advice Type"::"Savings Balance Adjustments") then
                                                                    CheckoffAdvice."Advice Type" := CheckoffAdvice."Advice Type"::"Savings Balance Adjustments";
                                                                If (MHeader."Advice Type" = MHeader."Advice Type"::"Savings Adjustments") then
                                                                    CheckoffAdvice."Advice Type" := CheckoffAdvice."Advice Type"::"Savings Adjustments";
                                                                If (MHeader."Advice Type" = MHeader."Advice Type"::"New Savings") then
                                                                    CheckoffAdvice."Advice Type" := CheckoffAdvice."Advice Type"::"New Savings";

                                                                CheckoffAdvice."Advice Date" := EndDate;
                                                                CheckoffAdvice."Payroll No" := Memb."Payroll/Staff No.";
                                                                CheckoffAdvice."Amount Off" := 0;
                                                                CheckoffAdvice."Amount On" := 0;
                                                                CheckoffAdvice."Sort Order" := CheckoffAdvice."Member No." + '-03';
                                                                CheckoffAdvice.Amount := GetDepositContribution(SavingsAccounts."No.", Memb."Member Class");
                                                                CheckoffAdvice."Change Balance" := 0;
                                                                CheckoffAdvice."Current Balance" := 0;
                                                                CheckoffAdvice."Cummulative Contribution" := 0;


                                                                if Employer."Advice Method" = Employer."advice method"::Everything then
                                                                    CheckoffAdvice."Advice Method" := CheckoffAdvice."advice method"::Everything
                                                                else
                                                                    if Employer."Advice Method" = Employer."advice method"::Changes then
                                                                        CheckoffAdvice."Advice Method" := CheckoffAdvice."advice method"::Changes;


                                                                CheckoffAdvice.Insert;


                                                            end;

                                                        end;
                                                    until SavingsAccounts.Next = 0;

                                                end;

                                            until LRec.Next = 0;
                                            // Get other existing Loans
                                            LRec.Reset;
                                            if EmpCode <> '' then
                                                LRec.SetRange("Employer Code", EmpCode);
                                            LRec.SetRange("Member No.", Loans."Member No.");
                                            LRec.SetFilter(LRec."Outstanding Principal", '>0');
                                            LRec.SetRange("Repay Mode", LRec."Repay Mode"::"Check Off");
                                            if LRec.FindFirst() then begin
                                                repeat
                                                    //Delete Records
                                                    CheckoffAdvice.Reset;
                                                    //CheckoffAdvice.SetRange("Employer Code", EmpCode);
                                                    //CheckoffAdvice.SetRange(Processed, false);
                                                    CheckoffAdvice.SetRange("Loan No.", LRec."Loan No.");
                                                    CheckoffAdvice.SetRange("Advice Header No.", HeaderNo);
                                                    if not CheckoffAdvice.Find('-') then begin
                                                        Memb.Get(LRec."Member No.");
                                                        if (Memb."Member Status" <> Memb."Member Status"::Closed) and (Memb."Member Status" <> Memb."Member Status"::Deceased) then begin

                                                            CheckoffLoan := false;
                                                            LRec.CalcFields("Schedule Interest", "Schedule Principal");
                                                            LRec.CalcFields("Outstanding Principal", "Outstanding Interest", "Outstanding Penalty", "Outstanding Appraisal", "Total Outstanding Balance");

                                                            DefAmount := 0;

                                                            CheckoffAdvice.Init;
                                                            //CheckoffAdvice."No." := iEntryNo;
                                                            CheckoffAdvice."Advice Header No." := HeaderNo;
                                                            CheckoffAdvice."Account No." := LRec."Member No.";
                                                            CheckoffAdvice."Product Type" := LRec."Loan Product Type";
                                                            CheckoffAdvice."Product Name" := LRec."Loan Product Type Name";
                                                            CheckoffAdvice.Validate("Product Type");
                                                            CheckoffAdvice."Loan No." := LRec."Loan No.";
                                                            CheckoffAdvice."ID No." := Memb."ID No.";
                                                            CheckoffAdvice."Member No." := LRec."Member No.";
                                                            CheckoffAdvice."Employer Code" := Memb."Employer Code";
                                                            CheckoffAdvice.Validate(CheckoffAdvice."Member No.");
                                                            CheckoffAdvice.Name := Memb.Name;
                                                            CheckoffAdvice."Principal Arrears" := 0;
                                                            CheckoffAdvice."Schedule Balance" := LRec."Schedule Interest" + LRec."Schedule Principal";
                                                            CheckoffAdvice."Sort Order" := CheckoffAdvice."Member No." + '-02';


                                                            //LRec.TestField(Repayment);
                                                            if LRec."Outstanding Appraisal" > 0 then
                                                                CheckoffAdvice.Appraisal := LRec."Outstanding Appraisal";

                                                            if LRec."Outstanding Penalty" > 0 then
                                                                CheckoffAdvice.Penalty := LRec."Outstanding Penalty";

                                                            if LRec."Outstanding Interest" > 0 then
                                                                CheckoffAdvice.Interest := LRec."Outstanding Interest";


                                                            CheckoffAdvice.Principal := LRec."Loan Principle Repayment";
                                                            CheckoffAdvice.Interest := LRec."Loan Interest Repayment";
                                                            CheckoffAdvice.Amount := Round(LRec.Repayment, 1, '>');

                                                            if LRec."Adjusted Repayment" > 0 then begin
                                                                CheckoffAdvice.Amount := LRec."Adjusted Repayment";
                                                                CheckoffAdvice.Principal := CheckoffAdvice.Amount - CheckoffAdvice.Interest;
                                                            end;


                                                            CheckoffAdvice."Advice Type" := CheckoffAdvice."Advice Type"::" ";
                                                            //CheckoffAdvice."Loan Period" := LRec.Installments;

                                                            CheckoffAdvice."Amount On" := LRec.Repayment;
                                                            CheckoffAdvice."Amount Off" := 0;
                                                            CheckoffAdvice.Amount := Round(LRec.Repayment, 1, '>');
                                                            ;


                                                            CheckoffAdvice."Advice Date" := EndDate;
                                                            CheckoffAdvice."Payroll No" := Memb."Payroll/Staff No.";
                                                            CheckoffAdvice."Loan Balance" := 0;//LRec."Total Outstanding Balance";

                                                            LSchedule.Reset();
                                                            LSchedule.SetRange("Loan No.", LRec."Loan No.");
                                                            LSchedule.Setfilter("Repayment Date", '>%1', EndDate);
                                                            if LSchedule.FindFirst() then begin
                                                                LSchedule.CalcSums("Monthly Interest");
                                                                CheckoffAdvice."Loan Balance" := 0;//+= LSchedule."Monthly Interest";
                                                            end;

                                                            if Employer."Advice Method" = Employer."advice method"::Everything then
                                                                CheckoffAdvice."Advice Method" := CheckoffAdvice."advice method"::Everything
                                                            else
                                                                if Employer."Advice Method" = Employer."advice method"::Changes then
                                                                    CheckoffAdvice."Advice Method" := CheckoffAdvice."advice method"::Changes;



                                                            if MHeader."Loan Source" <> MHeader."Loan Source"::" " then begin

                                                                PSetup.Get(LRec."Loan Product Type");
                                                                if MHeader."Loan Source" = MHeader."Loan Source"::BOSA then
                                                                    If PSetup."Loan Source" <> PSetup."Loan Source"::BOSA then
                                                                        CheckoffAdvice.Amount := 0;
                                                                if MHeader."Loan Source" = MHeader."Loan Source"::FOSA then
                                                                    If PSetup."Loan Source" <> PSetup."Loan Source"::FOSA then
                                                                        CheckoffAdvice.Amount := 0;
                                                                if MHeader."Loan Source" = MHeader."Loan Source"::MICRO then
                                                                    If PSetup."Loan Source" <> PSetup."Loan Source"::MICRO then
                                                                        CheckoffAdvice.Amount := 0;
                                                            end;



                                                            // if CheckoffAdvice.Amount > 0 then
                                                            CheckoffAdvice.Insert;

                                                        end;
                                                    end;

                                                    //Savings
                                                    SavingsAccounts.Reset;
                                                    SavingsAccounts.SetRange("Member No.", LRec."Member No.");
                                                    SavingsAccounts.SetFilter("Product Category", '%1', SavingsAccounts."product category"::"Deposit Contribution");
                                                    //SavingsAccounts.SetRange("Repay Mode", SavingsAccounts."Repay Mode"::"Check Off");
                                                    if SavingsAccounts.Find('-') then begin
                                                        repeat
                                                            Memb.Get(SavingsAccounts."Member No.");

                                                            //Delete Records
                                                            CheckoffAdvice.Reset;

                                                            CheckoffAdvice.SetRange("Member No.", LRec."Member No.");
                                                            CheckoffAdvice.SetRange("Product Type", SavingsAccounts."Product Type");
                                                            CheckoffAdvice.SetRange("Advice Header No.", HeaderNo);
                                                            if not CheckoffAdvice.Find('-') then begin

                                                                if (Memb."Member Status" <> Memb."Member Status"::Closed) and (Memb."Member Status" <> Memb."Member Status"::Deceased) then begin
                                                                    SavingsAccounts.CalcFields("Balance (LCY)");

                                                                    iEntryNo := 0;
                                                                    CheckoffAdvice.Reset;
                                                                    if CheckoffAdvice.Find('+') then
                                                                        iEntryNo := CheckoffAdvice."No.";

                                                                    iEntryNo += 1;

                                                                    CheckoffAdvice.Init;
                                                                    //CheckoffAdvice."No." := iEntryNo;
                                                                    CheckoffAdvice."Advice Header No." := HeaderNo;
                                                                    CheckoffAdvice."Account No." := SavingsAccounts."No.";
                                                                    CheckoffAdvice."Product Type" := SavingsAccounts."Product Type";
                                                                    CheckoffAdvice.Validate("Product Type");
                                                                    CheckoffAdvice."Product Name" := SavingsAccounts."Product Name";
                                                                    CheckoffAdvice."Loan No." := '';
                                                                    CheckoffAdvice."ID No." := Memb."ID No.";
                                                                    CheckoffAdvice."Member No." := Memb."No.";
                                                                    CheckoffAdvice."Employer Code" := Memb."Employer Code";
                                                                    CheckoffAdvice.Validate(CheckoffAdvice."Member No.");
                                                                    CheckoffAdvice.Name := Memb.Name;

                                                                    If (MHeader."Advice Type" = MHeader."Advice Type"::"Savings Balance Adjustments") then
                                                                        CheckoffAdvice."Advice Type" := CheckoffAdvice."Advice Type"::"Savings Balance Adjustments";
                                                                    If (MHeader."Advice Type" = MHeader."Advice Type"::"Savings Adjustments") then
                                                                        CheckoffAdvice."Advice Type" := CheckoffAdvice."Advice Type"::"Savings Adjustments";
                                                                    If (MHeader."Advice Type" = MHeader."Advice Type"::"New Savings") then
                                                                        CheckoffAdvice."Advice Type" := CheckoffAdvice."Advice Type"::"New Savings";

                                                                    CheckoffAdvice."Advice Date" := EndDate;
                                                                    CheckoffAdvice."Payroll No" := Memb."Payroll/Staff No.";
                                                                    CheckoffAdvice."Amount Off" := 0;
                                                                    CheckoffAdvice."Amount On" := 0;
                                                                    CheckoffAdvice."Sort Order" := CheckoffAdvice."Member No." + '-03';
                                                                    CheckoffAdvice.Amount := GetDepositContribution(SavingsAccounts."No.", Memb."Member Class");
                                                                    CheckoffAdvice."Change Balance" := 0;
                                                                    CheckoffAdvice."Current Balance" := 0;
                                                                    CheckoffAdvice."Cummulative Contribution" := 0;


                                                                    if Employer."Advice Method" = Employer."advice method"::Everything then
                                                                        CheckoffAdvice."Advice Method" := CheckoffAdvice."advice method"::Everything
                                                                    else
                                                                        if Employer."Advice Method" = Employer."advice method"::Changes then
                                                                            CheckoffAdvice."Advice Method" := CheckoffAdvice."advice method"::Changes;


                                                                    CheckoffAdvice.Insert;


                                                                end;

                                                            end;
                                                        until SavingsAccounts.Next = 0;

                                                    end;

                                                until LRec.Next = 0;

                                            end;
                                        end;


                                        //Deposits


                                        //Savings
                                        SavingsAccounts.Reset;
                                        SavingsAccounts.SetRange("Member No.", Loans."Member No.");
                                        SavingsAccounts.SetFilter("Product Category", '%1', SavingsAccounts."product category"::"Deposit Contribution");
                                        //SavingsAccounts.SetRange("Repay Mode", SavingsAccounts."Repay Mode"::"Check Off");
                                        if SavingsAccounts.Find('-') then begin

                                            repeat


                                                Memb.Get(SavingsAccounts."Member No.");




                                                //Delete Records
                                                CheckoffAdvice.Reset;

                                                CheckoffAdvice.SetRange("Member No.", Loans."Member No.");
                                                CheckoffAdvice.SetRange("Product Type", SavingsAccounts."Product Type");
                                                CheckoffAdvice.SetRange("Advice Header No.", HeaderNo);
                                                if not CheckoffAdvice.Find('-') then begin



                                                    if (Memb."Member Status" <> Memb."Member Status"::Closed) and (Memb."Member Status" <> Memb."Member Status"::Deceased) then begin


                                                        SavingsAccounts.CalcFields("Balance (LCY)");



                                                        iEntryNo := 0;
                                                        CheckoffAdvice.Reset;
                                                        if CheckoffAdvice.Find('+') then
                                                            iEntryNo := CheckoffAdvice."No.";

                                                        iEntryNo += 1;

                                                        CheckoffAdvice.Init;
                                                        //CheckoffAdvice."No." := iEntryNo;
                                                        CheckoffAdvice."Advice Header No." := HeaderNo;
                                                        CheckoffAdvice."Account No." := SavingsAccounts."No.";
                                                        CheckoffAdvice."Product Type" := SavingsAccounts."Product Type";
                                                        CheckoffAdvice.Validate("Product Type");
                                                        CheckoffAdvice."Product Name" := SavingsAccounts."Product Name";
                                                        CheckoffAdvice."Loan No." := '';
                                                        CheckoffAdvice."ID No." := Memb."ID No.";
                                                        CheckoffAdvice."Member No." := Memb."No.";
                                                        CheckoffAdvice."Employer Code" := Memb."Employer Code";
                                                        CheckoffAdvice.Validate(CheckoffAdvice."Member No.");
                                                        CheckoffAdvice.Name := Memb.Name;

                                                        If (MHeader."Advice Type" = MHeader."Advice Type"::"Savings Balance Adjustments") then
                                                            CheckoffAdvice."Advice Type" := CheckoffAdvice."Advice Type"::"Savings Balance Adjustments";
                                                        If (MHeader."Advice Type" = MHeader."Advice Type"::"Savings Adjustments") then
                                                            CheckoffAdvice."Advice Type" := CheckoffAdvice."Advice Type"::"Savings Adjustments";
                                                        If (MHeader."Advice Type" = MHeader."Advice Type"::"New Savings") then
                                                            CheckoffAdvice."Advice Type" := CheckoffAdvice."Advice Type"::"New Savings";

                                                        CheckoffAdvice."Advice Date" := EndDate;
                                                        CheckoffAdvice."Payroll No" := Memb."Payroll/Staff No.";
                                                        CheckoffAdvice."Amount Off" := 0;
                                                        CheckoffAdvice."Amount On" := 0;
                                                        CheckoffAdvice."Sort Order" := CheckoffAdvice."Member No." + '-03';
                                                        CheckoffAdvice.Amount := GetDepositContribution(SavingsAccounts."No.", Memb."Member Class");
                                                        CheckoffAdvice."Change Balance" := 0;
                                                        CheckoffAdvice."Current Balance" := 0;
                                                        CheckoffAdvice."Cummulative Contribution" := 0;


                                                        if Employer."Advice Method" = Employer."advice method"::Everything then
                                                            CheckoffAdvice."Advice Method" := CheckoffAdvice."advice method"::Everything
                                                        else
                                                            if Employer."Advice Method" = Employer."advice method"::Changes then
                                                                CheckoffAdvice."Advice Method" := CheckoffAdvice."advice method"::Changes;


                                                        CheckoffAdvice.Insert;


                                                    end;

                                                end;
                                            until SavingsAccounts.Next = 0;

                                        end;

                                    end;

                                end;

                            end;

                        until Loans.Next = 0;

                        dWindow.Close();

                    end;

                    //Savings
                    SavingsAccounts.Reset;
                    if EmpCode <> '' then
                        SavingsAccounts.SetRange("Employer Code", EmpCode);
                    SavingsAccounts.SetFilter("Product Category", '%1', SavingsAccounts."Product Category"::"Deposit Contribution");
                    if SavingsAccounts.FindSet() then begin
                        dWindow.Open('Generating Savings Advice:                  #1#########\'
                                            + 'Total Members:              #2#########\'
                                            + 'Counter:                    #3#########\'
                                            + 'Progress:                   @4@@@@@@@@@\'
                                            + 'Press Esc to abort');


                        NoOfRecords := SavingsAccounts.Count;
                        repeat
                            dWindow.Update(2, NoOfRecords);
                            dWindow.Update(1, SavingsAccounts."Name");
                            CurrentRecordNo += 1;
                            dWindow.Update(3, CurrentRecordNo);
                            dWindow.Update(4, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));

                            Memb.Get(SavingsAccounts."Member No.");
                            if (Memb."Member Status" <> Memb."Member Status"::Closed) and (Memb."Member Status" <> Memb."Member Status"::Deceased) then begin

                                SavingsAccounts.CalcFields("Balance (LCY)");

                                iEntryNo := 0;
                                CheckoffAdvice.Reset;
                                if CheckoffAdvice.Find('+') then
                                    iEntryNo := CheckoffAdvice."No.";

                                iEntryNo += 1;

                                CheckoffAdvice.Init;
                                //CheckoffAdvice."No." := iEntryNo;
                                CheckoffAdvice."Advice Header No." := HeaderNo;
                                CheckoffAdvice."Account No." := SavingsAccounts."No.";
                                CheckoffAdvice."Product Type" := SavingsAccounts."Product Type";
                                CheckoffAdvice.Validate("Product Type");
                                CheckoffAdvice."Product Name" := SavingsAccounts."Product Name";
                                CheckoffAdvice."Loan No." := '';
                                CheckoffAdvice."ID No." := Memb."ID No.";
                                CheckoffAdvice."Member No." := Memb."No.";
                                CheckoffAdvice."Employer Code" := Memb."Employer Code";
                                CheckoffAdvice.Validate(CheckoffAdvice."Member No.");
                                CheckoffAdvice.Name := Memb.Name;

                                If (MHeader."Advice Type" = MHeader."Advice Type"::"Savings Balance Adjustments") then
                                    CheckoffAdvice."Advice Type" := CheckoffAdvice."Advice Type"::"Savings Balance Adjustments";
                                If (MHeader."Advice Type" = MHeader."Advice Type"::"Savings Adjustments") then
                                    CheckoffAdvice."Advice Type" := CheckoffAdvice."Advice Type"::"Savings Adjustments";
                                If (MHeader."Advice Type" = MHeader."Advice Type"::"New Savings") then
                                    CheckoffAdvice."Advice Type" := CheckoffAdvice."Advice Type"::"New Savings";

                                CheckoffAdvice."Advice Date" := EndDate;
                                CheckoffAdvice."Payroll No" := Memb."Payroll/Staff No.";
                                CheckoffAdvice."Amount Off" := SavingsAccounts."Old Amount";
                                CheckoffAdvice."Amount On" := SavingsAccounts."Monthly Contribution";
                                CheckoffAdvice.Amount := SavingsAccounts."Monthly Contribution";
                                CheckoffAdvice."Change Balance" := SavingsAccounts."Change Balance";
                                CheckoffAdvice."Current Balance" := SavingsAccounts."Current Balance";
                                CheckoffAdvice."Cummulative Contribution" := SavingsAccounts."Cummulative Contribution";



                                if Employer."Advice Method" = Employer."advice method"::Everything then
                                    CheckoffAdvice."Advice Method" := CheckoffAdvice."advice method"::Everything
                                else
                                    if Employer."Advice Method" = Employer."advice method"::Changes then
                                        CheckoffAdvice."Advice Method" := CheckoffAdvice."advice method"::Changes;

                                if (MHeader."Advice Type" = MHeader."Advice Type"::"Full Advice") then begin
                                    CheckoffAdvice.Insert;
                                end
                                else begin


                                    If (MHeader."Advice Type" = MHeader."Advice Type"::"New Savings") then begin
                                        if CheckoffAdvice."Amount Off" = 0 then begin
                                            if CheckoffAdvice.Amount > 0 then
                                                CheckoffAdvice.Insert;
                                        end;
                                    end;


                                    If (MHeader."Advice Type" = MHeader."Advice Type"::"Savings Adjustments") then begin
                                        if CheckoffAdvice."Amount Off" > 0 then begin
                                            if CheckoffAdvice.Amount > 0 then
                                                CheckoffAdvice.Insert;
                                        end;
                                    end;

                                    If (MHeader."Advice Type" = MHeader."Advice Type"::"Savings Balance Adjustments") then begin
                                        if CheckoffAdvice."Change Balance" <> 0 then begin
                                            CheckoffAdvice.Insert;
                                        end;
                                    end;

                                end;


                            end;

                        until SavingsAccounts.Next = 0;

                        dWindow.Close();
                    end;
                end;

            end;

            If MHeader."Advice Type" = MHeader."Advice Type"::"Full Advice" then begin

                EmployerFroup.Reset();
                EmployerFroup.SetRange("Advice No.", HeaderNo);
                if EmployerFroup.FindSet() then begin


                    dWindow.Open('Generating Advice Employers group Loans:                  #1#########\'
                                                   + 'Total Loans:              #2#########\'
                                                   + 'Counter:                    #3#########\'
                                                   + 'Progress:                   @4@@@@@@@@@\'
                                                   + 'Press Esc to abort');
                    NoOfRecords := EmployerFroup.Count;
                    repeat

                        //EmployerFroup."Employer Code"
                        Loans.Reset;
                        Loans.SetRange(Posted, true);
                        Loans.SetRange("Employer Code", EmployerFroup."Employer Code");
                        Loans.SetFilter("Disbursement Date", '.%2', EndDate);
                        Loans.SetFilter(Loans."Total Outstanding Balance", '>0');
                        //Loans.SetRange("Repay Mode", Loans."Repay Mode"::"Check Off"); 
                        if Loans.Find('-') then begin


                            dWindow.Update(2, NoOfRecords);
                            dWindow.Update(1, Loans."Member Name");
                            CurrentRecordNo += 1;
                            dWindow.Update(3, CurrentRecordNo);
                            dWindow.Update(4, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));

                            Memb.Get(Loans."Member No.");
                            if (Memb."Member Status" <> Memb."Member Status"::Closed) and (Memb."Member Status" <> Memb."Member Status"::Deceased) then begin


                                CheckoffLoan := false;
                                Loans.CalcFields("Schedule Interest", "Schedule Principal");
                                Loans.CalcFields("Outstanding Principal", "Outstanding Interest", "Outstanding Penalty", "Outstanding Appraisal", "Total Outstanding Balance");

                                DefAmount := 0;

                                CheckoffAdvice.Init;
                                //CheckoffAdvice."No." := iEntryNo;
                                CheckoffAdvice."Advice Header No." := HeaderNo;
                                CheckoffAdvice."Account No." := Loans."Member No.";
                                CheckoffAdvice."Product Type" := Loans."Loan Product Type";
                                CheckoffAdvice."Product Name" := Loans."Loan Product Type Name";
                                CheckoffAdvice.Validate("Product Type");
                                CheckoffAdvice."Loan No." := Loans."Loan No.";
                                CheckoffAdvice."ID No." := Memb."ID No.";
                                CheckoffAdvice."Member No." := Loans."Member No.";
                                CheckoffAdvice."Employer Code" := Memb."Employer Code";
                                CheckoffAdvice.Validate(CheckoffAdvice."Member No.");
                                CheckoffAdvice.Name := Memb.Name;
                                CheckoffAdvice."Principal Arrears" := 0;
                                CheckoffAdvice."Sort Order" := CheckoffAdvice."Member No." + '-01-P';

                                //Loans.TestField(Repayment);
                                if Loans."Outstanding Appraisal" > 0 then
                                    CheckoffAdvice.Appraisal := Loans."Outstanding Appraisal";

                                if Loans."Outstanding Penalty" > 0 then
                                    CheckoffAdvice.Penalty := Loans."Outstanding Penalty";

                                if Loans."Outstanding Interest" > 0 then
                                    CheckoffAdvice.Interest := Loans."Outstanding Interest";


                                CheckoffAdvice."Interest Arrears" := SaccoActivities.GetInterestArrearsPerDate(Loans."Loan No.", CalcDate('-CM', MHeader."Start Date"), Today);
                                CheckoffAdvice."Principal Arrears" := SaccoActivities.GetPrincipalArrearsPerDate(Loans."Loan No.", CalcDate('-CM', MHeader."Start Date"), Today);

                                CheckoffAdvice.Principal := Loans."Loan Principle Repayment";
                                CheckoffAdvice.Interest := Loans."Loan Interest Repayment";
                                CheckoffAdvice.Amount := Round(Loans.Repayment, 1, '>');

                                if Loans."Adjusted Repayment" > 0 then begin
                                    CheckoffAdvice.Amount := Loans."Adjusted Repayment";
                                    CheckoffAdvice.Principal := CheckoffAdvice.Amount - CheckoffAdvice.Interest;
                                end;


                                CheckoffAdvice."Advice Type" := CheckoffAdvice."Advice Type"::"New Loans";
                                CheckoffAdvice."Loan Period" := Loans.Installments;



                                CheckoffAdvice."Amount On" := CheckoffAdvice.Amount;
                                CheckoffAdvice."Amount Off" := 0;

                                CheckoffAdvice."Advice Date" := EndDate;
                                CheckoffAdvice."Payroll No" := Memb."Payroll/Staff No.";
                                CheckoffAdvice."Loan Balance" := Loans."Total Outstanding Balance";
                                LSchedule.Reset();
                                LSchedule.SetRange("Loan No.", Loans."Loan No.");
                                LSchedule.Setfilter("Repayment Date", '>%1', EndDate);
                                if LSchedule.FindFirst() then begin
                                    LSchedule.CalcSums("Monthly Interest");
                                    CheckoffAdvice."Loan Balance" += LSchedule."Monthly Interest";
                                end;

                                if Employer."Advice Method" = Employer."advice method"::Everything then
                                    CheckoffAdvice."Advice Method" := CheckoffAdvice."advice method"::Everything
                                else
                                    if Employer."Advice Method" = Employer."advice method"::Changes then
                                        CheckoffAdvice."Advice Method" := CheckoffAdvice."advice method"::Changes;


                                if MHeader."Loan Source" <> MHeader."Loan Source"::" " then begin

                                    PSetup.Get(Loans."Loan Product Type");
                                    if MHeader."Loan Source" = MHeader."Loan Source"::BOSA then
                                        If PSetup."Loan Source" <> PSetup."Loan Source"::BOSA then
                                            CheckoffAdvice.Amount := 0;
                                    if MHeader."Loan Source" = MHeader."Loan Source"::FOSA then
                                        If PSetup."Loan Source" <> PSetup."Loan Source"::FOSA then
                                            CheckoffAdvice.Amount := 0;
                                    if MHeader."Loan Source" = MHeader."Loan Source"::MICRO then
                                        If PSetup."Loan Source" <> PSetup."Loan Source"::MICRO then
                                            CheckoffAdvice.Amount := 0;
                                end;



                                if CheckoffAdvice.Amount > 0 then
                                    CheckoffAdvice.Insert;


                            end;
                        end;


                        //Savings
                        SavingsAccounts.Reset;
                        SavingsAccounts.SetRange("Employer Code", EmployerFroup."Employer Code");
                        SavingsAccounts.SetFilter("Product Category", '%1', SavingsAccounts."Product Category"::"Deposit Contribution");
                        if SavingsAccounts.Find('-') then begin
                            dWindow.Open('Generating Advice:                  #1#########\'
                                                + 'Total Members:              #2#########\'
                                                + 'Counter:                    #3#########\'
                                                + 'Progress:                   @4@@@@@@@@@\'
                                                + 'Press Esc to abort');


                            NoOfRecords := SavingsAccounts.Count;
                            repeat
                                dWindow.Update(2, NoOfRecords);
                                dWindow.Update(1, SavingsAccounts."Name");
                                CurrentRecordNo += 1;
                                dWindow.Update(3, CurrentRecordNo);
                                dWindow.Update(4, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));

                                Memb.Get(SavingsAccounts."Member No.");
                                if (Memb."Member Status" <> Memb."Member Status"::Closed) and (Memb."Member Status" <> Memb."Member Status"::Deceased) then begin

                                    SavingsAccounts.CalcFields("Balance (LCY)");

                                    iEntryNo := 0;
                                    CheckoffAdvice.Reset;
                                    if CheckoffAdvice.Find('+') then
                                        iEntryNo := CheckoffAdvice."No.";

                                    iEntryNo += 1;

                                    CheckoffAdvice.Init;
                                    //CheckoffAdvice."No." := iEntryNo;
                                    CheckoffAdvice."Advice Header No." := HeaderNo;
                                    CheckoffAdvice."Account No." := SavingsAccounts."No.";
                                    CheckoffAdvice."Product Type" := SavingsAccounts."Product Type";
                                    CheckoffAdvice.Validate("Product Type");
                                    CheckoffAdvice."Product Name" := SavingsAccounts."Product Name";
                                    CheckoffAdvice."Loan No." := '';
                                    CheckoffAdvice."ID No." := Memb."ID No.";
                                    CheckoffAdvice."Member No." := Memb."No.";
                                    CheckoffAdvice."Employer Code" := Memb."Employer Code";
                                    CheckoffAdvice.Validate(CheckoffAdvice."Member No.");
                                    CheckoffAdvice.Name := Memb.Name;

                                    If (MHeader."Advice Type" = MHeader."Advice Type"::"Savings Balance Adjustments") then
                                        CheckoffAdvice."Advice Type" := CheckoffAdvice."Advice Type"::"Savings Balance Adjustments";
                                    If (MHeader."Advice Type" = MHeader."Advice Type"::"Savings Adjustments") then
                                        CheckoffAdvice."Advice Type" := CheckoffAdvice."Advice Type"::"Savings Adjustments";
                                    If (MHeader."Advice Type" = MHeader."Advice Type"::"New Savings") then
                                        CheckoffAdvice."Advice Type" := CheckoffAdvice."Advice Type"::"New Savings";

                                    CheckoffAdvice."Advice Date" := EndDate;
                                    CheckoffAdvice."Payroll No" := Memb."Payroll/Staff No.";
                                    CheckoffAdvice."Amount Off" := SavingsAccounts."Old Amount";
                                    CheckoffAdvice."Amount On" := SavingsAccounts."Monthly Contribution";
                                    CheckoffAdvice.Amount := SavingsAccounts."Monthly Contribution";
                                    CheckoffAdvice."Change Balance" := SavingsAccounts."Change Balance";
                                    CheckoffAdvice."Current Balance" := SavingsAccounts."Current Balance";
                                    CheckoffAdvice."Cummulative Contribution" := SavingsAccounts."Cummulative Contribution";



                                    if Employer."Advice Method" = Employer."advice method"::Everything then
                                        CheckoffAdvice."Advice Method" := CheckoffAdvice."advice method"::Everything
                                    else
                                        if Employer."Advice Method" = Employer."advice method"::Changes then
                                            CheckoffAdvice."Advice Method" := CheckoffAdvice."advice method"::Changes;

                                    if (MHeader."Advice Type" = MHeader."Advice Type"::"Full Advice") then begin
                                        CheckoffAdvice.Insert;
                                    end
                                    else begin


                                        If (MHeader."Advice Type" = MHeader."Advice Type"::"New Savings") then begin
                                            if CheckoffAdvice."Amount Off" = 0 then begin
                                                if CheckoffAdvice.Amount > 0 then
                                                    CheckoffAdvice.Insert;
                                            end;
                                        end;


                                        If (MHeader."Advice Type" = MHeader."Advice Type"::"Savings Adjustments") then begin
                                            if CheckoffAdvice."Amount Off" > 0 then begin
                                                if CheckoffAdvice.Amount > 0 then
                                                    CheckoffAdvice.Insert;
                                            end;
                                        end;

                                        If (MHeader."Advice Type" = MHeader."Advice Type"::"Savings Balance Adjustments") then begin
                                            if CheckoffAdvice."Change Balance" <> 0 then begin
                                                CheckoffAdvice.Insert;
                                            end;
                                        end;

                                    end;


                                end;

                            until SavingsAccounts.Next = 0;

                            dWindow.Close();
                        end;

                    until EmployerFroup.Next() = 0;
                end;
                dWindow.Close();

            end;

        end;
    end;


    /// <summary>
    /// GetDepositContribution.
    /// </summary>
    /// <param name="AccNo">Code[20].</param>
    /// <returns>Return variable DepAmt of type Decimal.</returns>
    procedure GetDepositContribution(AccNo: Code[20]; Class: Text[20]) DepAmt: Decimal;
    var
        Advice: Record "Monthly Checkoff Lines";
        Savings: Record "Savings Accounts";
        ChkHeader: Record "Monthly Checkoff Header";
        Classes: Record "Member Class";
    begin
        DepAmt := 0;
        Classes.Get(Class);
        Savings.Get(AccNo);
        case Savings."Product Category" of

            Savings."Product Category"::"Deposit Contribution":
                DepAmt := Classes."Default Share Deposits";
            Savings."Product Category"::"Share Capital":
                DepAmt := Classes."Default Share Capital";

        end;

        exit(DepAmt);

    end;


}

