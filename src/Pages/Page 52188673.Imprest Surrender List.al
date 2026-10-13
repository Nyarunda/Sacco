
Page 50336 "Imprest Surrender List"
{
    ApplicationArea = Basic;
    CardPageID = "Imprest Surrender Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Imprest Surrender Header";
    SourceTableView = where(Posted = const(false));
    UsageCategory = Lists;

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
                field(SurrenderDate; Rec."Surrender Date")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(AccountName; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(ImprestIssueNo; Rec."Imprest Issue No.")
                {
                    ApplicationArea = Basic;
                }
                field(ImprestIssueDate; Rec."Imprest Issue Date")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
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

