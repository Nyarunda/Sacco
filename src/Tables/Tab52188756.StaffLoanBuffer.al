table 50438 "Staff Loan Buffer"
{
    Caption = 'Staff Loan Buffer';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Loan No."; Code[15])
        {
            Caption = 'Loan No.';
        }
        field(2; "Payroll Period"; Date)
        { }
        field(3; "Payroll Month"; Integer)
        { }
        field(4; "Payroll Year"; Integer)
        { }
        field(5; Amount; Decimal)
        { }
        field(6; "Loan Interest Rate"; Decimal)
        { }
        field(7; "Loan Repayment"; Decimal)
        { }
        field(8; "Outstanding Balance"; Decimal)
        { }
        field(9; "Rec Found"; Boolean)
        { }
        field(10; "Member No."; code[100])
        { }
        field(11; "Payroll/Staff No."; code[10])
        { }
        field(12; "Repayment"; Decimal)
        { }
        field(13; "Product Type"; code[10])
        { }
        field(14; "Payroll Transaction Code"; code[10])
        { }
        field(15; "Ledger Fee Balance"; Decimal)
        { }

    }
    keys
    {
        key(PK; "Loan No.")
        {
            Clustered = true;
        }
    }
}
