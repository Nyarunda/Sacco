Table 50315 "Portal KYC"
{

    fields
    {
        field(1; "Code"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = MEMBER_NUMBER,ID_NUMBER,DOB;
        }
        field(2; Name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Type; Text[250])
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

