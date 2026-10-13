
table 50006 "CRM Department"
{
    fields
    {
        field(1; Code; Code[20]) { }
        field(2; Name; Text[100]) { }
        field(3; Active; Boolean) { }
    }
    keys
    {
        key(PK; Code) { Clustered = true; }
    }
}
