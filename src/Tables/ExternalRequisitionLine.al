table 50501 "External Requisition Line"
{
    Caption = 'External Requisition Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Requisition No."; Code[20])
        {
            Caption = 'Requisition No.';
            DataClassification = CustomerContent;
            TableRelation = "External Requisition Header";
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
        field(6; "Unit Cost"; Decimal)
        {
            Caption = 'Unit Cost';
            DataClassification = CustomerContent;
            AutoFormatType = 2;
        }
        field(7; "Total Cost"; Decimal)
        {
            Caption = 'Total Cost';
            DataClassification = CustomerContent;
            AutoFormatType = 1;
            Editable = false;
        }
        field(8; "Budget Dimension 1"; Code[20])
        {
            Caption = 'Budget Dimension 1';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Dimension Code" = field("Budget Dimension 1 Code"));
        }
        field(9; "Budget Dimension 1 Code"; Code[20])
        {
            Caption = 'Budget Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = Dimension;
        }
        field(10; "Budget Dimension 2"; Code[20])
        {
            Caption = 'Budget Dimension 2';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Dimension Code" = field("Budget Dimension 2 Code"));
        }
        field(11; "Budget Dimension 2 Code"; Code[20])
        {
            Caption = 'Budget Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = Dimension;
        }
        field(12; "Budget Dimension 3"; Code[20])
        {
            Caption = 'Budget Dimension 3';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Dimension Code" = field("Budget Dimension 3 Code"));
        }
        field(13; "Budget Dimension 3 Code"; Code[20])
        {
            Caption = 'Budget Dimension 3 Code';
            DataClassification = CustomerContent;
            TableRelation = Dimension;
        }
        field(14; "Store Requisition Line No."; Integer)
        {
            Caption = 'Store Requisition Line No.';
            DataClassification = CustomerContent;
            TableRelation = "Store Requisition Lines"."Line No." where("Requistion No" = field("Store Requisition No."));
        }
        field(15; "Store Requisition No."; Code[20])
        {
            Caption = 'Store Requisition No.';
            DataClassification = CustomerContent;
            TableRelation = "Store Requisition Header";
        }
    }

    keys
    {
        key(Key1; "Requisition No.", "Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnModify()
    begin
        "Total Cost" := Quantity * "Unit Cost";
        UpdateHeaderAmount();
    end;

    trigger OnDelete()
    begin
        UpdateHeaderAmount();
    end;

    var
        ExternalRequisitionHeader: Record "External Requisition Header";

    local procedure UpdateHeaderAmount()
    var
        ExternalRequisitionLine: Record "External Requisition Line";
    begin
        ExternalRequisitionHeader.Get("Requisition No.");
        ExternalRequisitionLine.SetRange("Requisition No.", "Requisition No.");
        ExternalRequisitionLine.CalcSums("Total Cost");
        ExternalRequisitionHeader."Total Amount" := ExternalRequisitionLine."Total Cost";
        ExternalRequisitionHeader.Modify(true);
    end;
}
