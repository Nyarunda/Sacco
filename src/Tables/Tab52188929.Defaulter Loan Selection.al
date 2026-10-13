table 50631 "Defaulter Loan Selection"
{
    Caption = 'Defaulter Loan Selection';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Advice No."; Code[20])
        {
            Editable = false;
        }
        field(3; "Loan No."; Code[20])
        {
            Caption = 'Loan No.';
            TableRelation = Loans where("Member No." = field("Member No."));
        }
        field(5; "Amount To Distribute"; Decimal)
        {
            Caption = 'Amount To Distribute';
        }
        field(6; "Member No."; Code[20])
        {
            Caption = 'Member No.';
            TableRelation = Members;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Advice No.", "Member No.", "Loan No.")
        {
            Clustered = true;
        }
    }
}
