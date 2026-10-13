namespace UnitedWomen_Production.UnitedWomen_Production;

page 50425 "CRM Setup"
{
    ApplicationArea = All;
    Caption = 'CRM Setup';
    PageType = Card;
    SourceTable = "CRM Setup";
    UsageCategory = Tasks;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Customer Nos."; Rec."Customer Nos.")
                {
                    ToolTip = 'Specifies the value of the Customer Nos. field.', Comment = '%';
                }
                field("Ticket Nos."; Rec."Ticket Nos.")
                {
                    ToolTip = 'Specifies the value of the Ticket Nos. field.', Comment = '%';
                }
                field("Auto Assignment"; Rec."Auto Assignment")
                {
                    ToolTip = 'Specifies the value of the Auto Assignment field.', Comment = '%';
                }
                field("Email Notifications"; Rec."Email Notifications")
                {
                    ToolTip = 'Specifies the value of the Email Notifications field.', Comment = '%';
                }
                field("SMS Notifications"; Rec."SMS Notifications")
                {
                    ToolTip = 'Specifies the value of the SMS Notifications field.', Comment = '%';
                }
            }
        }
    }
}
