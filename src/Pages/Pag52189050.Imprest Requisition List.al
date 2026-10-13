namespace CentralDB.CentralDB;

page 50752 "Imprest Requisition List"
{
    ApplicationArea = All;
    Editable = false;
    DeleteAllowed = false;
    Caption = 'Imprest Requisition List';
    PageType = List;
    CardPageId = "Imprest Requisition Card";
    SourceTable = "Imprest Requisition";
    SourceTableView = where(status = filter(<> Approved));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }
}
