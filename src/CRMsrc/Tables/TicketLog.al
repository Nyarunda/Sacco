
table 50007 "Ticket Log"
{
    fields
    {
        field(1; "Ticket No."; Code[20]) { }
        field(2; "Action Description"; Text[250]) { }
        field(3; "User ID"; Code[50]) { }
        field(4; "Date Time"; DateTime) { }
    }
    keys
    {
        key(PK; "Ticket No.", "Date Time") { Clustered = true; }
    }
}
