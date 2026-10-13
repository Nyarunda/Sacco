
Table 50149 "Staggered Lines."
{

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(5; "Lower Limit"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Minimum Amount';
            MinValue = 0;

            trigger OnValidate()
            begin
                CheckMinimalAmount;
            end;
        }
        field(6; "Discount %"; Decimal)
        {
            Caption = 'Discount %';
            MaxValue = 100;
            MinValue = 0;
        }
        field(50000; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "O365 Cust. Disc",Staggered;
        }
        field(50001; "Upper Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Charge Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Use Percentage"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; Percentage; Decimal)
        {
            DecimalPlaces = 5;
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Code", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(Brick; "Lower Limit", "Discount %")
        {
        }
    }

    var
        DuplicateMinimumAmountErr: label 'Customer Invoice Discount with Minimal Amount %1 already exists.', Comment = '%1 - some amount';

    local procedure CheckMinimalAmount()
    var
        CustInvoiceDisc: Record "Cust. Invoice Disc.";
    begin
        CustInvoiceDisc.SetRange(Code, Code);
        CustInvoiceDisc.SetRange("Minimum Amount", "Lower Limit");
        if not CustInvoiceDisc.IsEmpty then
            Error(DuplicateMinimumAmountErr, "Lower Limit");
    end;
}

