table 50442 "Suspend Interest Accounts"
{
    Caption = 'Suspend Interest Accounts';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No"; code[50])
        {
            Caption = 'No';
        }
        field(2; "Loan No."; code[20])
        {
        }
        field(3; "Account No."; code[30])
        { }
        field(4; "Loan Product Type"; code[10])
        { }
        field(5; "Interest Date"; Date)
        { }
        field(6; "Interest Amount"; Decimal)
        { }
        field(7; "Issued Date"; date)
        { }
        field(8; "Transfered to Income Ac"; Boolean)
        { }
        field(9; "Suspended Account No."; code[20])
        { }
        field(11; "Interest Income Account"; code[20])
        { }
        field(12; Posted; Boolean)
        { }
        field(13; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(14; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(15; "Description"; Text[100])
        {
        }
    }
    keys
    {
        key(PK; "No", "Loan No.", "Interest Date")
        {
            Clustered = true;
        }
    }
}
