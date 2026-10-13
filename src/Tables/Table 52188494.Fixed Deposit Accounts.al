
Table 50157 "Fixed Deposit Accounts"
{
    DrillDownPageID = "Fixed Deposit Accounts";
    LookupPageID = "Fixed Deposit Accounts";

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                Error('Operation Not Allowed');
                if "No." <> xRec."No." then begin
                    SalesSetup.Get;
                    NoSeries.TestManual(SalesSetup."Fixed Deposit Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Members;

            trigger OnValidate()
            begin

                "FD Type" := '';
                "FD Start Date" := 0D;
                "FD Maturity Date" := 0D;
                "FD Amount" := 0;
                "Fixed Account No." := '';
                "Savings Account" := '';

                if Members.Get("Member No.") then begin

                    ProductSetup.Reset;
                    ProductSetup.SetRange("Product Category", ProductSetup."product category"::"Fixed Deposit");
                    ProductSetup.FindFirst;
                    "Global Dimension 1 Code" := ProductSetup."Global Dimension 1 Code";

                    Accounts.Reset;
                    Accounts.SetRange("Member No.", "Member No.");
                    Accounts.SetRange("Product Category", Accounts."product category"::"Fixed Deposit");
                    if Accounts.FindFirst then begin
                        "Fixed Account No." := Accounts."No.";
                    end
                    else begin

                        if (Portal) then begin
                            ProductSetup.Reset;
                            ProductSetup.SetRange("Product Category", ProductSetup."product category"::"Fixed Deposit");
                            ProductSetup.FindFirst;
                            MemberActivities.CreateSavingsAccount(ProductSetup, Members, 0, false, ProductSetup."Repay Mode");
                        end
                        else if (Confirm('Member does not have a fixed deposit account. do you want to create one automatically?')) then begin
                            ProductSetup.Reset;
                            ProductSetup.SetRange("Product Category", ProductSetup."product category"::"Fixed Deposit");
                            ProductSetup.FindFirst;
                            MemberActivities.CreateSavingsAccount(ProductSetup, Members, 0, false, ProductSetup."Repay Mode");
                        end
                        else
                            Error('Process Aborted');


                        /* Accounts.Reset;
                        Accounts.SetRange("Member No.", "Member No.");
                        Accounts.SetRange("Product Category", Accounts."product category"::"Fixed Deposit");
                        if Accounts.FindFirst then begin
                            "Fixed Account No." := MemberActivities.CreateSavingsAccount(ProductSetup, Members, 0, false, ProductSetup."Repay Mode");
                        */

                    end;

                end;


                Accounts.Reset;
                Accounts.SetRange("Member No.", "Member No.");
                Accounts.SetRange("Product Category", Accounts."product category"::"Ordinary Savings");
                if Accounts.FindFirst then begin
                    "Savings Account" := Accounts."No.";
                    "Savings Account Balance" := MemberActivities.GetAccountBalance("Savings Account");
                end
                else begin
                    Error('Member does not have a savings account');
                end;

            end;
        }
        field(3; "Fixed Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Savings Accounts" where("Member No." = field("Member No."),
                                                     "Product Category" = const("Fixed Deposit"));
        }
        field(4; Name; Text[200])
        {
            CalcFormula = lookup(Members.Name where("No." = field("Member No.")));
            FieldClass = FlowField;
        }
        field(5; "FD Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "FD Types";

            trigger OnValidate()
            begin
                CalculateFD;
            end;
        }
        field(6; "FD Duration"; DateFormula)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "FD Start Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CalculateFD;
            end;
        }
        field(8; "FD Maturity Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Approval Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(10; "FD Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CalculateFD;
            end;
        }
        field(11; "Monthly Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12; "Total Expected Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13; "Total Interest Earned"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14; FD; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; "Savings Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Savings Accounts" where("Member No." = field("Member No."),
                                                     "Product Category" = filter("Ordinary Savings" | Business));
        }
        field(16; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Negotiated Interest %"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CalculateFD;
            end;
        }
        field(18; "FD Annual Interest %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(19; "Payment Frequency"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "On Maturity",Monthly,Quarterly,"Tri-Annually","Semi-Annually",Annually;
        }
        field(20; "Application Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Captured By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "KRA PIN"; Code[20])
        {
            Caption = 'KRA PIN';
            CalcFormula = lookup(Members."KRA PIN" where("No." = field("Member No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(22; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(23; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(24; "FD Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Active,Matured,Closed,Forfeited,"Revision Pending","Forfeit Pending";
        }
        field(61; "Savings Account Balance"; Decimal)
        {
            Editable = false;
        }
        field(82; "FD Maturity Instructions"; Option)
        {
            Caption = 'Placement Maturity Instructions';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Transfer all to Savings,Transfer Interest & Renew Principal,Renew Both Principal & Interest,Transfer all to Bank';
            OptionMembers = " ","Transfer all to Savings","Transfer Interest & Renew Principal","Renew Both Principal & Interest","Transfer all to Bank";

            trigger OnValidate()
            begin
                Validate("Payment Frequency");
            end;
        }
        field(83; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(84; "Exempt W/Tax"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(85; "Fixed Account Balance"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - sum("Savings Ledger Entry"."Amount (LCY)" where("Account No." = field("Fixed Account No."),
                                                                            "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(86; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(87; "Posted By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(88; Months; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(90; "Accrued Interest"; Decimal)
        {
            CalcFormula = sum("Savings Interest Buffer"."Interest Amount" where("Account No." = field("No."),
                                                                                 Posted = const(true),
                                                                                 Accrued = const(true)));
            FieldClass = FlowField;
        }
        field(91; "Untransfered Interest"; Decimal)
        {
            CalcFormula = sum("Savings Interest Buffer"."Interest Amount" where("Account No." = field("No."),
                                                                                 Posted = const(false),
                                                                                 Accrued = const(true)));
            FieldClass = FlowField;
        }
        field(96; "Portal"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(97; "Payee Bank Name"; Text[100])
        {
            Caption = 'Bank';
            DataClassification = CustomerContent;

        }
        field(98; "Payee Account Name"; Text[100])
        {
            Caption = 'Account Payee Name';
            DataClassification = CustomerContent;
        }
        field(99; "Payee Account No."; Text[30])
        {
            Caption = 'Account Number';
            DataClassification = CustomerContent;
        }
        field(100; "Payee Branch"; Text[100])
        {
            Caption = 'Branch code';
            DataClassification = CustomerContent;
            TableRelation = "Bank Branches"."Branch Code" where("Bank Code" = field("Payee Bank Code"));
            trigger OnValidate()
            var
                PRBankBranch: Record "Bank Branches";
            begin
                "Payee Branch Name" := '';
                if PRBankBranch.Get("Payee Bank code", "Payee Branch") then
                    "Payee Branch Name" := PRBankBranch."Branch Name";
            end;
        }
        field(101; "Revised Maturity Instructions"; Option)
        {
            Caption = 'Placement Maturity Instructions';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Transfer all to Savings,Transfer Interest & Renew Principal,Renew Both Principal & Interest,Transfer all to Bank';
            OptionMembers = " ","Transfer all to Savings","Transfer Interest & Renew Principal","Renew Both Principal & Interest","Transfer all to Bank";
        }

        field(103; "Payee Branch Name"; Text[100])
        {
            Caption = 'Payee Branch Name';
            DataClassification = CustomerContent;
            Editable = false;

        }
        field(104; "Payee Bank Code"; Code[20])
        {
            Caption = 'Payee Bank Code';
            DataClassification = CustomerContent;
            TableRelation = "Bank Codes";
            trigger OnValidate()
            var
                PRBankAccount: Record "Bank Codes";
            begin
                "Payee Bank Name" := '';
                if PRBankAccount.Get("Payee Bank Code") then
                    "Payee Bank Name" := PRBankAccount."Bank Name";
            end;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin



        if "No." = '' then begin
            SalesSetup.get();
            SalesSetup.TestField("Fixed Deposit Nos");

            // Get the next number
            "No." := NoSeries.GetNextNo(SalesSetup."Fixed Deposit Nos", WorkDate(), true);
        end;

        "Application Date" := Today;
        "Captured By" := UserId;

        UserSetup.Get(UserId);
        UserSetup.TestField("Global Dimension 1 Code");
        UserSetup.TestField("Global Dimension 2 Code");

        "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";

        if not UserSetup."Fixed Deposit" then
            Error('You do not have any permissions for fixed deposit to access. Contact the administrator!');
    end;

    var
        FDTypes: Record "FD Types";
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";
        Members: Record Members;
        Accounts: Record "Savings Accounts";
        MemberActivities: Codeunit "Member Activities";
        ProductSetup: Record "Product Setup";
        IntRate: Decimal;
        TestDate: Date;
        UserSetup: Record "User Setup";


    procedure CalculateFD()
    var
        InitDF: DateFormula;
        FDInterestRates: Record "FD Interest Rates";
        BankAct: Codeunit "Banking Activities";
    begin
        "FD Duration" := InitDF;
        "FD Maturity Date" := 0D;
        "FD Annual Interest %" := 0;
        "Monthly Interest" := 0;
        "Total Expected Interest" := 0;
        Months := 0;
        "Savings Account Balance" := MemberActivities.GetAccountBalance("Savings Account");

        if FDTypes.Get("FD Type") then begin

            FDTypes.TestField(Months);

            if FDTypes."FD Duration" = InitDF then
                Error('FD Type not Set Up');

            "FD Duration" := FDTypes."FD Duration";

            Months := FDTypes.Months;

            if "FD Start Date" <> 0D then
                "FD Maturity Date" := CalcDate("FD Duration", "FD Start Date");

            if "FD Amount" > 0 then begin
                FDInterestRates.Reset;
                FDInterestRates.SetRange(Code, "FD Type");
                FDInterestRates.SetFilter(Minimum, '<=%1', "FD Amount");
                FDInterestRates.SetFilter(Maximum, '>=%1', "FD Amount");
                if FDInterestRates.FindFirst then
                    "FD Annual Interest %" := FDInterestRates."Int Rate";
            end;

            IntRate := "FD Annual Interest %";
            if "Negotiated Interest %" > 0 then
                IntRate := "Negotiated Interest %";

            "Monthly Interest" := ROUND(IntRate / 1200 * "FD Amount", 1, '<');

            if not FDTypes."Call Deposit" then begin
                if ("FD Start Date" <> 0D) and ("FD Maturity Date" <> 0D) and ("FD Maturity Date" > "FD Start Date") then begin
                    TestDate := CalcDate('1M', "FD Start Date");

                    "Total Expected Interest" := BankAct.CalcMaturityInterest(Rec."FD Amount", IntRate, Rec."FD Start Date", Rec."FD Maturity Date");
                    /*
                    WHILE TestDate <= "FD Maturity Date" DO BEGIN
                        "Total Expected Interest" += "Monthly Interest";
                        TestDate := CALCDATE('1M',TestDate);
                    END;
                    */
                end;
            end;

        end;

    end;


    procedure PlaceFD()
    var
        MemberActivities: Codeunit "Member Activities";
        SaccoActivities: Codeunit "Sacco Activities";
        MemberAccounts: Record "Savings Accounts";
        JTemplate: Code[30];
        JBatch: Code[30];
        UserSetup: Record "User Setup";
        AccBal: Decimal;
        AcctType: Enum "Gen. Journal Account Type";
        AcctNo: Code[20];
        BalAcctType: Enum "Gen. Journal Account Type";
        ExtDocNo: Code[20];
        TransType: Enum "Transaction Type Enum";
        TCHannel: Enum "Transaction Channel";
    begin

        TestField("Approval Status", "approval status"::Approved);

        UserSetup.Get(UserId);
        UserSetup.TestField("General Journal Template");
        UserSetup.TestField("General Journal Batch");
        JTemplate := UserSetup."General Journal Template";
        JBatch := UserSetup."General Journal Batch";

        MemberAccounts.Get("Savings Account");

        AccBal := MemberActivities.GetAccountBalance(MemberAccounts."No.");

        if AccBal < "FD Amount" then
            Error('Not Enough Funds in Ordinary Account to enable placement of Fixed Deposit. Current Balance is %1', AccBal);

        SaccoActivities.JournalInit(JTemplate, JBatch);

        AcctType := Accttype::Savings;

        SaccoActivities.JournalInsert(JTemplate, JBatch, "No.", "FD Start Date", AcctType, "Savings Account", 'Fixed Deposit Placement', BalAcctType, '', "FD Amount", ExtDocNo,
                                      '', TransType, "Global Dimension 1 Code", "Global Dimension 2 Code", true, TChannel::" ", UserSetup."Dimension Set ID");

        SaccoActivities.JournalInsert(JTemplate, JBatch, "No.", "FD Start Date", AcctType, "Fixed Account No.", 'Fixed Deposit Placement', BalAcctType, '', -"FD Amount", ExtDocNo,
                                      '', TransType, "Global Dimension 1 Code", "Global Dimension 2 Code", true, TChannel::" ", UserSetup."Dimension Set ID");

        "FD Status" := "fd status"::Active;

        Posted := true;
        "Posted By" := UserId;
        SaccoActivities.JournalPost(JTemplate, JBatch);

        if TrySendFDCertificateEmail("No.") then;


        Message('FD Placed Successfully');
    end;

    [TryFunction]
    local procedure TrySendFDCertificateEmail(FDNo: Code[20])
    var
        FixedDepositAccount: Record "Fixed Deposit Accounts";
    begin
        if FDNo = '' then
            exit;

        FixedDepositAccount.Reset();
        FixedDepositAccount.SetRange("No.", FDNo);
        FixedDepositAccount.SetRange("Approval Status", FixedDepositAccount."Approval Status"::Approved);
        FixedDepositAccount.SetRange("FD Status", FixedDepositAccount."FD Status"::Active);
        FixedDepositAccount.SetRange(Posted, true);
        if FixedDepositAccount.FindFirst() then
            Report.Run(Report::"Email FD Certificate", false, false, FixedDepositAccount);
    end;
}

