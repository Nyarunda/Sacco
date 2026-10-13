pageextension 50111 JobQueueCard extends "Job Queue Category List"
{

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
