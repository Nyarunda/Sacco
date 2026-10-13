/// <summary>
/// Table UPG_Members (ID 50001).
/// </summary>
table 50001 UPG_Members
{
    Caption = 'UPG_Members';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(91; First; Text[200])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(92; Second; Text[200])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(93; Last; Text[200])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[200])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(3; "Staff No."; Code[200])
        {
            Caption = 'Staff No.';
            DataClassification = ToBeClassified;
        }
        field(4; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';
            DataClassification = ToBeClassified;
        }
        field(5; "ID No."; Code[500])
        {
            Caption = 'ID No.';
            DataClassification = ToBeClassified;
        }
        field(52; "Passport"; Code[500])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Mobile Phone No"; Code[50])
        {
            Caption = 'Mobile Phone No';
            DataClassification = ToBeClassified;
        }
        field(7; Pin; Code[500])
        {
            Caption = 'Pin';
            DataClassification = ToBeClassified;
        }
        field(8; Gender; Text[30])
        {
            Caption = 'Gender';
            DataClassification = ToBeClassified;
        }
        field(9; "Marital Status"; Text[30])
        {
            Caption = 'Marital Status';
            DataClassification = ToBeClassified;
        }
        field(10; "Employer Code"; Code[30])
        {
            Caption = 'Employer Code';
            DataClassification = ToBeClassified;
        }
        field(11; "Bank Code"; Code[20])
        {
            Caption = 'Bank Code';
            DataClassification = ToBeClassified;
        }
        field(12; "Bank Branch Code"; Code[20])
        {
            Caption = 'Bank Branch Code';
            DataClassification = ToBeClassified;
        }
        field(13; "Bank Account No."; Text[200])
        {
            Caption = 'Bank Account No.';
            DataClassification = ToBeClassified;
        }
        field(14; "E-Mail"; Text[200])
        {
            Caption = 'E-Mail';
            DataClassification = ToBeClassified;
        }
        field(15; Created; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "New Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Registration Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Captured By"; Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Post Code"; Code[200])
        {
            DataClassification = ToBeClassified;
        }

        field(20; "Address"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(21; "Address 2"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(22; "City"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(23; "Country/Region Code"; Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Global Dimension 2 Code"; Code[200])
        {
            DataClassification = ToBeClassified;
        }

        field(25; Status; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(126; "Current Address"; Text[200]) { DataClassification = ToBeClassified; }
        field(226; "Phone No."; Text[200]) { DataClassification = ToBeClassified; }
        field(326; "E-Mail (Personal)"; Text[200]) { DataClassification = ToBeClassified; }
        field(526; "Employer Name"; Text[200]) { DataClassification = ToBeClassified; }
        field(626; "Old Account No"; Text[200]) { DataClassification = ToBeClassified; }
        field(826; "Created By"; Text[200]) { DataClassification = ToBeClassified; }
        field(926; "Nationality"; Text[200]) { DataClassification = ToBeClassified; }
        field(1126; "MPESA Mobile No"; Text[200]) { DataClassification = ToBeClassified; }
        field(1226; "District/County"; Text[200]) { DataClassification = ToBeClassified; }
        field(1326; Division; Text[200]) { DataClassification = ToBeClassified; }
        field(2146; Location; Text[200]) { DataClassification = ToBeClassified; }
        field(2156; "Sub-Location"; Text[200]) { DataClassification = ToBeClassified; }
        field(1626; "Current Residence"; Text[200]) { DataClassification = ToBeClassified; }
        field(1826; "Current Location"; Text[200]) { DataClassification = ToBeClassified; }
        field(1926; "Recruited By"; Text[200]) { DataClassification = ToBeClassified; }

    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}
