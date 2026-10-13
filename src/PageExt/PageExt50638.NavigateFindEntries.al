pageextension 50638 "Navigate Find Entries Guard" extends Navigate
{
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        if not UserSetup.Get(UserId) then
            Error('You do not have permission to open Find Entries.');

        if not UserSetup."View Find Entries" then
            Error('You do not have permission to open Find Entries.');
    end;
}
