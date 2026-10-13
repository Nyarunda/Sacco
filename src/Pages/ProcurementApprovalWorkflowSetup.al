page 50507 "Proc Appr WF Setup"
{
    PageType = List;
    SourceTable = "Procurement Approval Workflow";
    Caption = 'Procurement Approval Workflow Setup';

    layout
    {
        area(Content)
        {
            repeater(Workflows)
            {
                field("Workflow Type"; Rec."Workflow Type")
                {
                    ApplicationArea = All;
                }
                field("Approval Level"; Rec."Approval Level")
                {
                    ApplicationArea = All;
                }
                field("Approver Type"; Rec."Approver Type")
                {
                    ApplicationArea = All;
                }
                field("Approver User ID"; Rec."Approver User ID")
                {
                    ApplicationArea = All;
                }
                field("Threshold From"; Rec."Threshold From")
                {
                    ApplicationArea = All;
                }
                field("Threshold To"; Rec."Threshold To")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
