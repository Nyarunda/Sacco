
Table 50170 Denominations
{
    DrillDownPageID = Denominations;
    LookupPageID = Denominations;

    fields
    {
        field(1; "Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Value; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Note,Coin;
        }
        field(5; Priority; Integer)
        {
            DataClassification = ToBeClassified;
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

