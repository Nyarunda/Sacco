namespace CentralDB.CentralDB;

page 50754 "Approved Imprest Requisition"
{
    ApplicationArea = All;
    Caption = 'Approved Imprest Requisition';
    PageType = List;
    DeleteAllowed = false;
    Editable = false;
    CardPageId = "Imprest Requisition Card";
    SourceTable = "Imprest Requisition";
    SourceTableView = where(Status = const(Approved));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
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
                field(TotalNetAmount; Rec."Total Net Amount")
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
