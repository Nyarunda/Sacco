
Table 50118 "Loan Top Up"
{

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
            begin

                Commision := GetCommission;
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
        }
        field(50008; "Loan Top Up"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Loans where("Member No." = field("Member No."),
                                         "Total Outstanding Balance" = filter(> 0));

            trigger OnValidate()
            var
                Balance: Decimal;
                SaccoActivities: Codeunit "Sacco Activities";
            begin

                if Loans.Get("Loan Top Up") then begin

                    if ProductSetup.Get(Loans."Loan Product Type") then;

                    Loans.CalcFields("Outstanding Principal", "Outstanding Interest", "Outstanding Appraisal", "Outstanding Penalty", "Interest Due Date");
                    if Loans."Outstanding Interest" < 0 then
                        Loans."Outstanding Interest" := 0;
                    if Loans."Outstanding Penalty" < 0 then
                        Loans."Outstanding Penalty" := 0;
                    if Loans."Outstanding Appraisal" < 0 then
                        Loans."Outstanding Appraisal" := 0;

                    "Loan Type" := Loans."Loan Product Type";
                    "Principle Top Up" := Loans."Outstanding Principal";
                    //IF Loans."Outstanding Interest" = 0 THEN
                    //  "Interest Top Up" := "Principle Top Up" * (Loans."Annual Interest %" / 12 / 100)
                    //ELSE
                    "Interest Top Up" := Loans."Outstanding Interest";
                    "Penalty Top Up" := Loans."Outstanding Penalty";
                    "Appraisal Top Up" := Loans."Outstanding Appraisal";
                    Balance := Loans."Outstanding Principal";


                    IF Loans."Interest Due Date" >= CalcDate('-CM', Today) then
                        "Uncharged Interest" := 0
                    else
                        "Uncharged Interest" := ROUND(SaccoActivities.GetInterestAmount(Loans."Loan No.", Today, Today, false), 0.01, '>');

                    IF Loans."Last Ins. Due Date" >= CalcDate('-CM', Today) then
                        "Uncharged Insurance" := 0
                    else begin
                        "Uncharged Insurance" := SaccoActivities.smartround(SaccoActivities.CalculateMonthlyInsurance(Loans, ProductSetup, Today));
                    end;

                    if ProductSetup."Skip Int Due On Top Up" then begin
                        "Uncharged Interest" := 0;
                        "Uncharged Insurance" := 0
                    end;

                    //"Uncharged Interest" := 0;// ROUND("Uncharged Interest" * days / 30);

                    if Loans."Interest Calculation Method" = Loans."interest calculation method"::"Straight Line" then begin
                        //"Uncharged Interest"  := ROUND(Loans."Approved Amount"*Loans."Annual Interest %"/1200);
                    end;


                    if ProductSetup."Skip Int Due On Top Up" then
                        "Uncharged Interest" := 0;


                    Validate("Principle Top Up");

                    Commision := GetCommission;
                    "Total Top Up" := "Principle Top Up" + "Interest Top Up" + "Penalty Top Up" + "Appraisal Top Up" + "Uncharged Insurance" + "Uncharged Interest" + Commision + "Commision Excise";
                end;

            end;
        }
        field(50009; "Penalty Top Up"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Top Up" := "Principle Top Up" + "Interest Top Up" + "Penalty Top Up" + "Appraisal Top Up" + Commision;
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
        Loans: Record Loans;
        ProductSetup: Record "Product Setup";
        SaccoActivities: Codeunit "Sacco Activities";
        MemberActivities: Codeunit "Member Activities";
        LastPayDate: Date;
        days: Integer;
        TChannel: Enum "Transaction Channel";

    local procedure GetCommission(): Decimal
    var
        PCharges: Record "Loan Product Charges.";
        Amt: Decimal;
        MainProduct: Record "Product Setup";
        MainLoan: Record "Member Salary Appraisal";
        Loantypes: Record "Product Setup";
        TopUpProduct: Record "Top Up Products";
        CommissionRate: Decimal;
        AmountPaid: Decimal;
        ThresholdAmount: Decimal;
        PaymentPercentage: Decimal;
        Loans: Record Loans;
    begin
        Amt := 0;

        Loans.Get("Loan Top Up");
        Loans.CalcFields("Outstanding Principal");
        if ProductSetup.Get(Loans."Loan Product Type") then;
        if MainLoan.Get(Loans."Salary Appraisal No.") then;
        if MainProduct.Get(MainLoan."Loan Product Type") then;

        TopUpProduct.Reset();
        TopUpProduct.SetRange("Product ID", MainLoan."Loan Product Type");
        TopUpProduct.SetRange("Top Up Product", Loans."Loan Product Type");
        if TopUpProduct.FindFirst() then begin
            TopUpProduct.TestField(TopUpProduct."Commission GL");
            "Commission GL" := TopUpProduct."Commission GL";


            if TopUpProduct."Use Payment Threshold" then begin

                AmountPaid := Loans."Approved Amount" - Loans."Outstanding Principal";


                ThresholdAmount := Loans."Approved Amount" * (TopUpProduct."Payment Threshold %" / 100);

                Message('Threshold Amount: %1\Commission %% Above: %2\Commission %% Below: %3',
                        ThresholdAmount,
                        TopUpProduct."Commission % Above Threshold",
                        TopUpProduct."Commission % Below Threshold");


                if Loans."Approved Amount" > 0 then
                    PaymentPercentage := (AmountPaid / Loans."Approved Amount") * 100
                else
                    PaymentPercentage := 0;


                if AmountPaid >= ThresholdAmount then begin
                    // Paid MORE than threshold - use LOWER commission rate
                    CommissionRate := TopUpProduct."Commission % Above Threshold";

                end else begin
                    // Paid LESS than threshold - use HIGHER commission rate
                    CommissionRate := TopUpProduct."Commission % Below Threshold";

                end;
            end else begin
                // Use standard commission rate if threshold is not enabled
                CommissionRate := TopUpProduct."Commission %";
            end;

            // Calculate commission amount
            Amt := ("Principle Top Up" * (CommissionRate / 100));

            // Apply minimum and maximum limits
            if TopUpProduct.Minimum > 0 then
                if Amt < TopUpProduct.Minimum then
                    Amt := TopUpProduct.Minimum;

            if TopUpProduct.Maximum > 0 then
                if Amt > TopUpProduct.Maximum then
                    Amt := TopUpProduct.Maximum;
        end;

        Amt := Round(Amt, 0.5, '=');

        exit(Amt);
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


    trigger OnModify()
    var
        Loans: Record Loans;
    begin
        if Loans.Get(Rec."Loan No.") then begin
            if Loans.Posted then
                Error('Loans Posted');
        end;
    end;
}

