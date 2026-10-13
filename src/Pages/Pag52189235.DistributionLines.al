namespace Kentours.Kentours;

page 50937 "Distribution Lines"
{
    ApplicationArea = All;
    Caption = 'Distribution Lines';
    PageType = ListPart;
    SourceTable = "Distribution Lines";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Loan No"; Rec."Loan No")
                {
                    ToolTip = 'Specifies the value of the Loan No field.', Comment = '%';
                }
                field("Guarantor Member No."; Rec."Guarantor Member No.")
                {
                    ToolTip = 'Specifies the value of the Guarantor Member No. field.', Comment = '%';
                }
                field("Guarantor Name"; Rec."Guarantor Name")
                {
                    ToolTip = 'Specifies the value of the Guarantor Name field.', Comment = '%';
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ToolTip = 'Specifies the value of the Approved Amount field.', Comment = '%';
                }
                field("Current Outstanding Balance"; Rec."Current Outstanding Balance")
                {
                    ToolTip = 'Specifies the value of the Current Outstanding Balance field.', Comment = '%';
                }
                field("Current Outstanding Interest"; Rec."Current Outstanding Interest")
                {
                    ToolTip = 'Specifies the value of the Current Outstanding Interest field.', Comment = '%';
                }
                field("Disbributed Amount"; Rec."Disbributed Amount")
                {
                    ToolTip = 'Specifies the value of the Disbributed Amount field.', Comment = '%';
                }
                field("Recovery Method"; Rec."Recovery Method")
                {
                    ToolTip = 'Specifies how the guarantor recovery was originally done.';
                }
                field("Amount as Loan"; Rec."Amount as Loan")
                {
                    ToolTip = 'Specifies the portion originally issued as a defaulter loan.';
                }
                field("Amount from Savings"; Rec."Amount from Savings")
                {
                    ToolTip = 'Specifies the portion originally recovered from savings.';
                }
                field("Guarantor Outstanding Loan No."; Rec."Guarantor Outstanding Loan No.")
                {
                    ToolTip = 'Specifies the guarantor defaulter loan to clear first, where applicable.';
                }
            }
        }
    }
}
