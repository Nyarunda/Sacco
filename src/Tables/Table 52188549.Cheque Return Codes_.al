
Table 50212 "Cheque Return Codes_"
{
    //DrillDownPageID = UnknownPage52018509;
    //LookupPageID = UnknownPage52018509;

    fields
    {
        field(1; "Return Code"; Code[2])
        {
        }
        field(2; "Code Interpretation"; Text[100])
        {
        }
        field(3; Charges; Decimal)
        {
        }
        field(4; "Bounced Charges GL Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(5; "Charge Code"; Code[20])
        {
            TableRelation = "Transaction Charges" where(Type = const("Cheque Unpay"));
        }
    }

    keys
    {
        key(Key1; "Return Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Return Code", "Code Interpretation")
        {
        }
    }
}

