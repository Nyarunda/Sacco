table 50551 "CRB Submission Logs"
{
    Caption = 'CRB Submission Logs';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Header No."; Integer)
        {
            Caption = 'Header No.';
        }
        field(2; "GUID"; Guid)
        {
            Caption = 'GUID ';
        }
        field(3; "Loan No."; Code[20])
        {
            Caption = 'Loan No.';
        }
        field(4; "Member No."; Code[20])
        {
            Caption = 'Member No.';
        }
        field(5; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(6; column_name; Text[100])
        {
            Caption = 'column_name';
        }
        field(7; value_provided; Text[100])
        {
            Caption = 'value_provided';
        }
        field(8; error_description; Text[1000])
        {
            Caption = 'error_description';
        }
    }
    keys
    {
        key(PK; "Header No.", "GUID")
        {
            Clustered = true;
        }
    }
}
