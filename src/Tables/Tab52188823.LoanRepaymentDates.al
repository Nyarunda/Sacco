table 50518 "Loan Repayment Dates"
{
    Caption = 'Loan Repayment Dates';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Loan No."; Code[20])
        {
            Caption = 'Loan No.';
        }
        field(2; "Member No."; Code[20])
        {
            Caption = 'Member No.';
        }
        field(3; "Member name"; Text[100])
        {
            Caption = 'Member name';
        }
        field(4; "Repayment Date"; Date)
        {
            Caption = 'Repayment Date';
        }
        field(5; "Days in Arrears"; Integer)
        {
            Caption = 'Days in Arrears';
        }
    }
    keys
    {
        key(PK; "Loan No.")
        {
            Clustered = true;
        }
        key(Key1; "Repayment Date")
        {
        }
        key(Key2; "Days in Arrears")
        {
        }
    }
}
