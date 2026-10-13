Table 51039 "HR OSSafety Rules"
{

    fields
    {
        field(1; "Safety No"; Code[10])
        {
        }
        field(2; "Safety Rules"; Text[200])
        {
        }
        field(3; "Accident No."; Code[10])
        {
            TableRelation = "HR OSAccident"."Accident No";
        }
    }

    keys
    {
        key(Key1; "Safety No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Safety No", "Safety Rules")
        {
        }
    }
}

