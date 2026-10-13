
Table 50064 "Information Base."
{

    fields
    {
        field(1; "Member No."; Code[20])
        {
        }
        field(2; Info; Text[2000])
        {

            trigger OnValidate()
            begin

                Date := Today;
                "Captured By" := UserId;
            end;
        }
        field(3; Date; Date)
        {
            Editable = false;
        }
        field(4; "Captured By"; Code[50])
        {
            Editable = false;
        }
        field(5; "Account No."; Code[20])
        {
        }
        field(6; "Action Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Member No.", Info, "Account No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        myInt: Integer;
    begin
        if "Captured By" <> UserId then
            Error('This can only be deleted by %1', "Captured By");
    end;

    trigger OnModify()
    var
        myInt: Integer;
    begin
        if "Captured By" <> UserId then
            Error('This can only be deleted by %1', "Captured By");
    end;
}

