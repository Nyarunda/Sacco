
Table 50556 "Portal Top Up"
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
                "Total Top Up" := "Principle Top Up" + "Interest Top Up" + "Penalty Top Up" + "Appraisal Top Up" + Commision;

            end;
        }
        field(50005; "Interest Top Up"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Top Up" := "Principle Top Up" + "Interest Top Up" + "Penalty Top Up" + "Appraisal Top Up" + Commision;

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

                    "Uncharged Interest" := 0;// ROUND(Loans."Outstanding Principal" * Loans."Annual Interest %" / 1200);


                    //MESSAGE('"Uncharged Interest" Full Month: %1',"Uncharged Interest");
                    /*
                    LastPayDate :=  SaccoActivities.GetLoanRePaymentDate(Loans,CALCDATE('-1M',TODAY));
                    IF SaccoActivities.GetLoanRePaymentDate(Loans,TODAY) < TODAY THEN
                         LastPayDate := SaccoActivities.GetLoanRePaymentDate(Loans,TODAY);
                    */
                    LastPayDate := Loans."Interest Due Date";
                    if LastPayDate = 0D then
                        LastPayDate := Loans."Disbursement Date";
                    //Message('Last Pay Date: %1', LastPayDate);

                    days := Today - LastPayDate;
                    if days < 0 then
                        days := 0;

                    //Message('days: %1', days);

                    "Uncharged Interest" := 0;// ROUND("Uncharged Interest" * days / 30);

                    if Loans."Interest Calculation Method" = Loans."interest calculation method"::"Straight Line" then begin
                        //"Uncharged Interest"  := ROUND(Loans."Approved Amount"*Loans."Annual Interest %"/1200);
                    end;


                    if ProductSetup."Skip Int Due On Top Up" then
                        "Uncharged Interest" := 0;


                    Validate("Principle Top Up");

                    Commision := GetCommission;
                    "Total Top Up" := "Principle Top Up" + "Interest Top Up" + "Penalty Top Up" + "Appraisal Top Up" + Commision + "Uncharged Interest";
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
                "Total Top Up" := "Principle Top Up" + "Interest Top Up" + "Penalty Top Up" + "Appraisal Top Up" + Commision;
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
        field(50013; "Product Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Product Name"; Text[100])
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
        MainLoan: Record "Portal Loans";
        Loantypes: Record "Product Setup";
    begin



        Amt := 0;

        Loans.Get("Loan Top Up");
        ProductSetup.Get(Loans."Loan Product Type");
        MainLoan.Get("Loan No.");
        MainProduct.Get(MainLoan."Loan Product Type");

        PCharges.Reset;
        PCharges.SetRange(PCharges."Product Code", ProductSetup."Product ID");
        PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::"Top up");
        if (PCharges.Find('-')) and (MainProduct."Exclude Topup Fee" = false) then begin
            repeat
                PCharges.TestField(PCharges."Account No.");
                "Commission GL" := PCharges."Account No.";
                if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount") and (PCharges."Charging Option" = PCharges."charging option"::"On Approved Amount") then begin
                    Amt := (Loans."Approved Amount" * (PCharges.Percentage / 100));
                end else
                    if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount") and (PCharges."Charging Option" = PCharges."charging option"::"On Net Amount") then begin
                        Amt := (("Principle Top Up" /*+ "Interest Top Up" + "Penalty Top Up" + "Appraisal Top Up" + "Uncharged Interest"*/) * (PCharges.Percentage / 100))
                    end else
                        Amt := PCharges."Charge Amount";

                if PCharges.Minimum > 0 then
                    if Amt < PCharges.Minimum then
                        Amt := PCharges.Minimum;

                if PCharges.Maximum > 0 then
                    if Amt > PCharges.Maximum then
                        Amt := PCharges.Maximum;
            //Message('Comm: %1', Amt);
            until PCharges.Next = 0;
        end;

        Amt := ROUND(Amt, 1, '>');

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

    end;


}

