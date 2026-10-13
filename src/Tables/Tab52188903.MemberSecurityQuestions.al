Table 50605 "Member Security Questions"
{
    DataClassification = CustomerContent;
    Caption = 'Member Security Questions';
    DrillDownPageId = "Member Security Questions";
    LookupPageId = "Member Security Questions";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
            Editable = false;
            AutoIncrement = true;
        }
        field(2; "Member No"; Code[20])
        {
            Caption = 'Member No';
            DataClassification = CustomerContent;
            TableRelation = Members."No.";
        }
        field(3; "Question ID"; Integer)
        {
            Caption = 'Question ID';
            DataClassification = CustomerContent;
            TableRelation = "Portal Mbanking Questions".id;
        }
        field(4; "Question"; Text[1000])
        {
            Caption = 'Question';
            FieldClass = FlowField;
            CalcFormula = lookup("Portal Mbanking Questions".Questions where(id = field("Question ID")));
        }
        field(5; "Answer"; Text[250])
        {
            Caption = 'Answer';
            DataClassification = CustomerContent;
            // Store hashed answer for better security
        }
        field(6; "Date Created"; DateTime)
        {
            Caption = 'Date Created';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(7; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(8; "Last Modified"; DateTime)
        {
            Caption = 'Last Modified';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(9; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(10; "Is Active"; Boolean)
        {
            Caption = 'Is Active';
            DataClassification = CustomerContent;
            InitValue = true;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Member No", "Question ID")
        {
            Unique = true;
        }
    }

    trigger OnInsert()
    begin
        "Date Created" := CurrentDateTime;
        "Created By" := UserId;
        "Last Modified" := CurrentDateTime;
        "Modified By" := UserId;
    end;

    trigger OnModify()
    begin
        "Last Modified" := CurrentDateTime;
        "Modified By" := UserId;
    end;
}
