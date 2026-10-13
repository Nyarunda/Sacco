table 50534 "Check Off Codes"
{

    fields
    {
        field(1; "RCPT Code"; Code[10])
        {
            NotBlank = true;
        }
        field(2; "Reporting Name"; Text[50])
        {
        }
        field(3; "Posting Code"; Code[20])
        {
            TableRelation = "Product Setup"."Product ID";
        }
        field(4; "Transaction Type"; Enum "Transaction Type Enum")
        {
        }
        field(5; "Account Type"; Enum "Gen. Journal Account Type")
        {
        }
        field(6; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = "Savings Accounts";
            trigger OnValidate()
            begin
            end;
        }
        field(7; Priority; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "RCPT Code")
        {
        }
        key(Key2; Priority)
        {
        }
    }

    fieldgroups
    {
    }
}

