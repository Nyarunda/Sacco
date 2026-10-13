
Table 50304 "Sasra - Annex 1 Tabke 1"
{

    fields
    {
        field(1; "Loan Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Member Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Member Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Branch Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Loan Officer"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Employer Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Loan Type"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Loan Amortization Type"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Loan Installments"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Annual Loan Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Loan Frequency"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Date Loan Disbursed"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Loan Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Loan Maturity"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Loan First Pmt date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Latest amount paid"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Latest payment date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Loan Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Days in Arrears"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Arrears date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Loan-Classification"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Loan loss Provision"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Loan Restructure Flag[1]"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(24; Loan_Interest_Due; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "No. of Loan Guarantors"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Amount of guarantee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Other Collateral_Security"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
         field(29; "Loan category"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Total Outstanding Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "Loan Number")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

