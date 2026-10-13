/// <summary>
/// Table Loans Repayment Property (ID 50451).
/// </summary>
table 50451 "Loan Repayment Property"
{
    Caption = 'Loan Repayment Property';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Loan No"; Code[20])
        {
            Caption = 'Loan No';
            Editable = false;
        }
        field(2; "Member No."; Code[20])
        {
            Caption = 'Member No';
            TableRelation = Members where("No." = field("Member No."));
        }
        // field(4; "Property Code"; Code[20])
        // {
        //     Caption = 'Property Code';
        //     TableRelation = "Property Codes" where("Member No." = field("Member No."));
        // }
        field(5; Amount; Decimal)
        {
            Caption = 'Repayment Amount';

        }
    }
    keys
    {
        key(Key1; "Loan No", "Member No.")
        {
            Clustered = true;
        }
    }
}
