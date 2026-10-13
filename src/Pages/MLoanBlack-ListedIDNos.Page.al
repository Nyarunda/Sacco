Page 50424 "MLoan Black-Listed ID Nos"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "Sky Black-Listed ID Nos";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(IDNos; Rec."ID Nos.")
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
                RunObject = XMLport "Import BlackListed IDs";
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
        StatusPermission: Record "Sky Permissions";
}

