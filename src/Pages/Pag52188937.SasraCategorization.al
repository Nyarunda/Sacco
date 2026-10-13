/// <summary>
/// Page Sasra Categorization (ID 50639).
/// </summary>
page 50639 "Sasra Categorization"
{
    ApplicationArea = All;
    Caption = 'Sasra Categorization';
    PageType = List;
    SourceTable = "Sasra Categorization";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Loan No."; Rec."Loan No.")
                {
                    ToolTip = 'Specifies the value of the Loan No. field.';
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ToolTip = 'Specifies the value of the Approved Amount field.';
                }
                field("Account No."; Rec."Account No.")
                {
                    ToolTip = 'Specifies the value of the Account No. field.';
                }
                field("As At"; Rec."As At")
                {
                    ToolTip = 'Specifies the value of the As At field.';
                }
                field("Days in Arrears"; Rec."Days in Arrears")
                {
                    ToolTip = 'Specifies the value of the Days in Arrears field.';
                }
                field("Loan Category"; Rec."Loan Category")
                {
                    ToolTip = 'Specifies the value of the Loan Category field.';
                }
                field("Principal Arrears"; Rec."Principal Arrears")
                {
                    ToolTip = 'Specifies the value of the Principal Arrears field.';
                }
                field("Member No."; Rec."Member No.")
                {
                    ToolTip = 'Specifies the value of the Member No. field.';
                }
            }
        }
    }

}
