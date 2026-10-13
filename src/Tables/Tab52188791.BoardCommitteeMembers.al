table 50473 "Board Committee Members"
{
    Caption = 'Board Committee Members';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Committee; Code[20])
        {
            Caption = 'Committee';
            TableRelation = "Board Committees";
        }
        field(2; "Member No."; Code[20])
        {
            Caption = 'Member No.';
            TableRelation = "Members";

            trigger OnValidate()
            var
                Members: Record Members;
            begin
                "Member Name" := '';
                if Members.Get("Member No.") then
                    "Member Name" := Members."Name";

            end;
        }
        field(3; "Member Name"; Text[100])
        {
            Caption = 'Member Name';
            Editable = false;
        }
    }
    keys
    {
        key(PK; Committee, "Member No.")
        {
            Clustered = true;
        }
    }
}
