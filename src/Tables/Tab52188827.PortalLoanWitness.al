table 50529 "Portal Loan Witness"
{
    Caption = 'Portal Loan Witness';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Witness No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Loan Application No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Witness Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Witness Phone"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Witness Address"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Date Added"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Witness Approved"; Option)
        {
            OptionMembers = Pending,Yes,No;
            DataClassification = ToBeClassified;
        }
        field(8; "Date Approved"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Loan Application No.", "Witness No.")
        {
            Clustered = true;
        }
        key(LoanApplicationKey; "Loan Application No.")
        {
            // Non-clustered key for loan application reference
        }
    }
}
