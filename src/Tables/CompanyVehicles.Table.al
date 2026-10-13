Table 50971 "Company Vehicles"
{
    //DrillDownPageID = UnknownPage52018785;
    //LookupPageID = UnknownPage52018785;

    fields
    {
        field(1; "Registration No."; Code[20])
        {
        }
        field(2; Description; Text[100])
        {
        }
        field(3; Capacity; Decimal)
        {
        }
        field(4; "Asset No."; Code[20])
        {
            TableRelation = "Fixed Asset"."No.";

            trigger OnValidate()
            begin
                FA.Reset;
                if FA.Get("Asset No.") then
                    Description := FA.Description;
            end;
        }
    }

    keys
    {
        key(Key1; "Registration No.", "Asset No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Registration No.", Description)
        {
        }
    }

    var
        FA: Record "Fixed Asset";
}

