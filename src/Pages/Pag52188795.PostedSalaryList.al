Page 50477 "Posted Salary List"
{
    ApplicationArea = Basic;
    CardPageID = "Salary Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Salary Header";
    UsageCategory = Lists;
    SourceTableView = where(Posted = const(true), "Salary Type" = Filter(<> "Direct Debit"));

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
                field(AccountType; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field(DocumentNo; Rec."Document No")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(ScheduledAmount; Rec."Scheduled Amount")
                {
                    ApplicationArea = Basic;
                }
                field(TotalCount; Rec."Total Count")
                {
                    ApplicationArea = Basic;
                }
                field(AccountName; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(EmployerCode; Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(IncomeType; Rec."Income Type")
                {
                    ApplicationArea = Basic;
                }
                field(Postingdate; Rec."Posting date")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(PostedBy; Rec."Posted By")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    var
        DocMustbeOpen: label 'This application request must be open';
        DocMustbePending: label 'This application request must be Pending';
        Text0001: label 'Ensure the Salary  Journal Template is set up in Banking User Setup';
        Text0002: label 'Ensure the Salary Journal Batch is set up in Banking User Setup';
}


