
Table 50302 "Dummy Bank Transfer"
{

    fields
    {
        field(1; "Receipt No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Phone No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Already Posted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Transfered; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Pending Posting"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Member Account"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Receipt No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        BLedger.Reset;
        BLedger.SetRange("Document No.", "Receipt No.");
        if BLedger.FindFirst then begin
            "Already Posted" := true;
        end;


        SkyTransactions.Reset;
        SkyTransactions.SetRange("Transaction ID", "Receipt No.");
        if SkyTransactions.FindFirst then begin
            "Pending Posting" := true;
        end;

        Description := CopyStr(Description, 1, 32);
        //Amount := Amount *-1;


        MemberAccounts.Reset;
        MemberAccounts.SetRange("Transactional Mobile No", '+' + "Phone No.");
        if MemberAccounts.FindFirst then
            "Member Account" := MemberAccounts."No.";
    end;

    var
        BLedger: Record "Bank Account Ledger Entry";
        SkyTransactions: Record "Sky Transactions.";
        MemberAccounts: Record "Savings Accounts";
}

