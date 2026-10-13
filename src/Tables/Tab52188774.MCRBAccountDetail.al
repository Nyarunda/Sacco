table 50547 "MCRB Account Detail"
{
    Caption = 'MCRB Account Detail';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "AccountDetailID"; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(2; "IntegrationLogID"; Integer)
        {
            DataClassification = ToBeClassified;
            // Optional: use this to link back to the log entry.
        }
        field(3; "AccountNumber"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "AccountStatus"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Active,Closed,"Write-Off",Performing,"Non-Performing";
        }
        field(5; "CurrentBalance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "DateOpened"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "DaysInArrears"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "DelinquencyCode"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "HighestDaysInArrears"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "LastPaymentAmount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "LastPaymentDate"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "LoadedAt"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "OriginalAmount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "OverdueBalance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "OverdueDate"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "ProductTypeID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "AccountDetailID")
        {
            Clustered = true;
        }
    }
}

