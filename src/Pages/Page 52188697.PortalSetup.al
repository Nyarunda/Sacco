page 50360 "Portal Setup"
{
    Caption = 'Portal Setup';
    PageType = Card;
    SourceTable = "Portal Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Portal Statement Path"; Rec."Portal Statement Path")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Portal Statement Path field.';
                }
            }
        }
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
