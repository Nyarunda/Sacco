
/// <summary>
/// Table Property Codes (ID 50199).
/// </summary>
Table 50199 "Tiered Debt Threshold"
{

    fields
    {

        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Loan Product"; Code[10])
        {
            TableRelation = "Product Setup";


        }
        field(3; "Lower Limit"; Decimal)
        {
            Caption = 'Lower Base Limit';

            trigger OnValidate()
            begin
                if "Lower Limit" > "Upper Limit" then begin
                    if "Upper Limit" > 0 then Error(ErrLimits);
                end;
            end;
        }
        field(4; "Upper Limit"; Decimal)
        {
            Caption = 'Upper Base Limit';

            trigger OnValidate()
            begin
                Validate("Lower Limit");
            end;
        }
        field(5; "Maximum Loan Term"; Integer)
        {

        }

    }

    keys
    {
        key(Key1; "Loan Product", "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ErrLimits: label 'The Lower Limit cannot be more than the Upper Limit';

}

