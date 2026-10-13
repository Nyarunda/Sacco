table 50004 "UPG_Loan Guarantors"
{
    Caption = 'UPG_Loan Guarantors';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Loan No"; Code[20])
        {
            Caption = 'Loan No';
            DataClassification = ToBeClassified;
        }
        field(2; "Member No"; Code[20])
        {
            Caption = 'Member No';
            DataClassification = ToBeClassified;
        }
        field(3; "Member Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Loan Balance"; Decimal)
        {
            Caption = 'Loan Balance';
            DataClassification = ToBeClassified;
        }
        field(5; Shares; Decimal)
        {
            Caption = 'Shares';
            DataClassification = ToBeClassified;
        }
        field(6; Substituted; Boolean)
        {
            Caption = 'Substituted';
            DataClassification = ToBeClassified;
        }
        field(7; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(8; "Amount Guaranteed"; Decimal)
        {
            Caption = 'Amont Guaranteed';
            DataClassification = ToBeClassified;
        }
        field(9; "Payroll No"; Code[200])
        {
            Caption = 'Payroll No.';
            DataClassification = ToBeClassified;
        }
        field(10; "ID No"; Code[200])
        {
            Caption = 'ID No';
            DataClassification = ToBeClassified;
        }
        field(11; "Free Shares"; Decimal)
        {
            Caption = 'Free Shares';
            DataClassification = ToBeClassified;
        }
        field(12; "Mobile Phone No"; Code[200])
        {
            Caption = 'Mobile Phone No';
            DataClassification = ToBeClassified;
        }
        field(13; "Guarantor Free Shares"; Decimal)
        {
            Caption = 'Guarantor Free Shares';
            DataClassification = ToBeClassified;
        }
        field(14; "Self Guaranteed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Employer Code"; Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Substituted Guarantor"; Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(18; "Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "Loan No", "Member No", "Line No.")
        {
            Clustered = true;
        }
    }
}
