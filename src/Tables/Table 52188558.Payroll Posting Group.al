
Table 50221 "Payroll Posting Group"
{

    fields
    {
        field(1; "Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Salary Account"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(4; "Income Tax Account"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(5; "Net Salary Payable"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(6; "Operating Overtime"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(7; "Tax Relief"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(8; "Employee Provident Fund Acc."; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(9; "Pay Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "Payroll Periods"."Date Opened";
        }
        field(10; SalaryExpenseAC; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(11; DirectorsFeeGL; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(12; StaffGratuity; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(13; "Payroll Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Tax Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Employment Tax Debit"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(16; "Employment Tax Credit"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(17; "Payroll Control"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(18; "NITA Expense Account"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(19; "NITA Payable Account"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(20; "NSSF Tier 2"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(21; "Fringe Expense Account"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(22; "Fringe Payable Account"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(24; "Salary Paying Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

