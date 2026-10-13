table 50539 "Mobile Loan Limit"
{
    Caption = 'Mobile Loan Limit';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Account No."; Code[20])
        {
            Caption = 'Account No.';
        }
        field(2; "Loan Type"; Code[20])
        {
            Caption = 'Loan Type';
            TableRelation = "Product Setup"."Product ID" where("Product Class" = const(Credit), Status = const(Active), "Available on Mobile" = const(true));

            trigger OnValidate()
            var
                PSetup: Record "Product Setup";
            begin
                PSetup.Get("Loan Type");
                "Repay Mode" := PSetup."Repay Mode";
            end;
        }
        field(3; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(4; "Repay Mode"; Enum "Repay Mode Enum")
        {
            DataClassification = ToBeClassified;
            ValuesAllowed = " ", Salary, "Check Off", "Dividends", "Internal Standing Order", "External Standing Order", "Pension", Allowance, Cash;
        }
    }
    keys
    {
        key(PK; "Account No.", "Loan Type")
        {
            Clustered = true;
        }
    }
}
