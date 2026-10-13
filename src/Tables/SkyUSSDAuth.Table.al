Table 50354 "Sky USSD Auth"
{

    fields
    {
        field(1; "Mobile No."; Code[30])
        {
        }
        field(2; "Account No."; Code[30])
        {
            Editable = true;
            TableRelation = Vendor;
        }
        field(3; "PIN No."; Text[250])
        {
            Editable = true;
        }
        field(4; "Reset PIN"; Boolean)
        {

            trigger OnValidate()
            begin


                Vend.Get("Account No.");

                PINChangeLog.Init;
                PINChangeLog.Date := CurrentDatetime;
                PINChangeLog."Account No." := "Account No.";
                PINChangeLog."Account Name" := Vend.Name;
                PINChangeLog."Changed By" := UserId;
                PINChangeLog."Old Value" := Format(xRec."Reset PIN");
                PINChangeLog."New Value" := Format("Reset PIN");
                PINChangeLog."Field Modified" := 'Reset PIN';
                PINChangeLog.Insert;
            end;
        }
        field(5; "User Status"; Option)
        {
            OptionCaption = 'Active,Inactive, ';
            OptionMembers = Active,Inactive," ";

            trigger OnValidate()
            begin

                Vend.Get("Account No.");

                PINChangeLog.Init;
                PINChangeLog.Date := CurrentDatetime;
                PINChangeLog."Account No." := "Account No.";
                PINChangeLog."Account Name" := Vend.Name;
                PINChangeLog."Changed By" := UserId;
                PINChangeLog."Old Value" := Format(xRec."User Status");
                PINChangeLog."New Value" := Format("User Status");
                PINChangeLog."Field Modified" := 'User Status';
                PINChangeLog.Insert;
            end;
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

            trigger OnValidate()
            begin

                "Reset PIN" := "Force PIN";

                Vend.Get("Account No.");

                PINChangeLog.Init;
                PINChangeLog.Date := CurrentDatetime;
                PINChangeLog."Account No." := "Account No.";
                PINChangeLog."Account Name" := Vend.Name;
                PINChangeLog."Changed By" := UserId;
                PINChangeLog."Old Value" := Format(xRec."Force PIN");
                PINChangeLog."New Value" := Format("Force PIN");
                PINChangeLog.Insert;
            end;
        }
        field(10; "Pin Sent"; Boolean)
        {
        }
        field(11; IMSI; Text[50])
        {
        }
        field(12; IMEI; Text[50])
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
        field(19; "Login Attempts Action"; Text[50])
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
        field(25; "B2B Transactions Enabled"; Boolean)
        {
        }
        field(26; "Clear M-Banking Suspension"; Boolean)
        {
        }


        field(27; "Entries"; Integer)
        {
            CalcFormula = count("Sky USSD Auth" where("Account No." = field("Account No.")));
            Editable = false;
            FieldClass = FlowField;
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
        PINChangeLog: Record "Sky PIN Change Log.";
        Vend: Record "Savings Accounts";
}

