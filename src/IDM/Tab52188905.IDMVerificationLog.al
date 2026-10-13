table 50615 "IDM Verification Log"
{
    Caption = 'IDM Verification Log';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(2; "Verification Type"; Enum "IDM Verification Type")
        {
            Caption = 'Verification Type';
            DataClassification = CustomerContent;
        }
        field(3; "API Request ID"; Text[100])
        {
            Caption = 'API Request ID';
            DataClassification = SystemMetadata;
        }
        field(4; Identifier; Text[100])
        {
            Caption = 'Identifier';
            DataClassification = CustomerContent;
        }
        field(5; "Secondary Identifier"; Text[100])
        {
            Caption = 'Secondary Identifier';
            DataClassification = CustomerContent;
        }
        field(6; "Member No."; Code[20])
        {
            Caption = 'Member No.';
            DataClassification = CustomerContent;
            TableRelation = Customer."No.";
            ValidateTableRelation = false;
        }
        field(7; "Member Name"; Text[150])
        {
            Caption = 'Member Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No." = field("Member No.")));
            Editable = false;
        }
        field(8; "Requested By"; Code[50])
        {
            Caption = 'Requested By';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(9; "Request Date Time"; DateTime)
        {
            Caption = 'Request Date Time';
            DataClassification = SystemMetadata;
        }
        field(10; "Response Date Time"; DateTime)
        {
            Caption = 'Response Date Time';
            DataClassification = SystemMetadata;
        }
        field(11; Status; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            OptionMembers = Pending,Success,"Not Found",Failed;
            OptionCaption = 'Pending,Success,Not Found,Failed';
        }
        field(12; "API Response Status"; Text[50])
        {
            Caption = 'API Response Status';
            DataClassification = CustomerContent;
        }
        field(13; "Error Code"; Text[100])
        {
            Caption = 'Error Code';
            DataClassification = CustomerContent;
        }
        field(14; "Error Message"; Text[500])
        {
            Caption = 'Error Message';
            DataClassification = CustomerContent;
        }
        field(15; "Full Name"; Text[150])
        {
            Caption = 'Full Name';
            DataClassification = CustomerContent;
        }
        field(16; "HTTP Status Code"; Integer)
        {
            Caption = 'HTTP Status Code';
            DataClassification = CustomerContent;
        }
        field(17; "Request JSON"; Text[2048])
        {
            Caption = 'Request JSON';
            DataClassification = CustomerContent;
        }
        field(18; "Response JSON"; Text[2048])
        {
            Caption = 'Response JSON';
            DataClassification = CustomerContent;
        }
        field(19; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';
            DataClassification = CustomerContent;
        }
        field(20; Gender; Text[10])
        {
            Caption = 'Gender';
            DataClassification = CustomerContent;
        }
        field(21; "Additional Info"; Text[500])
        {
            Caption = 'Additional Info';
            DataClassification = CustomerContent;
        }
        field(22; "PDF Report"; Blob)
        {
            Caption = 'PDF Report';
            DataClassification = CustomerContent;
        }
        field(23; "Citizenship"; Text[50])
        {
            Caption = 'Citizenship';
            DataClassification = CustomerContent;
        }
        field(24; "Tax Status"; Text[50])
        {
            Caption = 'Tax Status';
            DataClassification = CustomerContent;
        }
        field(25; "Trading Name"; Text[150])
        {
            Caption = 'Trading Name';
            DataClassification = CustomerContent;
        }
        field(26; "PAYE Registered"; Boolean)
        {
            Caption = 'PAYE Registered';
            DataClassification = CustomerContent;
        }
        field(27; "VAT Registered"; Boolean)
        {
            Caption = 'VAT Registered';
            DataClassification = CustomerContent;
        }
        field(28; "Licence Class"; Text[20])
        {
            Caption = 'Licence Class';
            DataClassification = CustomerContent;
        }
        field(29; "Licence Expiry Date"; Date)
        {
            Caption = 'Licence Expiry Date';
            DataClassification = CustomerContent;
        }
        field(30; "Vehicle Make"; Text[50])
        {
            Caption = 'Vehicle Make';
            DataClassification = CustomerContent;
        }
        field(31; "Vehicle Model"; Text[50])
        {
            Caption = 'Vehicle Model';
            DataClassification = CustomerContent;
        }
        field(32; "Vehicle Color"; Text[30])
        {
            Caption = 'Vehicle Color';
            DataClassification = CustomerContent;
        }
        field(33; "Registration Status"; Text[50])
        {
            Caption = 'Registration Status';
            DataClassification = CustomerContent;
        }
        field(34; "Owner Name"; Text[150])
        {
            Caption = 'Owner Name';
            DataClassification = CustomerContent;
        }
        field(35; "Business Type"; Text[100])
        {
            Caption = 'Business Type';
            DataClassification = CustomerContent;
        }
        field(36; "Bank Name"; Text[100])
        {
            Caption = 'Bank Name';
            DataClassification = CustomerContent;
        }
        field(37; "Account Status"; Text[50])
        {
            Caption = 'Account Status';
            DataClassification = CustomerContent;
        }
        field(38; "Credit Score"; Integer)
        {
            Caption = 'Credit Score';
            DataClassification = CustomerContent;
        }
        field(39; "Score Grade"; Text[5])
        {
            Caption = 'Score Grade';
            DataClassification = CustomerContent;
        }
        field(40; "Phone Matched"; Boolean)
        {
            Caption = 'Phone Matched';
            DataClassification = CustomerContent;
        }
        field(41; "District of Birth"; Text[100])
        {
            Caption = 'District of Birth';
            DataClassification = CustomerContent;
        }
        field(42; "Registration Date"; Date)
        {
            Caption = 'Registration Date';
            DataClassification = CustomerContent;
        }
        field(43; "Credit Summary"; Text[500])
        {
            Caption = 'Credit Summary';
            DataClassification = CustomerContent;
        }

        field(45; "First Name"; Text[150])
        {
            Caption = 'First Name';
            DataClassification = CustomerContent;
        }
        field(46; "Middle Name"; Text[150])
        {
            Caption = 'Middle Name';
            DataClassification = CustomerContent;
        }
        field(47; "Surname"; Text[150])
        {
            Caption = 'Surname';
            DataClassification = CustomerContent;
        }
        field(48; "ID Serial No."; Text[150])
        {
            Caption = 'ID Serial No.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(MemberTypeKey; "Member No.", "Verification Type")
        {
        }
        key(UserDateKey; "Requested By", "Request Date Time")
        {
        }
        key(StatusKey; Status)
        {
        }
        key(IdentifierKey; Identifier, "Verification Type")
        {
        }
    }



}
