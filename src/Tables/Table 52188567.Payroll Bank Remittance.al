
Table 50230 "Payroll Bank Remittance"
{

    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; "Bank Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Branch Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payroll Periods";
        }
        field(5; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Transaction Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Staff No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "% Net PAY"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Bank Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Branch Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50000; "A/C  Number"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Sacco Account"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Payment to"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Bank,Sacco,Cash;
        }
    }

    keys
    {
        key(Key1; "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

