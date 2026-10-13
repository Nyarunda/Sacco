table 50100 "RFQ Vendors Quotations"
{
    Caption = 'RFQ Vendors Quotations';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No"; Code[20])
        {
            Caption = 'Document No';
            DataClassification = CustomerContent;
        }
        field(2; "Type"; Enum "Purchase Line Type")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(3; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(4; Quantity; Integer)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Amount := "Unit Cost" * Quantity;
            end;
        }
        field(5; "Unit Cost"; Decimal)
        {
            Caption = 'Unit Cost';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Amount := "Unit Cost" * Quantity;
            end;
        }
        field(6; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
        field(7; "Vendor No"; Code[30])
        {
            Caption = 'Vendor No';
            DataClassification = CustomerContent;
        }
        field(8; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
    }
    keys
    {
        key(PK; "Document No", "Type", "Vendor No", "Line No.")
        {
            Clustered = true;
        }
    }
}
