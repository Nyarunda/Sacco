
Page 50168 "Black-Listed Phone Nos"
{
    // 
    // StatusPermission.RESET;
    // StatusPermission.SETRANGE("User ID",USERID);
    // StatusPermission.SETRANGE("Black-List Accounts",TRUE);
    // IF NOT StatusPermission.FIND('-') THEN BEGIN
    //     ERROR('You do not have the following permission: "Black-List Accounts"');
    // END;

    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "Sky Black-Listed Phone Nos";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(TransactionalPhoneNo; Rec."Transactional Phone No.")
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
                //RunObject = XMLport UnknownXMLport50056;
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

