
Table 50268 "Mpesa Manual Upload"
{

    fields
    {
        field(1; "Receipt No."; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Completion Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Initiation Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Details; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Transaction Status"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Paid In"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Withdrawn; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Balance; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Balance Confirmed"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Reason Type"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Other Party Info"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Linked Transaction ID"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "A/C No."; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Key Word"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Loan No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Loan Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; Validated; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19; Transfered; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "New Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Needs Change"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Date Uploaded"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Already Posted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Receipt No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Date Uploaded" := Today;

        Validated := false;
        Transfered := false;
        "Needs Change" := false;
        "Already Posted" := false;
    end;

    trigger OnModify()
    begin

        Validated := false;
        Transfered := false;
        "Needs Change" := false;
        "Already Posted" := false;
    end;
}

