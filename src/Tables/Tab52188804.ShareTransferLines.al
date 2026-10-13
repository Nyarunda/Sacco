table 50486 "Share Transfer Lines"
{
    Caption = 'Share Transfer Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(50001; "No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Source Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Source Account Type" = const("G/L Account")) "G/L Account" where("Account Type" = const(Posting),
                                                                                                 Blocked = const(false))
            else
            if ("Source Account Type" = const(Customer)) Customer
            else
            if ("Source Account Type" = const(Vendor)) Vendor
            else
            if ("Source Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Source Account Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Source Account Type" = const("IC Partner")) "IC Partner"
            else
            if ("Source Account Type" = const(Savings)) "Savings Accounts" where("Member No." = field("Member No."), "Product Category" = filter("Share Capital"))
            else
            if ("Source Account Type" = const(Credit)) "Credit Accounts" where("Member No." = field("Member No."));

            trigger OnValidate()

            begin
                "Source Account Name" := '';
                "Available Balance" := 0;
                Balance := 0;
                "Source Loan No." := '';
                "Line No." := CreateGuid();


                if "Source Account Type" = "source account type"::"G/L Account" then begin
                    if "G/L".Get("Source Account No.") then begin
                        "Source Account Name" := "G/L".Name;
                        //Validate("Source Loan No.");
                    end;
                end;

                if "Source Account Type" = "source account type"::Vendor then begin
                    if Vend.Get("Source Account No.") then begin
                        "Source Account Name" := Vend.Name;
                        Vend.CalcFields(Vend."Balance (LCY)", Vend.Balance);
                        Balance := Vend.Balance;
                        "Available Balance" := Vend."Balance (LCY)";

                    end;
                end;

                if "Source Account Type" = "source account type"::Credit then begin

                    Credit.Reset;
                    if Credit.Get("Source Account No.") then begin
                        "Source Account Name" := Credit."Member Name";
                    end;

                end;

                if "Source Account Type" = "source account type"::Savings then begin
                    Saving.Reset;
                    Saving.setrange("No.", "Source Account No.");
                    if Saving.findfirst then begin
                        Saving.CalcFields(Saving.Balance);
                        "Source Account Name" := Saving.Name;
                        "Product Name" := Saving."Product Name";
                        Balance := Saving.Balance;
                        "Available Balance" := MemberActivities.GetAccountBalance("Source Account No.");
                    end;
                end;

                if "Source Account Type" = "source account type"::Customer then begin
                    Cust.Reset;
                    if Cust.Get("Source Account No.") then begin
                        "Source Account Name" := Cust.Name;
                        Cust.CalcFields(Cust."Balance (LCY)", Cust.Balance);
                        Balance := Cust.Balance;
                        "Available Balance" := Cust."Balance (LCY)";
                    end;
                end;



                if "Source Account Type" = "source account type"::"Bank Account" then begin
                    Bank.Reset;
                    if Bank.Get("Source Account No.") then begin
                        "Source Account Name" := Bank.Name;
                        Bank.CalcFields(Bank."Balance (LCY)", Bank.Balance);
                        Balance := Bank.Balance;
                        "Available Balance" := Bank."Balance (LCY)";
                    end;
                end;
            end;
        }
        field(50003; "Source Account Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Source Transaction Type"; Enum "Transaction Type Enum")
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Source Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Loans where("Member No." = field("Member No."));
            trigger OnValidate()
            var
                Loans: Record Loans;
            begin
                if Loans.get("Source Loan No.") then begin
                    if "Source Account Name" = '' then
                        "Source Account Name" := Loans."Member Name";
                    "Product Name" := Loans."Loan Product Type";
                end
            end;
        }
        field(50006; "Source Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //VALIDATE("Source Account No.");

                if "Source Account Type" = "source account type"::Savings then begin

                    Message('"Source Amount" %1\"Available Balance" %2', "Source Amount", "Available Balance");

                    if "Source Amount" > "Available Balance" then
                        Error('Amount cannot be more than the avaiable balance');
                end;


                if "Source Amount" < 0 then
                    Error('Invalid Amount');
            end;
        }
        field(50007; "Source Account Type"; Enum "Gen. Journal Account Type")
        {
            DataClassification = ToBeClassified;
            ValuesAllowed = Savings;
        }
        field(50008; "External Document No."; Code[20])
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
        field(50011; Balance; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50012; "Available Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50013; "Product Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Members;
        }
        field(50015; "Line No."; Guid)
        {

        }
        field(50016; "Destination Account Type"; Enum "Gen. Journal Account Type")
        {
            DataClassification = ToBeClassified;
            ValuesAllowed = Savings;
        }
        field(50017; "Destination Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50019; "Destination Account No."; Code[20])
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
            if ("Destination Account Type" = const(Savings)) "Savings Accounts" where("Product Category" = filter("Share Capital"))
            else
            if ("Destination Account Type" = const(Credit)) "Credit Accounts" where("Member No." = field("Member No."));

            trigger OnValidate()

            begin
                "Destination Account Name" := '';
                //"Available Balance" := 0;
                Balance := 0;
                //"Destination Loan No." := '';
                "Line No." := CreateGuid();


                if "Destination Account Type" = "Destination account type"::"G/L Account" then begin
                    if "G/L".Get("Destination Account No.") then begin
                        "Destination Account Name" := "G/L".Name;
                        //Validate("Destination Loan No.");
                    end;
                end;

                if "Destination Account Type" = "Destination account type"::Vendor then begin
                    if Vend.Get("Destination Account No.") then begin
                        "Destination Account Name" := Vend.Name;
                        Vend.CalcFields(Vend."Balance (LCY)", Vend.Balance);
                        //Balance := Vend.Balance;
                        "Destination Balance" := Vend."Balance (LCY)";

                    end;
                end;

                if "Destination Account Type" = "Destination account type"::Credit then begin

                    Credit.Reset;
                    if Credit.Get("Destination Account No.") then begin
                        "Destination Account Name" := Credit."Member Name";
                    end;

                end;

                if "Destination Account Type" = "Destination account type"::Savings then begin
                    Saving.Reset;
                    Saving.setrange("No.", "Destination Account No.");
                    if Saving.findfirst then begin
                        Saving.CalcFields(Saving.Balance);
                        "Destination Account Name" := Saving.Name;
                        "Product Name" := Saving."Product Name";
                        //"Destination Balance" := Saving.Balance;
                        "Destination Balance" := MemberActivities.GetAccountBalance("Destination Account No.");
                    end;
                end;

                if "Destination Account Type" = "Destination account type"::Customer then begin
                    Cust.Reset;
                    if Cust.Get("Destination Account No.") then begin
                        "Destination Account Name" := Cust.Name;
                        Cust.CalcFields(Cust."Balance (LCY)", Cust.Balance);
                        "Destination Balance" := Cust.Balance;
                        //"Available Balance" := Cust."Balance (LCY)";
                    end;
                end;



                if "Destination Account Type" = "Destination account type"::"Bank Account" then begin
                    Bank.Reset;
                    if Bank.Get("Destination Account No.") then begin
                        "Destination Account Name" := Bank.Name;
                        Bank.CalcFields(Bank."Balance (LCY)", Bank.Balance);
                        "Destination Balance" := Bank.Balance;
                        //"Available Balance" := Bank."Balance (LCY)";
                    end;
                end;
            end;
        }
        field(50020; "Destination Account Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.", "Source Account No.", "Source Loan No.", "Source Transaction Type", "line no.", "Member No.")
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
        Credit: Record Loans;
        Saving: Record "Savings Accounts";
        TChargeAmount: Decimal;
        SaccoSetup: Record "Sacco Setup";
        transtype: Code[20];
        ChargeAmount: Decimal;
        Account: Record "Savings Accounts";
        AccountTypes: Record "Product Setup";
        MemberActivities: Codeunit "Member Activities";
}

