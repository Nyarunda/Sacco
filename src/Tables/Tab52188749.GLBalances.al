table 50429 "GL Balances"
{
    Caption = 'GL Balances';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "G/L Account"; Code[20])
        {
            Caption = 'G/L Account';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Record "G/L Account";
            begin
                // myInt."Income/Balance"
            end;
        }
        field(2; "G/L Account Name"; Text[200])
        {
            Caption = 'G/L Account Name';
            DataClassification = ToBeClassified;
        }
        field(3; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(4; Balance; Decimal)
        {
            Caption = 'Balance';
            DataClassification = ToBeClassified;
        }

        field(9; "Income/Balance"; Option)
        {
            Caption = 'Income/Balance';
            OptionCaption = 'Income Statement,Balance Sheet';
            OptionMembers = "Income Statement","Balance Sheet";

        }
    }
    keys
    {
        key(PK; "G/L Account", Date)
        {
            Clustered = true;
        }
    }
}
