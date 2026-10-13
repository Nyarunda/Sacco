table 50504 "LPO/LSO Line"
{
    Caption = 'LPO/LSO Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "LPO No."; Code[20])
        {
            Caption = 'LPO No.';
            DataClassification = CustomerContent;
            TableRelation = "LPO/LSO Header";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Item/Service Description"; Text[100])
        {
            Caption = 'Item/Service Description';
            DataClassification = CustomerContent;
        }
        field(4; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
            TableRelation = Item;
        }
        field(5; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(6; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            DataClassification = CustomerContent;
            AutoFormatType = 2;
        }
        field(7; "Total Price"; Decimal)
        {
            Caption = 'Total Price';
            DataClassification = CustomerContent;
            AutoFormatType = 1;
            Editable = false;
        }
        field(8; "Delivery Date"; Date)
        {
            Caption = 'Delivery Date';
            DataClassification = CustomerContent;
        }
        field(9; Terms; Text[250])
        {
            Caption = 'Terms';
            DataClassification = CustomerContent;
        }
        field(10; "Vendor Quotation Line No."; Integer)
        {
            Caption = 'Vendor Quotation Line No.';
            DataClassification = CustomerContent;
            TableRelation = "Vendor Quotation Line"."Line No." where("Quotation No." = field("Vendor Quotation No."));
        }
        field(11; "Vendor Quotation No."; Code[20])
        {
            Caption = 'Vendor Quotation No.';
            DataClassification = CustomerContent;
            TableRelation = "Vendor Quotation Header";
        }
    }

    keys
    {
        key(Key1; "LPO No.", "Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnModify()
    begin
        "Total Price" := Quantity * "Unit Price";
        UpdateHeaderAmount();
    end;

    trigger OnDelete()
    begin
        UpdateHeaderAmount();
    end;

    var
        LPOLSOHeader: Record "LPO/LSO Header";

    local procedure UpdateHeaderAmount()
    var
        LPOLSOLine: Record "LPO/LSO Line";
    begin
        LPOLSOHeader.Get("LPO No.");
        LPOLSOLine.SetRange("LPO No.", "LPO No.");
        LPOLSOLine.CalcSums("Total Price");
        LPOLSOHeader."Total Amount" := LPOLSOLine."Total Price";
        LPOLSOHeader.Modify(true);
    end;
}
