table 55034 "Rent Repayment Schedule"
{
    Caption = 'Rent Repayment Schedule';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = Customer."No.";
        }
        field(50002; "Repayment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Rent Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Monthly Principal"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Monthly Charges"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Monthly Repayment"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Rent Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "VAT Amt"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Customer No.", "Repayment Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

