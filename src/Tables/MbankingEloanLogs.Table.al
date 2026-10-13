Table 50376 "Mbanking Eloan Logs"
{

    fields
    {
        field(1; Guid; Guid)
        {
        }
        field(2; Date; Date)
        {
        }
        field(3; Time; Time)
        {
        }
        field(4; "Entry No"; Integer)
        {
            AutoIncrement = false;
        }
        field(5; PhoneNo; Text[30])
        {
        }
        field(6; LoanType; Text[30])
        {
        }
        field(7; LoanPeriod; Integer)
        {
        }
        field(8; Amount; Decimal)
        {
        }
        field(9; SpotCashID; Text[30])
        {
        }
        field(10; ReferenceID; Text[30])
        {
        }
        field(11; Msg; Text[300])
        {
        }
        field(12; ResCode; Text[20])
        {
        }
        field(13; Response; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; Guid)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

