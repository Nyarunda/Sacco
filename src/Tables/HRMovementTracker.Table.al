Table 51120 "HR Movement Tracker"
{
    //DrillDownPageID = UnknownPage39004265;
    //LookupPageID = UnknownPage39004265;

    fields
    {
        field(1; "Document No."; Code[20])
        {
        }
        field(2; "Approval Type"; Option)
        {
            OptionCaption = 'Loans,Special Loans,Personal Loans,Refunds,Funeral Expenses,Withdrawals - Resignation,Withdrawals - Death,Branch Loans';
            OptionMembers = Loans,"Special Loans","Personal Loans",Refunds,"Funeral Expenses","Withdrawals - Resignation","Withdrawals - Death","Branch Loans";
        }
        field(3; Stage; Integer)
        {
            TableRelation = "HR Approvals Set Up".Stage where("Approval Type" = field("Approval Type"));
        }
        field(4; Remarks; Text[50])
        {
        }
        field(5; Status; Option)
        {
            OptionCaption = 'Being Processed,Approved,Rejected';
            OptionMembers = "Being Processed",Approved,Rejected;
        }
        field(6; "Current Location"; Boolean)
        {
        }
        field(7; "Date/Time In"; DateTime)
        {
        }
        field(8; "Date/Time Out"; DateTime)
        {
        }
        field(9; "USER ID"; Code[20])
        {
        }
        field(10; "Entry No."; Code[10])
        {
        }
        field(11; Description; Text[50])
        {
        }
        field(12; Station; Code[50])
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Document No.", "Approval Type", "Entry No.", Stage)
        {
            Clustered = true;
        }
        key(Key3; "Document No.", "Current Location")
        {
        }
    }

    fieldgroups
    {
    }
}

