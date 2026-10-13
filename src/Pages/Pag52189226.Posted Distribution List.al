namespace Kentours.Kentours;

page 50938 "Posted Distribution List"
{
    ApplicationArea = All;
    Caption = 'Posted Distribution List';
    PageType = List;
    CardPageId = "Distribution Card";
    SourceTable = "Distributions Header";
    UsageCategory = Lists;
    Editable = false;
    SourceTableView = where(Posted = const(true));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Member No."; Rec."Member No.")
                {
                    ToolTip = 'Specifies the value of the Member No. field.', Comment = '%';
                }
                field("Member Name"; Rec."Member Name")
                {
                    ToolTip = 'Specifies the value of the Member Name field.', Comment = '%';
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ToolTip = 'Specifies the value of the Loan No. field.', Comment = '%';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
                }
                field("Captured By"; Rec."Captured By")
                {
                    ToolTip = 'Specifies the value of the Captured By field.', Comment = '%';
                }
                field("Date Captured"; Rec."Date Captured")
                {
                    ToolTip = 'Specifies the value of the Date Captured field.', Comment = '%';
                }
            }
        }
    }
}
