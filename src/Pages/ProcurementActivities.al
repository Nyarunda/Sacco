page 50527 "Procurement Activities"
{
    PageType = CardPart;
    SourceTable = "Procurement Cue";
    Caption = 'Procurement Activities';
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            cuegroup(Requisitions)
            {
                Caption = 'Requisitions';

                field("Open Store Requisitions"; Rec."Open Store Requisitions")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Store Requisitions List";
                    ToolTip = 'Shows open store requisitions.';
                }
                field("Pending Store Requisitions"; Rec."Pending Store Requisitions")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Store Requisitions List";
                    ToolTip = 'Shows store requisitions pending approval.';
                }
            }

            cuegroup(Sourcing)
            {
                Caption = 'Sourcing';

                field("Open RFQs"; Rec."Open RFQs")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "RFQ List";
                    ToolTip = 'Shows open RFQs.';
                }
                field("RFQs Under Evaluation"; Rec."RFQs Under Evaluation")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "RFQ List";
                    ToolTip = 'Shows RFQs currently under evaluation.';
                }
                field("Awarded RFQs"; Rec."Awarded RFQs")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "RFQ List";
                    ToolTip = 'Shows RFQs that have been awarded.';
                }
                field("Submitted Quotations"; Rec."Submitted Quotations")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Vendor Quotation List";
                    ToolTip = 'Shows submitted vendor quotations.';
                }
                field("Quotations Under Evaluation"; Rec."Quotations Under Evaluation")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Vendor Quotation List";
                    ToolTip = 'Shows quotations under evaluation.';
                }
            }

            cuegroup(Execution)
            {
                Caption = 'Execution';

                field("Open LPOs/LSOs"; Rec."Open LPOs/LSOs")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "LPO/LSO List";
                    ToolTip = 'Shows open LPO/LSO documents.';
                }
                field("Pending LPOs/LSOs"; Rec."Pending LPOs/LSOs")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "LPO/LSO List";
                    ToolTip = 'Shows LPO/LSO documents pending approval.';
                }
                field("Approved LPOs/LSOs"; Rec."Approved LPOs/LSOs")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "LPO/LSO List";
                    ToolTip = 'Shows approved LPO/LSO documents.';
                }
                field("Open GRNs"; Rec."Open GRNs")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Goods Receipt Note List";
                    ToolTip = 'Shows open goods receipt notes.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get('PROC') then begin
            Rec.Init();
            Rec."Primary Key" := 'PROC';
            Rec.Insert();
        end;
    end;
}
