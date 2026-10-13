
Page 50321 "Cheque Types"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "Cheque Types";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(ClearingDays; Rec."Clearing Days")
                {
                    ApplicationArea = Basic;
                }
                field(Control9; Rec."Clearing  Days")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }


    trigger OnInit()
    begin
        RestrictAccess
    end;


    procedure RestrictAccess()
    var
        SaccoPermissions: Record "User Setup";
    begin
        SaccoPermissions.Reset;
        SaccoPermissions.SetRange("User ID", UserId);
        SaccoPermissions.SetRange("Savings Setups", true);
        if not SaccoPermissions.FindFirst then
            Error('You do not have the following permission: "Saving Setups"');
    end;

}

