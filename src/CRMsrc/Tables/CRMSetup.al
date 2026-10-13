
table 50403 "CRM Setup"
{
    DataClassification = SystemMetadata;
    fields
    {
        field(1; "Primary Key"; Code[20])
        {

        }
        field(2; "Customer Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(3; "Ticket Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(4; "Auto Assignment"; Boolean) { }
        field(5; "Email Notifications"; Boolean) { }
        field(6; "SMS Notifications"; Boolean) { }
        field(7; "Support Personnel Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(PK; "Primary Key") { Clustered = true; }
    }

}
