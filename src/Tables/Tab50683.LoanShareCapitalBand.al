table 50683 "Loan Share Capital Band"
{
    Caption = 'Loan Share Capital Band';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Loan Product"; Code[20])
        {
            Caption = 'Loan Product';
            TableRelation = "Product Setup"."Product ID" where("Product Class" = const(Credit));
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Minimum Amount"; Decimal)
        {
            Caption = 'Minimum Amount';
            MinValue = 0;

            trigger OnValidate()
            begin
                ValidateAmountRange();
            end;
        }
        field(4; "Maximum Amount"; Decimal)
        {
            Caption = 'Maximum Amount';
            MinValue = 0;

            trigger OnValidate()
            begin
                ValidateAmountRange();
            end;
        }
        field(5; "Required Share Capital"; Decimal)
        {
            Caption = 'Required Share Capital';
            MinValue = 0;
        }
    }

    keys
    {
        key(PK; "Loan Product", "Line No.")
        {
            Clustered = true;
        }
        key(AmountBand; "Loan Product", "Minimum Amount", "Maximum Amount")
        {
        }
    }

    local procedure ValidateAmountRange()
    begin
        if ("Maximum Amount" <> 0) and ("Maximum Amount" < "Minimum Amount") then
            Error('Maximum amount cannot be less than minimum amount.');
    end;
}
