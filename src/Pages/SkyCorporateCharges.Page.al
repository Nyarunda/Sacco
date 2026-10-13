Page 50163 "Sky Corporate Charges"
{
    PageType = List;
    SourceTable = "Sky Safcom Corporate Charges";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Minimum; Rec.Minimum)
                {
                    ApplicationArea = Basic;
                }
                field(Maximum; Rec.Maximum)
                {
                    ApplicationArea = Basic;
                }
                field(Charge; Rec.Charge)
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
        Permission.Reset;
        Permission.SetRange("User ID", UserId);
        Permission.SetRange("Sky Mobile Setups", true);
        if not Permission.FindFirst then
            Error('You do not have the following permission: "Sky Mobile Setups"');
    end;

    var
        Permission: Record "Sky Permissions";
}

