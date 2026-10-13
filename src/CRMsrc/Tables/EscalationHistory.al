// Escalation History Table
table 50421 "Escalation History"
{
    Caption = 'Escalation History';
    DataClassification = CustomerContent;
    LookupPageId = "Escalation History List";
    DrillDownPageId = "Escalation History List";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            DataClassification = SystemMetadata;
        }
        field(2; "Rule Code"; Code[20])
        {
            Caption = 'Rule Code';
            TableRelation = "Escalation Rules"."Rule Code";
            DataClassification = CustomerContent;
        }
        field(3; "Source Type"; Enum "Escalation Source Type")
        {
            Caption = 'Source Type';
            DataClassification = CustomerContent;
        }
        field(4; "Source Document No."; Code[20])
        {
            Caption = 'Source Document No.';
            DataClassification = CustomerContent;
        }
        field(5; "Escalated To User ID"; Code[50])
        {
            Caption = 'Escalated To User ID';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(6; "Escalation Date"; DateTime)
        {
            Caption = 'Escalation Date';
            DataClassification = CustomerContent;
        }
        field(7; "Status"; Enum "Escalation Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(8; "Resolution Date"; DateTime)
        {
            Caption = 'Resolution Date';
            DataClassification = CustomerContent;
        }
        field(9; "Resolution Notes"; Text[250])
        {
            Caption = 'Resolution Notes';
            DataClassification = CustomerContent;
        }
        field(10; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = EndUserIdentifiableInformation;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(Rule; "Rule Code", "Escalation Date")
        {
        }
        key(Status; "Status", "Escalation Date")
        {
        }
    }

    trigger OnInsert()
    begin
        "Created By" := CopyStr(UserId, 1, MaxStrLen("Created By"));
        if "Escalation Date" = 0DT then
            "Escalation Date" := CurrentDateTime;
    end;
}


