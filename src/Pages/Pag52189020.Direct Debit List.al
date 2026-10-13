page 50722 "Direct Debit List"
{
    ApplicationArea = All;
    Caption = 'Direct Debit List';
    CardPageID = "Direct Debit Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Salary Header";
    UsageCategory = Lists;
    SourceTableView = where(Posted = const(false), "Salary Type" = const("Direct Debit"));

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

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin

        UserSetup.Get(UserId);
        if not UserSetup."Salary processing" then
            Error('You do not have any permissions for salary processing to access this report. Contact the administrator!');

    end;


    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Salary Type" := Rec."Salary Type"::"Direct Debit";
        Rec."Income Type" := Rec."Income Type"::"Direct Debit";
    end;

    var
        DocMustbeOpen: label 'This application request must be open';
        DocMustbePending: label 'This application request must be Pending';
        Text0001: label 'Ensure the Salary  Journal Template is set up in Banking User Setup';
        Text0002: label 'Ensure the Salary Journal Batch is set up in Banking User Setup';
}

