Table 50385 "Sky Agency Auth"
{

    fields
    {
        field(1; Username; Text[50])
        {
        }
        field(2; "Agent Code"; Code[30])
        {
        }
        field(3; Password; Text[250])
        {
        }
        field(4; "Software ID"; Text[250])
        {
        }
        field(5; "Reset PIN"; Boolean)
        {
        }
        field(6; Status; Option)
        {
            OptionCaption = 'Active,Inactive, ';
            OptionMembers = Active,Inactive," ";
        }
        field(7; "Initial PIN Sent"; Boolean)
        {
        }
        field(8; "Force PIN"; Boolean)
        {

            trigger OnValidate()
            begin

                // Vend.GET("Agent Code");
                //
                // PINChangeLog.INIT;
                // PINChangeLog."Table ID" := CURRENTDATETIME;
                // PINChangeLog."Document Type" := "Agent Code";
                // PINChangeLog."Document No." := Vend.Name;
                // PINChangeLog."Sequence No." := USERID;
                // PINChangeLog."Approval Code" := FORMAT(xRec."Software Activated");
                // PINChangeLog."Sender ID" := FORMAT("Software Activated");
                // PINChangeLog.INSERT;
            end;
        }
        field(9; "Software Activated"; Boolean)
        {
        }
        field(10; "PIN Encrypted"; Boolean)
        {
        }
        field(11; "Login Attempts Count"; Integer)
        {
        }
        field(12; "Login Attempts Tag"; Text[30])
        {
        }
        field(13; "Login Attempts Action"; Text[50])
        {
        }
        field(14; "Login Attempts Action Expiry"; DateTime)
        {
        }
        field(15; "OTP Attempts Count"; Integer)
        {
        }
        field(16; "OTP Attempts Tag"; Text[30])
        {
        }
        field(17; "OTP Attempts Action"; Text[50])
        {
        }
        field(18; "OTP Attempts Action Expiry"; DateTime)
        {
        }
        field(19; "Device Serial Number"; Text[250])
        {
        }
        field(20; "Date Created"; Date)
        {
        }
        field(21; "Date Updated"; Date)
        {
        }
        field(22; "Device IMEI"; Text[250])
        {
        }
        field(23; "Processor ID"; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; Username)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        //PINChangeLog: Record UnknownRecord52185934;
        Vend: Record "Savings Accounts";
}

