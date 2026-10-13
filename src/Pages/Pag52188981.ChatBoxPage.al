namespace CentralDB.CentralDB;


page 50683 "Chat Box Page"
{
    PageType = Document;
    ApplicationArea = All;
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            part(ChatsList; "PortalChatsList")
            {
                ApplicationArea = All;
            }
            part(ChatEntry; "PortalChatEntry")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(RefreshChats)
            {
                Caption = 'Refresh Chats';
                trigger OnAction()
                begin
                    CurrPage.Update(false);
                end;
            }
        }
    }
}
