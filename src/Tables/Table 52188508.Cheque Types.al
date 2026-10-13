
Table 50171 "Cheque Types"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Clearing Days"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Clearing Charge Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Local,Inhouse,Upcountry';
            OptionMembers = "Local",Inhouse,Upcountry;
        }
        field(6; "Clearing Charges GL Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(7; "Clearing  Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Cheque Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
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
}

