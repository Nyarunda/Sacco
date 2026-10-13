Table 50321 "Dashboard Lines"
{

    fields
    {
        field(1; Date; Date)
        {
            TableRelation = DashBoard.Date;
        }
        field(2; Description; Text[200])
        {
        }
        field(3; Value; Decimal)
        {
        }
        field(4; Type; Option)
        {
            OptionMembers = " ","Treasury Balances","Loans Category";
        }
        field(5; Balance; Decimal)
        {
        }
        field(6; Guid; Guid)
        {
        }
    }

    keys
    {
        key(Key1; Date, Description, Guid)
        {
            Clustered = true;
        }
        key(Key2; Type)
        {
        }
    }

    fieldgroups
    {
    }
}

