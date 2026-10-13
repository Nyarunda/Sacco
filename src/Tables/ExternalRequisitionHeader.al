table 50500 "External Requisition Header"
{
    Caption = 'External Requisition Header';
    DataClassification = CustomerContent;
   // LookupPageId = "External Requisition List";
    //DrillDownPageId = "External Requisition List";

    fields
    {
        field(1; "Requisition No."; Code[20])
        {
            Caption = 'Requisition No.';
            DataClassification = CustomerContent;
        }
        field(2; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('DEPARTMENT'));
        }
        field(3; "Request Date"; Date)
        {
            Caption = 'Request Date';
            DataClassification = CustomerContent;
        }
        field(4; "Required Date"; Date)
        {
            Caption = 'Required Date';
            DataClassification = CustomerContent;
        }
        field(5; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Open,"Pending Approval",Approved,Rejected,"RFQ Created","LPO Created";
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,RFQ Created,LPO Created';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(6; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            DataClassification = CustomerContent;
            AutoFormatType = 1;
            Editable = false;
        }
        field(7; "Approval Status"; Option)
        {
            Caption = 'Approval Status';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            DataClassification = CustomerContent;
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
            TableRelation =Dimension;
        }
        field(14; "Store Requisition No."; Code[20])
        {
            Caption = 'Store Requisition No.';
            DataClassification = CustomerContent;
            TableRelation = "Store Requisition Header";
        }
        field(15; "RFQ No."; Code[20])
        {
            Caption = 'RFQ No.';
            DataClassification = CustomerContent;
            TableRelation = "RFQ Header";
            Editable = false;
        }
        field(16; "LPO No."; Code[20])
        {
            Caption = 'LPO No.';
            DataClassification = CustomerContent;
            TableRelation = "LPO/LSO Header";
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Requisition No.")
        {
            Clustered = true;
        }
        key(Key2; Status, "Request Date")
        {
        }
        key(Key3; "Department Code", "Request Date")
        {
        }
    }

    trigger OnInsert()
    var
        ProcurementSetup: Record "Procurement Setup";
        NoSeriesMgt: Codeunit "No. Series";
    begin
        if "Requisition No." = '' then begin
            ProcurementSetup.Get();
            ProcurementSetup.TestField("External Requisition Nos.");
            "Requisition No." := NoSeriesMgt.GetNextNo(ProcurementSetup."External Requisition Nos.", WorkDate(), true);
        end;
        if "Request Date" = 0D then
            "Request Date" := WorkDate();
    end;

    trigger OnDelete()
    var
        ExternalRequisitionLine: Record "External Requisition Line";
    begin
        if Status <> Status::Open then
            Error('You cannot delete a requisition that is not in Open status.');
        ExternalRequisitionLine.SetRange("Requisition No.", "Requisition No.");
        ExternalRequisitionLine.DeleteAll(true);
    end;
}
