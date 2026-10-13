page 50506 "LPO/LSO List"
{
    PageType = List;
    SourceTable = "LPO/LSO Header";
    Caption = 'LPO/LSO List';
    CardPageId = "LPO/LSO Card";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(LPOs)
            {
                field("LPO No."; Rec."LPO No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the LPO number.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the document type.';
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vendor number.';
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vendor name.';
                }
                field("LPO Date"; Rec."LPO Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the LPO date.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status.';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total amount.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(New)
            {
                ApplicationArea = All;
                Caption = 'New';
                Image = New;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                RunObject = page "LPO/LSO Card";
                RunPageMode = Create;
                ToolTip = 'Create a new LPO/LSO.';
            }
        }
    }
}
