Table 50367 "Approval Code"
{
    Caption = 'Approval Code';
    DrillDownPageID = "Approval Code";
    LookupPageID = "Approval Code";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(3; "Linked To Table Name"; Text[50])
        {
            Caption = 'Linked To Table Name';
        }
        field(4; "Linked To Table No."; Integer)
        {
            Caption = 'Linked To Table No.';

            trigger OnValidate()
            begin
            end;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
}

