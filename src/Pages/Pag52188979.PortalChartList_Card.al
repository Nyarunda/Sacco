namespace CentralDB.CentralDB;

page 50681 PortalChatsList
{
    PageType = Listpart;
    SourceTable = "Portal Chats";


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("DateTime"; Rec."DateTime")
                {
                    ApplicationArea = All;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                }
                field(From; Rec.From)
                {
                    ApplicationArea = All;
                }
                field(ChatMessage; Rec.ChatMessage)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
