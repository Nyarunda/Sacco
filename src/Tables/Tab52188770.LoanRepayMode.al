/// <summary>
/// Table Loan Repay Mode (ID 50452).
/// </summary>
table 50452 "Loan Repay Mode"
{
    Caption = 'Loan Repay Mode';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Repay Mode"; Enum "Repay Mode Enum")
        {
            Caption = 'Repay Mode';
            ValuesAllowed = " ", Salary, "Check Off", "Dividends", "Internal Standing Order", "External Standing Order", "Pension", Allowance, Cash, Property;
        }

        field(6; Amount; Decimal)
        {
            Caption = 'Amount';
        }
    }
    keys
    {
        key(Key1; "Loan No.", "Repay Mode")
        {
            Clustered = true;
        }
    }
}
