table 51000 "Bank Reconciliation"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'No.';
        }
        field(2; "Bank Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
            Caption = 'Bank Account No.';
        }
        field(3; "Statement No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Statement No.';
        }
        field(4; "Statement Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Statement Date';
        }
        field(5; "Balance Last Statement"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Balance Last Statement';
        }
        field(6; "Statement Ending Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Statement Ending Balance';
        }
        field(7; Status; Enum "Bank Reconciliation Status")
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            Editable = false;
        }
        field(8; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Created By';
            Editable = false;
        }
        field(9; "Created Date"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Created Date';
            Editable = false;
        }
        field(10; "Last Statement Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Last Statement Balance';
        }
        field(11; "Last Statement Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Last Statement Date';
        }
        field(12; "Calculated Statement Balance"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("Bank Reconciliation Line"."Statement Amount" WHERE("Document No." = FIELD("No.")));
        }
        field(13; "Calculated Ending Balance"; Decimal)
        {
            Editable = false;
            Caption = 'Calculated Ending Balance';
        }
        field(21; "Posted By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Posted By';
            Editable = false;
        }
        field(22; "Posted Date"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Posted Date';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        BankAccount: Record "Bank Account";
    begin
        // Get last statement balance from bank account
        if BankAccount.Get("Bank Account No.") then begin
            "Last Statement Balance" := BankAccount.Balance;
        end;

        "Created By" := UserId;
        "Created Date" := CurrentDateTime;
    end;

    procedure CalculateEndingBalance()
    var
        BankRecLine: Record "Bank Reconciliation Line";
        StatementTotal: Decimal;
    begin
        BankRecLine.Reset();
        BankRecLine.SetRange("Document No.", "No.");
        if BankRecLine.FindSet() then
            repeat
                StatementTotal += BankRecLine."Statement Amount";
            until BankRecLine.Next() = 0;

        "Calculated Ending Balance" := "Last Statement Balance" + StatementTotal;
        Modify();
    end;
}