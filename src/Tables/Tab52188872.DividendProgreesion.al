table 50574 " Old Dividend Progresion"
{
    Caption = 'Old Dividend Progresion';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Entry No';
        }
        field(2; "Account No"; Code[30])
        {
            Caption = 'Account No';
        }
        field(3; "Processing Date"; Date)
        {
            Caption = 'Processing Date';
        }
        field(4; Product; Code[10])
        {
            Caption = 'Product';
        }
        field(5; "Product Name"; Text[50])
        {
            Caption = 'Product Name';
        }
        field(6; "Member No"; Code[30])
        {
            Caption = 'Member No';
        }
        field(7; "Qualifying Shares"; Decimal)
        {
            Caption = 'Qualifying Shares';
        }
        field(8; Shares; Decimal)
        {
            Caption = 'Shares';
        }
        field(9; "Gross Dividends"; Decimal)
        {
            Caption = 'Gross Dividends';
        }
        field(10; "Net Dividends"; Decimal)
        {
            Caption = 'Net Dividends';
        }
        field(11; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(12; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(13; "WithHolding Tax"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Account No", "End Date")
        {
            Clustered = true;
        }
    }
}
