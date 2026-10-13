pageextension 50602 "User Settings Perm." extends "User Settings"
{
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        if not UserSetup.Get(UserId) then
            Error('User setup is missing for %1.', UserId);

        if not UserSetup."User Settings" then
            Error('You do not have permission to open User Settings.');
    end;
}
