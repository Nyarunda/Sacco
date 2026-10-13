
Table 50201 "Sacco Category _New"
{

    fields
    {
        field(1; "Loan Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Performing,Watch,Substandard,Doubtful,Loss';
            OptionMembers = Performing,Watch,Substandard,Doubtful,Loss;
        }
        field(2; From_Days; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; To_Days; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Loan Category")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

