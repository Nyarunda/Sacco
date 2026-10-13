table 50541 "Portal Registration Attempt"
{
    Caption = 'Portal Registration Attempt';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "E-mail"; Text[200])
        {
            Caption = 'E-mail';
        }
        field(2; "Phone No."; Code[20])
        {
            Caption = 'Phone No.';
        }
        field(3; "Date"; Date)
        {
            Caption = 'Date ';
        }
        field(4; "OTP"; Code[20])
        {
        }
        field(5; "Access Key"; Text[2000])
        {
        }
        field(6; "Name"; Text[200])
        {
        }
        field(7; "Type Of Organization"; Text[200])
        {
        }
        field(8; "Nature of Business"; Text[200])
        {
        }
        field(9; "Member Type"; Option)
        {
            Caption = 'Member Type';
            OptionMembers = "Individual","Joint","Chama","Group","Business";
            OptionCaption = 'Individual,Joint,Chama,Group,Business';

        }

        field(10; "First Name"; Text[200])
        {
        }

        field(11; "Surname"; Text[200])
        {
        }
        field(12; "Other Names"; Text[1000])
        {
        }
        field(13; "OTP Expiry Time"; DateTime)
        {
        }
    }
    keys
    {
        key(PK; "E-mail")
        {
            Clustered = true;
        }
    }
    trigger onInsert()
    var
    //PortalActs: codeunit "Calwide Portal";
    begin
        //portalActs.SendRegistrationAttemptNotification("E-mail", "Phone No.", Name);
    end;
}
