Table 55001 "Account Signatories"
{

    fields
    {
        field(1; "Account No"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Names; Text[50])
        {
            NotBlank = true;
        }
        field(3; "Date Of Birth"; Date)
        {
        }
        field(4; "Staff/Payroll"; Code[20])
        {
        }
        field(5; "ID No."; Code[50])
        {
        }
        field(6; Signatory; Boolean)
        {
        }
        field(7; "Must Sign"; Boolean)
        {
        }
        field(8; "Must be Present"; Boolean)
        {
        }
        field(9; Picture; Blob)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(10; Signature; Blob)
        {
            Caption = 'Signature';
            SubType = Bitmap;
        }
        field(11; "Expiry Date"; Date)
        {
        }
        field(12; "Sections Code"; Code[20])
        {
            //TableRelation = "Member Section"."No.";
        }
        field(13; "Company Code"; Code[20])
        {
            //TableRelation = Employer.Code;
        }
        field(14; "Personal Pin"; Code[20])
        {
        }
        field(15; Nationality; Text[50])
        {
        }
        field(16; "Marital Status"; Option)
        {
            OptionCaption = ',Male,Female';
            OptionMembers = ,Male,Female;
        }
        field(17; "Postal Address"; Text[50])
        {
        }
        field(18; "Tel No."; Code[30])
        {
        }
        field(19; Email; Text[50])
        {
        }
        field(20; "Current  Residence"; Text[60])
        {
        }
        field(21; "Home district"; Text[30])
        {
        }
        field(22; Division; Text[30])
        {
        }
        field(23; Location; Text[30])
        {
        }
        field(24; "Sub-Location"; Text[30])
        {
        }
        field(25; "Member No"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Account No", Names)
        {
            Clustered = true;
        }
        key(Key2; "ID No.")
        {
        }
    }

    fieldgroups
    {
    }
}

