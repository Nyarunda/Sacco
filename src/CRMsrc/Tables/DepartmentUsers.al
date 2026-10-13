
table 50405 "OLD Department Users"
{
    fields
    {
        field(1; "Department Code"; Code[20]) { }
        field(2; "User ID"; Code[50]) { }
        field(3; Active; Boolean) { }
    }
    keys
    {
        key(PK; "Department Code", "User ID") { Clustered = true; }
    }
}
