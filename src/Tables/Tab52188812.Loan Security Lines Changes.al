table 50494 "Loan Security Lines Changes"
{
    Caption = 'Loan Security Lines Changes';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Loan No"; Code[20])
        {
            Caption = 'Loan No';
            Editable = false;
        }
        field(2; "Security Type"; Option)
        {
            Caption = 'Security Type';
            OptionMembers = Guarantor,Collateral,Lien;
            Editable = false;
        }
        field(3; "Security Name"; Text[80])
        {
            Caption = 'Security Name';
            Editable = false;
        }
        field(4; "Security Account"; Code[20])
        {
            Caption = 'Security Account';
            Editable = false;
        }
        field(5; "Amount Guaranteed"; Decimal)
        {
            Caption = 'Amount Guaranteed';
            Editable = false;
        }
        field(6; "Commited Amount"; Decimal)
        {
            Caption = 'Commited Amount';
            Editable = false;
        }
        field(7; "New Commited Amount"; Decimal)
        {
            Caption = 'New Commited Amount';
        }
        field(8; "Collateral Reg. No."; Code[20])
        {
            Caption = 'Collateral Reg. No.';
            Editable = false;
        }
        field(9; Subtituted; Boolean)
        {
            Caption = 'Subtituted';
        }
    }
    keys
    {
        key(PK; "Loan No", "Security Account", "Collateral Reg. No.")
        {
            Clustered = true;
        }
    }
}
