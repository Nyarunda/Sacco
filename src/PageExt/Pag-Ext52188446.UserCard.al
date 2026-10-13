pageextension 50093 UserCard extends "User Card"
{
    layout
    {

        addafter("Full Name")
        {
            field(SystemModifiedAt; Rec.SystemModifiedAt)
            {
                ApplicationArea = Basic;
            }
        }


    }
    actions
    {
    }

    trigger OnOpenPage()
    begin
        RestrictAccess
    end;

    procedure RestrictAccess()
    var
        SaccoPermissions: Record "User Setup";
    begin
        SaccoPermissions.Reset;
        SaccoPermissions.SetRange("User ID", UserId);
        SaccoPermissions.SetRange("Administration Setups", true);
        if not SaccoPermissions.FindFirst then
            Error('You do not have the following permission: "Administration Setups"');
    end;

}
