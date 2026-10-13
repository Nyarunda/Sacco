table 50568 "Portal Application Documents"
{
    Caption = 'Portal Application Documents';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Document ID"; Code[100])
        {
            Caption = 'Document ID';
        }
        field(3; "Document Description"; Text[1000])
        {
            Caption = 'Document Decsription';
        }
        field(4; "Application Type"; Option)
        {
            Caption = 'Application Type';
            OptionMembers = "Individual","Joint","Chama","Group","Business";
            OptionCaption = 'Individual,Joint,Chama,Group,Business';
        }
        field(5; "Document"; Blob)
        {
            Caption = 'Document';
        }
        field(6; "Extension"; Text[1000])
        {
        }
        field(7; "GUID"; Text[50])
        {
        }

        field(8; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Time; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Member Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Type; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(18; Format; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(19; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Pending,Approved,Effected,Rejected;
        }
        field(20; Path; Text[250])
        {
            DataClassification = ToBeClassified;
        }

        field(23; Blob; Blob)
        {
            Caption = 'Blob';
        }
        field(24; "Blob Name"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }

        field(25; "Blob Url"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.", "Document ID", GUID)
        {
            Clustered = true;
        }
    }
}
