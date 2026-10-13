Page 50423 "Update PIN Change"
{
    PageType = Card;
    SourceTable = "Sky USSD Auth";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(MobileNo; Rec."Mobile No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(UserStatus; Rec."User Status")
                {
                    ApplicationArea = Basic;
                }
                field(ResetPIN; Rec."Reset PIN")
                {
                    ApplicationArea = Basic;
                }
                field(ForcePIN; Rec."Force PIN")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(IMSI; Rec.IMSI)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ExtendedDatatype = Masked;
                }
                field(IMEI; Rec.IMEI)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ExtendedDatatype = Masked;
                }
                field(MobileAppKYCEnabled; Rec."Mobile App KYC Login Enabled")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile App KYC Enabled';
                }
                field("<Clear M-Banking Suspension>"; Rec."Clear M-Banking Suspension")
                {
                    ApplicationArea = Basic;
                    Caption = 'Clear M-Banking Suspension';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Reset IMEI")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to reset the IMEI Code?') then begin
                        Rec.IMEI := '';
                        Rec.Modify;
                        Message('Reset Successful');
                    end;
                end;
            }
            action("Reset IMSI")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to reset the IMSI Code?') then begin
                        Rec.IMSI := '';
                        Rec.Modify;
                        Message('Reset Successful');
                    end;
                end;
            }
        }
    }

    trigger OnClosePage()
    var
        SkyAuth: Record "Sky USSD Auth";
    begin

        SkyMbanking.PinReset;
        SkyMbanking.ClearMbankingSuspension();


        /*
        if "Clear M-Banking Suspension" then begin
            SkyAuth.Reset;
            SkyAuth.SetRange("Mobile No.", "Mobile No.");
            if (SkyAuth.Find('-')) then begin
                SkyAuth."Login Attempts Action" := 'NONE';
                SkyAuth."Login Attempts Tag" := '';
                Clear(SkyAuth."Login Attempts Action Expiry");
                SkyAuth."Login Attempts Count" := 0;
                SkyAuth."OTP Attempts Action" := 'NONE';
                SkyAuth."OTP Attempts Tag" := '';
                Clear(SkyAuth."OTP Attempts Action Expiry");
                SkyAuth."OTP Attempts Count" := 0;
                SkyAuth."Clear M-Banking Suspension" := false;
                SkyAuth.Modify;
            end;
        end;
        */
    end;

    trigger OnInit()
    begin
        StatusPermissions.Reset;
        StatusPermissions.SetRange("Reset Mpesa Pin", true);
        StatusPermissions.SetRange("User ID", UserId);
        if not StatusPermissions.FindFirst then
            Error('You do not have the following permission: "Reset Mpesa Pin"');
    end;

    var
        StatusPermissions: Record "Sky Permissions";
        SkyMbanking: Codeunit "Sky MBanking";
}

