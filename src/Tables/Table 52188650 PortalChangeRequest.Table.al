Table 50313 "Portal Change Request"
{

    fields
    {
        field(1; "CR ID"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Time; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Name; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Field"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Current Value"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "New Value"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Pending,Approved,Effected,Rejected;
        }
        field(10; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Processed by"; Code[50])
        {
        }
        field(12; "Date Processed"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "CR ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

