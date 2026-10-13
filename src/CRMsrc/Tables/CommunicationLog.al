
table 50008 "Communication Log"
{
    fields
    {
        field(1; "Ticket No."; Code[20]) { }
        field(2; "Communication Type"; Text[20]) { }
        field(3; Recipient; Text[80]) { }
        field(4; "Message Content"; Text[250]) { }
        field(5; "Sent DateTime"; DateTime) { }
        field(6; "Sent By"; Code[50]) { }
    }
    keys
    {
        key(PK; "Ticket No.", "Sent DateTime") { Clustered = true; }
    }
}
