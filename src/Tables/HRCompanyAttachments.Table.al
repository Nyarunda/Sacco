Table 51032 "HR Company Attachments"
{

    fields
    {
        field(1; "Code"; Code[30])
        {
            NotBlank = true;
        }
        field(2; "Document Description"; Text[200])
        {
            NotBlank = true;
        }
        field(6; "Attachment No."; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(7; "Language Code (Default)"; Code[10])
        {
            //TableRelation = Table8;
        }
        field(8; Attachment; Option)
        {
            Editable = true;
            OptionMembers = No,Yes;
        }
    }

    keys
    {
        key(Key1; "Code", "Document Description")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

