
table 50009 "User Workload"
{
    fields
    {
        field(1; "User ID"; Code[50]) { }
        field(2; "Active Tickets"; Integer) { }
        field(3; "Last Updated"; DateTime) { }
    }
    keys
    {
        key(PK; "User ID") { Clustered = true; }
    }
}
