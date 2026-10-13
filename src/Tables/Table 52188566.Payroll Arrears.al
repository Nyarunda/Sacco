
Table 50229 "Payroll Arrears"
{

    fields
    {
        field(1; "Employee Code"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(2; "Transaction Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'From when do we back date';
        }
        field(4; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'Upto when do we back date';
        }
        field(5; "Salary Arrears"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "PAYE Arrears"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Period Month"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Period Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Current Basic"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payroll Periods"."Date Opened";
        }
        field(11; Number; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
    }

    keys
    {
        key(Key1; "Employee Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

