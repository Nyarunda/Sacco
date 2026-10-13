namespace CentralDB.CentralDB;

page 50707 "Share Trading List"
{
    ApplicationArea = All;
    Caption = 'Share Trading List';
    CardPageId = "Share Trading Card";
    Editable = false;
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Share Transfer";
    SourceTableView = where(Posted = const(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                }
                field(TransactionDate; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionTime; Rec."Transaction Time")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(CreatedBy; Rec."Created By")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }
}
