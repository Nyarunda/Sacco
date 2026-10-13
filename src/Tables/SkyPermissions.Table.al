Table 50348 "Sky Permissions"
{

    fields
    {
        field(1; "User ID"; Code[80])
        {
            Caption = 'User ID.';
            TableRelation = "User Setup"."User ID";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(7; "View Setup"; Boolean)
        {
        }
        field(8; "Edit Setup"; Boolean)
        {
        }
        field(48; "Reset Mpesa Pin"; Boolean)
        {
        }
        field(49; "Update Paybill Transaction"; Boolean)
        {
        }
        field(50000; "Update Transactional Mobile No"; Boolean)
        {
        }
        field(50050; "Sky Mobile Setups"; Boolean)
        {
        }
        field(50051; "Reverse Sky Transactions"; Boolean)
        {
        }
        field(50052; "Black-List Accounts"; Boolean)
        {
        }
        field(50056; "Update MPESA Withdrawal"; Boolean)
        {
        }
        field(50060; "View BlackListed Accounts"; Boolean)
        {
        }
        field(50062; "Clear Transactional Mobile"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "User ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

