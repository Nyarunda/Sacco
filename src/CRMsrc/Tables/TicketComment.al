
table 50402 "Ticket Comment"
{
    fields
    {
        field(1; "Ticket No."; Code[20]) { }
        field(2; "Line No."; Integer) { }
        field(3; "Comment Type"; Enum "Comment Type") { }
        field(4; Comment; Text[250]) { }
        field(5; "Created By"; Code[50]) { }
        field(6; "Created DateTime"; DateTime) { }
    }
    keys
    {
        key(PK; "Ticket No.", "Line No.") { Clustered = true; }
    }
}
