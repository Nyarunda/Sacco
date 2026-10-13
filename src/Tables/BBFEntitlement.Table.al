Table 50450 "BBF Entitlement"
{
    Caption = 'GFE';
    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Description; Text[30])
        {
            Editable = false;
        }
        field(3; Amount; Decimal)
        {
        }
        field(4; "Max No."; Integer)
        {
        }
        field(5; Minor; Boolean)
        {
        }
        field(6; Self; Boolean)
        {
        }
        field(7; Entitlement; Text[80])
        {
            TableRelation = Relationship;

        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Relations: Record Relationship;
}
