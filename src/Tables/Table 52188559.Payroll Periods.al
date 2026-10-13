
Table 50222 "Payroll Periods"
{

    fields
    {
        field(1; "Period Month"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Period Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Period Name"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'e.g November 2009';
        }
        field(4; "Date Opened"; Date)
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(5; "Date Closed"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Closed; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'A period is either closed or open';
        }
        field(7; "Closed By"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Opened By"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Date Opened")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Date Opened", "Period Name")
        {
        }
    }
}

