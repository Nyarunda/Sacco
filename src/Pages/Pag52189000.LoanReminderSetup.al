namespace CentralDB.CentralDB;

page 50702 "Loan Reminder Setup"
{
    ApplicationArea = All;
    Caption = 'Loan Reminder Setup';
    PageType = ListPart;
    SourceTable = "Loan Reminder Setup";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Loan Product"; Rec."Loan Product")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Loan Product field.', Comment = '%';
                }
                field("Reminder Type"; Rec."Reminder Type")
                {
                    ToolTip = 'Specifies the value of the Reminder Type field.', Comment = '%';
                }
                field("Loan Reminder Days"; Rec."Loan Reminder Days")
                {
                    ToolTip = 'Specifies the value of the Loan Reminder Days field.', Comment = '%';
                }
            }
        }
    }
}
