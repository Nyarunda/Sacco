table 50548 "MCRB Credit Score History"
{
    Caption = 'MCRB Credit Score History';
    DataClassification = ToBeClassified;


    fields
    {
        field(1; "ScoreHistoryID"; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(2; "IdentityNumber"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "CreditScore"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "ScoreDate"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "ScoreHistoryID")
        {
            Clustered = true;
        }
    }
}
