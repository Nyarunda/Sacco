table 50517 "Procurement Cue"
{
    Caption = 'Procurement Cue';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(10; "Open Store Requisitions"; Integer)
        {
            Caption = 'Open Store Requisitions';
            FieldClass = FlowField;
            CalcFormula = count("Store Requisition Header" where(Status = const(Open)));
            Editable = false;
        }
        field(11; "Pending Store Requisitions"; Integer)
        {
            Caption = 'Pending Store Requisitions';
            FieldClass = FlowField;
            CalcFormula = count("Store Requisition Header" where(Status = const("Pending Approval")));
            Editable = false;
        }
        field(20; "Open RFQs"; Integer)
        {
            Caption = 'Open RFQs';
            FieldClass = FlowField;
            CalcFormula = count("RFQ Header" where(Status = const(Open)));
            Editable = false;
        }
        field(21; "RFQs Under Evaluation"; Integer)
        {
            Caption = 'RFQs Under Evaluation';
            FieldClass = FlowField;
            CalcFormula = count("RFQ Header" where(Status = const("Under Evaluation")));
            Editable = false;
        }
        field(22; "Awarded RFQs"; Integer)
        {
            Caption = 'Awarded RFQs';
            FieldClass = FlowField;
            CalcFormula = count("RFQ Header" where(Status = const(Awarded)));
            Editable = false;
        }
        field(30; "Submitted Quotations"; Integer)
        {
            Caption = 'Submitted Quotations';
            FieldClass = FlowField;
            CalcFormula = count("Vendor Quotation Header" where(Status = const(Submitted)));
            Editable = false;
        }
        field(31; "Quotations Under Evaluation"; Integer)
        {
            Caption = 'Quotations Under Evaluation';
            FieldClass = FlowField;
            CalcFormula = count("Vendor Quotation Header" where(Status = const("Under Evaluation")));
            Editable = false;
        }
        field(40; "Open LPOs/LSOs"; Integer)
        {
            Caption = 'Open LPOs/LSOs';
            FieldClass = FlowField;
            CalcFormula = count("LPO/LSO Header" where(Status = const(Open)));
            Editable = false;
        }
        field(41; "Pending LPOs/LSOs"; Integer)
        {
            Caption = 'Pending LPOs/LSOs';
            FieldClass = FlowField;
            CalcFormula = count("LPO/LSO Header" where(Status = const("Pending Approval")));
            Editable = false;
        }
        field(42; "Approved LPOs/LSOs"; Integer)
        {
            Caption = 'Approved LPOs/LSOs';
            FieldClass = FlowField;
            CalcFormula = count("LPO/LSO Header" where(Status = const(Approved)));
            Editable = false;
        }
        field(50; "Open GRNs"; Integer)
        {
            Caption = 'Open GRNs';
            FieldClass = FlowField;
            CalcFormula = count("Goods Receipt Note Header" where(Status = const(Open)));
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        if "Primary Key" = '' then
            "Primary Key" := 'PROC';
    end;
}
