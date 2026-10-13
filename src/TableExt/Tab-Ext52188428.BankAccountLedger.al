tableextension 50063 "Bank Account Ledger" extends "Bank Account Ledger Entry"
{

    fields
    {
        field(90000; "Statement Difference"; Decimal)
        {
            Caption = 'Statement Difference';
            DataClassification = ToBeClassified;
        }
        field(50013; Remarks; Text[200])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }
        field(50188; "Match Option"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Date & Document No & Amount","Document No & Amount";
        }
        field(50018; "Old No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(KeyBankOpenExtRevStmt; "Bank Account No.", Open, "External Document No.", Reversed, "Statement Status")
        {
        }
        key(KeyBankAmtOpenExtRevStmt; "Bank Account No.", Amount, Open, "External Document No.", Reversed, "Statement Status")
        {
        }
    }

    procedure SetStyleText() StyleText: Text[20]
    begin
        StyleText := '';
        case "Match Option" of
            "Match Option"::"Document No & Amount":
                StyleText := 'StandardAccent';
            "Match Option"::"Date & Document No & Amount":
                StyleText := 'Favorable';
        end;
    end;
}
