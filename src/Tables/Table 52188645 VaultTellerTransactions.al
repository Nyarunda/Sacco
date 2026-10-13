#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50308 "Treasury/Teller Transactions"
{
    DrillDownPageID = "Treasury/Teller Trans. List";
    LookupPageID = "Treasury/Teller Trans. List";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(50002; "Transaction Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Transaction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Treasury To Teller,Teller To Treasury,Bank to Treasury,Treasury To Bank,Teller to Teller,Treasury to Treasury,End of Day Teller to Treasury,Mpesa to Teller,Treasury to Mpesa,Mpesa to Treasury,Treasury to Equity,Equity to Treasury,Bank to Bank';
            OptionMembers = "Treasury To Teller","Teller To Treasury","Bank to Treasury","Treasury To Bank","Teller to Teller","Treasury to Treasury","End of Day Teller to Treasury","Mpesa to Teller","Treasury to Mpesa","Mpesa to Treasury","Treasury to Equity","Equity to Treasury","Bank to Bank";

            trigger OnValidate()
            begin

                if "Transaction Type" = "transaction type"::"Mpesa to Teller" then begin
                    Description := Format("transaction type"::"Mpesa to Teller");

                    if BankingUser.Get(UserId) then begin
                        BankAccount.Reset;
                        BankAccount.SetRange("No.", BankingUser."MPesa Bank Account");
                        if BankAccount.Find('-') then begin
                            "From Till" := CopyStr(BankAccount.Name, 1, 50);
                        end;
                    end;

                end;


                if "Transaction Type" = "transaction type"::"Treasury To Teller" then begin

                    if BankingUser.Get(UserId) then begin
                        if BankingUser.Type = BankingUser.Type::Treasury then begin
                            "From Account" := UpperCase(UserId);
                            //"From Till":=BankingUser."Default  Bank";
                            BankAccount.Reset;
                            BankAccount.SetRange("No.", BankingUser."Default  Bank");
                            if BankAccount.Find('-') then begin
                                "From Till" := CopyStr(BankingUser."Default  Bank" + ' ' + BankAccount.Name, 1, 50);
                            end;

                        end;
                    end;


                    // Get Treasury
                    Treasury.Reset;
                    Treasury.SetRange(Treasury."Shortcut Dimension 2 Code", UserSetup."Global Dimension 2 Code");
                    Treasury.SetRange(Treasury.Type, Treasury.Type::Treasury);
                    if Treasury.Find('-') then begin
                        "From Account" := Treasury."User Name";
                        Validate("From Account");
                    end;
                end;


                if "Transaction Type" = "transaction type"::"Teller To Treasury" then begin
                    if BankingUser.Get(UserId) then begin
                        if BankingUser.Type = BankingUser.Type::Cashier then begin
                            "From Account" := UpperCase(UserId);
                            BankAccount.Reset;
                            BankAccount.SetRange("No.", BankingUser."Default  Bank");
                            if BankAccount.Find('-') then begin
                                "From Till" := CopyStr(BankingUser."Default  Bank" + ' ' + BankAccount.Name, 1, 50);

                            end;
                        end;
                    end;
                end;

                if "Transaction Type" = "transaction type"::"Teller to Teller" then begin

                    if BankingUser.Get(UserId) then begin
                        if BankingUser.Type = BankingUser.Type::Cashier then begin
                            "From Account" := UpperCase(UserId);
                            //"From Till":=BankingUser."Default  Bank";
                            BankAccount.Reset;
                            BankAccount.SetRange("No.", BankingUser."Default  Bank");
                            if BankAccount.Find('-') then begin
                                "From Till" := CopyStr(BankingUser."Default  Bank" + ' ' + BankAccount.Name, 1, 50);
                            end;
                        end;
                    end;
                end;

                if "Transaction Type" = "transaction type"::"Bank to Treasury" then begin
                    "From Account" := '';
                    "From Till" := '';
                    if BankingUser.Get(UserId) then begin
                        if BankingUser.Type = BankingUser.Type::Treasury then begin
                            "To Account" := UpperCase(UserId);
                            BankAccount.Reset;
                            BankAccount.SetRange("No.", BankingUser."Default  Bank");
                            if BankAccount.Find('-') then begin
                                "To Till" := CopyStr(BankingUser."Default  Bank" + ' ' + BankAccount.Name, 1, 50);
                            end;
                        end;
                    end;
                end;

                if "Transaction Type" = "transaction type"::"Treasury To Bank" then begin
                    if BankingUser.Get(UserId) then begin
                        if BankingUser.Type = BankingUser.Type::Treasury then begin
                            "From Account" := UpperCase(UserId);
                            BankAccount.Reset;
                            BankAccount.SetRange("No.", BankingUser."Default  Bank");
                            if BankAccount.Find('-') then begin
                                "From Till" := CopyStr(BankingUser."Default  Bank" + ' ' + BankAccount.Name, 1, 50);
                            end;
                        end;
                    end;
                end;

                if "Transaction Type" = "transaction type"::"Treasury to Treasury" then begin
                    if BankingUser.Get(UserId) then begin
                        if BankingUser.Type = BankingUser.Type::Treasury then begin
                            "From Account" := UpperCase(UserId);
                            BankAccount.Reset;
                            BankAccount.SetRange("No.", BankingUser."Default  Bank");
                            if BankAccount.Find('-') then begin
                                "From Till" := CopyStr(BankingUser."Default  Bank" + ' ' + BankAccount.Name, 1, 50);
                            end;
                        end;
                    end;
                end;

                if "Transaction Type" = "transaction type"::"End of Day Teller to Treasury" then begin
                    if BankingUser.Get(UserId) then begin
                        if BankingUser.Type = BankingUser.Type::Cashier then begin
                            "From Account" := UpperCase(UserId);

                            BankAccount.Reset;
                            BankAccount.SetRange("No.", BankingUser."Default  Bank");
                            if BankAccount.Find('-') then begin
                                "From Till" := CopyStr(BankingUser."Default  Bank" + ' ' + BankAccount.Name, 1, 50);
                            end;
                        end;
                    end;

                end;

                // Get Treasury
                if ("Transaction Type" = "transaction type"::"Treasury To Teller") then begin
                    UserSetup.Get(UserId);
                    UserSetup.TestField("Global Dimension 2 Code");

                    Treasury.Reset;
                    Treasury.SetRange(Treasury."Shortcut Dimension 2 Code", UserSetup."Global Dimension 2 Code");
                    Treasury.SetRange(Treasury.Type, Treasury.Type::Treasury);
                    if Treasury.Find('-') then begin
                        "From Account" := Treasury."User Name";
                    end;


                    if BankingUser.Get(UserId) then begin
                        if BankingUser.Type = BankingUser.Type::Cashier then begin
                            "To Account" := UpperCase(UserId);
                            "To Till" := BankingUser."Default  Bank";
                        end;
                    end;
                end;

                // Get Treasury
                if ("Transaction Type" = "transaction type"::"Teller To Treasury") then begin
                    UserSetup.Get(UserId);
                    UserSetup.TestField("Global Dimension 2 Code");

                    Treasury.Reset;
                    Treasury.SetRange(Treasury."Shortcut Dimension 2 Code", UserSetup."Global Dimension 2 Code");
                    Treasury.SetRange(Treasury.Type, Treasury.Type::Treasury);
                    if Treasury.Find('-') then begin
                        "To Account" := Treasury."User Name";
                        Validate("To Account");
                    end;


                    if BankingUser.Get(UserId) then begin
                        if BankingUser.Type = BankingUser.Type::Cashier then begin
                            "From Account" := UpperCase(UserId);
                            "To Till" := BankingUser."Default  Bank";
                        end;
                    end;
                end;

                if ("Transaction Type" = "transaction type"::"Bank to Treasury") then begin
                    UserSetup.Get(UserId);
                    UserSetup.TestField("Global Dimension 2 Code");

                    Treasury.Reset;
                    Treasury.SetRange(Treasury."Shortcut Dimension 2 Code", UserSetup."Global Dimension 2 Code");
                    Treasury.SetRange(Treasury.Type, Treasury.Type::Treasury);
                    if Treasury.Find('-') then begin
                        "To Account" := Treasury."User Name";
                        Validate("To Account");
                    end;

                    /*
                    IF BankingUser.GET(USERID) THEN BEGIN
                    IF BankingUser.Type=BankingUser.Type::Cashier THEN BEGIN
                      "From Account":='';//UPPERCASE(USERID);
                      "To Till":=BankingUser."Default  Bank";
                     // MESSAGE("from Account");
                    END;
                    END;
                    */
                    "From Account" := '';
                    Validate("From Account");
                end;

                // Get Treasury
                if ("Transaction Type" = "transaction type"::"Treasury To Bank") then begin
                    UserSetup.Get(UserId);
                    UserSetup.TestField("Global Dimension 2 Code");

                    Treasury.Reset;
                    Treasury.SetRange(Treasury."Shortcut Dimension 2 Code", UserSetup."Global Dimension 2 Code");
                    Treasury.SetRange(Treasury.Type, Treasury.Type::Treasury);
                    if Treasury.Find('-') then begin
                        "From Account" := Treasury."User Name";
                        Validate("From Account");
                    end;

                    /*IF BankingUser.GET(USERID) THEN BEGIN
                    IF BankingUser.Type=BankingUser.Type::Cashier THEN BEGIN
                      "From Account":=UPPERCASE(USERID);
                      "To Till":=BankingUser."Default  Bank";
                     // MESSAGE("from Account");
                    END;
                    END;
                    */

                    "To Account" := '';
                    Validate("To Account");
                end;


                if ("Transaction Type" = "transaction type"::"Teller to Teller") then begin
                    if BankingUser.Get(UserId) then begin
                        if BankingUser.Type = BankingUser.Type::Cashier then begin
                            "From Account" := UpperCase(UserId);
                            "From Till" := BankingUser."Default  Bank";
                            "To Account" := '';
                            Validate("To Account");
                            "To Till" := '';
                        end;
                    end;
                end;

                // Get Treasury
                if ("Transaction Type" = "transaction type"::"End of Day Teller to Treasury") then begin
                    UserSetup.Get(UserId);
                    UserSetup.TestField("Global Dimension 2 Code");

                    Treasury.Reset;
                    Treasury.SetRange(Treasury."Shortcut Dimension 2 Code", UserSetup."Global Dimension 2 Code");
                    Treasury.SetRange(Treasury.Type, Treasury.Type::Treasury);
                    if Treasury.Find('-') then begin
                        "To Account" := Treasury."User Name";
                        Validate("To Account");
                    end;


                    if BankingUser.Get(UserId) then begin
                        if BankingUser.Type = BankingUser.Type::Cashier then begin
                            "From Account" := UpperCase(UserId);
                            "From Till" := BankingUser."Default  Bank";
                        end;
                    end;
                end;

                if ("Transaction Type" = "transaction type"::"Treasury To Teller") then begin
                    if BankingUser.Get(UserId) then begin
                        if BankingUser.Type = BankingUser.Type::Treasury then begin
                            "From Account" := UpperCase(UserId);
                            "From Till" := BankingUser."Default  Bank";
                        end;
                    end;
                end;





                Description := Format("Transaction Type");




                Validate("From Account");
                Validate("To Account");

            end;
        }
        field(50004; "From Account"; Code[30])
        {
            DataClassification = ToBeClassified;
            Description = 'IF (Transaction Type=FILTER(Treasury To Bank|Treasury to Treasury|Treasury To Teller)) "Banking User Setup"."User Name" WHERE (Type=CONST(Treasury)) ELSE IF (Transaction Type=FILTER(End of Day Teller to Treasury|Teller To Treasury|Teller to Teller|Mpesa to Teller)) "Banking User Setup"."User Name" WHERE (Type=CONST(Cashier)) ELSE IF (Transaction Type=FILTER(Bank to Treasury)) "Bank Account".No. WHERE (Bank Type=CONST(Normal))';
            TableRelation = if ("Transaction Type" = filter("Treasury To Bank" | "Treasury to Treasury" | "Treasury To Teller" | "Treasury to Mpesa" | "Treasury to Equity")) "Banking User Setup"."User Name" where(Type = const(Treasury))
            else
            if ("Transaction Type" = filter("End of Day Teller to Treasury" | "Teller To Treasury" | "Teller to Teller" | "Mpesa to Teller" | "Mpesa to Treasury" | "Equity to Treasury")) "Banking User Setup"."User Name" where(Type = const(Cashier))
            else
            if ("Transaction Type" = filter("Bank to Treasury" | "Bank to Bank")) "Bank Account"."No.";

            trigger OnValidate()
            begin


                if StrLen("From Account") <= 20 then begin
                    if BankAccount.Get("From Account") then begin
                        "From Till" := BankAccount.Name;
                        BankAccount.CalcFields("Balance (LCY)");
                        "From Balance" := BankAccount."Balance (LCY)";
                        "From Bank" := BankAccount."No.";
                    end;
                end;

                if BankingUser.Get("From Account") then begin
                    BankAccount.Reset;
                    BankAccount.SetRange("No.", BankingUser."Default  Bank");
                    if BankAccount.Find('-') then begin
                        "From Till" := CopyStr(BankingUser."Default  Bank" + ' ' + BankAccount.Name, 1, 50);
                        BankAccount.CalcFields("Balance (LCY)");
                        "From Balance" := BankAccount."Balance (LCY)";
                        "From Bank" := BankAccount."No.";
                    end;

                    BankAccount.Reset;
                    BankAccount.SetRange("No.", BankingUser."Default  Bank");
                    if BankAccount.Find('-') then begin
                        "From Till" := CopyStr(BankingUser."Default  Bank" + ' ' + BankAccount.Name, 1, 50);
                        BankAccount.CalcFields("Balance (LCY)");
                        "From Balance" := BankAccount."Balance (LCY)";
                        "From Bank" := BankAccount."No.";
                    end;

                    if "Transaction Type" = "transaction type"::"Mpesa to Teller" then begin
                        BankAccount.Reset;
                        BankAccount.SetRange("No.", BankingUser."MPesa Bank Account");
                        if BankAccount.Find('-') then begin
                            "From Till" := CopyStr(BankAccount.Name, 1, 50);
                            BankAccount.CalcFields("Balance (LCY)");
                            "From Balance" := BankAccount."Balance (LCY)";
                            "From Bank" := BankAccount."No.";
                        end;
                    end;


                    if "Transaction Type" = "transaction type"::"Mpesa to Treasury" then begin
                        BankAccount.Reset;
                        BankAccount.SetRange("No.", BankingUser."MPesa Bank Account");
                        if BankAccount.Find('-') then begin
                            "From Till" := CopyStr(BankAccount.Name, 1, 50);
                            BankAccount.CalcFields("Balance (LCY)");
                            "From Balance" := BankAccount."Balance (LCY)";
                            "From Bank" := BankAccount."No.";
                        end;
                    end;

                    if "Transaction Type" = "transaction type"::"Equity to Treasury" then begin
                        BankAccount.Reset;
                        BankAccount.SetRange("No.", BankingUser."Equity Bank Account");
                        if BankAccount.Find('-') then begin
                            "From Till" := CopyStr(BankingUser."Equity Bank Account" + ' ' + BankAccount.Name, 1, 50);
                            BankAccount.CalcFields("Balance (LCY)");
                            "From Balance" := BankAccount."Balance (LCY)";
                            "From Bank" := BankAccount."No.";
                        end;
                    end;

                    if "Transaction Type" = "transaction type"::"Bank to Bank" then begin
                        BankAccount.Reset;
                        BankAccount.SetRange("No.", "From Account");
                        if BankAccount.Find('-') then begin
                            "From Till" := CopyStr(BankingUser."Equity Bank Account" + ' ' + BankAccount.Name, 1, 50);
                            BankAccount.CalcFields("Balance (LCY)");
                            "From Balance" := BankAccount."Balance (LCY)";
                            "From Bank" := BankAccount."No.";
                        end;
                    end;


                end;
            end;
        }
        field(50005; "To Account"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Transaction Type" = filter("Teller To Treasury" | "Bank to Treasury" | "Treasury to Treasury" | "End of Day Teller to Treasury" | "Mpesa to Treasury" | "Equity to Treasury")) "Banking User Setup"."User Name" where(Type = const(Treasury))
            else
            if ("Transaction Type" = filter("Treasury To Teller" | "Mpesa to Teller" | "Teller to Teller" | "Treasury to Mpesa" | "Treasury to Equity")) "Banking User Setup"."User Name" where(Type = const(Cashier),
                                                                                                                                                                                                   "Shortcut Dimension 2 Code" = field("Global Dimension 2 Code"))
            else
            if ("Transaction Type" = filter("Treasury To Bank" | "Bank to Bank")) "Bank Account"."No.";

            trigger OnValidate()
            begin


                if StrLen("To Account") <= 20 then begin
                    if BankAccount.Get("To Account") then begin
                        "To Till" := BankAccount.Name;
                        BankAccount.CalcFields("Balance (LCY)");
                        "To Balance" := BankAccount."Balance (LCY)";
                        "To Bank" := BankAccount."No.";
                    end;
                end;


                if BankingUser.Get("To Account") then begin

                    BankAccount.Reset;
                    BankAccount.SetRange("No.", BankingUser."Default  Bank");
                    if BankAccount.Find('-') then begin
                        "To Till" := CopyStr(BankingUser."Default  Bank" + ' ' + BankAccount.Name, 1, 50);
                        BankAccount.CalcFields("Balance (LCY)");
                        "To Balance" := BankAccount."Balance (LCY)";
                        "To Bank" := BankAccount."No.";
                    end;
                    //"From Till":=BankingUser."Default  Bank";
                    BankAccount.Reset;
                    BankAccount.SetRange("No.", BankingUser."Default  Bank");
                    if BankAccount.Find('-') then begin
                        "To Till" := CopyStr(BankingUser."Default  Bank" + ' ' + BankAccount.Name, 1, 50);
                        BankAccount.CalcFields("Balance (LCY)");
                        "To Balance" := BankAccount."Balance (LCY)";
                        "To Bank" := BankAccount."No.";
                    end;

                    if "Transaction Type" = "transaction type"::"Mpesa to Teller" then begin
                        BankAccount.Reset;
                        BankAccount.SetRange("No.", BankingUser."MPesa Bank Account");
                        if BankAccount.Find('-') then begin
                            "To Till" := CopyStr(BankAccount.Name, 1, 50);
                            BankAccount.CalcFields("Balance (LCY)");
                            "To Balance" := BankAccount."Balance (LCY)";
                            "To Bank" := BankAccount."No.";
                        end;
                    end;

                    if "Transaction Type" = "transaction type"::"Treasury to Mpesa" then begin
                        BankAccount.Reset;
                        BankAccount.SetRange("No.", BankingUser."MPesa Bank Account");
                        if BankAccount.Find('-') then begin
                            "To Till" := CopyStr(BankAccount.Name, 1, 50);
                            BankAccount.CalcFields("Balance (LCY)");
                            "To Balance" := BankAccount."Balance (LCY)";
                            "To Bank" := BankAccount."No.";
                        end;
                    end;


                    if "Transaction Type" = "transaction type"::"Treasury to Equity" then begin
                        BankAccount.Reset;
                        BankAccount.SetRange("No.", BankingUser."Equity Bank Account");
                        if BankAccount.Find('-') then begin
                            "To Till" := CopyStr(BankAccount.Name, 1, 50);
                            BankAccount.CalcFields("Balance (LCY)");
                            "To Balance" := BankAccount."Balance (LCY)";
                            "To Bank" := BankAccount."No.";
                        end;
                    end;

                end;
            end;
        }
        field(50007; Amount; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                if Amount < 0 then
                    Error('Amount must not be negative')
            end;
        }
        field(50008; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Date Posted"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Time Posted"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Posted By"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(50013; "Transaction Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = ToBeClassified;
            TableRelation = Currency;
        }
        field(50015; Issued; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = No,Yes,"N/A";
        }
        field(50016; "Date Issued"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Time Issued"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Issue Received"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionMembers = No,Yes,"N/A";
        }
        field(50019; "Date Received"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(50020; "Time Received"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50021; "Issued By"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50022; "Received By"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50023; Received; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'No,Yes';
            OptionMembers = No,Yes;
        }
        field(50024; "Denomination Total"; Decimal)
        {
            CalcFormula = sum(Coinage."Total Amount" where(No = field(Code)));
            FieldClass = FlowField;
        }
        field(50025; "External Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50026; "Total Cash on Treasury Coinage"; Decimal)
        {
            CalcFormula = sum(Coinage."Total Amount" where(No = field(Code)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50027; "From Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50028; "Excess/Shortage Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                if "Excess/Shortage Amount" < 0 then
                    Error('Amount must not be negative');

                if Type = Type::" " then
                    Error('Please specify the type');
            end;
        }
        field(50029; "From Account Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50030; "To Account Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50031; "Actual Cash At Hand"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(50032; "Responsibility Center"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50033; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(50034; "Exces/Shortage"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Excess,Shortage';
            OptionMembers = " ",Excess,Shortage;

            trigger OnValidate()
            begin
                "Excess/Shortage Amount" := 0;
            end;
        }
        field(50035; "From Till"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50036; "To Till"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50037; "To Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50038; "Captured By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50046; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50047; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50049; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Excess,Shortage';
            OptionMembers = " ",Excess,Shortage;

            trigger OnValidate()
            begin
                "Excess/Shortage Amount" := 0;
            end;
        }
        field(50050; "From Bank"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50051; "To Bank"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
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
                    Rec, "Dimension Set ID", "Code", "Global Dimension 1 Code", "Global Dimension 2 Code");

                //IsChanged := OldDimSetID <> "Dimension Set ID";
            end;

            trigger OnValidate()
            var
                DimMgt: Codeunit DimensionManagement;
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Global Dimension 1 Code", "Global Dimension 2 Code");
            end;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if Code = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField("Treasury/Teller Nos");
            Code := NoSeries.GetNextNo(SalesSetup."Treasury/Teller Nos", WorkDate(), true);
        end;


        Denominations.Reset;
        if Denominations.Find('-') then begin
            repeat

                Coinage.No := Code;
                Coinage.Code := Denominations.Code;
                Coinage.Description := Denominations.Description;
                Coinage.Type := Denominations.Type;
                Coinage.Value := Denominations.Value;
                Coinage.Quantity := 0;
                Coinage.Insert;
            until Denominations.Next = 0;
        end;


        UserSetup.Get(UserId);
        UserSetup.TestField("Global Dimension 1 Code");
        UserSetup.TestField("Global Dimension 2 Code");
        "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
        "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";

        "External Document No." := Code;
        "Transaction Date" := Today;

        Validate("Transaction Type");
        Validate("From Account");
        Validate("To Account");
    end;

    var
        BankingUser: Record "Banking User Setup";
        BankAccount: Record "Bank Account";
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";
        UserSetup: Record "User Setup";
        BankNo: Code[20];
        Treasury: Record "Banking User Setup";
        Denominations: Record Denominations;
        Coinage: Record Coinage;
}

