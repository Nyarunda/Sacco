Table 50396 "Virtual Member Reg Images"
{

    fields
    {
        field(1; "Image Entry Number"; Text[50])
        {
        }
        field(2; "Registration Entry Number"; Text[50])
        {
        }
        field(3; "Image Path"; Text[250])
        {
        }
        field(4; Picture; Blob)
        {
            SubType = Bitmap;
        }
        field(5; Type; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Image Entry Number", "Registration Entry Number")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

