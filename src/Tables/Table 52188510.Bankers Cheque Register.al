
Table 50173 "Bankers Cheque Register"
{
    DrillDownPageID = "Bankers Cheque Register";
    LookupPageID = "Bankers Cheque Register";

    fields
    {
        field(1; "Cheque No."; Code[6])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Status; Option)
        {
            DataClassification = ToBeClassified;
            Editable = true;
            OptionCaption = 'Pending,Approved,Cancelled,stopped,Dishonoured';
            OptionMembers = Pending,Approved,Cancelled,stopped,Dishonoured;
        }
        field(3; "Approval Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Application No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Cancelled/Stopped By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Bank Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(7; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(8; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(9; "Leaf Limit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Bankers Cheque Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Co-op Bankers Cheque,Customer Service Cheques';
            OptionMembers = "Co-op Bankers Cheque","Customer Service Cheques";
        }
    }

    keys
    {
        key(Key1; "Cheque No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

