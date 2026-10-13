table 50296 "Offset Appraisal"
{
    Caption = 'Offset Appraisal';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Offset No."; Code[20])
        {
            Caption = 'Offset No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Member No."; Code[20])
        {
            Caption = 'Member No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Loan No."; Code[20])
        {
            Caption = 'Loan No.';
            DataClassification = ToBeClassified;
        }
        field(4; "Member Name"; Text[200])
        {
            Caption = 'Member Name';
            DataClassification = ToBeClassified;
        }
        field(5; "Loan Product"; Code[20])
        {
            Caption = 'Loan Product';
            DataClassification = ToBeClassified;
        }
        field(6; "Approved Amount"; Decimal)
        {
            Caption = 'Approved Amount';
            DataClassification = ToBeClassified;
        }
        field(7; "Savings"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Share Capital"; Decimal)
        {
            Caption = 'Share Capital';
            DataClassification = ToBeClassified;
        }
        field(9; "Share Capital Top Up"; Decimal)
        {
            Caption = 'Share Capital Top Up';
            DataClassification = ToBeClassified;
        }
        field(10; "New Share Capital"; Decimal)
        {
            Caption = 'New Share Capital';
            DataClassification = ToBeClassified;
        }
        field(11; "Outstanding Interest"; Decimal)
        {
            Caption = 'Outstanding Interest';
            DataClassification = ToBeClassified;
        }
        field(12; "Interest Waived"; Decimal)
        {
            Caption = 'Interest Waived';
            DataClassification = ToBeClassified;
        }
        field(13; "Out. Interest After Waiver"; Decimal)
        {
            Caption = 'Outstanding Interest After Waiver';
            DataClassification = ToBeClassified;
        }
        field(14; "New Outstanding Interest"; Decimal)
        {
            Caption = 'New Outstanding Interest';
            DataClassification = ToBeClassified;
        }
        field(15; "Outstanding Balance"; Decimal)
        {
            Caption = 'Outstanding Balance';
            DataClassification = ToBeClassified;
        }
        field(16; "New Outstanding Balance"; Decimal)
        {
            Caption = 'New Outstanding Balance';
            DataClassification = ToBeClassified;
        }
        field(17; "New Savings Balance"; Decimal)
        {
            Caption = 'New Share Deposits';
            DataClassification = ToBeClassified;
        }
        field(18; "Loan Balance Before Guarantors"; Decimal)
        {
            Caption = 'Loan Balance Before Guarantors';
            DataClassification = ToBeClassified;
        }
        field(19; "Recovered From Guarantors"; Decimal)
        {
            Caption = 'Recovered From Guarantors';
            DataClassification = ToBeClassified;
        }
        field(20; "Loan Balance After Guarantors"; Decimal)
        {
            Caption = 'Loan Balance After Guarantors';
            DataClassification = ToBeClassified;
        }
        field(21; Arrears; Decimal)
        {
            Caption = 'Loan Arrears';
            DataClassification = ToBeClassified;
        }
        field(22; "Arrears Recovered"; Boolean)
        {
            Caption = 'Loan Balance After Guarantors';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Offset No.", "Loan No.")
        {
            Clustered = true;
        }
    }
}
