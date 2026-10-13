table 50002 "UPG_Member Balances"
{
    Caption = 'UPG_Member Balances';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[200])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(3; "Monthly Contribution"; Decimal)
        {
            Caption = 'Monthly Contribution';
            DataClassification = ToBeClassified;
        }
        field(4; "Monthly Housing Contribution"; Decimal)
        {
            Caption = ' Monthly Housing Contribution';
            DataClassification = ToBeClassified;
        }
        field(5; "Monthly SFees Contribution"; Decimal)
        {
            Caption = 'Monthly SFees Contribution';
            DataClassification = ToBeClassified;
        }
        field(6; "Monthly Holiday Contribution"; Decimal)
        {
            Caption = 'Monthly Holiday Contribution';
            DataClassification = ToBeClassified;
        }
        field(7; "Shares Retained"; Decimal)
        {
            Caption = 'Shares Retained';
            DataClassification = ToBeClassified;
        }
        field(8; "Current Shares"; Decimal)
        {
            Caption = 'Current Shares';
            DataClassification = ToBeClassified;
        }
        field(9; "School Fees"; Decimal)
        {
            Caption = ' School Fees';
            DataClassification = ToBeClassified;
        }
        field(10; Holiday; Decimal)
        {
            Caption = 'Holiday';
            DataClassification = ToBeClassified;
        }
        field(11; Housing; Decimal)
        {
            Caption = 'Housing';
            DataClassification = ToBeClassified;
        }
        field(12; Retirement; Decimal)
        {
            Caption = 'Retirement';
            DataClassification = ToBeClassified;
        }
        field(13; "Loan Settlement Account"; Decimal)
        {
            Caption = 'Loan Settlement Account';
            DataClassification = ToBeClassified;
        }
        field(14; "FOSA Shares"; Decimal)
        {
            Caption = 'FOSA Shares';
            DataClassification = ToBeClassified;
        }
        field(15; "Un-allocated Funds"; Decimal)
        {
            Caption = 'Un-allocated Funds';
            DataClassification = ToBeClassified;
        }
        field(16; "Dividend Amount"; Decimal)
        {
            Caption = 'Dividend Amount';
            DataClassification = ToBeClassified;
        }
        field(17; "Interest On Deposits"; Decimal)
        {
            Caption = 'Interest On Deposits';
            DataClassification = ToBeClassified;
        }
        field(18; "Registration Fee Paid"; Decimal)
        {
            Caption = 'Registration Fee Paid';
            DataClassification = ToBeClassified;
        }
        field(19; "Recruitment Comission Amount"; Decimal)
        {
            Caption = 'Recruitment Comission Amount';
            DataClassification = ToBeClassified;
        }
        field(20; "Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}
