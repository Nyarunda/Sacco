pageextension 50132 Personalize extends "User Settings List"
{
    trigger OnOpenPage()
    begin
        RestrictAccess
    end;


    procedure RestrictAccess()
    var
        SaccoPermissions: Record "User Setup";
    begin
        if not SaccoPermissions.Get(UserId) then
            Error('User setup is missing for %1.', UserId);

        if not SaccoPermissions."User Settings" then
            Error('You do not have permission to open User Settings.');
    end;

}
