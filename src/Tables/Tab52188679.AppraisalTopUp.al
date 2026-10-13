table 50342 "Appraisal Top Up"
{
    Caption = 'Appraisal Top Up';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Loan No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = SystemMetadata;
        }
        field(50000; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Account Use","Top Up";
        }
        field(50002; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Loan Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Principle Top Up"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                MainLoan: Record Loans;
            begin
                MainLoan.Get(Rec."Loan Top Up");
                MainLoan.CalcFields("Outstanding Principal");
                if Rec."Principle Top Up" > MainLoan."Outstanding Principal" then
                    Error(
                        'Principal Top Up amount %1 cannot be greater than the outstanding principal balance %2 for loan %3.',
                        Rec."Principle Top Up",
                        MainLoan."Outstanding Principal",
                        MainLoan."Loan No."
                    );

                Commision := SaccoActivities.SmartRound(GetCommission);
                if Loans.Get("Loan No.") then begin
                    "Total Top Up" := "Principle Top Up" + "Interest Top Up" + "Penalty Top Up" + "Appraisal Top Up" + "Uncharged Insurance" + "Uncharged Interest" + Commision + "Commision Excise";
                end;
            end;
        }
        field(50005; "Interest Top Up"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Loans.Get("Loan No.") then begin
                    "Total Top Up" := "Principle Top Up" + "Interest Top Up" + "Penalty Top Up" + "Appraisal Top Up" + "Uncharged Insurance" + "Uncharged Interest" + Commision + "Commision Excise";
                end;
            end;
        }
        field(50006; "Total Top Up"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; Commision; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                SaccoSetup: Record "Sacco Setup";
            begin
                SaccoSetup.Get();
                "Commision Excise" := SaccoActivities.smartround(Commision * SaccoSetup."Excise Duty (%)" * 0.01);
                "Total Top Up" := "Principle Top Up" + "Interest Top Up" + "Penalty Top Up" + "Appraisal Top Up" + "Uncharged Insurance" + "Uncharged Interest" + Commision + "Commision Excise";
            end;
        }
        field(50008; "Loan Top Up"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Loans where("Total Outstanding Balance" = filter(> 0));

            trigger OnValidate()
            var
                LRec: Record Loans;
                TopUpProduct: Record "Top Up Products";
                MainLoan: Record "Member Salary Appraisal";
                Loans: Record Loans;
                LoanSecurity: Record "Loan Security";
                MemberAccounts: Record "Savings Accounts";
                DepAmt: Decimal;
                GuaranteedInApplication: Decimal;
                Committed: Decimal;
                AvailableGuarantorship: Decimal;
                SaccoSetup: Record "Sacco Setup";
            begin

                if LRec.Get("Loan Top Up") then begin

                    MainLoan.get("Loan No.");

                    TopUpProduct.Reset();
                    TopUpProduct.SetRange("Product ID", MainLoan."Loan Product Type");
                    TopUpProduct.SetRange("Top Up Product", LRec."Loan Product Type");
                    if not TopUpProduct.FindFirst() then
                        ERROR('Top Up Product not defined for this loan');


                    ProductSetup.Get(LRec."Loan Product Type");
                    SaccoSetup.Get();

                    LRec.CalcFields("Outstanding Principal", "Outstanding Interest", "Outstanding Insurance", "Last Ins. Due Date", "Outstanding Penalty", "Interest Due Date");

                    if LRec."Outstanding Interest" < 0 then
                        LRec."Outstanding Interest" := 0;
                    if LRec."Outstanding Penalty" < 0 then
                        LRec."Outstanding Penalty" := 0;
                    if LRec."Outstanding Insurance" < 0 then
                        LRec."Outstanding Insurance" := 0;

                    //check if Loan is eligible for top up based on settings on the loan product
                    ValidateStandardLoanCriteria(LRec);

                    "Loan Type" := LRec."Loan Product Type";
                    "Loan Name" := LRec."Loan Product Type Name";
                    "Principle Top Up" := LRec."Outstanding Principal";
                    "Interest Top Up" := LRec."Outstanding Interest";
                    "Penalty Top Up" := LRec."Outstanding Penalty";
                    "Appraisal Top Up" := LRec."Outstanding Insurance";

                    "Uncharged Interest" := 0;// ROUND(LRec."Outstanding Principal" * LRec."Annual Interest %" / 1200);


                    //MESSAGE('"Uncharged Interest" Full Month: %1',"Uncharged Interest");
                    /*
                    LastPayDate :=  SaccoActivities.GetLoanRePaymentDate(LRec,CALCDATE('-1M',TODAY));
                    IF SaccoActivities.GetLoanRePaymentDate(LRec,TODAY) < TODAY THEN
                         LastPayDate := SaccoActivities.GetLoanRePaymentDate(LRec,TODAY);
                    */
                    LastPayDate := LRec."Interest Due Date";
                    if LastPayDate = 0D then
                        LastPayDate := LRec."Disbursement Date";
                    //Message('Last Pay Date: %1', LastPayDate);

                    days := Today - LastPayDate;
                    if days < 0 then
                        days := 0;

                    IF LRec."Interest Due Date" >= CalcDate('-CM', Today) then
                        "Uncharged Interest" := 0
                    else
                        "Uncharged Interest" := SaccoActivities.smartround(SaccoActivities.GetInterestAmount(LRec."Loan No.", Today, Today, false));

                    IF LRec."Last Ins. Due Date" >= CalcDate('-CM', Today) then
                        "Uncharged Insurance" := 0
                    else begin
                        "Uncharged Insurance" := SaccoActivities.smartround(SaccoActivities.CalculateMonthlyInsurance(LRec, ProductSetup, Today));
                    end;

                    if ProductSetup."Skip Int Due On Top Up" then begin
                        "Uncharged Interest" := 0;
                        "Uncharged Insurance" := 0
                    end;


                    Validate("Principle Top Up");

                    //check if loan is within savings for a self guaranteed loan
                    MemberAccounts.Reset();
                    MemberAccounts.SetRange("Member No.", LRec."Member No.");
                    MemberAccounts.SetFilter("Product Category", '%1', MemberAccounts."Product Category"::"Deposit Contribution");
                    if MemberAccounts.FindFirst() then
                        LoanSecurity.CalculateAvailableShares(MemberAccounts, DepAmt, GuaranteedInApplication, Committed, AvailableGuarantorship, true);

                    if MainLoan."Requested Amount" >= AvailableGuarantorship
                    then
                        Commision := GetCommission()
                    else
                        Commision := 0;

                    "Commision Excise" := SaccoActivities.smartround(Commision * SaccoSetup."Excise Duty (%)" * 0.01);
                    "Total Top Up" := "Principle Top Up" + "Interest Top Up" + "Penalty Top Up" + "Appraisal Top Up" + "Uncharged Insurance" + "Uncharged Interest" + Commision + "Commision Excise";
                end;

            end;
        }
        field(50009; "Penalty Top Up"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Top Up" := "Principle Top Up" + "Interest Top Up" + "Penalty Top Up" + "Appraisal Top Up" + "Uncharged Insurance" + "Uncharged Interest" + Commision + "Commision Excise";
            end;
        }
        field(50010; "Appraisal Top Up"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Top Up" := "Principle Top Up" + "Interest Top Up" + "Penalty Top Up" + "Appraisal Top Up" + "Uncharged Insurance" + "Uncharged Interest" + Commision + "Commision Excise";
            end;
        }
        field(50011; "Commission GL"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Uncharged Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Commision Excise"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Loan Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Uncharged Insurance"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "Total Top Up" := "Principle Top Up" + "Interest Top Up" + "Penalty Top Up" + "Appraisal Top Up" + "Uncharged Insurance" + "Uncharged Interest" + Commision + "Commision Excise";
            end;
        }
        field(50016; "Commission % Threshold"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "Loan No.", "Member No.", "Loan Top Up")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Loans: Record "Member Salary Appraisal";
        ProductSetup: Record "Product Setup";
        SaccoActivities: Codeunit "Sacco Activities";
        MemberActivities: Codeunit "Member Activities";
        LastPayDate: Date;
        days: Integer;


    local procedure GetCommission(): Decimal
    var
        Amt: Decimal;
        MainLoan: Record "Member Salary Appraisal";
        TopUpProduct: Record "Top Up Products";
        CommissionRate: Decimal;
        AmountPaid: Decimal;
        Loans: Record Loans;
        SaccoSetup: Record "Sacco Setup";
    begin
        Amt := 0;
        CommissionRate := 0;

        // Safety checks
        if not Loans.Get("Loan Top Up") then exit(0);
        if not MainLoan.Get("Loan No.") then exit(0);

        Loans.CalcFields("Outstanding Principal", "Total Disbursed");

        // Self-guaranteed loans have no commission
        if MainLoan."Self Guarantee" then exit(0);

        // Only charge when clearing own loan of the same product type
        // e.g. Dev→Dev (same member) = charge | Dev→Emergency = no charge | Dev→Dev (different member) = no charge
        //if Loans."Loan Product Type" <> MainLoan."Loan Product Type" then exit(0);
        if Loans."Member No." <> MainLoan."Member No." then exit(0);

        // Find the top up product configuration
        TopUpProduct.Reset();
        TopUpProduct.SetRange("Product ID", MainLoan."Loan Product Type");
        TopUpProduct.SetRange("Top Up Product", Loans."Loan Product Type");
        if not TopUpProduct.FindFirst() then exit(0);

        TopUpProduct.TestField("Commission GL");
        "Commission GL" := TopUpProduct."Commission GL";

        // Determine commission rate
        if TopUpProduct."Use Payment Threshold" then begin
            if Loans."Total Disbursed" > 0 then begin
                AmountPaid := Loans."Total Disbursed" - Loans."Outstanding Principal";
                if AmountPaid >= Loans."Total Disbursed" * (TopUpProduct."Payment Threshold %" / 100) then
                    CommissionRate := TopUpProduct."Commission % Above Threshold"
                else
                    CommissionRate := TopUpProduct."Commission % Below Threshold";
            end;
        end else
            CommissionRate := TopUpProduct."Commission %";

        "Commission % Threshold" := CommissionRate;
        // Calculate commission amount
        Amt := "Principle Top Up" * (CommissionRate / 100);

        // Apply min/max caps
        if (TopUpProduct.Minimum > 0) and (Amt < TopUpProduct.Minimum) then
            Amt := TopUpProduct.Minimum;
        if (TopUpProduct.Maximum > 0) and (Amt > TopUpProduct.Maximum) then
            Amt := TopUpProduct.Maximum;

        exit(SaccoActivities.SmartRound(Amt));
    end;

    local procedure ChargeInterest(LoanRec: Record Loans; Amt: Decimal)
    var
        BUser: Record "User Setup";
        JTemplate: Code[10];
        JBatch: Code[10];
        Loantypes: Record "Product Setup";
        SaccoTrans: Codeunit "Sacco Activities";
        AcctType: Enum "Gen. Journal Account Type";
        BalAcctType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        TChannel: Enum "Transaction Channel";
    begin

        BUser.Get(UserId);
        BUser.TestField("General Journal Template");
        BUser.TestField("General Journal Batch");
        JTemplate := BUser."General Journal Template";
        JBatch := BUser."General Journal Batch";

        if ProductSetup.Get(Loans."Loan Product Type") then begin
            SaccoTrans.JournalInit(JTemplate, JBatch);

            SaccoTrans.JournalInsert(JTemplate, JBatch, LoanRec."Loan No.", Today, Accttype::Customer, LoanRec."Member No.", 'Top Up Interest Due',
                    Accttype::"G/L Account", ProductSetup."Loan Interest Income [G/L]", Amt, "Loan No.", LoanRec."Loan No.", Transtype::"Interest Due",
                    LoanRec."Global Dimension 1 Code", LoanRec."Booking Branch", true, TChannel::" ", BUser."Dimension Set ID");
            SaccoTrans.JournalPost(JTemplate, JBatch);
        end;
    end;

    local procedure ValidateStandardLoanCriteria(var Loan: Record Loans)
    var
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        CreditLedgerEntry: Record "Credit Ledger Entry";
        ConsecutiveMonths: Integer;
        RequiredMonths: Integer;
        TotalPaidForPeriod: Decimal;
        ActualPaymentDate: Date;
        IsTimely: Boolean;
        HasPayment: Boolean;
        SaccoSetup: Record "Sacco Setup";
    begin
        SaccoSetup.Get();
        RequiredMonths := SaccoSetup."Min Topup Months";
        ConsecutiveMonths := 0;

        // Get repayment schedule entries ordered by date
        LoanRepaymentSchedule.Reset();
        LoanRepaymentSchedule.SetRange("Loan No.", Loan."Loan No.");
        LoanRepaymentSchedule.SetFilter("Repayment Date", '<%1', Today);
        LoanRepaymentSchedule.SetCurrentKey("Repayment Date");

        if LoanRepaymentSchedule.FindSet() then begin
            repeat
                // Get payments made for this installment period from Credit Ledger
                TotalPaidForPeriod := 0;
                ActualPaymentDate := 0D;
                HasPayment := false;

                CreditLedgerEntry.Reset();
                CreditLedgerEntry.SetRange("Loan No.", Loan."Loan No.");
                CreditLedgerEntry.SetRange("Transaction Type", CreditLedgerEntry."Transaction Type"::"Principal Repayment");
                // Look for payments around the repayment date (e.g., within the month)
                CreditLedgerEntry.SetRange("Posting Date",
                    CalcDate('<-CM>', LoanRepaymentSchedule."Repayment Date"), // Start of month
                    LoanRepaymentSchedule."Repayment Date"); // Up to due date

                if CreditLedgerEntry.FindSet() then begin
                    repeat
                        TotalPaidForPeriod += Abs(CreditLedgerEntry.Amount);
                        if (ActualPaymentDate = 0D) or (CreditLedgerEntry."Posting Date" < ActualPaymentDate) then
                            ActualPaymentDate := CreditLedgerEntry."Posting Date"; // Get earliest payment date
                        HasPayment := true;
                    until CreditLedgerEntry.Next() = 0;
                end;

                // Check if this installment was paid on time and in full
                IsTimely := HasPayment and
                            (TotalPaidForPeriod >= LoanRepaymentSchedule."Monthly Repayment") and
                            (ActualPaymentDate <= LoanRepaymentSchedule."Repayment Date");

                if IsTimely then begin
                    // Continue the streak
                    ConsecutiveMonths += 1;
                end else begin
                    // Break in consecutive payments - restart count
                    ConsecutiveMonths := 0;
                end;

            until LoanRepaymentSchedule.Next() = 0;
        end;

        // Validate minimum consecutive months requirement
        if ConsecutiveMonths < RequiredMonths then
            Message('Loan does not qualify for refinancing. You need %1 consecutive months of timely repayments. Currently achieved: %2 months.',
                  RequiredMonths, ConsecutiveMonths);
    end;
}


