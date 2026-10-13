table 50604 "Security Log"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(2; "Event Type"; Text[50])
        {
            DataClassification = SystemMetadata;
        }
        field(3; "User ID"; Text[50])
        {
            DataClassification = SystemMetadata;
        }
        field(4; "Date and Time"; DateTime)
        {
            DataClassification = SystemMetadata;
        }
        field(5; "Details"; Text[250])
        {
            DataClassification = SystemMetadata;
        }
        field(6; "Is Alert"; Boolean)
        {
            DataClassification = SystemMetadata;
        }
        field(7; "IP Address"; Text[50])
        {
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(UserKey; "User ID")
        {
        }
        key(DateTimeKey; "Date and Time")
        {
        }
        key(EventTypeKey; "Event Type")
        {
        }
    }
}
