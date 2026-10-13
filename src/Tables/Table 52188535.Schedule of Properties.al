
Table 50198 "Schedule of Properties"
{
    DrillDownPageID = "Schedule of Properties";
    LookupPageID = "Schedule of Properties";

    fields
    {
        field(1; "Loan No."; Code[20])
        {
        }
        field(2; Item; Code[20])
        {
        }
        field(3; Description; Text[250])
        {
        }
        field(4; Year; Code[50])
        {
        }
        field(5; "Estimated Value"; Decimal)
        {
        }
        field(6; "Serial No."; Code[20])
        {
        }
        field(7; Category; Code[200])
        {
            // TableRelation = "Property Category";
        }
    }

    keys
    {
        key(Key1; "Loan No.", Category, Item)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Cust: Record Members;
}

