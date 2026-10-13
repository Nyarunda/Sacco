table 51150 "Sacco News Activity"
{
    Caption = 'Sacco News Activity';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'News,Activity,Alert';
            OptionMembers = News,Activity,Alert;
        }
        field(3; Title; Text[100])
        {
            Caption = 'Title';
        }
        field(4; Message; Text[2048])
        {
            Caption = 'Message';
        }
        field(5; "Activity Date"; Date)
        {
            Caption = 'Activity Date';
        }
        field(6; "Valid From"; Date)
        {
            Caption = 'Valid From';
        }
        field(7; "Valid To"; Date)
        {
            Caption = 'Valid To';
        }
        field(8; Active; Boolean)
        {
            Caption = 'Active';
        }
        field(9; "Created By"; Code[50])
        {
            Caption = 'Created By';
            Editable = false;
        }
        field(10; "Created DateTime"; DateTime)
        {
            Caption = 'Created DateTime';
            Editable = false;
        }
        field(11; "Last Modified By"; Code[50])
        {
            Caption = 'Last Modified By';
            Editable = false;
        }
        field(12; "Last Modified DateTime"; DateTime)
        {
            Caption = 'Last Modified DateTime';
            Editable = false;
        }
        field(13; "Sort Order"; Integer)
        {
            Caption = 'Sort Order';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(ActiveItems; Active, "Sort Order", "Activity Date", "Entry No.")
        {
        }
    }

    trigger OnInsert()
    begin
        if "Entry No." = 0 then
            "Entry No." := GetNextEntryNo();

        Active := true;
        "Created By" := CopyStr(UserId, 1, MaxStrLen("Created By"));
        "Created DateTime" := CurrentDateTime;
        SetModifiedAuditFields();
    end;

    trigger OnModify()
    begin
        SetModifiedAuditFields();
    end;

    local procedure GetNextEntryNo(): Integer
    var
        SaccoNewsActivity: Record "Sacco News Activity";
    begin
        SaccoNewsActivity.LockTable();
        if SaccoNewsActivity.FindLast() then
            exit(SaccoNewsActivity."Entry No." + 1);

        exit(1);
    end;

    local procedure SetModifiedAuditFields()
    begin
        "Last Modified By" := CopyStr(UserId, 1, MaxStrLen("Last Modified By"));
        "Last Modified DateTime" := CurrentDateTime;
    end;
}
