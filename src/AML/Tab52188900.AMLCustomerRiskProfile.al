

table 50690 "AML Customer Risk Profile"
{
    Caption = 'AML Customer Risk Profile';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
        }
        field(2; "Risk Level"; Enum "AML Risk Level")
        {
            Caption = 'Risk Level';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                "Risk Level Date" := CurrentDateTime;
                "Risk Level Updated By" := CopyStr(UserId, 1, MaxStrLen("Risk Level Updated By"));
            end;
        }
        field(3; "Risk Score"; Decimal)
        {
            Caption = 'Risk Score';
            DataClassification = CustomerContent;
            MinValue = 0;
            MaxValue = 100;
            DecimalPlaces = 2 : 2;
        }
        field(4; "Risk Level Date"; DateTime)
        {
            Caption = 'Risk Level Date';
            DataClassification = CustomerContent;
        }
        field(5; "Risk Level Updated By"; Code[50])
        {
            Caption = 'Risk Level Updated By';
            DataClassification = CustomerContent;
        }
        field(10; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Savings Accounts".Name where("No." = field("Customer No.")));
            Editable = false;
        }
        field(11; "ID Number"; Text[50])
        {
            Caption = 'ID Number';
            FieldClass = FlowField;
            CalcFormula = lookup("Savings Accounts"."ID No." where("No." = field("Customer No.")));
            Editable = false;
        }
        field(20; "Total Deposits"; Decimal)
        {
            Caption = 'Total Deposits';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(21; "Total Withdrawals"; Decimal)
        {
            Caption = 'Total Withdrawals';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(22; "Total Loan Amount"; Decimal)
        {
            Caption = 'Total Loan Amount';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(23; "Average Monthly Transactions"; Decimal)
        {
            Caption = 'Average Monthly Transactions';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(30; "Is PEP"; Boolean)
        {
            Caption = 'Is Politically Exposed Person';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Is PEP" then
                    if "Risk Level" = "Risk Level"::Low then
                        "Risk Level" := "Risk Level"::Medium;
            end;
        }
        field(31; "PEP Details"; Text[250])
        {
            Caption = 'PEP Details';
            DataClassification = CustomerContent;
        }
        field(32; "High Risk Country"; Boolean)
        {
            Caption = 'High Risk Country';
            DataClassification = CustomerContent;
        }
        field(33; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
            DataClassification = CustomerContent;
        }
        field(40; "Last Review Date"; Date)
        {
            Caption = 'Last Review Date';
            DataClassification = CustomerContent;
        }
        field(41; "Next Review Date"; Date)
        {
            Caption = 'Next Review Date';
            DataClassification = CustomerContent;
        }
        field(42; "Review Frequency Months"; Integer)
        {
            Caption = 'Review Frequency (Months)';
            DataClassification = CustomerContent;
            InitValue = 12;
            MinValue = 1;
            MaxValue = 36;
        }
        field(50; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(51; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(52; "Last Modified Date"; DateTime)
        {
            Caption = 'Last Modified Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(53; "Last Modified By"; Code[50])
        {
            Caption = 'Last Modified By';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Customer No.")
        {
            Clustered = true;
        }
        key(Key2; "Risk Level", "Risk Level Date")
        {
        }
        key(Key3; "Next Review Date")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Customer No.", "Customer Name", "Risk Level", "Risk Score")
        {
        }
    }

    trigger OnInsert()
    begin
        "Created Date" := CurrentDateTime;
        "Created By" := CopyStr(UserId, 1, MaxStrLen("Created By"));
        "Last Modified Date" := "Created Date";
        "Last Modified By" := "Created By";

        if "Risk Level Date" = 0DT then
            "Risk Level Date" := "Created Date";

        CalculateNextReviewDate();
    end;

    trigger OnModify()
    begin
        "Last Modified Date" := CurrentDateTime;
        "Last Modified By" := CopyStr(UserId, 1, MaxStrLen("Last Modified By"));

        CalculateNextReviewDate();
    end;

    local procedure CalculateNextReviewDate()
    begin
        if "Last Review Date" <> 0D then
            "Next Review Date" := CalcDate('<+' + Format("Review Frequency Months") + 'M>', "Last Review Date")
        else
            "Next Review Date" := CalcDate('<+' + Format("Review Frequency Months") + 'M>', Today);
    end;

    procedure UpdateRiskMetrics()
    var
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        CreditLedgerEntry: Record "Credit Ledger Entry";
        TotalDeposits: Decimal;
        TotalWithdrawals: Decimal;
        TotalLoanAmount: Decimal;
        TransactionCount: Integer;
        DateFilter: Date;
    begin
        DateFilter := CalcDate('<-12M>', Today);

        // Calculate savings transactions
        SavingsLedgerEntry.SetRange("Account No.", "Customer No.");
        SavingsLedgerEntry.SetFilter("Posting Date", '>=%1', DateFilter);
        if SavingsLedgerEntry.FindSet() then
            repeat
                if SavingsLedgerEntry."Debit Amount" > 0 then
                    TotalWithdrawals += SavingsLedgerEntry."Debit Amount"
                else if SavingsLedgerEntry."Credit Amount" > 0 then
                    TotalDeposits += SavingsLedgerEntry."Credit Amount";
                TransactionCount += 1;
            until SavingsLedgerEntry.Next() = 0;

        // Calculate loan amounts
        CreditLedgerEntry.SetRange("Account No.", "Customer No.");
        CreditLedgerEntry.SetFilter("Posting Date", '>=%1', DateFilter);
        if CreditLedgerEntry.FindSet() then
            repeat
                if CreditLedgerEntry."Debit Amount" > 0 then
                    TotalLoanAmount += CreditLedgerEntry."Debit Amount";
            until CreditLedgerEntry.Next() = 0;

        "Total Deposits" := TotalDeposits;
        "Total Withdrawals" := TotalWithdrawals;
        "Total Loan Amount" := TotalLoanAmount;
        "Average Monthly Transactions" := TransactionCount / 12;

        CalculateRiskScore();
        Modify();
    end;

    procedure CalculateRiskScore()
    var
        RiskScore: Decimal;
    begin
        RiskScore := 0;

        // Base scoring logic
        if "Total Deposits" > 10000000 then RiskScore += 20; // High volume deposits
        if "Total Withdrawals" > 5000000 then RiskScore += 15; // High volume withdrawals
        if "Total Loan Amount" > 20000000 then RiskScore += 10; // High loan amounts
        if "Average Monthly Transactions" > 100 then RiskScore += 15; // High frequency

        // Additional risk factors
        if "Is PEP" then RiskScore += 25;
        if "High Risk Country" then RiskScore += 20;

        "Risk Score" := RiskScore;

        // Update risk level based on score
        case true of
            RiskScore >= 75:
                "Risk Level" := "Risk Level"::Prohibited;
            RiskScore >= 50:
                "Risk Level" := "Risk Level"::High;
            RiskScore >= 25:
                "Risk Level" := "Risk Level"::Medium;
            else
                "Risk Level" := "Risk Level"::Low;
        end;
    end;
}
