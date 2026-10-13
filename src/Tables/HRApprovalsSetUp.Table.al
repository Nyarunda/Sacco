Table 51119 "HR Approvals Set Up"
{
    //DrillDownPageID = UnknownPage39004275;
    //LookupPageID = UnknownPage39004275;

    fields
    {
        field(1; "Approval Type"; Option)
        {
            OptionMembers = Loans,"Bridging Loans","Personal Loans",Refunds,"Funeral Expenses","Withdrawals - Resignation","Withdrawals - Death","Branch Loans",Journals,"File Movement","Appeal Loans","Bosa Loan Approval";
        }
        field(2; Stage; Integer)
        {
        }
        field(3; Description; Text[50])
        {
        }
        field(4; Station; Code[50])
        {
        }
        field(5; "Duration (Hr)"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Approval Type", Stage, Station)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

