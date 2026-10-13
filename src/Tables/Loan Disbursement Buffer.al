
table 50012 "Loan Disbursement Buffer"
{
    fields
    {
        field(1; "Loan Type"; Code[60]) { }
        field(2; "Branch"; Code[20]) { }
        field(3; "Amount Previous Month"; Decimal) { }
        field(4; "Amount Current Month"; Decimal) { }
        field(5; "Variance"; Decimal) { }
        field(6; "No. of Applicants"; Integer) { }
        field(7; "Previous Month"; Text[20]) { }
        field(8; "Current Month"; Text[20]) { }
        field(9; "Total Amount"; Decimal) { }
        field(10; "Total Previous Month"; Decimal)
        {
            CalcFormula = sum("Loan Disbursement Buffer"."Amount Previous Month" where("Loan Type" = field("Loan Type")));
            FieldClass = FlowField;
        }
        field(11; "Total Current Month"; Decimal)
        {
            CalcFormula = sum("Loan Disbursement Buffer"."Amount Current Month" where("Loan Type" = field("Loan Type")));
            FieldClass = FlowField;
        }
    }

    keys
    {

        key(key1; "Loan Type", Branch)
        {

        }
    }
}
