
table 50404 "SLA Setup"
{
    fields
    {
        field(1; "Ticket Type"; Enum "Ticket Type") { }
        field(2; Priority; Enum "Ticket Priority") { }
        field(3; "Response Time (Hours)"; Integer) { }
        field(4; "Resolution Time (Hours)"; Integer) { }
    }
    keys
    {
        key(PK; "Ticket Type", Priority) { Clustered = true; }
    }
}
