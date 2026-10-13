Table 50395 "Virtual Member Reg Buffer"
{

    fields
    {
        field(1; "Entry Number"; Text[50])
        {
        }
        field(2; "Date Created"; DateTime)
        {
        }
        field(3; Name; Code[50])
        {
        }
        field(4; "National ID Number"; Text[30])
        {
        }
        field(5; "Mobile Number"; Text[30])
        {
        }
        field(6; "Date of Birth"; Date)
        {
        }
        field(7; "Referee Name"; Code[50])
        {
        }
        field(8; "Referee Member Number"; Text[30])
        {
        }
        field(9; "Email Address"; Text[50])
        {
        }
        field(10; "Agent Code"; Code[30])
        {
        }
        field(11; "Postal Address"; Text[50])
        {
        }
        field(12; "Employment Status"; Text[30])
        {
        }
        field(13; Employer; Text[50])
        {
        }
        field(14; Region; Text[50])
        {
        }
        field(15; "Transaction Date"; Date)
        {
        }
        field(16; "Name on IPRS"; Code[50])
        {
        }
    }

    keys
    {
        key(Key1; "Entry Number")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

