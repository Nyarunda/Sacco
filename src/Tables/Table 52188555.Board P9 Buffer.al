
Table 50218 "Board P9 Buffer"
{

    fields
    {
        field(1; "Employee Code"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";
        }
        field(2; "Basic Pay"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Allowances; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Benefits; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Value Of Quarters"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Defined Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Owner Occupier Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Gross Pay"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Taxable Pay"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Tax Charged"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Insurance Relief"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Tax Relief"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; PAYE; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; NSSF; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; NHIF; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; Deductions; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Net Pay"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Period Month"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Period Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payroll Periods"."Date Opened";
        }
        field(21; "Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "Payroll Periods"."Date Opened";
        }
        field(22; Pension; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(23; HELB; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Payroll Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Monthly Period"; Code[20])
        {
        }
        field(26; "Entry No"; Integer)
        {
        }
        field(27; "Housing Levy"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

