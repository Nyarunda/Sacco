
Page 50172 "User Access Logs"
{
    ApplicationArea = Basic;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "User Access Logs";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(UserName; Rec."User Name")
                {
                    ApplicationArea = Basic;
                }
                field(LoginDate; Rec."Login Date")
                {
                    ApplicationArea = Basic;
                }
                field(LoginTime; Rec."Login Time")
                {
                    ApplicationArea = Basic;
                }
                field(LogoutDate; Rec."Logout Date")
                {
                    ApplicationArea = Basic;
                }
                field(LogoutTime; Rec."Logout Time")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

