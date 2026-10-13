
Table 50226 "Payroll Employee Transactions"
{

    fields
    {
        field(1; "Employee Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            Description = '"HR Employees".No.';
        }
        field(2; "Transaction Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            Description = '"Payroll Codes"."Transaction Code" WHERE (Transaction Type=FILTER(Earning|Deduction))';

            trigger OnValidate()
            begin
                Transcode.Reset;
                Transcode.SetRange(Transcode."Transaction Code", "Transaction Code");
                if Transcode.Find('-') then
                    "Transaction Name" := Transcode."Transaction Name";

                if Transcode."Special Identifier" = Transcode."special identifier"::NHIF then
                    Error('Invalid Code');

                if Transcode."Special Identifier" = Transcode."special identifier"::NSSF then
                    Error('Invalid Code');


                if Employee.Get("Employee Code") then begin
                    if Employee.Status = Employee.Status::Active then begin

                        if Employee."Member No" = '' then
                            Error('Member No. not captured under HR List: %1', "Employee Code");
                        Members.Get(Employee."Member No");

                        "Sub-Ledger" := "sub-ledger"::"G/L Account";
                        Balance := 0;
                        Amount := 0;
                        "Loan No." := '';
                        "Member No." := Members."No.";


                        Transcode.Reset;
                        Transcode.SetRange(Transcode."Transaction Code", "Transaction Code");
                        Transcode.SetRange(Transcode.Subledger, Transcode.Subledger::Savings);
                        if Transcode.Find('-') then begin

                            "Sub-Ledger" := "sub-ledger"::Savings;

                            MemberAccounts.Reset;
                            MemberAccounts.SetRange("Member No.", Members."No.");
                            MemberAccounts.SetRange("Product Type", Transcode."Sub-Ledger Product Type");
                            if MemberAccounts.FindFirst then begin
                                repeat
                                    "Sub-Ledger Account" := MemberAccounts."No.";
                                    MemberAccounts.CalcFields("Balance (LCY)");
                                    Balance := MemberAccounts."Balance (LCY)";
                                    Amount += MemberAccounts."Monthly Contribution";
                                until MemberAccounts.Next() = 0;
                            end;

                        end;

                        Transcode.Reset;
                        Transcode.SetRange(Transcode."Transaction Code", "Transaction Code");
                        Transcode.SetRange(Transcode.Subledger, Transcode.Subledger::Credit);
                        if Transcode.Find('-') then begin

                            "Sub-Ledger" := "sub-ledger"::Credit;
                            "Sub-Ledger Account" := Members."No.";
                            if Transcode."Special Transactions" = Transcode."special transactions"::"Staff Loan" then begin
                                Transcode.TestField("Sub-Ledger Product Type");

                                Balance := 0;
                                Amount := 0;
                                Loans.Reset;
                                Loans.SetRange("Member No.", Members."No.");
                                Loans.SetRange("Loan Product Type", Transcode."Sub-Ledger Product Type");
                                Loans.SetFilter("Outstanding Principal", '>0');
                                if Loans.FindFirst then begin
                                    Loans.CalcFields("Outstanding Principal");
                                    Balance := Loans."Outstanding Principal";
                                    "Loan No." := Loans."Loan No.";

                                    LSchedule.Reset();
                                    LSchedule.SetRange("Loan No.", Loans."Loan No.");
                                    LSchedule.SetRange("Repayment Date", CalcDate('-CM', "Payroll Period"), CalcDate('CM', "Payroll Period"));
                                    if LSchedule.FindFirst() then begin
                                        Amount := LSchedule."Monthly Principal";
                                    end else
                                        Amount := Loans."Loan Principle Repayment";

                                    //MESSAGE('Loan Balance: %1\Loan Principal Repayment: %2',Loans."Outstanding Loan Principal",Loans."Loan Principal Repayment");
                                end;
                            end;

                        end;

                    end;
                end;
            end;
        }
        field(3; "Transaction Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Balance; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //"Employer Balance" := 0;
                //IF (Balance > 0) AND ("#of Repayments" > 0) THEN
                //Amount:=Balance/"#of Repayments"
            end;
        }
        field(6; "Period Month"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Period Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payroll Periods"."Date Opened";
        }
        field(9; "Employer Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Employer Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Payroll Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Stopped; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Loans where("Member No." = field("Member No."),
                                       "Total Outstanding Balance" = filter(> 0));

            trigger OnValidate()
            var
                LSchedule: Record "Loan Repayment Schedule";
            begin
                if "Loan No." <> '' then begin
                    if Loans.Get("Loan No.") then begin

                        Loans.CalcFields("Outstanding Principal", "Outstanding Interest");
                        Balance := Loans."Outstanding Principal";
                        LSchedule.Reset();
                        LSchedule.SetRange("Loan No.", "Loan No.");
                        LSchedule.SetRange("Repayment Date", CalcDate('-CM', "Payroll Period"), CalcDate('CM', "Payroll Period"));
                        if LSchedule.FindFirst() then begin
                            Amount := LSchedule."Monthly Principal";
                        end else
                            Amount := Loans."Loan Principle Repayment";

                    end;
                    Message('Loan Balance: %1\Loan Principal Repayment: %2', Loans."Outstanding Principal", Loans."Loan Principle Repayment");

                end;
            end;
        }
        field(16; "Sub-Ledger"; Enum "Gen. Journal Account Type")
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Sub-Ledger Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Sub-Ledger" = const(Vendor)) Vendor
            else
            if ("Sub-Ledger" = const(Customer)) Customer;
        }
        field(18; "Interest Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Member No."; Code[20])
        {
            trigger Onvalidate()
            var
                myInt: Integer;
            begin
                if "Member No." <> '' then begin
                    if Employee.Get("Employee Code") then begin
                        Employee."Member No" := "Member No.";
                        Employee.Modify();
                    end;

                end
                else begin

                    if Employee.Get("Employee Code") then begin
                        if Employee."Member No" <> '' then
                            "Member No." := Employee."Member No";
                    end;
                end;
            end;
        }
        field(20; "User Defined Loan Interest"; Decimal)
        {
        }
        field(21; "Amortization Total Repayment"; Decimal)
        {
        }
        field(22; EntryNo; Integer)
        {
            AutoIncrement = true;
        }
        field(32; "Loan Product Type"; Code[20])
        {
            TableRelation = "Approval Tracker";
        }
        field(33; "Transaction Type"; Option)
        {
            CalcFormula = lookup("Payroll Codes"."Transaction Type" where("Transaction Code" = field("Transaction Code")));
            FieldClass = FlowField;
            OptionMembers = Earning,Deduction,"Basic Pay","Gross Pay","Net Pay",PAYE;
        }
        field(34; "Coop Parameters"; option)
        {
            CalcFormula = Lookup("Payroll Codes"."Special Transactions" where("Transaction Code" = field("Transaction Code")));
            fieldclass = flowfield;
            OptionMembers = "None","Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Custom 1",Mortgage,"Salary Arrears","Staff Loan","Education Insurance","Staff Welfare","Salary Advance",Overtime;

        }
        field(35; "Reference No"; code[50])
        {

        }
        field(36; "User Defined Loan Insurance"; Decimal)
        {
        }
        field(37; "Principal Repayment Preset"; Decimal)
        {
            trigger OnValidate()
            var
                SchedulePrincipalRepayment: Decimal;
            begin
                if "Principal Repayment Preset" < 0 then
                    Error('Principal Repayment Preset cannot be negative.');

                if "Principal Repayment Preset" = 0 then
                    exit;

                TestField("Loan No.");
                TestField("Payroll Period");

                SchedulePrincipalRepayment := GetSchedulePrincipalRepayment();
                if ("Principal Repayment Preset" < SchedulePrincipalRepayment) then
                    Error(
                        'Principal Repayment Preset cannot be less than the scheduled principal repayment of %1 for loan %2 in payroll period %3.',
                        SchedulePrincipalRepayment,
                        "Loan No.",
                        "Payroll Period");
            end;
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Transaction Code", "Payroll Period", EntryNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        LSchedule: Record "Loan Repayment Schedule";
        EmployeeTrans: Record "Payroll Employee Transactions";
        Transcode: Record "Payroll Codes";
        Employee: Record Employee;
        Members: Record Members;
        Loans: Record Loans;
        MemberAccounts: Record "Savings Accounts";

    local procedure GetSchedulePrincipalRepaymentOld(): Decimal
    var
        LoanSchedule: Record "Loan Repayment Schedule";
        LoanRec: Record Loans;
    begin
        LoanSchedule.Reset();
        LoanSchedule.SetRange("Loan No.", "Loan No.");
        LoanSchedule.SetFilter("Monthly Principal", '>0');
        LoanSchedule.SetRange("Repayment Date", CalcDate('-CM', "Payroll Period"), CalcDate('CM', "Payroll Period"));
        if LoanSchedule.FindFirst() then
            exit(LoanSchedule."Monthly Principal");

        if LoanRec.Get("Loan No.") then
            exit(LoanRec."Loan Principle Repayment");

        exit(0);
    end; // changed on 092226

    local procedure GetSchedulePrincipalRepayment(): Decimal
    var
        LoanSchedule: Record "Loan Repayment Schedule";
        LoanRec: Record Loans;
        OutstandingPrincipal: Decimal;
        ExpectedLoanBalance: Decimal;
        MonthlyPrincipal: Decimal;
        PrincipalDue: Decimal;
        PeriodStartDate: Date;
        PeriodEndDate: Date;
    begin
        PeriodStartDate := CalcDate('-CM', "Payroll Period");
        PeriodEndDate := CalcDate('CM', "Payroll Period");

        OutstandingPrincipal := 0;
        ExpectedLoanBalance := 0;
        MonthlyPrincipal := 0;
        PrincipalDue := 0;

        if not LoanRec.Get("Loan No.") then
            exit(0);

        LoanRec.CalcFields("Outstanding Principal");
        OutstandingPrincipal := LoanRec."Outstanding Principal";

        if OutstandingPrincipal <= 0 then
            exit(0);

        LoanSchedule.Reset();
        LoanSchedule.SetRange("Loan No.", "Loan No.");
        LoanSchedule.SetRange("Repayment Date", PeriodStartDate, PeriodEndDate);

        if not LoanSchedule.FindFirst() then
            exit(LoanRec."Loan Principle Repayment");

        ExpectedLoanBalance := LoanSchedule."Loan Balance";
        MonthlyPrincipal := LoanSchedule."Monthly Principal";

        PrincipalDue := OutstandingPrincipal - ExpectedLoanBalance;

        if PrincipalDue <= 0 then
            exit(0);

        if PrincipalDue >= MonthlyPrincipal then
            exit(MonthlyPrincipal);

        exit(PrincipalDue);
    end;
}
