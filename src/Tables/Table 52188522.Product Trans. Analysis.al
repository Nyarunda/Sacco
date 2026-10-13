
Table 50185 "Product Trans. Analysis"
{

    fields
    {
        field(1; "Product ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Lower Date"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Upper Date"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Variance; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Product Group"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'BOSA,FOSA,MICRO';
            OptionMembers = BOSA,FOSA,MICRO;
        }
        field(9; "User ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Product Class Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'Whether Loan Accounts or Operational accounts';
            OptionCaption = ' ,Loan,Savings';
            OptionMembers = " ",Loan,Savings;
        }
        field(11; "Product Category"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'Option to help identify type of savings accounts';
            OptionCaption = ' ,Share Capital,Deposit Contribution,Fixed Deposit,Junior Savings,Registration Fee,Benevolent,Unallocated Fund,Micro Credit Deposits,NHIF,Holiday,School Fee,Dividend';
            OptionMembers = " ","Share Capital","Deposit Contribution","Fixed Deposit","Junior Savings","Registration Fee",Benevolent,"Unallocated Fund","Micro Credit Deposits",NHIF,Holiday,"School Fee",Dividend;
        }
    }

    keys
    {
        key(Key1; "Product ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

