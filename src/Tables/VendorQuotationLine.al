table 50512 "Vendor Quotation Line"
{
    Caption = 'Vendor Quotation Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Quotation No."; Code[20])
        {
            Caption = 'Quotation No.';
            DataClassification = CustomerContent;
            TableRelation = "Vendor Quotation Header";
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
        field(8; "Delivery Timeframe"; Date)
        {
            Caption = 'Delivery Timeframe';
            DataClassification = CustomerContent;
        }
        field(9; Availability; Option)
        {
            Caption = 'Availability';
            OptionMembers = "Available","Limited Stock","Out of Stock","Custom Order";
            OptionCaption = 'Available,Limited Stock,Out of Stock,Custom Order';
            DataClassification = CustomerContent;
        }
        field(10; "RFQ Line No."; Integer)
        {
            Caption = 'RFQ Line No.';
            DataClassification = CustomerContent;
            TableRelation = "RFQ Line"."Line No." where("No." = field("RFQ No."));
        }
        field(11; "RFQ No."; Code[20])
        {
            Caption = 'RFQ No.';
            DataClassification = CustomerContent;
            TableRelation = "RFQ Header";
        }
        field(12; Type; Enum "Purchase Line Type")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Quotation No.", "Line No.")
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
        VendorQuotationHeader: Record "Vendor Quotation Header";

    local procedure UpdateHeaderAmount()
    var
        VendorQuotationLine: Record "Vendor Quotation Line";
    begin
        VendorQuotationHeader.Get("Quotation No.");
        VendorQuotationLine.SetRange("Quotation No.", "Quotation No.");
        VendorQuotationLine.CalcSums("Total Price");
        VendorQuotationHeader."Total Amount" := VendorQuotationLine."Total Price";
        VendorQuotationHeader.Modify(true);
    end;
}
