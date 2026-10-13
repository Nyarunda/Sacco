
Table 50127 "Teller Transaction"
{
    DrillDownPageID = "Teller Transactions - Posted";
    LookupPageID = "Teller Transactions - Posted";

    fields
    {
        field(1; "Transaction No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin

                if "Transaction No." <> xRec."Transaction No." then begin
                    NoSetup.Get();
                    NoSeries.TestManual(NoSetup."Teller Transaction Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Account Type" = const(Account)) "Savings Accounts"."No."
            else
            if ("Account Type" = const("Non-Member")) "Bank Account"."No."
            else
            if ("Account Type" = const("G/L Account")) "G/L Account"."No." where("Direct Posting" = const(true))
            else
            if ("Account Type" = const(Customer)) Customer where("Account Type" = filter(Employer | Imprest | Tenant));

            trigger OnValidate()
            Var
                Customer: Record Customer;
                TLines: Record "Teller Lines";
                GracePeriod: DateFormula;
            begin

                Remarks := '';
                Amount := 0;
                "Available Balance" := 0;

                TLines.Reset();
                TLines.SetRange("Transaction No.", "Transaction No.");
                if TLines.FindFirst() then
                    TLines.DeleteAll();


                Account.Reset;
                if Account.Get("Account No.") then begin
                    if Members.Get(Account."Member No.") then;

                    if "Account Type" = "Account Type"::Account then
                        if (Account.Status <> Account.Status::Active) and (Account.Status <> Account.Status::Dormant) and (Account.Status <> Account.Status::New) then
                            Error(Text0001);

                    if "Account Type" = "Account Type"::Account then
                        if Members.Blocked <> Members.Blocked::" " then
                            Error(Text0005);


                    Account.CalcFields(Balance);
                    "Account Name" := Account.Name;
                    "Account Status" := Account.Status;
                    "Mobile Phone No." := Members."Mobile Phone No.";
                    "Product Type" := Account."Product Type";
                    "Currency Code" := Account."Currency Code";
                    "ID No" := Members."ID No.";
                    "Member No." := Members."No.";
                    "Group Account" := Members."Group Account";
                    "Book Balance" := Account.Balance;
                    "Signing Instructions" := Account."Signing Instructions";
                    "Signing Instruction narration" := Account."Signing Instructions Narration";
                    "Product Category" := Account."Product Category";
                    "Employer Code" := Members."Employer Code";


                    "Loan Defaulted" := 0;
                    Loans.Reset;
                    Loans.SetRange("Member No.", "Member No.");
                    //Loans.SetFilter("Loans Category-SACCO", '<>%1&<>%2', Loans."Loans Category-SACCO"::Perfoming, Loans."Loans Category-SACCO"::Watch);
                    if Loans.FindFirst then begin
                        repeat
                            DefAmount := 0;
                            SaccoActivities.GetDefaultedAmount(Loans."Loan No.", Today, ExpectedAmt, AmtPaid, DefAmount, DaysInArrear, ArrearsDate, true, GracePeriod);
                            "Loan Defaulted" += DefAmount;
                        until Loans.Next = 0;
                    end;

                    if "Loan Defaulted" > 0 then
                        Message('Member has defaulted KES %1 on his/her Loan/s', "Loan Defaulted");
                end;


                ProductSetup.Reset;
                ProductSetup.SetRange("Product Category", ProductSetup."product category"::"Registration Fee");
                ProductSetup.SetFilter("Minimum Contribution", '>0');
                if ProductSetup.FindFirst then begin
                    Savings.Reset;
                    Savings.SetRange("Member No.", "Member No.");
                    Savings.SetRange("Product Type", ProductSetup."Product ID");
                    if Savings.FindFirst then begin
                        Savings.CalcFields("Balance (LCY)");
                        if Savings."Balance (LCY)" < ProductSetup."Minimum Contribution" then
                            Message('Member has contributed entrance Fee of KES %1 instead of %2', Savings."Balance (LCY)", ProductSetup."Minimum Contribution");
                    end
                    else
                        Message('Member does not have an Entrance Fee Account. Kindly inform the System Administrator');
                end;


                ProductSetup.Reset;
                ProductSetup.SetRange("Product Category", ProductSetup."product category"::"Share Capital");
                ProductSetup.SetFilter("Minimum Contribution", '>0');
                if ProductSetup.FindFirst then begin
                    Savings.Reset;
                    Savings.SetRange("Member No.", "Member No.");
                    Savings.SetRange("Product Type", ProductSetup."Product ID");
                    if Savings.FindFirst then begin
                        Savings.CalcFields("Balance (LCY)");
                        if Savings."Balance (LCY)" < ProductSetup."Minimum Contribution" then
                            Message('Member has contributed Share Capital of KES %1 instead of %2', Savings."Balance (LCY)", ProductSetup."Minimum Contribution");
                    end
                    else
                        Message('Member does not have an Share Capital Account. Kindly inform the System Administrator');
                end;


                CalcAvailableBal;
                if "Account Type" = "account type"::"G/L Account" then begin
                    "Account Name" := '';
                    if GL.Get("Account No.") then
                        "Account Name" := GL.Name;
                end;

                if "Account Type" = "Account Type"::Customer then begin
                    Customer.Get("Account No.");
                    "Account Name" := Customer.Name;
                end;

                UserSetup.Get(Cashier);
                UserSetup.TestField("Member No.");
                if "Member No." = UserSetup."Member No." then begin
                    Message('You cannot do a transaction on your account. Kindly seek approvals!');
                    "Attempted Self Transaction" := true;
                end;
            end;
        }
        field(3; "Account Name"; Text[55])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Transaction Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Account Type" = const(Account),
                                "Mobile Transaction" = const(false)) "Transaction Charges".Code where("Product Type" = field("Product Type"),
                                                                                                     Category = const(Cashier),
                                                                                                     "Default Mode" = field("Transaction Mode"))
            else
            if ("Account Type" = const("Non-Member")) "Transaction Charges".Code where(Type = filter("Bankers Cheque"),
                                                                                                                        "Product Type" = filter(''),
                                                                                                                        "Default Mode" = field("Transaction Mode"))
            else
            if ("Account Type" = const("G/L Account")) "Transaction Charges".Code where(Type = filter("Income Transactions" | "Cheque Deposit" | "Bankers Cheque GL"), "Product Type" = filter(''),
                                                                                                                                                            "Default Mode" = field("Transaction Mode"))
            else
            if ("Account Type" = const(Account), "Mobile Transaction" = const(true)) "Transaction Charges".Code where(Type = const("Mobile Transaction"))
            else
            if ("Account Type" = const(Customer)) "Transaction Charges".Code where(Type = filter("Cheque Deposit" | "Cash Deposit Customer"), "Default Mode" = field("Transaction Mode"));

            trigger OnValidate()
            var
                DefaultDF: DateFormula;
                TTRans: Record "Teller Transaction";
                LastTransDate: Date;
            begin

                if TransactionTypes.Get("Transaction Type") then begin
                    "Transaction Description" := TransactionTypes.Description;
                    Type := TransactionTypes.Type;

                end;

                if (Type = Type::"Cash Withdrawal") or (Type = Type::"Cheque Withdrawal") then begin
                    if Savings.get("Account No.") then begin
                        ProductSetup.get(Savings."Product Type");
                        if ProductSetup."Withdrawal Frequency" <> DefaultDF then begin
                            LastTransDate := Savings."Registration Date";
                            TTRans.Reset();
                            TTRans.SetRange("Account No.", "Account No.");
                            TTRans.SetFilter(Type, '%1|%2', TTRans.Type::"Cash Withdrawal", TTRans.Type::"Cheque Withdrawal");
                            TTRans.SetRange(Posted, true);
                            if TTRans.FindLast() then begin
                                if calcdate(ProductSetup."Withdrawal Frequency", TTRans."Date Posted") > today then
                                    Error('Withdrawal Frequency Control for this account has not yet been met. Last transaction date was %1', TTRans."Date Posted");
                            end;
                        end;
                    end;

                    Message(Format(Savings."Signing Instructions"));
                    if Savings."Signing Instructions Narration" <> '' then
                        Message(Savings."Signing Instructions Narration");


                end;
                if (Type = Type::"Credit Cheque") or (Type = Type::"Cheque Deposit") then begin

                    "Cheque Category" := "cheque category"::"Customer Cheque";

                    Members.Reset;
                    Members.SetRange("No.", "Member No.");
                    Members.SetFilter("Cheques Bounced", '>0');
                    if Members.FindFirst then begin
                        Members.CalcFields("Cheques Bounced");
                        Message('Please NOTE that this Member Deposited %1 Cheques that bounced ', Members."Cheques Bounced");
                    end;

                    BUserSetup.Reset;
                    BUserSetup.SetRange(BUserSetup."User Name", UserId);
                    if BUserSetup.Find('-') then begin
                        BUserSetup.TestField("Default  Cheque Bank");
                        "Bank Account" := BUserSetup."Default  Cheque Bank";
                    end;
                end;

                ConfirmTreasuryToTeller;
                CalcAvailableBal;
            end;
        }
        field(5; Amount; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                InformationBase: Record "Information Base.";
            begin
                if Amount < 0 then
                    Error('Amount cannot be less than zero');

                CalcAvailableBal;

                //ProductSet.GET();


                Account.Reset;
                Account.SetRange("No.", "Account No.");
                if Account.Find('-') and (Account."Product Category" = Account."product category"::Business) or (Account."Product Category" = Account."product category"::"Ordinary Savings") then begin
                    ProductSet.Reset;
                    ProductSet.SetRange(ProductSet."Product ID", Account."Product Type");
                    if ProductSet.Find('-') then begin
                        if "Transaction Type" = 'CW_O' then
                            if Amount > ProductSet."Max Teller Wiithdrawable" then
                                Error(Text0004, ProductSet."Max Teller Wiithdrawable");
                    end;
                end;
                InformationBase.Reset;
                InformationBase.SetRange("Member No.", "Member No.");
                InformationBase.SetFilter(Info, '<>%1', '');
                if InformationBase.FindFirst then
                    Message('Kindly Check the Info Base');

                if Mpesa then
                    Validate("Agent Transaction");
            end;
        }
        field(6; Cashier; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Transaction Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Transaction Time"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(11; "Product Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Product Setup"."Product ID" where("Product Class" = const(Savings));
        }
        field(12; "Cheque Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Cheque Types";

            trigger OnValidate()
            begin
                TestField(Amount);
                if ChequeTypes.Get("Cheque Type") then begin
                    //Added by ckigen
                    if (ChequeTypes."Cheque Limit" <> 0) and (Amount > ChequeTypes."Cheque Limit") then
                        Error(Text0003, ChequeTypes."Cheque Limit");
                    //Remarks:=ChequeTypes.Description;
                    CDays := ChequeTypes."Clearing  Days";

                    EMaturity := "Transaction Date";
                    if i < CDays then begin
                        repeat
                            EMaturity := CalcDate('1D', EMaturity);
                            if (Date2dwy(EMaturity, 1) <> 6) and (Date2dwy(EMaturity, 1) <> 7) then
                                i := i + 1;

                        until i = CDays;
                    end;

                    "Expected Maturity Date" := EMaturity;

                    "Cheque Status" := "cheque status"::Pending;
                end;
            end;
        }
        field(13; "Cheque No"; Code[6])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin


                Trans.Reset;
                //Trans.SetRange("Account No.", "Account No.");
                Trans.SetRange("Bank Account", "Issueing Bank Account");
                Trans.SetRange("Cheque No", "Cheque No");
                //Trans.SetRange("Cheque Category", Trans."cheque category"::"Customer Cheque");
                if Trans.Find('-') then begin
                    Message('The cheque No. %1 has already been posted to %2 on %3', Trans."Cheque No", Trans."Account No.", Trans."Transaction Date");
                end;

                if StrLen("Cheque No") <> 6 then
                    Error('Cheque No must be equal to 6 digits');

                if "Cheque No" = '000000' then
                    Error('Invalid Cheque No.');
            end;
        }
        field(14; "Cheque Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Cheque Date" > Today then
                    Error('Post dating not allowed');


                SaccoSetup.Get;

                SaccoSetup.Get;
                SaccoSetup.TestField("Cheque Reject Period");
                if "Cheque Date" < CalcDate('-' + Format(SaccoSetup."Cheque Reject Period"), Today) then
                    if not Confirm(Text0002 + 'Do you want to continue?') then
                        Error('Cancelled');
            end;
        }
        field(15; Payee; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(16; Remarks; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(17; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Cash Deposit","Cash Withdrawal","Credit Receipt","Credit Cheque","Bankers Cheque","Cheque Deposit","Cheque Withdrawal","Salary Processing",EFT,RTGS,Overdraft,"Standing Order","Dividend Processing",CalMobile,"CalMobile Deposit","CalMobile Ministatement","CalMobile Transfer","CalMobile Withdrawal","CalMobile Registration","CalMobile Charge",Transfers,"ATM Applications","Member Withdrawal","ATM Replacement",Statement,"Bounced Cheque",Lien,"Cheque Application","Bank Transfer Mode","Sacco_Co-op Charge","Savings Penalty","Delegates Payment","CalMobile Sms","Income Transactions","Cheque Unpay","Inhouse Cheque Transfer","Mobile Transaction","CalMobile Utility Payment","Sky Mobile","Loan Changes","Bankers Cheque GL","Account Closure","Account Activation","Share Exit","Share Trading","Cash Deposit Customer";
        }
        field(18; "Transaction Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(19; Status; Option)
        {
            Editable = false;
            Caption = 'Transaction Status';
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(20; "Date Posted"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Time Posted"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Posted By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Expected Maturity Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Currency Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency;
        }
        field(25; "Post Dated"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Book Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(27; Overdraft; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Protected Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Members."No.";

            trigger OnValidate()
            begin
                "Account No." := '';
            end;
        }
        field(30; "Banked By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Date Banked"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Time Banked"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Cleared By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Date Cleared"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Time Cleared"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "ID No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Bank Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account" where("Cheque Clearing Acc." = const(true));

            trigger OnValidate()
            begin
                Validate("Cheque No");
                if BankAccount.Get("Bank Account") then
                    "Cheque Issueing Bank" := BankAccount.Name;
            end;
        }
        field(38; Printed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(40; "Available Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Attempted Self Transaction"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Change Log"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Cheque Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Pending,Stopped,Bounced,Honoured,Matured,Reversed';
            OptionMembers = Pending,Stopped,Bounced,Honoured,Matured,Reversed;
        }
        field(45; "Bankers Cheque No"; Code[6])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bankers Cheque Register"."Cheque No." where(Status = filter(Pending),
                                                                          "Global Dimension 2 Code" = field("Global Dimension 2 Code"),
                                                                          "Bankers Cheque Type" = field("Bankers Cheque Type"));
        }
        field(46; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(47; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(48; "Allocated Amount"; Decimal)
        {
            CalcFormula = sum("Teller Lines".Amount where("Transaction No." = field("Transaction No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; "FingerPrint Verified"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50002; SystemGeneratedGuid; Guid)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; Select; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                "Selected By" := '';
                if Select then
                    "Selected By" := UserId;
            end;
        }
        field(50004; "Discounting Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                "Cheque Discounting" := false;

                if "Discounting Amount" > 0 then begin
                    if "Cheque Status" <> "cheque status"::Pending then
                        Error('You can only discount a pending cheque');

                    if "Discounting Amount" < 0 then
                        Error('Amount must be greater than zero');


                    ProductSetup.Reset;
                    ProductSetup.SetRange("Nature of Loan Type", ProductSetup."nature of loan type"::"Cheque Discounting");
                    ProductSetup.SetRange("Product Class", ProductSetup."product class"::Credit);
                    if ProductSetup.Find('-') then begin
                        ProductSetup.TestField(ProductSetup."Interest Rate (Min.)");
                        ProductSetup.TestField(ProductSetup."Maximum Loan Amount");

                        if "Discounting Amount" > ProductSetup."Maximum Loan Amount" then
                            Error('The amount cannot be more than %1', ProductSetup."Maximum Loan Amount");
                    end
                    else
                        Error('Discounting loan product not found.');


                    "Cheque Discounting" := true;
                end;
            end;
        }
        field(50005; "Discounted Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Signing Instruction Narration"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Till Name"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50009; "Product Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Share Capital,Deposit Contribution,Fixed Deposit,Junior Savings,Registration Fee';
            OptionMembers = " ","Share Capital","Deposit Contribution","Fixed Deposit","Junior Savings","Registration Fee";
        }
        field(50010; "Till Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(50011; "New Account Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Employer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50013; Dublicate; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Cheque Issueing Bank"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Drawer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Account,Non-Member,G/L Account,Customer';
            OptionMembers = Account,"Non-Member","G/L Account",Customer;

            trigger OnValidate()
            begin
                ClearAll;
                if "Account Type" = "account type"::"Non-Member" then begin
                    BUserSetup.Reset;
                    BUserSetup.SetRange(BUserSetup."User Name", UserId);
                    if BUserSetup.Find('-') then begin
                        "Till Code" := BUserSetup."Default  Bank";
                        bankacc.Reset;
                        bankacc.SetRange("No.", BUserSetup."Default  Bank");
                        if bankacc.Find('-') then begin
                            "Account No." := bankacc."No.";
                            "Till Name" := PadStr(BUserSetup."Default  Bank" + ' ' + bankacc.Name, 50)
                        end;
                    end;
                end;

                if "Account Type" = "account type"::"Non-Member" then
                    "Account Name" := Format("Account Type");
            end;
        }
        field(50018; "Lien Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Loans;
        }
        field(50019; "Special Cheque Charge"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Cheque Location"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Teller,Chief Cashier 1,Accountant,Awaiting Clearance,Cleared,Chief Cashier 2';
            OptionMembers = Teller,"Chief Cashier 1",Accountant,"Awaiting Clearance",Cleared,"Chief Cashier 2";
        }
        field(50021; "Chief Cashier Select"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Bankers Cheque Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Co-op Bankers Cheque,Customer Service Cheques';
            OptionMembers = "Co-op Bankers Cheque","Customer Service Cheques";
        }
        field(50023; "Transaction Mode"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Cash,Cheque';
            OptionMembers = Cash,Cheque;

            trigger OnValidate()
            begin

                "Cheque Category" := "cheque category"::" ";

                if "Transaction Mode" = "transaction mode"::Cheque then begin
                    BUserSetup.Reset;
                    BUserSetup.SetRange(BUserSetup."User Name", UserId);
                    if BUserSetup.Find('-') then begin
                        if BUserSetup.Type = BUserSetup.Type::Cashier then
                            "Cheque Category" := "cheque category"::"Customer Cheque"
                        else
                            if BUserSetup.Type = BUserSetup.Type::Treasury then
                                "Cheque Category" := "cheque category"::"MBS Sacco Cheque";
                    end;
                end;
            end;
        }
        field(50024; "Account Status"; Enum "Account Status Enum")
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "Mobile Phone No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50026; "Bouncing Charge"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Transaction Charges" where(Type = const("Bounced Cheque"));
        }
        field(50027; Mpesa; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50028; "Mpesa/Agent Transaction"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Deposit,Withdrawal';
            OptionMembers = " ",Deposit,Withdrawal;

            trigger OnValidate()
            begin
                Amount := 0;
                Validate("Agent Transaction");
            end;
        }
        field(50029; "Source Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Savings Accounts";
        }
        field(50030; "Cheques Issued"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'No,Yes';
            OptionMembers = No,Yes;
        }
        field(50031; "Cheques Received"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'No,Yes';
            OptionMembers = No,Yes;
        }
        field(50032; "Issueing Bank Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account" where("Cheque Clearing Acc." = const(true));

            trigger OnValidate()
            begin
                Validate("Cheque No");
                if BankAccount.Get("Issueing Bank Account") then
                    "Cheque Issueing Bank" := BankAccount.Name;
            end;
        }
        field(50033; "Loan Defaulted"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50034; "Mobile Transaction"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50035; "Total Deposits"; Decimal)
        {
            CalcFormula = sum("Teller Lines".Amount where("Transaction No." = field("Transaction No."),
                                                           Transaction = const(Deposit)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50036; "Total Withdrawals"; Decimal)
        {
            CalcFormula = sum("Teller Lines".Amount where("Transaction No." = field("Transaction No."),
                                                           Transaction = const(Withdrawal)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50037; "Deposits Count"; Integer)
        {
            CalcFormula = count("Teller Lines" where("Transaction No." = field("Transaction No."),
                                                      Transaction = const(Deposit)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50038; "Withdrawals Count"; Integer)
        {
            CalcFormula = count("Teller Lines" where("Transaction No." = field("Transaction No."),
                                                      Transaction = const(Withdrawal)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50039; "Total Charge Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50040; "Date Reversed"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50041; "Reversed By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50042; "Cheque Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Customer Cheque,Yetu Sacco Cheque';
            OptionMembers = " ","Customer Cheque","MBS Sacco Cheque";

            trigger OnValidate()
            begin

                if "Transaction Mode" = "transaction mode"::Cheque then begin
                    BUserSetup.Reset;
                    BUserSetup.SetRange(BUserSetup."User Name", UserId);
                    if BUserSetup.Find('-') then begin
                        if BUserSetup.Type = BUserSetup.Type::Cashier then
                            if "Cheque Category" <> "cheque category"::"Customer Cheque" then
                                if not Confirm('Applicable to Cashiers only. Do you want to continue?') then
                                    Error('Aborted');

                        if BUserSetup.Type = BUserSetup.Type::Treasury then
                            if "Cheque Category" <> "cheque category"::"MBS Sacco Cheque" then
                                if not Confirm('Applicable to Treasury only. Do you want to continue?') then
                                    Error('Aborted');

                    end;
                end;
            end;
        }
        field(50043; "Selected By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50044; "Group Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50045; "Cheque Discounting"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50046; "Cheque Clearing Bank"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(50047; "Cheque Clearing Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50048; "Agent Transaction"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,MPESA,Equity,Super Agent';
            OptionMembers = " ",MPESA,Equity,"Super Agent";

            trigger OnValidate()
            begin

                "Till Code" := '';
                "Account No." := '';
                "Account Name" := '';
                "Till Name" := '';
                "M_Money Till Balance" := 0;
                "Float Balance" := 0;

                if Mpesa then begin
                    BUserSetup.Get(UserId);
                    if "Agent Transaction" = "agent transaction"::MPESA then begin
                        BUserSetup.TestField("MPesa Bank Account");
                        BUserSetup.TestField("MPesa Customer Account");
                        "Till Code" := BUserSetup."MPesa Bank Account";
                        "Account No." := BUserSetup."MPesa Customer Account";
                        Cust.Get("Account No.");
                        Cust.CalcFields("Balance (LCY)");
                        "Float Balance" := Cust."Balance (LCY)";
                        "Account Name" := Cust.Name;
                        bankacc.Get(BUserSetup."MPesa Bank Account");
                        bankacc.CalcFields("Balance (LCY)");
                        "M_Money Till Balance" := bankacc."Balance (LCY)";
                        "Till Name" := bankacc.Name;
                    end;
                    if "Agent Transaction" = "agent transaction"::Equity then begin
                        BUserSetup.TestField("Equity Bank Account");
                        BUserSetup.TestField("Equity Customer Account");
                        "Till Code" := BUserSetup."Equity Bank Account";
                        "Account No." := BUserSetup."Equity Customer Account";
                        Cust.Get("Account No.");
                        Cust.CalcFields("Balance (LCY)");
                        "Float Balance" := Cust."Balance (LCY)";
                        "Account Name" := Cust.Name;
                        bankacc.Get(BUserSetup."Equity Bank Account");
                        bankacc.CalcFields("Balance (LCY)");
                        "M_Money Till Balance" := bankacc."Balance (LCY)";
                        "Till Name" := bankacc.Name;
                    end;


                    if "Agent Transaction" = "agent transaction"::"Super Agent" then begin
                        BUserSetup.TestField("MPesa Bank Account");
                        BUserSetup.TestField("Super Agent Customer Account");
                        "Till Code" := BUserSetup."MPesa Bank Account";
                        "Account No." := BUserSetup."Super Agent Customer Account";
                        Cust.Get("Account No.");
                        Cust.CalcFields("Balance (LCY)");
                        "Float Balance" := Cust."Balance (LCY)";
                        "Account Name" := Cust.Name;
                        bankacc.Get(BUserSetup."MPesa Bank Account");
                        bankacc.CalcFields("Balance (LCY)");
                        "M_Money Till Balance" := bankacc."Balance (LCY)";
                        "Till Name" := bankacc.Name;
                    end;

                end;
            end;
        }
        field(50049; Charges; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50050; "Excise Duty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50051; "TIll Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50052; "Cheque ByPassed By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50053; "Float Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50054; "M_Money Till Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50087; "Signing Instructions"; Option)
        {
            OptionMembers = Single,"All must Sign","Either Must Sign";
        }
        field(50088; "Employer Type"; Enum "Employer Type")
        {
        }
        field(50089; "Close Account"; Boolean)
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                CalcAvailableBal();
            end;
        }
        field(50090; "Other Charges"; decimal)
        {
        }
        field(51200; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = true;
            TableRelation = "Dimension Set Entry";
            trigger OnLookup()
            var
                OldDimSetID: Integer;
                IsHandled: Boolean;
                DimMgt: Codeunit DimensionManagement;
            begin

                OldDimSetID := "Dimension Set ID";
                "Dimension Set ID" :=
                  DimMgt.EditDimensionSet(
                    Rec, "Dimension Set ID", "Transaction No.", "Global Dimension 1 Code", "Global Dimension 2 Code");

                //IsChanged := OldDimSetID <> "Dimension Set ID";
            end;

            trigger OnValidate()
            var
                DimMgt: Codeunit DimensionManagement;
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Global Dimension 1 Code", "Global Dimension 2 Code");
            end;
        }
        field(51202; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";

            trigger OnValidate()
            begin


                TestField(Status, Status::Open);
            end;
        }
        field(51203; "Send SMS"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Transaction No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if "Transaction No." = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."Teller Transaction Nos.");
            "Transaction No." := NoSeries.GetNextNo(NoSetup."Teller Transaction Nos.", WorkDate(), true);
        end;

        Cashier := UserId;
        "Transaction Date" := Today;
        "Transaction Time" := Time;


        OPenrecords := '';
        i := 0;
        Trans.Reset;
        Trans.SetRange(Cashier, UserId);
        Trans.SetFilter(Posted, '%1', false);
        Trans.SetRange(Mpesa, false);
        if Trans.Find('-') then begin
            i := Trans.Count;
            OPenrecords := Trans."Transaction No.";
        end;

        BUserSetup.Reset;
        BUserSetup.SetRange(BUserSetup."User Name", UserId);
        if BUserSetup.Find('-') then begin
            "Till Code" := BUserSetup."Default  Bank";
            if Type <> Type::Lien then
                BUserSetup.TestField(Type, BUserSetup.Type::Cashier);

            bankacc.Reset;
            bankacc.SetRange("No.", BUserSetup."Default  Bank");
            if bankacc.Find('-') then begin
                bankacc.CalcFields("Balance (LCY)");
                "Till Name" := CopyStr(BUserSetup."Default  Bank" + ' ' + bankacc.Name, 1, 50);
                "TIll Balance" := bankacc."Balance (LCY)";
            end;
        end;


        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User ID", UserId);
        if UserSetup.Find('-') then begin
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";


            if UserSetup."Max. Open Documents" > 0 then
                if i > UserSetup."Max. Open Documents" then
                    Error('You are not allowed to open multiple documents. Complete %1 first.', OPenrecords);
        end;



        //ConfirmTreasuryToTeller;
    end;

    var
        NoSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";
        Account: Record "Savings Accounts";
        TransactionTypes: Record "Transaction Charges";
        ChequeTypes: Record "Cheque Types";
        CDays: Integer;
        EMaturity: Date;
        i: Integer;
        UserSetup: Record "User Setup";
        TCharges: Decimal;
        ChargeAmount: Decimal;
        Trans: Record "Teller Transaction";
        TChargeAmount: Decimal;
        GenSetup: Record "Sacco Setup";
        ProductSetup: Record "Product Setup";
        TransType: Record "Transaction Charges";
        BUserSetup: Record "Banking User Setup";
        bankacc: Record "Bank Account";
        BankAccount: Record "Bank Account";
        OPenrecords: Code[20];
        GL: Record "G/L Account";
        Cust: Record Customer;
        Savings: Record "Savings Accounts";
        Members: Record Members;
        Loans: Record Loans;
        Text0001: label 'The account is not active and therefore cannot be transacted upon.';
        Text0005: label 'The account is blocked and therefore cannot be transacted upon.';
        Text0002: label 'The cheque has expired';
        Text0003: label 'The cheque limit should not exceed the cheque amount limit of %1';
        SaccoActivities: Codeunit "Sacco Activities";
        MemberActivities: Codeunit "Member Activities";
        ExpectedAmt: Decimal;
        AmtPaid: Decimal;
        DefAmount: Decimal;
        DaysInArrear: Integer;
        ArrearsDate: Date;
        ChargeAcctType: Enum "Gen. Journal Account Type";
        ChargeAcct: Code[20];
        SharingAmt: Decimal;
        SharingDuty: Decimal;
        SharingChargeAcctType: Enum "Gen. Journal Account Type";
        SharingChargeAcct: Code[20];
        Value: Decimal;
        SaccoSetup: Record "Sacco Setup";
        ProductSet: Record "Product Setup";
        Text0004: label 'You Cannot Withdrawal More Than Maximum Allowable Amount of  %1 ';

    local procedure CalcAvailableBal()
    var
        ProductSetup: Record "Product Setup";
        Emp: Record Customer;
        SaccoCategory: Record "SACCO Categorization";
        TArrears: Decimal;
        OtherExciseDuty: Decimal;
        SavingsAcc: Record "Savings Accounts";
        SActivities: Codeunit "Sacco Activities";
        SLedger: Record "Savings Ledger Entry";
    begin


        BUserSetup.Reset;
        BUserSetup.SetRange(BUserSetup."User Name", UserId);
        if BUserSetup.Find('-') then begin
            "Till Code" := BUserSetup."Default  Bank";
            BUserSetup.TestField(Type, BUserSetup.Type::Cashier);

            bankacc.Reset;
            bankacc.SetRange("No.", BUserSetup."Default  Bank");
            if bankacc.Find('-') then begin
                bankacc.CalcFields("Balance (LCY)");
                "Till Name" := CopyStr(BUserSetup."Default  Bank" + ' ' + bankacc.Name, 1, 50);
                "TIll Balance" := bankacc."Balance (LCY)";
            end;
        end;



        "Available Balance" := 0;
        Charges := 0;
        "Excise Duty" := 0;
        "Other Charges" := 0;
        OtherExciseDuty := 0;
        "Total Charge Amount" := 0;


        ProductSetup.Reset;
        ProductSetup.SetRange("Product ID", "Product Type");
        if ProductSetup.Find('-') then begin
            //MESSAGE('T');
            "Available Balance" := MemberActivities.GetAccountBalance("Account No.");
            if "Close Account" then
                "Available Balance" := MemberActivities.GetAccountBalanceWithoutMinAccBalance("Account No.");

            if Savings.Get("Account No.") then;
            //"Available Balance" -= SActivities.GetTotalArrears("Member No.");

            if Amount = 0 then
                Value := ("Available Balance")
            else
                Value := (Amount);


            Members.Get("Member No.");


            if Type = Type::"Cash Withdrawal" then begin
                if not Savings."Exempt Charges" then
                    MemberActivities.GetGeneralCumulativeChargeAmount("Transaction Type", Value, Charges, "Excise Duty", ChargeAcctType, ChargeAcct);

            end
            else begin

                if not Savings."Exempt Charges" then
                    MemberActivities.GetGeneral_SharingChargeAmountBankers("Transaction Type", Value, Charges, "Excise Duty", ChargeAcctType, ChargeAcct, SharingAmt, SharingDuty, SharingChargeAcctType, SharingChargeAcct);

            end;

            if "Close Account" then begin
                MemberActivities.GetGeneralCumulativeChargeAmount('CLOSURE', Value, "Other Charges", OtherExciseDuty, ChargeAcctType, ChargeAcct);
            end;

            if ProductSetup."Withdrawal Frequency Count" > 0 then begin
                SLedger.Reset();
                SLedger.SetRange("Account No.", "Account No.");
                SLedger.SetFilter("Debit Amount (LCY)", '>0');
                SLedger.SetFilter(Description, '<>%1&<>%2', 'Excise Duty on Cash Withdrawal Charge', 'Penalty on Cash Withdrawal');
                if SLedger.FindFirst() then begin
                    Message('Ct %1', SLedger.Count);
                    if SLedger.Count() + 1 <= ProductSetup."Withdrawal Frequency Count" then begin
                        Charges := 0;
                        SharingAmt := 0;
                        "Excise Duty" := 0;
                    end;
                end else begin
                    Charges := 0;
                    SharingAmt := 0;
                    "Excise Duty" := 0;
                end;
            end;


            "Total Charge Amount" := Charges + SharingAmt + "Excise Duty";

            "Other Charges" += OtherExciseDuty;

            "Available Balance" -= ("Total Charge Amount" + OtherExciseDuty + "Other Charges");


            if Type = Type::"Cash Withdrawal" then
                "New Account Balance" := "Available Balance" - Amount
            else
                if Type = Type::"Cash Deposit" then
                    "New Account Balance" := "Available Balance" + Amount
                else
                    if Type = Type::"Bankers Cheque" then
                        "New Account Balance" := "Available Balance" - Amount
        end;
    end;


    procedure ClearAll()
    begin
        "Account No." := '';
        "Member No." := '';
        "Account Name" := '';
        Amount := 0;
        "Transaction Type" := '';
        //Type:=Type::" ";
        "ID No" := '';
        "Book Balance" := 0;
        "Available Balance" := 0;
        "New Account Balance" := 0;
        Remarks := '';
        "Signing Instruction Narration" := '';
        "Cheque Date" := 0D;
        "Cheque No" := '';
        "Product Type" := '';
    end;


    procedure ConfirmTreasuryToTeller()
    var
        TreasuryTellerTransactions: Record "Treasury/Teller Transactions";
    begin

        if (Type <> Type::"Cash Deposit") and (Type <> Type::Lien) then begin

            TreasuryTellerTransactions.Reset;
            TreasuryTellerTransactions.SetRange("To Bank", "Till Code");
            TreasuryTellerTransactions.SetRange("Date Received", Today);
            TreasuryTellerTransactions.SetRange(Posted, true);
            TreasuryTellerTransactions.SetRange("Transaction Type", TreasuryTellerTransactions."transaction type"::"Treasury To Teller");
            if not TreasuryTellerTransactions.FindFirst then begin
                //Error('You have not been Issued any Funds from Treasury. Kindly Contact your Supervisor');
            end;
        end;
    end;
}

