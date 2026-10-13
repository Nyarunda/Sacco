
Table 50147 "Savings Interest Buffer"
{
    DrillDownPageID = "Savings Interest Buffer";
    LookupPageID = "Savings Interest Buffer";

    fields
    {
        field(1; "Account No."; Code[20])
        {
        }
        field(22; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(23; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50003; "Product Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Interest Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Interest Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Account Matured"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(50010; "Late Interest"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Mark For Deletion"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Reference No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Qualifying Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; Description; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50016; Accrued; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Interest Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Witholding Tax"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Payable Account"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Withholding Tax Account"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Expense Account"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Accrued By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "Posted By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Interest Date", "Account No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

