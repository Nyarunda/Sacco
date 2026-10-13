
Table 50175 "Teller Lines"
{

    fields
    {
        field(1; "Transaction No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Members;
        }
        field(3; "Transaction Type"; Enum "Transaction Type Enum")
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                ErrorOnInvalidTransType: label 'Transaction type -%1- is disabled on this document. Please contact your system administrator.';
            begin
                case "Transaction Type" of
                    "transaction type"::"Loan Disbursement":
                        begin
                            Error(ErrorOnInvalidTransType, "Transaction Type");
                        end;
                end;
            end;
        }
        field(4; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Loans where("Member No." = field("Member No."), Posted = const(true), "Loan Account" = field("Account No."));

            trigger OnValidate()
            var
                GracePeriod: DateFormula;
            begin
                if Loans.Get("Loan No.") then begin
                    Arrears := 0;

                    Loans.CalcFields("Outstanding Interest", "Outstanding Principal", "Outstanding Appraisal", "Outstanding Penalty", "Total Outstanding Balance");
                    "Outstanding Principal" := Loans."Outstanding Principal";
                    "Outstanding Interest" := Loans."Outstanding Interest";
                    "Outstanding Penalty" := Loans."Outstanding Penalty";
                    "Outstanding Appraisal" := Loans."Outstanding Appraisal";
                    "Total Balance" := Loans."Total Outstanding Balance";

                    "Account No." := Loans."Loan Account";

                    if Loans."Disbursement Date" <> 0D then
                        SaccoActivities.GetDefaultedAmount(Loans."Loan No.", CalcDate('-1D', Today), ExpectedAmt, AmtPaid, DefAmount, DaysInArrear, ArrearsDate, true, GracePeriod);
                    if DefAmount < 0 then
                        DefAmount := 0;

                    "Interest Arrears" := SaccoActivities.GetInterestArrears(Loans."Loan No.", CalcDate('-1M+CM', Today));

                    Arrears := DefAmount;
                    "Principal Due" := Loans."Loan Principle Repayment";
                    if "Principal Due" > Loans."Outstanding Principal" then
                        "Principal Due" := Loans."Outstanding Principal";
                    "Outstanding Appraisal" := Loans."Outstanding Appraisal";
                    "Outstanding Penalty" := Loans."Outstanding Penalty";
                    "Appraisal Fee Due" := Loans."Outstanding Appraisal";
                    "Interest Due" := Loans."Outstanding Interest" - "Interest Arrears";
                    Repayment := Loans.Repayment;
                    Description := Loans."Loan Product Type Name";
                    "Interest Calculation Method" := Format(Loans."Interest Calculation Method");
                end;
            end;
        }
        field(5; Amount; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Amount < 0 then
                    Error('Amount cannot be less than zero');

                DiffReg := 0;

                case Type of
                    Type::Credit:
                        begin

                            TestField("Loan No.");
                            if Loans.Get("Loan No.") then begin
                                if Amount > ("Outstanding Principal" + "Outstanding Interest" + "Outstanding Appraisal" + "Outstanding Penalty") then
                                    Error(Text001);

                                if Amount >= "Outstanding Principal" then
                                    "Loan Clearance" := true
                                else
                                    "Loan Clearance" := false;
                            end;
                        end;
                end;


                "Charge Amount" := 0;
                if CashTrans.Get("Transaction No.") then begin
                    if CashTrans."Mobile Transaction" then begin
                        if Transaction = Transaction::" " then begin
                            Error('Transaction Must have a value');
                        end;
                        if Transaction = Transaction::Withdrawal then begin
                            //"Charge Amount":=SaccoTransactions.GetChargeAmount(CashTrans."Transaction Type",Amount,'','',0D,'',0,'','',0,'','','',TRUE);
                        end;
                    end;
                end;
            end;
        }
        field(6; "Transaction Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if (Type = const(Credit)) "Credit Accounts" where("Member No." = field("Member No."))
            else
            if (Type = const(Savings)) "Savings Accounts" where("Member No." = field("Member No."))
            else
            if (Type = const("G/L Account")) "G/L Account"."No." where("Cashier G/L" = const(true));

            trigger OnValidate()
            begin

                if savingsacc.Get("Account No.") then begin
                    "Member No." := savingsacc."Member No.";
                    "Product Type" := savingsacc."Product Type";
                    //Description:=savingsacc.Name;
                    Description := savingsacc."Product Name";

                    savingsacc.CalcFields("Balance (LCY)");
                    "Book Balance" := savingsacc."Balance (LCY)";
                    "Available Balance" := MemberActivities.GetAccountBalance("Account No.");
                end;

                "Loan No." := '';
                Amount := 0;
                "Charge Amount" := 0;
            end;
        }
        field(8; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Savings,Credit,G/L Account';
            OptionMembers = Savings,Credit,"G/L Account";

            trigger OnValidate()
            var
                Teller: Record "Teller Transaction";
            begin
                Teller.Get("Transaction No.");
                "Member No." := Teller."Member No.";
            end;

        }
        field(9; "Product Type"; Code[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Product Setup";
        }
        field(10; "Principal Due"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Outstanding Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12; "Outstanding Principal"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Appraisal Fee Due"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Outstanding Penalty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Activity Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(16; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(17; Transaction; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Deposit,Withdrawal;
        }
        field(18; "Charge Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Book Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(20; "Available Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(21; "Outstanding Appraisal"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Interest Due"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Loan Clearance"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Total Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(25; Arrears; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(26; Repayment; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Interest Calculation Method"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Interest Arrears"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Transaction No.", "Account No.", "Loan No.", "Transaction Type", "Member No.", "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Member No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        creditacc: Record Customer;
        savingsacc: Record "Savings Accounts";
        ProductF: Record "Product Setup";
        DiffReg: Decimal;
        Loans: Record Loans;
        Members: Record Members;
        DiffShare: Decimal;
        CashTrans: Record "Teller Transaction";
        SaccoActivities: Codeunit "Sacco Activities";
        MemberActivities: Codeunit "Member Activities";
        ExpectedAmt: Decimal;
        AmtPaid: Decimal;
        DefAmount: Decimal;
        DaysInArrear: Integer;
        ArrearsDate: Date;
        Text001: label 'This will lead to Loan Clearance with an Excess. ';
}

