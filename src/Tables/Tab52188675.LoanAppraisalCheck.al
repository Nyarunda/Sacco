table 50338 "Loan Appraisal Check"
{
    Caption = 'Loan Appraisal Check';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; "Member No."; Code[20])
        {
            Caption = 'Member No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Member Name"; Text[200])
        {
            Caption = 'Member Name';
            DataClassification = ToBeClassified;
        }
        field(4; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(5; "Requested Amount"; Decimal)
        {
            Caption = 'Requested Amount';
            DataClassification = ToBeClassified;
        }
        field(6; Basic; Decimal)
        {
            Caption = 'Basic';
            DataClassification = ToBeClassified;
        }
        field(7; "House Allowance"; Decimal)
        {
            Caption = 'House Allowance';
            DataClassification = ToBeClassified;
        }
        field(8; "Commuter Allowance"; Decimal)
        {
            Caption = 'Commuter Allowance';
            DataClassification = ToBeClassified;
        }
        field(9; "Other Allowances"; Decimal)
        {
            Caption = 'Other Allowances';
            DataClassification = ToBeClassified;
        }
        field(10; "Sacco Bosa Deductions"; Decimal)
        {
            Caption = 'Sacco Bosa Deductions';
            DataClassification = ToBeClassified;
        }
        field(11; "Sacco Fosa Deductions"; Decimal)
        {
            Caption = 'Sacco Fosa Deductions';
            DataClassification = ToBeClassified;
        }
        field(12; "Appraised By"; Code[50])
        {
            Caption = '';
            DataClassification = ToBeClassified;
        }

        field(13; "Total Top Up"; Decimal)
        {
            Caption = 'Sacco Fosa Deductions';
            DataClassification = ToBeClassified;
        }
        field(14; "Total Charges"; Decimal)
        {
            Caption = 'Sacco Fosa Deductions';
            DataClassification = ToBeClassified;
        }
        field(15; "Total Boosting"; Decimal)
        {
            Caption = 'Sacco Fosa Deductions';
            DataClassification = ToBeClassified;
        }
        field(16; "Total Clearance"; Decimal)
        {
            Caption = 'Sacco Fosa Deductions';
            DataClassification = ToBeClassified;
        }
        field(17; "Net Take Home"; Decimal)
        {
            Caption = 'Sacco Fosa Deductions';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
