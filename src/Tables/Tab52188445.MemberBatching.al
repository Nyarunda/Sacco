table 50092 "Member Batching"
{
    Caption = 'Member Batching';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Batch No."; Integer)
        {
            Caption = 'Batch No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
        }
        field(3; "Starting No."; Code[20])
        {
            Caption = 'Starting No.';
            DataClassification = ToBeClassified;
        }
        field(4; "Ending No."; Code[20])
        {
            Caption = 'Ending No.';
            DataClassification = ToBeClassified;
        }
        field(5; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionMembers = " ",Dividends,"Monthly Processes";
        }

        field(6; "Posted"; Boolean)
        {
        }

    }
    keys
    {
        key(PK; "Batch No.", "Created By", "Document Type")
        {
            Clustered = true;
        }
    }
}
