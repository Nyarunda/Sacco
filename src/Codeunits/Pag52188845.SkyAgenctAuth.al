page 50547 "Sky Agenct Auth"
{
    Caption = 'Sky Agenct Auth';
    PageType = List;
    SourceTable = "Sky Agency Auth";
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;



    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Username; Rec.Username)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Username field.';
                }
                field("Agent Code"; Rec."Agent Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Agent Code field.';
                }
                field(Password; Rec.Password)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Password field.';
                }
                field("Software ID"; Rec."Software ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Software ID field.';
                }
                field("Reset PIN"; Rec."Reset PIN")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reset PIN field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
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
                field("Software Activated"; Rec."Software Activated")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Software Activated field.';
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
                field("Device Serial Number"; Rec."Device Serial Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Device Serial Number field.';
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
                field("Device IMEI"; Rec."Device IMEI")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Device IMEI field.';
                }
                field("Processor ID"; Rec."Processor ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Processor ID field.';
                }
            }
        }
    }
}
