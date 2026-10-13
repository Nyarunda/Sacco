table 59994 "Loan Graduation Model"
{
    Caption = 'Loan Graduation Model';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Version No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(4; Active; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(5; "Evaluation Period Months"; Integer)
        {
            DataClassification = CustomerContent;
            InitValue = 12;
            MinValue = 1;
        }
        field(6; "Minimum Qualifying Score"; Decimal)
        {
            DataClassification = CustomerContent;
            InitValue = 50;
        }
        field(7; "Grace Days Before Due"; Integer)
        {
            DataClassification = CustomerContent;
            InitValue = 7;
            MinValue = 0;
        }
        field(8; "Grace Days After Due"; Integer)
        {
            DataClassification = CustomerContent;
            InitValue = 30;
            MinValue = 0;
        }
        field(9; "On Time Grace Days"; Integer)
        {
            DataClassification = CustomerContent;
            InitValue = 7;
            MinValue = 0;
        }
        field(10; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(11; "Created At"; DateTime)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
        key(ActiveKey; Active) { }
    }

    trigger OnInsert()
    begin
        "Created By" := UserId;
        "Created At" := CurrentDateTime;
    end;
}
