
Table 50285 "Sky Black-Listed Phone Nos"
{

    fields
    {
        field(1; "Transactional Phone No."; Code[20])
        {
        }
        field(2; "Black-Listed"; Boolean)
        {

            trigger OnValidate()
            begin
                TestField(Reason);
                "Black-Listed By" := UserId;
                "Date Black-Listed" := Today;
            end;
        }
        field(3; "Black-Listed By"; Code[50])
        {
            Editable = false;
        }
        field(4; "Date Black-Listed"; Date)
        {
            Editable = false;
        }
        field(5; Reason; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Transactional Phone No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        Error('Action not Allowed');
    end;

    trigger OnInsert()
    begin
        StatusPermission.Reset;
        StatusPermission.SetRange("User ID", UserId);
        StatusPermission.SetRange("Black-List Accounts", true);
        if not StatusPermission.Find('-') then begin
            Error('You do not have the following permission: "Black-List Accounts"');
        end;

        "Black-Listed By" := UserId;
        "Date Black-Listed" := Today;
    end;

    trigger OnModify()
    begin

        StatusPermission.Reset;
        StatusPermission.SetRange("User ID", UserId);
        StatusPermission.SetRange("Black-List Accounts", true);
        if not StatusPermission.Find('-') then begin
            Error('You do not have the following permission: "Black-List Accounts"');
        end;


        "Black-Listed By" := UserId;
        "Date Black-Listed" := Today;
    end;

    var
        StatusPermission: Record "Status Change Permissions";
}

