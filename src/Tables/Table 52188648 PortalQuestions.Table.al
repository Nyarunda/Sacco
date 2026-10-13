Table 50544 "Portal Mbanking Questions"
{

    fields
    {
        field(1; id; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; Questions; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; CreatedBy; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; DateCreated; Date)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; id)
        {
            Clustered = true;
        }
    }


    fieldgroups
    {
    }

    trigger OnInsert()
    var
        AnnouncementList: Record "Portal Mbanking Questions";
    begin
        AnnouncementList.RESET;
        if AnnouncementList.findlast then
            id := AnnouncementList.id + 1
        else
            id := 1;
        CreatedBy := UserId;
        DateCreated := Today;
        Date := Today;
    end;
}

