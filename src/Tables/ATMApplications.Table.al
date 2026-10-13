Table 50358 "ATM Applications"
{
    DrillDownPageID = "Approved ATM Application List";
    LookupPageID = "Approved ATM Application List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    BankingNoSetup.Get;
                    NoSeries.TestManual(BankingNoSetup."ATM Application Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Account No"; Code[20])
        {
            TableRelation = "Savings Accounts"."No." where("Product Category" = filter("Ordinary Savings"));

            trigger OnValidate()
            begin
                ATMApplications.Reset;
                ATMApplications.SetRange(ATMApplications."Account No", "Account No");
                ATMApplications.SetRange(ATMApplications."ATM Delinked", false);
                if ATMApplications.Find('-') then begin
                    repeat
                        if ATMApplications."ATM Charges Applied" = false
                          then
                            Error('This Account has an active ATM application');
                    until ATMApplications.Next = 0;
                end;
                TestField("Card Type");
                UserSetup.Get(UserId);
                SavingsAccounts.Reset;
                SavingsAccounts.SetRange(SavingsAccounts."No.", "Account No");
                if SavingsAccounts.Find('-') then begin
                    Members.Reset;
                    Members.SetRange(Members."No.", SavingsAccounts."Member No.");
                    if Members.Find('-') then begin
                        // "Branch Code":=Members."Global Dimension 2 Code";
                        // "Shortcut Dimension 1 Code":=UserSetup."Global Dimension 1 Code";//Members."Global Dimension 1 Code";
                        // "Shortcut Dimension 2 Code":=UserSetup."Global Dimension 2 Code";//Members."Global Dimension 2 Code";
                        "Account Name" := Members.Name;
                        "Customer ID" := Members."ID No.";
                        "Phone No." := SavingsAccounts."Mobile Phone No.";
                        Address := Members."Address 2";
                        "Phone No." := Members."Mobile Phone No.";
                    end else begin
                        //  "Branch Code":='';
                        // "Shortcut Dimension 1 Code":='';
                        // "Shortcut Dimension 2 Code":='';
                        "Account Name" := '';
                        "Customer ID" := '';
                        "Phone No." := '';
                        Address := '';
                    end;

                    AvailableBalance := 0;
                    MinBalance := 0;
                    //     TChargeAmount:=0;
                    if Account.Get(SavingsAccounts."No.") then begin
                        ProdType.Reset;
                        ProdType.SetRange(ProdType."Product ID", Account."Product Type");
                        if ProdType.Find('-') then begin
                            AvailableBalance := MemberActivities.GetAccountBalance(Account."No.");
                        end;
                    end;

                    GenSetup.Get;
                    ChargeAmount := 0;

                    ATMCardTypes.Reset;
                    ATMCardTypes.SetRange(ATMCardTypes.Code, "Card Type");
                    if ATMCardTypes.Find('-') then begin
                        if "Request Type" = "request type"::New then begin



                            Value := 0;
                            ChargeAmount := 0;
                            ChargeDuty := 0;
                            ChargeAcctType := Chargeaccttype::"G/L Account";
                            ChargeAcct := '';
                            MemberActivities.GetGeneralChargeAmount(ATMCardTypes."Application Charge Code", Value, ChargeAmount, ChargeDuty, ChargeAcctType, ChargeAcct);

                            TChargeAmount := ChargeDuty + ChargeAmount;


                        end else
                            //if card type not new
                            if "Request Type" = "request type"::Replacement then begin


                                Value := 0;
                                ChargeAmount := 0;
                                ChargeDuty := 0;
                                ChargeAcctType := Chargeaccttype::"G/L Account";
                                ChargeAcct := '';
                                MemberActivities.GetGeneralChargeAmount(ATMCardTypes."Replacement Charge Code", Value, ChargeAmount, ChargeDuty, ChargeAcctType, ChargeAcct);

                                TChargeAmount := ChargeDuty + ChargeAmount;

                            end;
                    end;//IF ATMCardTypes.FIND('-')
                end;

                if AvailableBalance < TChargeAmount then
                    Error('Insufficient balance avail: %1 charges %2', AvailableBalance, TChargeAmount);

                if AvailableBalance < TChargeAmount then begin
                    //send sms
                    SavingsACC.Reset;
                    SavingsACC.SetRange("No.", "Account No");
                    if SavingsACC.Find('-') then begin
                        //  MESSAGE(SavingsACC."No.");
                        //SendSMS.SendSms(SourceType::"ATM Collection",SavingsACC."Mobile Phone No",Txt004,"No.","Account No",TRUE,FALSE);
                    end;
                    // ERROR(ErrRejectCard,TChargeAmount);
                end;
                //   MESSAGE('T charges %1 and %2',TChargeAmount,ChargeAmount);
                CashierTransactions.Init;
                CashierTransactions."Transaction No." := '';
                CashierTransactions."Account No." := "Account No";
                CashierTransactions."Account Name" := "Account Name";
                CashierTransactions."Available Balance" := AvailableBalance;
                CashierTransactions."Global Dimension 1 Code" := "Shortcut Dimension 1 Code";
                CashierTransactions."Global Dimension 2 Code" := "Shortcut Dimension 2 Code";
                CashierTransactions."ID No" := '';
                //CashierTransactions."Responsibility Center" := "Responsibility Center";
                CashierTransactions.Amount := TChargeAmount;
                CashierTransactions.Cashier := UserId;
                CashierTransactions.Remarks := 'ATM Application Charges';
                CashierTransactions.Posted := true;
                CashierTransactions.Type := CashierTransactions.Type::Lien;
                CashierTransactions.Insert(true);
            end;
        }
        field(3; "Branch Code"; Code[20])
        {
            Editable = false;
        }
        field(4; "Account Type"; Option)
        {
            OptionCaption = 'Savings,Current';
            OptionMembers = Savings,Current;
        }
        field(5; "Account Name"; Text[50])
        {
            Editable = false;
        }
        field(6; Address; Text[35])
        {
            Editable = false;
        }
        field(7; "Customer ID"; Code[11])
        {
            Editable = false;
        }
        field(8; "Relation Indicator"; Option)
        {
            OptionCaption = 'Primary,Suplimentary';
            OptionMembers = Primary,Suplimentary;
        }
        field(9; "Card Type"; Code[10])
        {
            TableRelation = "ATM Card Types".Code;
        }
        field(10; "Request Type"; Option)
        {
            OptionCaption = 'New,Replacement';
            OptionMembers = New,Replacement;

            trigger OnValidate()
            begin
                TestField("Account No");
                if "Request Type" = "request type"::Replacement then begin
                    SavingsAccountss.Get("Account No");
                    "Replacement For Card No" := SavingsAccountss."ATM No.";
                end else begin
                    "Replacement For Card No" := '';
                end;
                Validate("Account No");
            end;
        }
        field(11; "Application Date"; Date)
        {
            Editable = false;
        }
        field(12; "Card No"; Code[30])
        {
        }
        field(13; "Date Issued"; Date)
        {
            Editable = false;
        }
        field(14; Limit; Decimal)
        {
        }
        field(15; "Terms Read and Understood"; Boolean)
        {
        }
        field(16; "Card Issued"; Boolean)
        {
            Editable = false;
        }
        field(17; "Form No"; Code[30])
        {
        }
        field(18; "Sent To External File"; Option)
        {
            OptionMembers = No,Yes;
        }
        field(19; "Card Status"; Option)
        {
            Editable = false;
            OptionMembers = Pending,Active,Frozen;
        }
        field(20; "Date Activated"; Date)
        {
            Editable = false;
        }
        field(21; "Date Frozen"; Date)
        {
            Editable = false;
        }
        field(22; "Replacement For Card No"; Code[20])
        {
        }
        field(23; "Phone No."; Code[20])
        {
        }
        field(24; "No. Series"; Code[10])
        {
            Editable = false;
        }
        field(25; Collected; Boolean)
        {
            Editable = false;
        }
        field(26; "Application Approved"; Boolean)
        {
            Editable = false;
        }
        field(27; "Date Collected"; Date)
        {
            Editable = false;
        }
        field(28; "Card Issued By"; Code[20])
        {
            Editable = false;
        }
        field(29; "Approval Date"; Date)
        {
            Editable = false;
        }
        field(30; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(31; "Card Expiry Date"; Date)
        {
            Editable = false;
        }
        field(32; "Posted By."; Code[80])
        {
            Editable = false;
            TableRelation = "User Setup";
        }
        field(33; "Responsibility Center"; Code[10])
        {
            Editable = true;
            TableRelation = "Responsibility Center";
        }
        field(34; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(35; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(36; "Card Issued Date"; Date)
        {
            Editable = false;
        }
        field(37; "PIN Issued Date"; Date)
        {
            Editable = false;
        }
        field(38; "PIN Issued By"; Code[20])
        {
            Editable = false;
        }
        field(39; "Linked Date"; Date)
        {
            Editable = false;
        }
        field(40; "ATM Linked"; Boolean)
        {
            Editable = false;
        }
        field(41; "ATM Charges Applied"; Boolean)
        {
            Editable = false;
        }
        field(42; "ATM Charged Date"; Date)
        {
        }
        field(43; "PIN Issued"; Boolean)
        {
            Editable = false;
        }
        field(44; "Linked By"; Code[20])
        {
            Editable = false;
        }
        field(45; "Delinked By"; Code[20])
        {
            Editable = false;
        }
        field(46; "ATM Delinked"; Boolean)
        {
            Editable = false;
        }
        field(47; "ATM Delinked Date"; Date)
        {
            Editable = false;
        }
        field(48; "Sales Agent"; Code[20])
        {
            TableRelation = if ("Sales Agent Type" = filter(BDE)) "Employee"."No."
            else
            "Salesperson/Purchaser".Code;
        }
        field(49; "Captured By"; Code[50])
        {
            Editable = false;
        }
        field(50; "Capture Date"; Date)
        {
            Editable = false;
        }
        field(51; "Approved  By"; Code[50])
        {
            Editable = false;
        }
        field(52; "Sales Agent Type"; Option)
        {
            OptionCaption = 'BDE,Others';
            OptionMembers = BDE,Others;
        }
        field(53; "Received from coop"; Boolean)
        {
        }
        field(54; "Received from coop By"; Code[50])
        {
            Editable = false;
        }
        field(55; "Issue To Branch"; Boolean)
        {
        }
        field(56; "Issue To Branc By"; Code[50])
        {
            Editable = false;
        }
        field(57; "Receive From Branch"; Boolean)
        {
        }
        field(58; "Receive from Branch By"; Code[50])
        {
            Editable = false;
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
            BankingNoSetup.Get();
            BankingNoSetup.TestField(BankingNoSetup."ATM Application Nos");
            "No." := NoSeries.GetNextNo(BankingNoSetup."ATM Application Nos", WorkDate(), true);
        end;
        "Application Date" := Today;
        UserSetup.Get(UserId);
        //BEGIN
        UserSetup.TestField("Global Dimension 1 Code");
        UserSetup.TestField("Global Dimension 2 Code");
        //UserSetup.TestField("Responsibility Centre");

        "Shortcut Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
        "Shortcut Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
        //"Responsibility Center" := UserSetup."Responsibility Centre";

        "Capture Date" := Today;
        "Captured By" := UserId;
        GeneralSetUp.Get();
        Limit := GeneralSetUp."Maximum ATM Limit";
    end;

    var
        BankingNoSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";
        SavingsAccounts: Record "Savings Accounts";
        Members: Record Members;
        SavingsAccountss: Record "Savings Accounts";
        TChargeAmount: Decimal;
        TCharges: Decimal;
        ChargeAmount: Decimal;
        GenSetup: Record "Sacco Setup";
        AccountTypes: Record "Product Setup";
        Account: Record "Savings Accounts";
        AvailableBalance: Decimal;
        MinBalance: Decimal;
        ProdType: Record "Product Setup";
        ErrRejectCard: label 'This account do not have minimum balance of KES %1 to apply for ATM Card.';
        ATMCardTypes: Record "ATM Card Types";
        UserSetup: Record "User Setup";
        ATMApplications: Record "ATM Applications";
        CashierTransactions: Record "Teller Transaction";
        SavingsACC: Record "Savings Accounts";
        MemberActivities: Codeunit "Member Activities";
        SourceType: Enum "SMS Source Enum";
        Txt004: label 'Dear Member, Your account donot have sufficient funds to apply for ATM card';
        GeneralSetUp: Record "Sacco Setup";

        ChargeAmt: Decimal;
        ChargeDuty: Decimal;
        ChargeAcctType: Enum "Gen. Journal Account Type";
        ChargeAcct: Code[20];
        SharingAmt: Decimal;
        SharingChargeAcctType: Enum "Gen. Journal Account Type";
        SharingChargeAcct: Code[20];
        Value: Decimal;
        TotalCharge: Decimal;
        TotalDuty: Decimal;
}

