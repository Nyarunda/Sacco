
Table 50150 "Staggered Header."
{
    Caption = 'O365 HTML Template';
    DrillDownPageID = "Staggered Header List";
    LookupPageID = "Staggered Header List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(7; "Media Resources Ref"; Code[50])
        {
            Caption = 'Media Resources Ref';
        }
        field(50000; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "0365 HTML",Staggered;
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
}

