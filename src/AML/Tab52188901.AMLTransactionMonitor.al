

table 50691 "AML Transaction Monitor"
{
    Caption = 'AML Transaction Monitor';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
        }
        field(3; "Transaction Type"; Enum "AML Transaction Type")
        {
            Caption = 'Transaction Type';
            DataClassification = CustomerContent;
        }
        field(4; "Transaction Date"; Date)
        {
            Caption = 'Transaction Date';
            DataClassification = CustomerContent;
        }
        field(5; "Transaction Time"; Time)
        {
            Caption = 'Transaction Time';
            DataClassification = CustomerContent;
        }
        field(6; "Amount"; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
        field(7; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = CustomerContent;
        }
        field(8; "Amount (LCY)"; Decimal)
        {
            Caption = 'Amount (LCY)';
            DataClassification = CustomerContent;
        }
        field(9; "Member No."; Code[20])
        {
            Caption = 'Member No.';
            DataClassification = CustomerContent;
        }
        field(10; "Source Table ID"; Integer)
        {
            Caption = 'Source Table ID';
            DataClassification = CustomerContent;
        }
        field(11; "Source Entry No."; Integer)
        {
            Caption = 'Source Entry No.';
            DataClassification = CustomerContent;
        }
        field(12; "Source Document No."; Code[20])
        {
            Caption = 'Source Document No.';
            DataClassification = CustomerContent;
        }
        field(20; "Risk Score"; Decimal)
        {
            Caption = 'Risk Score';
            DataClassification = CustomerContent;
            MinValue = 0;
            MaxValue = 100;
            DecimalPlaces = 2 : 2;
        }
        field(21; "Alert Generated"; Boolean)
        {
            Caption = 'Alert Generated';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(22; "Alert Type"; Enum "AML Alert Type")
        {
            Caption = 'Alert Type';
            DataClassification = CustomerContent;
        }
        field(23; "Alert Description"; Text[250])
        {
            Caption = 'Alert Description';
            DataClassification = CustomerContent;
        }
        field(30; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Savings Accounts".Name where("No." = field("Customer No.")));
            Editable = false;
        }
        field(31; "Customer Risk Level"; Enum "AML Risk Level")
        {
            Caption = 'Customer Risk Level';
            FieldClass = FlowField;
            CalcFormula = lookup("AML Customer Risk Profile"."Risk Level" where("Customer No." = field("Customer No.")));
            Editable = false;
        }
        field(40; "Daily Transaction Count"; Integer)
        {
            Caption = 'Daily Transaction Count';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(41; "Daily Transaction Amount"; Decimal)
        {
            Caption = 'Daily Transaction Amount';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(42; "Monthly Transaction Count"; Integer)
        {
            Caption = 'Monthly Transaction Count';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(43; "Monthly Transaction Amount"; Decimal)
        {
            Caption = 'Monthly Transaction Amount';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50; "Account Type"; Text[30])
        {
            Caption = 'Account Type';
            DataClassification = CustomerContent;
        }
        field(51; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = CustomerContent;
        }
        field(52; "Counterparty"; Text[100])
        {
            Caption = 'Counterparty';
            DataClassification = CustomerContent;
        }
        field(53; "Transaction Channel"; Text[30])
        {
            Caption = 'Transaction Channel';
            DataClassification = CustomerContent;
        }
        field(60; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(61; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(63; "Loan No."; Code[20])
        {
            Caption = 'Loan No.';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }

        // Primary query path: customer daily/monthly metrics + CalcSums
        key(Key2; "Customer No.", "Transaction Date", "Transaction Type")
        {
            SumIndexFields = "Amount (LCY)", "Amount";
        }

        // Member-based queries + CalcSums
        key(Key3; "Member No.", "Transaction Date", "Transaction Type")
        {
            SumIndexFields = "Amount (LCY)", "Amount";
        }

        // Loan-linked transaction lookups
        key(Key4; "Loan No.", "Transaction Date")
        {
        }

        // Alert processing queue
        key(Key5; "Alert Generated", "Alert Type")
        {
        }

        // Duplicate check in CreateFromSavingsEntry / IsEmpty guard
        key(Key6; "Source Table ID", "Source Entry No.")
        {
        }

        // Risk scoring queries — only keep if you have explicit SetRange on Risk Score
        key(Key7; "Risk Score")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Entry No.", "Customer No.", "Customer Name", "Transaction Type", "Amount", "Transaction Date")
        {
        }
    }
    trigger OnInsert()
    begin
        "Created Date" := CurrentDateTime;
        "Created By" := CopyStr(UserId, 1, MaxStrLen("Created By"));

        if "Transaction Time" = 0T then
            "Transaction Time" := Time;

        CalculateTransactionMetrics();
    end;

    local procedure CalculateTransactionMetrics()
    var
        AMLTransactionMonitor: Record "AML Transaction Monitor";
        MonthStart: Date;
    begin
        MonthStart := CalcDate('<-1M>', "Transaction Date"); // First day of current month

        // --- Daily metrics ---
        AMLTransactionMonitor.SetLoadFields("Amount (LCY)");
        AMLTransactionMonitor.SetRange("Customer No.", "Customer No.");
        AMLTransactionMonitor.SetRange("Transaction Date", "Transaction Date");
        AMLTransactionMonitor.SetRange("Transaction Type", "Transaction Type");
        AMLTransactionMonitor.CalcSums("Amount (LCY)");

        // +1 and + self because current record not yet committed
        "Daily Transaction Count" := AMLTransactionMonitor.Count + 1;
        "Daily Transaction Amount" := AMLTransactionMonitor."Amount (LCY)" + "Amount (LCY)";

        // --- Monthly metrics (calendar month-to-date) ---
        AMLTransactionMonitor.SetRange("Transaction Date", MonthStart, "Transaction Date");
        // Customer No. and Transaction Type filters still applied — explicitly reset for clarity
        AMLTransactionMonitor.SetRange("Customer No.", "Customer No.");
        AMLTransactionMonitor.SetRange("Transaction Type", "Transaction Type");
        AMLTransactionMonitor.CalcSums("Amount (LCY)");

        "Monthly Transaction Count" := AMLTransactionMonitor.Count + 1;
        "Monthly Transaction Amount" := AMLTransactionMonitor."Amount (LCY)" + "Amount (LCY)";
    end;

    local procedure AnalyzeTransaction()
    var
        AMLCodeunit: Codeunit "AML Management";
    begin
        AMLCodeunit.AnalyzeTransaction(Rec);
    end;

    procedure CreateFromSavingsEntry(SavingsEntry: Record "Savings Ledger Entry")
    begin
        Init();
        "Customer No." := SavingsEntry."Account No.";
        "Transaction Date" := SavingsEntry."Posting Date";
        "Source Table ID" := Database::"Savings Ledger Entry";
        "Source Entry No." := SavingsEntry."Entry No.";
        "Source Document No." := SavingsEntry."Document No.";
        "Account No." := SavingsEntry."Account No.";
        "Account Type" := 'Savings';

        if SavingsEntry."Debit Amount" > 0 then begin
            "Transaction Type" := "Transaction Type"::Withdrawal;
            "Amount" := SavingsEntry."Debit Amount";
            "Amount (LCY)" := SavingsEntry."Debit Amount";
        end else begin
            "Transaction Type" := "Transaction Type"::Deposit;
            "Amount" := SavingsEntry."Credit Amount";
            "Amount (LCY)" := SavingsEntry."Credit Amount";
        end;

        "Currency Code" := '';

        Insert();
    end;

    procedure CreateFromCreditEntry(CreditEntry: Record "Credit Ledger Entry")
    begin
        Init();
        "Customer No." := CreditEntry."Account No.";
        "Transaction Date" := CreditEntry."Posting Date";
        "Source Table ID" := Database::"Credit Ledger Entry";
        "Source Entry No." := CreditEntry."Entry No.";
        "Source Document No." := CreditEntry."Document No.";
        "Account No." := CreditEntry."Account No.";
        "Account Type" := 'Credit';

        if CreditEntry."Debit Amount" > 0 then begin
            "Transaction Type" := "Transaction Type"::LoanDisbursement;
            "Amount" := CreditEntry."Debit Amount";
            "Amount (LCY)" := CreditEntry."Debit Amount";
        end else begin
            "Transaction Type" := "Transaction Type"::LoanRepayment;
            "Amount" := CreditEntry."Credit Amount";
            "Amount (LCY)" := CreditEntry."Credit Amount";
        end;

        "Currency Code" := '';

        Insert();
    end;
}
