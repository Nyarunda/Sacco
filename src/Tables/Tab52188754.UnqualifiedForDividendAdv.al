table 50436 "Unqualified For Dividend Adv"
{
    Caption = 'Unqualified For Dividend Adv';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Member No"; code[20])
        {

        }
        field(3; Reason; Text[250])
        {

        }
        field(4; "Date Applied"; Date)
        {

        }
    }
    keys
    {
        key(PK; "Entry No")
        {
            Clustered = true;
        }
    }
}
