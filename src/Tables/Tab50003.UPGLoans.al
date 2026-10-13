table 50003 UPG_Loans
{
    Caption = 'UPG_Loans';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Loan No."; Code[20])
        {
            Caption = 'Loan No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Client Code"; Code[20])
        {
            Caption = 'Client Code';
            DataClassification = ToBeClassified;
        }
        field(3; "Client Name"; Text[200])
        {
            Caption = 'Client Name';
            DataClassification = ToBeClassified;
        }
        field(4; "Loan Product Type"; Code[20])
        {
            Caption = 'Loan Product Type';
            DataClassification = ToBeClassified;
        }
        field(5; "Loan Product Type Name"; Text[200])
        {
            Caption = 'Loan Product Type Name';
            DataClassification = ToBeClassified;
        }
        field(6; "Application Date"; Date)
        {
            Caption = 'Application Date';
            DataClassification = ToBeClassified;
        }
        field(7; "Requested Amount"; Decimal)
        {
            Caption = 'Requested Amount';
            DataClassification = ToBeClassified;
        }
        field(8; "Approved Amount"; Decimal)
        {
            Caption = 'Approved Amount';
            DataClassification = ToBeClassified;
        }
        field(9; Interest; Decimal)
        {
            Caption = 'Interest';
            DataClassification = ToBeClassified;
        }
        field(10; "Loan Status"; Text[50])
        {
            Caption = 'Loan Status';
            DataClassification = ToBeClassified;
        }
        field(11; "Issued Date"; Date)
        {
            Caption = 'Issued Date';
            DataClassification = ToBeClassified;
        }
        field(12; Installments; Integer)
        {
            Caption = 'Installments';
            DataClassification = ToBeClassified;
        }
        field(13; "Loan Disbursement Date"; Date)
        {
            Caption = 'Loan Disbursement Date';
            DataClassification = ToBeClassified;
        }
        field(14; "Last Pay Date"; Date)
        {
            Caption = 'Last Pay Date';
            DataClassification = ToBeClassified;
        }
        field(15; "Repayment Start Date"; Date)
        {
            Caption = 'Repayment Start Date';
            DataClassification = ToBeClassified;
        }
        field(16; "Repayment Frequency"; Text[50])
        {
            Caption = 'Repayment Frequency';
            DataClassification = ToBeClassified;
        }
        field(17; "Repayment Method"; Text[50])
        {
            Caption = 'Repayment Method';
            DataClassification = ToBeClassified;
        }
        field(18; "Outstanding Balance"; Decimal)
        {
            Caption = 'Outstanding Balance';
            DataClassification = ToBeClassified;
        }
        field(19; "Oustanding Interest"; Decimal)
        {
            Caption = 'Oustanding Interest';
            DataClassification = ToBeClassified;
        }
        field(20; "New Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(21; Created; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Loan No.")
        {
            Clustered = true;
        }
    }
}
