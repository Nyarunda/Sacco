
Table 50077 "SMS Messages"
{

    fields
    {
        field(1; "SMS ID"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; Source; Enum "SMS Source Enum")
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Mobile Phone No."; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Date Entered"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Time Entered"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Entered By"; Code[150])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "SMS Message"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Sent To Server"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'No,Yes,Failed';
            OptionMembers = No,Yes,Failed;
        }
        field(9; "Date Sent to Server"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Account No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Document No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Bulk SMS Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(21; IsChargeable; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(22; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Post to Loan Penalty"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Charge Not Found"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "SMS Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(27; Remark; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(28; Status; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(29; ResponseID; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "SMS ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

