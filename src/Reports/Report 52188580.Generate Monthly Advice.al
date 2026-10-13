
Report 50243 "Generate Monthly Advice"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Generate Monthly Advice.rdlc';

    dataset
    {
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Employer; EmpCode)
                {
                    ApplicationArea = Basic;
                    TableRelation = Customer where("Account Type" = const(Employer));
                }
                field("Start Date"; StartDate)
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; EndDate)
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

    trigger OnPreReport()
    begin
        MonthlyCheckoffAdvice;
    end;

    var
        EmpCode: Code[20];
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


    procedure MonthlyCheckoffAdvice()
    var
        Loans: Record Loans;
        Employer: Record Customer;
        iEntryNo: Integer;
        SavingsAccounts: Record "Savings Accounts";
        Memb: Record Members;
        InterestAmount: Decimal;
        Mdays: Integer;
        CheckoffLoan: Boolean;
        CheckoffAdvice: Record "Monthly Advice";
        SaccoActivities: Codeunit "Sacco Activities";
        Amt: Decimal;
        Source: Option Savings,Credit;
        GracePeriod: DateFormula;
        PSetup: Record "Product Setup";
    begin
        if Employer.Get(EmpCode) then begin

            if Employer."Advice Method" = Employer."advice method"::" " then
                Error('Kindly Specify Employer Advice Type');


            //Delete Records
            CheckoffAdvice.Reset;
            CheckoffAdvice.SetRange("Employer Code", EmpCode);
            CheckoffAdvice.SetRange(Processed, false);
            CheckoffAdvice.SetRange("Advice Date", EndDate);
            if CheckoffAdvice.Find('-') then begin
                CheckoffAdvice.DeleteAll;
            end;

            AsAt := StartDate - 1;

            Memb.Reset;
            Memb.SetRange("Employer Code", Employer."No.");
            Memb.SetFilter("Member Status", '<>%1&<>%2', Memb."Member Status"::Closed, Memb."Member Status"::Deceased);
            if Memb.Find('-') then begin

                dWindow.Open('Generating Advice:                  #1#########\'
                                    + 'Total Members:              #2#########\'
                                    + 'Counter:                    #3#########\'
                                    + 'Progress:                   @4@@@@@@@@@\'
                                    + 'Press Esc to abort');

                repeat
                    NoOfRecords := Memb.Count;
                    dWindow.Update(2, NoOfRecords);
                    dWindow.Update(1, Memb.Name);
                    CurrentRecordNo += 1;
                    dWindow.Update(3, CurrentRecordNo);
                    dWindow.Update(4, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));



                    Loans.Reset;
                    Loans.SetRange("Member No.", Memb."No.");
                    Loans.SetFilter(Loans."Outstanding Principal", '>0');
                    //Loans.SetRange("Repay Mode", Loans."Repay Mode"::"Check Off");
                    if Employer."Advice Method" = Employer."advice method"::Everything then
                        Loans.SetFilter("Disbursement Date", '..%1', EndDate)
                    else
                        if Employer."Advice Method" = Employer."advice method"::Changes then
                            Loans.SetFilter("Disbursement Date", '%1..%2', StartDate, EndDate);

                    if Loans.Find('-') then begin
                        repeat

                            CheckoffLoan := false;
                            Loans.CalcFields("Outstanding Principal", "Outstanding Interest", "Outstanding Penalty", "Outstanding Appraisal", "Total Outstanding Balance", "Principal Arrears");


                            iEntryNo := 0;
                            CheckoffAdvice.Reset;
                            if CheckoffAdvice.Find('+') then
                                iEntryNo := CheckoffAdvice."No.";
                            iEntryNo += 1;
                            Source := Source::Credit;

                            Amt := 0;
                            DefAmount := 0;
                            ExpectedAmt := 0;
                            AmtPaid := 0;
                            DaysInArrear := 0;
                            SaccoActivities.GetDefaultedAmount(Loans."Loan No.", AsAt, ExpectedAmt, AmtPaid, DefAmount, DaysInArrear, ArrearsDate, true, GracePeriod);

                            CheckoffAdvice.Init;
                            CheckoffAdvice."No." := iEntryNo;
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
                            Loans.TestField(Repayment);
                            if Loans."Outstanding Appraisal" > 0 then
                                CheckoffAdvice.Appraisal := Loans."Outstanding Appraisal";

                            if Loans."Outstanding Penalty" > 0 then
                                CheckoffAdvice.Penalty := Loans."Outstanding Penalty";

                            if Loans."Outstanding Interest" > 0 then
                                CheckoffAdvice.Interest := Loans."Outstanding Interest";


                            CheckoffAdvice.Principal := Loans."Loan Principle Repayment";

                            if Loans."Interest Calculation Method" = Loans."interest calculation method"::Amortised then begin
                                RSchedule.Reset;
                                RSchedule.SetRange("Loan No.", Loans."Loan No.");
                                RSchedule.SetRange("Repayment Date", 0D, EndDate);
                                if RSchedule.FindFirst then
                                    CheckoffAdvice.Principal := RSchedule."Monthly Principal";
                            end;

                            CheckoffAdvice."Principal Arrears" := Loans."Principal Arrears";
                            if Amt <= 0 then
                                Amt := CheckoffAdvice.Appraisal + CheckoffAdvice.Penalty + CheckoffAdvice.Interest + CheckoffAdvice.Principal + CheckoffAdvice."Principal Arrears";

                            CheckoffAdvice.Amount := Amt;

                            CheckoffAdvice."Advice Date" := EndDate;
                            CheckoffAdvice."Payroll No" := Memb."Payroll/Staff No.";
                            CheckoffAdvice."Loan Balance" := Loans."Total Outstanding Balance";

                            if Employer."Advice Method" = Employer."advice method"::Everything then
                                CheckoffAdvice."Advice Method" := CheckoffAdvice."advice method"::Everything
                            else
                                if Employer."Advice Method" = Employer."advice method"::Changes then
                                    CheckoffAdvice."Advice Method" := CheckoffAdvice."advice method"::Changes;


                            if CheckoffAdvice.Amount > 0 then
                                CheckoffAdvice.Insert;

                        until Loans.Next = 0;

                    end;


                    //Savings
                    SavingsAccounts.Reset;
                    SavingsAccounts.SetRange("Member No.", Memb."No.");
                    SavingsAccounts.SetFilter("Product Category", '<>%1', SavingsAccounts."product category"::"Registration Fee");
                    if Employer."Advice Method" = Employer."advice method"::Changes then
                        SavingsAccounts.SetRange("Monthly Contribution Date", StartDate, EndDate);

                    if SavingsAccounts.Find('-') then begin
                        repeat

                            PSetup.Get(SavingsAccounts."Product Type");
                            SavingsAccounts.CalcFields("Balance (LCY)");

                            Amt := 0;
                            iEntryNo := 0;
                            CheckoffAdvice.Reset;
                            if CheckoffAdvice.Find('+') then
                                iEntryNo := CheckoffAdvice."No.";
                            Source := Source::Savings;
                            SaccoActivities.GetCheckoffInstructions(SavingsAccounts."No.", Amt, Source);
                            if Amt <= 0 then
                                Amt := SavingsAccounts."Monthly Contribution";

                            if Amt = 0 then Amt := PSetup."Minimum Contribution";

                            iEntryNo += 1;

                            CheckoffAdvice.Init;
                            CheckoffAdvice."No." := iEntryNo;
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
                            CheckoffAdvice."Advice Date" := EndDate;
                            CheckoffAdvice."Payroll No" := Memb."Payroll/Staff No.";
                            CheckoffAdvice.Amount := Amt;
                            if Employer."Advice Method" = Employer."advice method"::Everything then
                                CheckoffAdvice."Advice Method" := CheckoffAdvice."advice method"::Everything
                            else
                                if Employer."Advice Method" = Employer."advice method"::Changes then
                                    CheckoffAdvice."Advice Method" := CheckoffAdvice."advice method"::Changes;

                            if CheckoffAdvice.Amount > 0 then
                                CheckoffAdvice.Insert;

                        until SavingsAccounts.Next = 0;

                    end;

                until Memb.Next = 0;
                dWindow.Close;

            end;
        end;
    end;
}

