
Table 50179 "Bank Branches"
{
    DrillDownPageID = "Bank Branches";
    LookupPageID = "Bank Branches";

    fields
    {
        field(1; "Bank Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Codes";

            trigger OnValidate()
            begin
                "Bank Name" := '';
                if BankCodes.Get("Bank Code") then
                    "Bank Name" := BankCodes."Bank Name";
            end;
        }
        field(2; "Bank Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Branch Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Branch Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Bank Code", "Branch Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Branch Code", "Branch Name")
        {
        }
    }

    var
        BankCodes: Record "Bank Codes";
}

