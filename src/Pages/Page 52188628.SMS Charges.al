
Page 50291 "SMS Charges"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "SMS Charges";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Source; Rec.Source)
                {
                    ApplicationArea = Basic;
                }
                field(ChargeAmount; Rec."Charge Amount")
                {
                    ApplicationArea = Basic;
                }
                field(ChargeGLAccount; Rec."Charge G/L Account")
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
        SaccoPermissions.SetRange("General Setups", true);
        if not SaccoPermissions.FindFirst then
            Error('You do not have the following permission: "General Setups"');
    end;
}

