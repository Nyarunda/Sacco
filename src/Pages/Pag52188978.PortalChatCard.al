
page 50682 PortalChatEntry
{
    ApplicationArea = All;
    PageType = CardPart;
    SourceTable = "Portal Chats";

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                }
                field(ChatMsg; ChatMsg)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        Chats: Record "Portal Chats";
                    begin
                        if ChatMsg <> '' then begin
                            Chats.Init();
                            Chats.GUID := CreateGuid();
                            Chats."Member No." := Rec."Member No.";
                            Chats."Member Name" := Rec."Member Name";
                            Chats.Validate(ChatMessage, ChatMsg);
                            Chats.Insert(true);
                            ChatMsg := '';
                        end;
                    end;
                }
                field(From; Rec.From)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(SendMessage)
            {
                Caption = 'Send Message';
                trigger OnAction()
                var
                    Chats: Record "Portal Chats";
                begin
                    if ChatMsg <> '' then begin
                        Chats.Init();
                        Chats.GUID := CreateGuid();
                        Chats."Member No." := Rec."Member No.";
                        Chats."Member Name" := Rec."Member Name";
                        Chats.Validate(ChatMessage, ChatMsg);
                        Chats.Insert(true);
                        ChatMsg := '';
                    end;
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.From := Rec.From::Member;
        Rec.DateTime := CurrentDateTime;
        Rec.Agent := USERID;
        Rec.GUID := CreateGuid();
    end;

    var
        ChatMsg: Text[2000];
}
