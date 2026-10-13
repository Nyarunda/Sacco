
Page 50169 "Black-Listed Accounts"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "Sky Black-Listed Account Nos";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = Basic;
                }
                field(BlackListed; Rec."Black-Listed")
                {
                    ApplicationArea = Basic;
                }
                field(BlackListedBy; Rec."Black-Listed By")
                {
                    ApplicationArea = Basic;
                }
                field(DateBlackListed; Rec."Date Black-Listed")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Import)
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedIsBig = true;
                //RunObject = XMLport UnknownXMLport50058;
            }
        }
    }

    trigger OnInit()
    begin

        StatusPermission.Reset;
        StatusPermission.SetRange("User ID", UserId);
        StatusPermission.SetRange("View BlackListed Accounts", true);
        if not StatusPermission.Find('-') then begin
            Error('You do not have the following permission: "Black-List Accounts"');
        end;
    end;

    var
        StatusPermission: Record "Status Change Permissions";
}

