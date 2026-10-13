
Table 50141 "Destination Account Transfers"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = SystemMetadata;
        }
        field(50000; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Currency,Transfers;
        }
        field(50002; "Destination Account Type"; Enum "Gen. Journal Account Type")
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin

                "Destination Loan No." := '';
                "Destination Account No." := '';
                "Product Code" := '';
                "Product Name" := '';

            end;
        }
        field(50003; "Destination Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Destination Account Type" = const("G/L Account")) "G/L Account" where("Account Type" = const(Posting),
                                                                                                      Blocked = const(false))
            else
            if ("Destination Account Type" = const(Customer)) Customer
            else
            if ("Destination Account Type" = const(Vendor)) Vendor
            else
            if ("Destination Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Destination Account Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Destination Account Type" = const("IC Partner")) "IC Partner"
            else
            if ("Destination Account Type" = const(Savings)) "Savings Accounts" where("Member No." = field("Member No."))
            else
            if ("Destination Account Type" = const(Credit)) "Credit Accounts" where("Member No." = field("Member No."));

            trigger OnValidate()
            begin


                "Destination Account Name" := '';
                "Destination Loan No." := '';
                "Line No." := CreateGuid();


                if "Destination Account Type" = "destination account type"::"G/L Account" then begin
                    if "G/L".Get("Destination Account No.") then begin
                        "Destination Account Name" := "G/L".Name;
                        Validate("Destination Loan No.");
                    end;
                end;

                if "Destination Account Type" = "destination account type"::Vendor then begin
                    if Vend.Get("Destination Account No.") then begin
                        "Destination Account Name" := Vend.Name;

                    end;
                end;

                if "Destination Account Type" = "destination account type"::Credit then begin
                    Credit.Reset;
                    if Credit.Get("Destination Account No.") then begin
                        "Destination Account Name" := Credit.Name;
                    end;
                end;

                if "Destination Account Type" = "destination account type"::Savings then begin
                    Saving.Reset;
                    if Saving.Get("Destination Account No.") then begin
                        Saving.CalcFields(Saving.Balance);
                        "Destination Account Name" := Saving.Name;
                        "Product Name" := Saving."Product Name";
                    end;
                end;

                if "Destination Account Type" = "destination account type"::Customer then begin
                    Cust.Reset;
                    if Cust.Get("Destination Account No.") then begin
                        "Destination Account Name" := Cust.Name;
                    end;
                end;

                if "Destination Account Type" = "destination account type"::"Bank Account" then begin
                    Bank.Reset;
                    if Bank.Get("Destination Account No.") then begin
                        "Destination Account Name" := Bank.Name;
                    end;
                end;
            end;
        }
        field(50004; "Destination Loan No."; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Loans where("Member No." = field("Member No."), "Total Outstanding Balance" = filter(> 0));
            trigger OnValidate()
            var
                Loans: Record Loans;
            begin

                if (Loans.get("Destination Loan No.")) and ("Destination Account Type" = "Destination Account Type"::Credit) then begin
                    Loans.Calcfields("Total Arrears", "Outstanding Interest");
                    "Destination Account No." := Loans."Loan Account";
                    //if "Destination Account Name" = '' then
                    "Destination Account Name" := Loans."Member Name";
                    Description := Loans."Loan Product Type Name";
                    "Destination Loan No." := Loans."Loan No.";
                    "Product Name" := Loans."Loan Product Type Name";
                    "Principle Amount" := Loans."Loan Principle Repayment";
                    if "Principle Amount" = 0 then
                        "Principle Amount" := Loans.Repayment;

                    "Arrears Amount" := Loans."Total Arrears";
                    "Interest Amount" := Loans."Outstanding Interest";
                end;
            end;
        }
        field(50005; "Destination Transaction Type"; Enum "Transaction Type Enum")
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Destination Account Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Destination Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                UserSetup: Record "User Setup";
                Transfer: Record "Account Transfers";
            begin
                if "Destination Account Type" = "destination account type"::Credit then begin
                    if "Destination Transaction Type" = "destination transaction type"::" " then
                        Error('Kindly specify transaction type for credit accounts');

                    TestField("Destination Loan No.");
                    Loans.Reset;
                    Loans.SetRange("Loan No.", "Destination Loan No.");
                    if Loans.FindFirst then begin
                        Loans.CalcFields("Outstanding Interest", "Outstanding Penalty", "Outstanding Principal");

                        UserSetup.Reset();
                        UserSetup.SetRange("User ID", UserId);
                        UserSetup.SetRange("Overpay Loan", true);
                        if not UserSetup.FindFirst() then begin

                            if "Destination Transaction Type" = "destination transaction type"::"Interest Paid" then
                                if "Destination Amount" > Loans."Outstanding Interest" then
                                    Error('This will lead to overpayment of Interest. Current Interest Balance is KES %1', Loans."Outstanding Interest");
                            if "Destination Transaction Type" = "destination transaction type"::"Penalty Paid" then
                                if "Destination Amount" > Loans."Outstanding Penalty" then
                                    Error('This will lead to overpayment of Penalty. Current  Balance is KES %1', Loans."Outstanding Penalty");
                            if "Destination Transaction Type" = "destination transaction type"::"Principal Repayment" then
                                if "Destination Amount" > Loans."Outstanding Principal" then
                                    Error('This will lead to overpayment of Principal. Current Principal Balance is KES %1', Loans."Outstanding Principal");

                        end;
                    end;

                end;

                if "Destination Amount" < 0 then
                    Error('Invalid Amount');

                if "Destination Account Type" = "destination account type"::Savings then begin

                    Saving.Reset();
                    Saving.Get("Destination Account No.");
                    Saving.CalcFields("Balance (LCY)");

                    "Excise Duty" := 0;
                    "PloughBack Amount" := 0;
                    if (Saving."Product Category" = Saving."Product Category"::"Deposit Contribution") or (Saving."Product Category" = Saving."Product Category"::"Share Capital") then begin
                        Transfer.Reset();
                        Transfer.SetRange(No, Rec."No.");
                        Transfer.SetRange("Transaction Type", 'P-BACK');
                        if Transfer.FindFirst() then begin
                            MemberActivities.GetGeneralCumulativeChargeAmount(Transfer."Transaction Type", "Destination Amount", "PloughBack Amount", "Excise Duty", ChargeAcctType, ChargeAcct);
                        end;
                    end;
                end;
            end;
        }
        field(50008; "External Document No."; Code[35])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Entry No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(50010; "Product Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50011; "Product Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50012; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Members;
        }

        field(50015; "Line No."; Guid)
        {
        }
        field(50016; Description; Text[50])
        {
        }
        field(50017; "Principle Amount"; Decimal)
        {
            Editable = false;
        }
        field(50018; "Interest Amount"; Decimal)
        {
            Editable = false;
        }
        field(50019; "Arrears Amount"; Decimal)
        {
            Editable = false;
        }
        field(50020; "PloughBack Amount"; Decimal)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "No.", "Destination Account No.", "Destination Loan No.", "Destination Transaction Type", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Cust: Record Customer;
        Vend: Record "Savings Accounts";
        Bank: Record "Bank Account";
        Transfer: Record "Account Transfers";
        "G/L": Record "G/L Account";
        Memb: Record Members;
        Credit: Record "Credit Accounts";
        Saving: Record "Savings Accounts";
        TChargeAmount: Decimal;
        SaccoSetup: Record "Sacco Setup";
        transtype: Code[20];
        ChargeAmount: Decimal;
        Account: Record "Savings Accounts";
        AccountTypes: Record "Product Setup";
        ChargeAcctType: Enum "Gen. Journal Account Type";
        ChargeAcct: Code[20];
        Value: Decimal;
        "Excise Duty": Decimal;
        MemberActivities: Codeunit "Member Activities";
        GenJournalLine: Record "Gen. Journal Line";
        Loans: Record Loans;
}

