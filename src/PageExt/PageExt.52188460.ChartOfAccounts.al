pageextension 50123 ChartOfAccounts extends "Chart of Accounts"
{


    trigger OnOpenPage();
    var
        UserSetup: Record "User Setup";
    begin
        Rec.SetRange(Blocked, false);

        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId);
        UserSetup.SetRange("View Chart of Acount", false);
        if UserSetup.FindFirst() then Error(ViewError);
    end;

    var
        ViewError: Label 'You do not have permission to view chart of accounts. Contact ICT administrator';
}
