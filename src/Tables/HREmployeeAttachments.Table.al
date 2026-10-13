Table 50989 "HR Employee Attachments"
{

    fields
    {
        field(1; "Employee No"; Code[50])
        {
            NotBlank = true;
            TableRelation = "HR Succession Job Rotation"."Line No.";
        }
        field(2; "Document Description"; Text[200])
        {
            NotBlank = true;
        }
        field(3; "Document Link"; Text[200])
        {
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
            Editable = false;
            OptionMembers = No,Yes;
        }
    }

    keys
    {
        key(Key1; "Employee No", "Document Description")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
    //DocLink: Record UnknownRecord39003917;


    procedure PlaceFilter(prompt: Boolean; EmployeeNo: Code[10]): Boolean
    begin
        if prompt then begin
            SetFilter("Employee No", EmployeeNo);
        end;
    end;
}

