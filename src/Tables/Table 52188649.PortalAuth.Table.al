Table 50312 "Portal Auth"
{

    fields
    {
        field(1; UserName; Code[30])
        {
        }
        field(2; Password; Text[250])
        {
        }
        field(3; OTP; Text[250])
        {
            Editable = true;
        }
        field(4; "Reset PIN"; Boolean)
        {
        }
        field(5; "User Status"; Option)
        {
            OptionMembers = Active,Inactive," ",Blocked;
        }
        field(6; "Date Created"; Date)
        {
        }
        field(7; "Date Updated"; Date)
        {
        }
        field(8; "Initial PIN Sent"; Boolean)
        {
        }
        field(9; "Force PIN"; Boolean)
        {
        }
        field(10; "Pin Sent"; Boolean)
        {
        }
        field(11; Captcha; Text[250])
        {
        }
        field(12; "Access Key"; Text[1000])
        {
        }
        field(13; "Mobile App Activated"; Boolean)
        {
        }
        field(15; "Mobile App KYC Login Enabled"; Boolean)
        {
        }
        field(16; "PIN Encrypted"; Boolean)
        {
        }
        field(17; "Login Attempts Count"; Integer)
        {
        }
        field(18; "Login Attempts Tag"; Text[30])
        {
        }
        field(19; "Login Attempts Action"; Text[500])
        {
        }
        field(20; "Login Attempts Action Expiry"; DateTime)
        {
        }
        field(21; "OTP Attempts Count"; Integer)
        {
        }
        field(22; "OTP Attempts Tag"; Text[30])
        {
        }
        field(23; "OTP Attempts Action"; Text[50])
        {
        }
        field(24; "OTP Attempts Action Expiry"; DateTime)
        {
        }
        field(25; "Clear M-Banking Suspension"; Boolean)
        {
        }
        field(26; "PIN Reset Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "PIN Rest No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Sent to Server"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Email Sent"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Mobile No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Created By"; Code[50])
        {
        }
        field(33; "Suspended Before"; Boolean)
        {
        }
        field(34; "Member Name"; Text[100])
        {
        }

        field(35; "Last Active"; DateTime)
        {
        }
        field(36; "Session Expiry"; DateTime)
        {
        }
        field(37; "OTP Expiry"; DateTime)
        {
        }
        field(38; "Password Hash"; Text[250])
        {
            Caption = 'Password Hash';
            DataClassification = CustomerContent;
        }
        field(39; "Password Salt"; Text[100])
        {
            Caption = 'Password Salt';
            DataClassification = CustomerContent;
        }

        field(40; "Old Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; UserName)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


}

