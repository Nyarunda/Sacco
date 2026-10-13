
Table 50262 "Ordinary Cheque Register"
{
    DrillDownPageID = "Ordinary Cheque Register Setup";
    LookupPageID = "Ordinary Cheque Register Setup";

    fields
    {
        field(1; "Ordinary Cheque No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Issued; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Cancelled; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Branch Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(5; Source; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Co-op Bank,Equity bank';
            OptionMembers = " ","Co-op Bank","Equity bank";
        }
    }

    keys
    {
        key(Key1; "Ordinary Cheque No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

