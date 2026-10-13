
Table 50178 "Bank Codes"
{
    DrillDownPageID = "Bank Code";
    LookupPageID = "Bank Code";

    fields
    {
        field(1; "Bank Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Bank Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Bank Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        
        fieldgroup(DropDown;"Bank Code","Bank Name"){}
    
    }
}

