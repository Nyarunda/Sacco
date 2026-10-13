Table 51086 "Salary Grades"
{
    //DrillDownPageID = UnknownPage39004027;
    //LookupPageID = UnknownPage39004027;

    fields
    {
        field(1; "Salary Grade"; Code[20])
        {
        }
        field(2; "Salary Amount"; Decimal)
        {
        }
        field(3; Description; Text[100])
        {
        }
        field(4; "Pays NHF"; Boolean)
        {
        }
        field(5; "Pays NSITF"; Boolean)
        {
        }
        field(6; "Minimum Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                "Maxmum Amount" := 0;
                Modify
            end;
        }
        field(7; "Maxmum Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Maxmum Amount" < "Minimum Amount" then
                    Error('Maximum amount cannot be less than the minimum amount')
            end;
        }
        field(8; "Leave Allowance"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Salary Grade")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

