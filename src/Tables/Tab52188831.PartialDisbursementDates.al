table 50533 "Partial Disbursement Dates"
{
    Caption = 'Partial Disbursement Dates';
    DataClassification = ToBeClassified;

    fields
    {

        field(2; "Loan No."; Code[20])
        {
            Caption = 'Loan No.';
        }
        field(3; "Disbursement Date"; Date)
        {
            Caption = 'Disbursement Date';
        }
    }
    keys
    {
        key(PK; "Disbursement Date", "Loan No.")
        {
            Clustered = true;
        }
    }
}
