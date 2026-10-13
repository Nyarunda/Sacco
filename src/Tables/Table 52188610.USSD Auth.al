
Table 50273 "USSD Auth"
{

    fields
    {
        field(1; "Mobile No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Account No."; Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "PIN No."; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(4; "Reset PIN"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin


                Vend.Get("Account No.");

                PinChangeLog.Init;
                PinChangeLog.Date := CurrentDatetime;
                PinChangeLog."Account No." := "Account No.";
                PinChangeLog."Account Name" := Vend.Name;
                PinChangeLog."Changed By" := UserId;
                PinChangeLog."Old Value" := Format(xRec."Reset PIN");
                PinChangeLog."New Value" := Format("Reset PIN");
                PinChangeLog."Field Modified" := 'Reset PIN';
                PinChangeLog.Insert;
            end;
        }
        field(5; "User Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Active,Inactive, ';
            OptionMembers = Active,Inactive," ";

            trigger OnValidate()
            begin

                Vend.Get("Account No.");

                PinChangeLog.Init;
                PinChangeLog.Date := CurrentDatetime;
                PinChangeLog."Account No." := "Account No.";
                PinChangeLog."Account Name" := Vend.Name;
                PinChangeLog."Changed By" := UserId;
                PinChangeLog."Old Value" := Format(xRec."User Status");
                PinChangeLog."New Value" := Format("User Status");
                PinChangeLog."Field Modified" := 'User Status';
                PinChangeLog.Insert;
            end;
        }
        field(6; "Date Created"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Date Updated"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Initial PIN Sent"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Force PIN"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                "Reset PIN" := "Force PIN";

                Vend.Get("Account No.");

                PinChangeLog.Init;
                PinChangeLog.Date := CurrentDatetime;
                PinChangeLog."Account No." := "Account No.";
                PinChangeLog."Account Name" := Vend.Name;
                PinChangeLog."Changed By" := UserId;
                PinChangeLog."Old Value" := Format(xRec."Force PIN");
                PinChangeLog."New Value" := Format("Force PIN");
                PinChangeLog.Insert;
            end;
        }
        field(10; "Pin Sent"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; IMSI; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(12; IMEI; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Mobile App Activated"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Mobile App KYC Login Enabled"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "PIN Encrypted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Login Attempts Count"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Login Attempts Tag"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Login Attempts Action"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Login Attempts Action Expiry"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "OTP Attempts Count"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "OTP Attempts Tag"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "OTP Attempts Action"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "OTP Attempts Action Expiry"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Clear M-Banking Suspension"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "PIN Reset Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "PIN Rest No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Mobile No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Vend: Record "Savings Accounts";
        PinChangeLog: Record "Pin Change Log";
}

