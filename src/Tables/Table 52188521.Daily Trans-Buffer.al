
Table 50184 "Daily Trans-Buffer"
{

    fields
    {
        field(1; "Product ID"; Code[200])
        {
        }
        field(2; Issued; Decimal)
        {
        }
        field(3; Paid; Decimal)
        {
        }
        field(4; "Issued Count"; Integer)
        {
        }
        field(5; "Paid Count"; Decimal)
        {
        }
        field(6; "Ledger Fees"; Decimal)
        {
        }
        field(7; Insurance; Decimal)
        {
        }
        field(8; "Product Group"; Option)
        {
            OptionCaption = 'BOSA,FOSA,MICRO';
            OptionMembers = BOSA,FOSA,MICRO;
        }
        field(9; "User ID"; Code[50])
        {
        }
        field(10; "Loan Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Non-Performing"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Defaulted Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; PAR; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Product ID", "User ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

