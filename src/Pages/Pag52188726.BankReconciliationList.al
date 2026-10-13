page 52003 "Bank Reconciliation List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Bank Reconciliation";
    CardPageId = "Bank Reconciliation Card";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = All;
                }
                field("Statement No."; Rec."Statement No.")
                {
                    ApplicationArea = All;
                }
                field("Statement Date"; Rec."Statement Date")
                {
                    ApplicationArea = All;
                }
                field("Balance Last Statement"; Rec."Balance Last Statement")
                {
                    ApplicationArea = All;
                }
                field("Statement Ending Balance"; Rec."Statement Ending Balance")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}