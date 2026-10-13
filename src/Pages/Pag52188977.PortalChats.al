page 50679 "Portal Chats"
{
    ApplicationArea = All;
    Caption = 'Portal Chats';
    PageType = List;
    SourceTable = "Portal Chats";
    SourceTableView = sorting("Entry No.") order(ascending) where(Closed = const(false));
    UsageCategory = Lists;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("DateTime"; Rec."DateTime")
                {
                    ToolTip = 'Specifies the value of the DateTime field.', Comment = '%';
                }
                field(ChatMessage; Rec.ChatMessage)
                {
                    ToolTip = 'Specifies the value of the ChatMessage field.', Comment = '%';
                }
                field("Member Name"; Rec."Member Name")
                {
                    ToolTip = 'Specifies the value of the Member Name field.', Comment = '%';
                    Editable = false;
                }
                field(From; Rec.From)
                {
                    ToolTip = 'Specifies the value of the From field.', Comment = '%';
                    Editable = false;
                }

                field(Agent; Rec.Agent)
                {
                    Editable = false;
                }
                field("Session ID"; Rec."Session ID")
                {
                    Editable = false;
                }
                field(Closed; Rec.Closed)
                {
                    Editable = false;
                }
                field("Closed By"; Rec."Closed By")
                {
                    Editable = false;
                }
            }

            part(ChatEntry; "PortalChatEntry")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action("Close Ticket")
                {
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = true;
                    ApplicationArea = Basic, Suite;
                    trigger OnAction()
                    var
                        chat: record "Portal Chats";
                    begin
                        chat.Reset();
                        chat.SetRange("Member No.", Rec."Member No.");
                        chat.SetRange("Session ID", Rec."Session ID");
                        if chat.FindFirst() then
                            chat.Modifyall(Closed, true);

                        Message('Closed');
                    end;
                }
            }
        }
    }

    trigger OnOpenPage();
    begin
        //('auto-refresh.js');
    end;




}
