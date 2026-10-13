namespace AL_.AL_;

using System.Security.User;

page 50728 "User Setup No Rights"
{
    ApplicationArea = All;
    Caption = 'User Setup No Rights';
    PageType = List;
    DeleteAllowed = false;
    InsertAllowed = false;
    SourceTable = "User Setup";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }
}
