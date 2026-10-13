table 50515 FinanceReports
{
    Caption = 'FinanceReports';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Year; Date)
        {
            Caption = 'Year';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Year)
        {
            Clustered = true;
        }
    }
}