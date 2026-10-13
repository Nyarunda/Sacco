page 50473 "Sky USSD Auth"
{
    Caption = 'Sky USSD Auth';
    PageType = List;
    SourceTable = "Sky USSD Auth";


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Mobile No."; Rec."Mobile No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mobile No. field.';
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account No. field.';
                }
                field("PIN No."; Rec."PIN No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PIN No. field.';
                }
                field("Reset PIN"; Rec."Reset PIN")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reset PIN field.';
                }
                field("User Status"; Rec."User Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User Status field.';
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Created field.';
                }
                field("Date Updated"; Rec."Date Updated")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Updated field.';
                }
                field("Initial PIN Sent"; Rec."Initial PIN Sent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Initial PIN Sent field.';
                }
                field("Force PIN"; Rec."Force PIN")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Force PIN field.';
                }
                field("Pin Sent"; Rec."Pin Sent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pin Sent field.';
                }
                field(IMSI; Rec.IMSI)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the IMSI field.';
                }
                field(IMEI; Rec.IMEI)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the IMEI field.';
                }
                field("Mobile App Activated"; Rec."Mobile App Activated")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mobile App Activated field.';
                }
                field("Mobile App KYC Login Enabled"; Rec."Mobile App KYC Login Enabled")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mobile App KYC Login Enabled field.';
                }
                field("PIN Encrypted"; Rec."PIN Encrypted")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PIN Encrypted field.';
                }
                field("Login Attempts Count"; Rec."Login Attempts Count")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Login Attempts Count field.';
                }
                field("Login Attempts Tag"; Rec."Login Attempts Tag")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Login Attempts Tag field.';
                }
                field("Login Attempts Action"; Rec."Login Attempts Action")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Login Attempts Action field.';
                }
                field("Login Attempts Action Expiry"; Rec."Login Attempts Action Expiry")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Login Attempts Action Expiry field.';
                }
                field("OTP Attempts Count"; Rec."OTP Attempts Count")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the OTP Attempts Count field.';
                }
                field("OTP Attempts Tag"; Rec."OTP Attempts Tag")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the OTP Attempts Tag field.';
                }
                field("OTP Attempts Action"; Rec."OTP Attempts Action")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the OTP Attempts Action field.';
                }
                field("OTP Attempts Action Expiry"; Rec."OTP Attempts Action Expiry")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the OTP Attempts Action Expiry field.';
                }
                field("B2B Transactions Enabled"; Rec."B2B Transactions Enabled")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the B2B Transactions Enabled field.';
                }
                field("Clear M-Banking Suspension"; Rec."Clear M-Banking Suspension")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Clear M-Banking Suspension field.';
                }
            }
        }
    }

    actions
    {

        area(navigation)
        {
            action(GenerateStartPins)
            {
                ApplicationArea = Suite;
                Image = Document;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Sky: Codeunit "Sky MBanking";
                begin


                    if Confirm('Are you sure you want to Generate Start PIns') then begin
                        Sky.GenerateStartPins();
                        Message('Generate');
                    end;


                end;
            }

            action(RemoveCASH)
            {
                ApplicationArea = Suite;
                Image = Document;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Sky: Codeunit "Sky MBanking";
                begin


                    if Confirm('Are you sure you want to Send Start PIns') then begin
                        Sky.SendStartPins();
                        Message('Sent');
                    end;


                end;
            }

            action(SendStartPins)
            {
                ApplicationArea = Suite;
                Image = Document;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Sky: Codeunit "Sky MBanking";
                begin


                    if Confirm('Are you sure you want to Send Start PIns') then begin
                        Sky.SendStartPins();
                        Message('Sent');
                    end;


                end;
            }

        }
    }


}
