
Table 50176 "Cheque Return Codes"
{

    fields
    {
        field(1; "Return Code"; Code[2])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Code Interpretation"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Charges; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Bounced Charges GL Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(5; "Charge Code"; Code[20])
        {
            DataClassification = ToBeClassified;
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
    }
}

