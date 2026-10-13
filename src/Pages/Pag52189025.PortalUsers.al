namespace CentralDB.CentralDB;

page 50727 "Portal Users"
{
    ApplicationArea = All;
    Caption = 'Portal Users';
    PageType = List;
    SourceTable = "Portal Auth";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(UserName; Rec.UserName)
                {
                    ToolTip = 'Specifies the value of the UserName field.', Comment = '%';
                }
                field("Member Name"; Rec."Member Name")
                {
                    ToolTip = 'Specifies the value of the Member Name field.', Comment = '%';
                }
                field("Date Created"; Rec."Date Created")
                {
                    ToolTip = 'Specifies the value of the Date Created field.', Comment = '%';
                }
                field("Date Updated"; Rec."Date Updated")
                {
                    ToolTip = 'Specifies the value of the Date Updated field.', Comment = '%';
                }
                field("Last Active"; Rec."Last Active")
                {
                    ToolTip = 'Specifies the value of the Force PIN field.', Comment = '%';
                }
                field("Session Expiry"; Rec."Session Expiry")
                {
                    ToolTip = 'Specifies the value of the Force PIN field.', Comment = '%';
                }
                field("Force PIN"; Rec."Force PIN")
                {
                    ToolTip = 'Specifies the value of the Force PIN field.', Comment = '%';
                }
                field("Member No."; Rec."Member No.")
                {
                    ToolTip = 'Specifies the value of the Member No. field.', Comment = '%';
                }
                field("Suspended Before"; Rec."Suspended Before")
                {
                    ToolTip = 'Specifies the value of the Suspended Before field.', Comment = '%';
                }
            }
        }
    }
}
