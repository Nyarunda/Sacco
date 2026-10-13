pageextension 50501 "Purchase Order Ext" extends "Purchase Order"
{
    layout
    {
        addafter("Vendor Invoice No.")
        {
            field("LPO No."; Rec."LPO No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the related LPO number.';
            }
            field("External Requisition No."; Rec."External Requisition No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the related External Requisition number.';
            }
            field("Procurement Status"; Rec."Procurement Status")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the procurement status.';
            }
        }
    }
}
