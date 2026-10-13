Table 50343 "Sky Alerts"
{

    fields
    {
        field(1; Guid; Guid)
        {
            Editable = false;
        }
        field(2; "Date Captured"; DateTime)
        {
            Editable = false;
        }
        field(3; "Captured By"; Code[50])
        {
            Editable = false;
        }
        field(4; Title; Text[250])
        {
        }
        field(5; Body; Text[250])
        {
        }
        field(6; Status; Option)
        {
            OptionMembers = " ",Visible,"Not Visible";
        }
        field(7; Priority; Integer)
        {
        }
        field(8; Type; Option)
        {
            OptionMembers = Text,Image;
        }
    }

    keys
    {
        key(Key1; Guid)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Guid := CreateGuid;
        "Date Captured" := CurrentDatetime;
        "Captured By" := UserId;
    end;
}

