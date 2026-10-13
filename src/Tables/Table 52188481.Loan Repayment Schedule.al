
Table 50144 "Loan Repayment Schedule"
{

    fields
    {
        field(1; "Loan No."; Code[20])
        {
            Caption = 'No.';
            //TableRelation = Loans."Loan No.";
        }
        field(50002; "Repayment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Loan Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Monthly Principal"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Monthly Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Monthly Appraisal"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Monthly Repayment"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Loan Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Deposit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Old Repayment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Insurance Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Monthly Shares"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Loan No.", "Repayment Date","Member No.")
        {
            Clustered = true;
        }
        key(Key2; "Member No.", "Deposit Amount")
        {
        }
    }

    fieldgroups
    {
    }
}
