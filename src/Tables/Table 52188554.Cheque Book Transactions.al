
Table 50217 "Cheque Book Transactions"
{

    fields
    {
        field(1; Guid; Guid)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Currency; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Ref Number"; Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "DR Account"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "DR Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "CR Account"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Narrative; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(10; MICR; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Cheque Number"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(12; Inputter; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Branch Number"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Comments; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(15; Indicator; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(16; UnpaidCode; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Transaction Type"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(18; Time; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(19; DateTime; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Cheque Transaction"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Inward,Outward,"Unpay Inward","Unpay Outward";
        }
        field(21; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Posted By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Date Posted"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Needs Change"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Posting Remark"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Transacting Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Guid)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

