table 50514 "Goods Receipt Note Line"
{
    Caption = 'Goods Receipt Note Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "GRN No."; Code[20])
        {
            Caption = 'GRN No.';
            DataClassification = CustomerContent;
            TableRelation = "Goods Receipt Note Header";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
            TableRelation = Item;
        }
        field(4; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(5; "Quantity Ordered"; Decimal)
        {
            Caption = 'Quantity Ordered';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
        }
        field(6; "Quantity Received"; Decimal)
        {
            Caption = 'Quantity Received';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(7; "Quantity Accepted"; Decimal)
        {
            Caption = 'Quantity Accepted';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
        }
        field(8; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            DataClassification = CustomerContent;
            AutoFormatType = 2;
        }
        field(9; "Total Value"; Decimal)
        {
            Caption = 'Total Value';
            DataClassification = CustomerContent;
            AutoFormatType = 1;
        }
        field(10; "LPO No."; Code[20])
        {
            Caption = 'LPO No.';
            DataClassification = CustomerContent;
            TableRelation = "LPO/LSO Header";
        }
        field(11; "LPO Line No."; Integer)
        {
            Caption = 'LPO Line No.';
            DataClassification = CustomerContent;
            TableRelation = "LPO/LSO Line"."Line No." where("LPO No." = field("LPO No."));
        }
        field(12; "Quality Inspection Passed"; Boolean)
        {
            Caption = 'Quality Inspection Passed';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "GRN No.", "Line No.")
        {
            Clustered = true;
        }
    }

    local procedure CalcTotals()
    begin
        if "Quality Inspection Passed" then
            "Quantity Accepted" := "Quantity Received"
        else
            "Quantity Accepted" := 0;

        "Total Value" := "Quantity Accepted" * "Unit Price";
    end;
}

