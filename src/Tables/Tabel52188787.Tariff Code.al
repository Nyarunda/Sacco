/// <summary>
/// Table Tariff Code (ID 50469).
/// </summary>
table 50469 "Tariff Code"
{
    Caption = 'Tariff Code';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "Type"; Option)
        {
            Caption = 'Type';
            OptionMembers = ,"W/Tax",VAT,Excise,Retention,"W/VAT","W/Tax 3%","W/Tax 5%";
        }
        field(4; Percentage; Decimal)
        {
            Caption = 'Percentage';
        }
        field(5; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        }
        field(6; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = "G/L Account";
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
