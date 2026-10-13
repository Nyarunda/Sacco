table 50339 "Member Payslip"
{
    Caption = 'Member Payslip';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Member No."; Code[20])
        {
            Caption = 'Member No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(3; Basic; Decimal)
        {
            Caption = 'Basic';
            DataClassification = ToBeClassified;
        }
        field(4; "House Allowance"; Decimal)
        {
            Caption = 'House Allowance';
            DataClassification = ToBeClassified;
        }
        field(5; "Commutter Allowance"; Decimal)
        {
            Caption = 'Commutter Allowance';
            DataClassification = ToBeClassified;
        }
        field(6; "Other Allowances"; Decimal)
        {
            Caption = 'Other Allowances';
            DataClassification = ToBeClassified;
        }
        field(7; "BOSA Loans"; Decimal)
        {
            Caption = 'BOSA Loans';
            DataClassification = ToBeClassified;
        }
        field(8; Pension; Decimal)
        {
            Caption = 'Pension';
            DataClassification = ToBeClassified;
        }
        field(9; NSSF; Decimal)
        {
            Caption = 'NSSF';
            DataClassification = ToBeClassified;
        }
        field(10; NHIF; Decimal)
        {
            Caption = 'NHIF';
            DataClassification = ToBeClassified;
        }
        field(11; "Other Deductions"; Decimal)
        {
            Caption = 'Other Deductions';
            DataClassification = ToBeClassified;
        }
        field(12; "External Clearance"; Decimal)
        {
            Caption = 'External Clearance';
            DataClassification = ToBeClassified;
        }
        field(13; Gross; Decimal)
        {
            Caption = 'Gross';
            DataClassification = ToBeClassified;
        }
        field(14; "1/3 of Gross"; Decimal)
        {
            Caption = '1/3 of Gross';
            DataClassification = ToBeClassified;
        }
        field(15; "Fosa Loans"; Decimal)
        {
            Caption = 'Fosa Loans';
            DataClassification = ToBeClassified;
        }
        field(16; "Net Salary Average"; Decimal)
        {
            Caption = 'Net Salary Average';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Member No.")
        {
            Clustered = true;
        }
    }
}
