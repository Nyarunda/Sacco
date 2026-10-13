Page 50968 "HR Asset Transfer List"
{
    CardPageID = "HR Asset Transfer Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "HR Asset Transfer Header";
    Caption = 'Asset Transfer List';
    SourceTableView = where(Transfered = const(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(DocumentDate; Rec."Document Date")
                {
                    ApplicationArea = Basic;
                }
                field(CurrentHolder; Rec."Current Holder")
                {
                    ApplicationArea = Basic;
                }
                field(AssettoTransfer; Rec."Asset to Transfer")
                {
                    ApplicationArea = Basic;
                }
                field(NewHolder; Rec."New Holder")
                {
                    ApplicationArea = Basic;
                }
                field(Transfered; Rec.Transfered)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

