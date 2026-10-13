
PageExtension 50114 GeneralLedgerSetup extends "General Ledger Setup"
{

    layout
    {
        Addlast(Content)
        {
            group("Custom Setups")
            {
                field("SMS Sender ID"; Rec."SMS Sender ID")
                {
                    ApplicationArea = Basic;
                }
                field("SMS Sender Name"; Rec."SMS Sender Name")
                {
                    ApplicationArea = Basic;
                }
            }
        }

    }

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

