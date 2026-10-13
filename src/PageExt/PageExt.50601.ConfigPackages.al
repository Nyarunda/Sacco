pageextension 50601 "Config Packages Perm." extends "Config. Packages"
{
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        if not UserSetup.Get(UserId) then
            Error('User setup is missing for %1.', UserId);

        if not UserSetup."Config. Packages" then
            Error('You do not have permission to open Config. Packages.');
    end;
}
