
Table 50128 "Defaulter Loan Recovery"
{
    LookupPageID = "Defaulter Loan Recovery List";
    fields
    {
        field(1; "No."; Code[10])
        {
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SalesSetup.Get;
                    NoSeries.TestManual(SalesSetup."Loan Recovery Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(8; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(9; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }

        field(10; Stage; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionMembers = Booking,Verification,Approval,Recovery;
        }
        field(50001; "Member No."; Code[20])
        {
            DataClassification = EndUserIdentifiableInformation;

            TableRelation = Members;

            trigger OnValidate()
            begin

                if Members.Get("Member No.") then
                    Name := Members.Name
                else
                    Name := '';

                RecoveryLines.Reset;
                RecoveryLines.SetRange("Header No.", "No.");
                if RecoveryLines.FindFirst then
                    if Confirm('This will clear the lines below. Do you want to continue?') then
                        RecoveryLines.DeleteAll
                    else
                        Error('Cancelled');

                "Recovery Type" := "recovery type"::" ";
                "Recovery Source" := "recovery source"::" ";
                "Loan No." := '';

                "Member Deposits" := 0;
                "Member Savings" := 0;
                "Outstanding Principal" := 0;
                "Outstanding Appraisal" := 0;
                "Outstanding Interest" := 0;
                "Outstanding Penalty" := 0;
                "Total Available" := 0;
                "Committed Deposits" := 0;
                "Deposit Balance" := 0;
                "Total Deduction" := 0;

                validate("Recovery Type", "Recovery Type"::"All Loans");
                validate("Recovery Option", "Recovery Option"::"Recover from Multiple Accounts");
                if "Posting Date" <> 0D then
                    Validate("Posting Date");

            end;
        }
        field(50002; Name; Text[50])
        {
            DataClassification = EndUserIdentifiableInformation;
            Editable = false;
        }
        field(50003; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Loans where("Member No." = field("Member No."),
                                         "Total Outstanding Balance" = filter(> 0));

            trigger OnValidate()
            var
                ExpAmt: Decimal;
                AmtPaid: Decimal;
                DefAmt: Decimal;
                DaysDef: Integer;
                ArrearsDate: Date;
                GracePeriod: DateFormula;
                SaccoSetup: Record "Sacco Setup";
                Sacco: Codeunit "Sacco Activities";
            begin
                SaccoSetup.Get();
                GracePeriod := SaccoSetup."Arrears Grace Period";
                if ("Recovery Type" = "Recovery Type"::"All Loans") or ("Recovery Type" = "Recovery Type"::" ") then
                    Error('Recovery Type is required [Single or Arreas]');

                RecoveryLines.Reset;
                RecoveryLines.SetRange("Header No.", "No.");
                if RecoveryLines.FindFirst then begin
                    if Confirm('This will clear the lines below. Do you want to continue?') then
                        RecoveryLines.DeleteAll
                    else
                        Error('Cancelled');
                end;


                if "Recovery Type" = "Recovery Type"::Arrears then begin
                    Loans.Get("Loan No.");


                    "Interest Arrears" := Sacco.GetInterestArrears(Loans."Loan No.", Today);

                    Sacco.GetDefaultedAmount(Loans."Loan No.", Today, ExpAmt, AmtPaid, DefAmt, DaysDef, ArrearsDate, true, GracePeriod);

                    "Principal Arrears" := DefAmt;

                    Arrears := "Principal Arrears" + "Interest Arrears";

                    "Amount to Recover" := Arrears;
                end;
            end;
        }
        field(50004; "Date Entered"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50005; "Entered By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50006; Status; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if Status = Status::Pending then begin
                    Stage := Stage::Approval;
                    Modify();
                end;
                if Status = Status::Approved then begin
                    Stage := Stage::Recovery;
                    Modify();
                end;

            end;
        }
        field(50007; "Outstanding Principal"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50008; "Outstanding Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50009; "Member Deposits"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50010; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; Recovered; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50012; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
                AppraisalLine: Record "Offset Appraisal";
                SaccoActivities: Codeunit "Sacco Activities";
            begin

            end;
        }
        field(50013; "Recovery Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Single Loan,All Loans,Arrears';
            OptionMembers = " ","Single Loan","All Loans",Arrears;

            trigger OnValidate()
            begin
                "Loan No." := '';
                "Source Account" := '';
                "Amount to Recover" := 0;
                "Recovery Option" := "Recovery Option"::" ";
                if "Recovery Type" = "Recovery Type"::"All Loans" then
                    "Recovery Option" := "Recovery Option"::"Recover from Multiple Accounts";

                /*
                RecoveryLines.Reset;
                RecoveryLines.SetRange("Header No.", "No.");
                if RecoveryLines.FindFirst then
                    if Confirm('This will clear the lines below. Do you want to continue?') then
                        RecoveryLines.DeleteAll
                    else
                        Error('Cancelled');

                if "Recovery Type" <> "Recovery Type"::"All Loans" then begin

                    OffsetLines.Reset;
                    OffsetLines.SetRange("Header No.", "No.");
                    OffsetLines.SetFilter("Loan No", '<>%1', '');
                    if OffsetLines.FindFirst then
                        OffsetLines.DeleteAll();

                end;

                GetAmounts;
                */
            end;
        }
        field(50014; "Recovery Source"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Defaulter Withdrawable Savings","Defaulter Non-Withdrawable Deposits","Guarantor Withdrawable Savings","Guarantor Non-Withdrawable Deposits","Issue Guarantor Defaulter Loan","Recovery From All","Recover & Issue Guarantor Defaulter Loan";

            trigger OnValidate()
            begin
                //GetAmounts;
            end;
        }
        field(50015; "Member Savings"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50016; "Source Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Savings Accounts"."No." where("Product Category" = filter("Deposit Contribution" | "MFI Deposit"),
                                            "Member No." = field("Member No."));

            trigger OnValidate()
            begin


                if "Source Account" <> '' then begin
                    if ("Recovery Option" <> "recovery option"::"Recover from Single Account") then
                        Error('Recovery Ootion must be [Recover from Single Account]');
                end;
                //GetAmounts();
            end;
        }
        field(50017; "Amount to Recover"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin

                if "Amount to Recover" > 0 then begin
                    TestField("Source Account");
                    if ("Recovery Option" <> "recovery option"::"Recover from Single Account") then
                        Error('Recovery Ootion must be [Recover from Single Account]');

                    if "Amount to Recover" > MemberActivities.GetAccountBalance("Source Account") then
                        Error('Amount cannot be More than the Account Balance of KES %1', MemberActivities.GetAccountBalance("Source Account"));
                end;
            end;
        }
        field(50018; "Outstanding Penalty"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50019; "Outstanding Appraisal"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50020; "Recovery Option"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Recover from Single Account","Recover from Multiple Accounts";

            trigger OnValidate()
            begin
                //"Source Account" := '';
                //"Amount to Recover" := 0;
                //"Recovery Source" := "recovery source"::" ";
                //GetAmounts;
            end;
        }
        field(50021; "Total Available"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50022; "Committed Deposits"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50024; "Share Capital"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50025; "Share Capital Top Up"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50026; "Deposit Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50027; "Waiver"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50028; "Self Guaranteed"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50029; "Total Deduction"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50030; "Withdrawal Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50031; "Dividend Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50032; "Net Refund"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50033; "Arrears"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50034; Source; Option)
        {
            OptionMembers = " ",Buffer;
        }
        field(50035; "Total Deduction Loans"; Decimal)
        {
            //DataClassification = ToBeClassified;
            FieldClass = Flowfield;
            CalcFormula = Sum("Defaulter Recovery Buffer".Amount where("Header No." = field("No."), "Account Type" = const(Credit)));
            Editable = false;
        }
        field(50036; "Total Deduction Savings"; Decimal)
        {
            //DataClassification = ToBeClassified;
            FieldClass = Flowfield;
            CalcFormula = Sum("Defaulter Recovery Buffer".Amount where("Header No." = field("No."), "Account Type" = const(Savings)));
            Editable = false;
        }
        field(50037; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(50038; "Total Count"; Integer)
        {
            //DataClassification = ToBeClassified;
            FieldClass = Flowfield;
            CalcFormula = Count("Defaulter Recovery Buffer" where("Header No." = field("No."), "Account Type" = const(Savings)));
            Editable = false;
        }
        field(50039; "Outstanding Insurance"; Decimal)
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
                    Rec, "Dimension Set ID", "No.", "Global Dimension 1 Code", "Global Dimension 2 Code");

                //IsChanged := OldDimSetID <> "Dimension Set ID";
            end;

            trigger OnValidate()
            var
                DimMgt: Codeunit DimensionManagement;
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Global Dimension 1 Code", "Global Dimension 2 Code");
            end;
        }
        field(51201; "Loan Product"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Product Setup";
        }
        field(51202; "Skip Loan Category Check"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51203; "Source Account Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Product Setup" where("Product Class" = filter(Savings), "Can Offset Loan" = const(true));
        }
        field(51204; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51205; "Principal Arrears"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(51206; "Interest Arrears"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(51207; "Free Shares"; Decimal)
        {
            DataClassification = CustomerContent;
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
            SalesSetup.Get;
            SalesSetup.TestField("Loan Recovery Nos");
            "No." := NoSeries.GetNextNo(SalesSetup."Loan Recovery Nos", WorkDate(), true);
        end;


        "Date Entered" := Today;
        "Entered By" := UserId;

        UserSetup.Get(UserId);
        UserSetup.TestField("Global Dimension 1 Code");
        UserSetup.TestField("Global Dimension 2 Code");

        "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";

    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";
        Members: Record Members;
        RecoveryLines: Record "Defaulter Recovery Lines";
        MemberAccounts: Record "Savings Accounts";
        MemberActivities: Codeunit "Member Activities";
        Loans: Record Loans;
        UserSetup: Record "User Setup";
        OffsetLines: Record "Loans Offet List";


    procedure GetFreeShares(MemberAccounts: Record "Savings Accounts"): Decimal
    var
        LoanSecurity: Record "Loan Security";
        DepAmt: Decimal;
        GuaranteedInApplication: Decimal;
        Committed: Decimal;
        Available: Decimal;
        FreeShares: Decimal;
    begin
        FreeShares := 0;

        LoanSecurity.CalculateAvailableShares(MemberAccounts, DepAmt, GuaranteedInApplication, Committed, Available, false);
        DepAmt := MemberActivities.GetAccountBalance(MemberAccounts."No.");
        FreeShares := DepAmt - Committed;
        exit(FreeShares);
    end;

    procedure GetAmounts()
    var
        Security: Record "Loan Security";
        OffsetLines: Record "Loans Offet List";
        Loans: Record Loans;
        Legacy: Codeunit Legacy;
        MActivities: Codeunit "Member Activities";
        SelfGuaranteeAmt: Decimal;
        ThirdPartyCommitted: Decimal;
        SelfCommitted: Decimal;
        FreeShares: Decimal;
        EffectiveAvailable: Decimal;
        RemainingLoanBalance: Decimal;
        GuarantorAvailableBal: Decimal;
        TotalGuarantorshipLessLonee: Decimal;
    begin
        InitializeAmounts();

        if "Recovery Option" = "Recovery Option"::"Recover from Single Account" then
            "Total Available" := MActivities.GetAccountBalance("Source Account")
        else
            "Total Available" := Legacy.GetProductsToOffsetAccountBalance("Member No.");

        "Share Capital" := MActivities.GetAccountBalance(Legacy.GetShareCapitalAccount("Member No."));
        "Dividend Balance" := MActivities.GetAccountBalance(Legacy.GetDividendAccount("Member No."));

        // Third-party commitments reduce what is freely available.
        // Self-guarantees are tracked separately because recovering your own loan
        // from your own committed shares is valid — they should not reduce FreeShares.
        Security.Reset();
        Security.SetRange("Member No", "Member No.");
        Security.SetFilter("Guarantor Type", '%1|%2',
            Security."guarantor type"::Guarantor,
            Security."guarantor type"::Lien);
        Security.SetRange(Substituted, false);
        if Security.FindSet() then
            repeat
                if Security."Self Guarantee" then
                    SelfCommitted += Security."Current Committed"
                else
                    ThirdPartyCommitted += Security."Current Committed";
            until Security.Next() = 0;

        "Committed Deposits" := ThirdPartyCommitted;


        MemberAccounts.Get(Legacy.GetDepositAccounts("Member No."));
        FreeShares := GetFreeShares(MemberAccounts);

        FreeShares := MaxDec("Total Available" - ThirdPartyCommitted, 0);
        "Total Available" := FreeShares;
        EffectiveAvailable := MinDec(FreeShares + SelfCommitted, "Total Available");


        ClearExistingLines();
        BuildOffsetLines(FreeShares, EffectiveAvailable);

        OffsetLines.Reset();
        OffsetLines.SetRange("Header No.", "No.");
        if not OffsetLines.FindSet() then
            exit;

        repeat
            OffsetLines.Validate("Loan No");
            OffsetLines.Modify();

            Loans.Get(OffsetLines."Loan No");
            Loans.CalcFields("Outstanding Interest", "Outstanding Principal",
                             "Outstanding Insurance", "Outstanding Penalty",
                             "Total Outstanding Balance");

            "Outstanding Principal" += Loans."Outstanding Principal";
            "Outstanding Interest" += Loans."Outstanding Interest";
            "Outstanding Insurance" += Loans."Outstanding Insurance";
            "Outstanding Penalty" += Loans."Outstanding Penalty";

            SetSelfGuaranteedFlag(OffsetLines, Loans."Loan No.");

            if OffsetLines."Recover From Guarantors" then begin
                SelfGuaranteeAmt := GetSelfGuaranteeAmt(Loans."Loan No.");
                "Self Guaranteed" += SelfGuaranteeAmt;
                RemainingLoanBalance := MaxDec(Loans."Total Outstanding Balance"
                                            - OffsetLines."Deposit Allocation Amount", 0);

                Security.Reset();
                Security.SetRange("Loan No.", Loans."Loan No.");
                Security.SetFilter("Guarantor Type", '%1|%2',
                    Security."guarantor type"::Guarantor,
                    Security."guarantor type"::Lien);
                Security.SetRange("Self Guarantee", false);
                Security.SetRange(Substituted, false);
                if Security.FindSet() then begin
                    Security.CalcSums("Amount Guaranteed");
                    TotalGuarantorshipLessLonee := Security."Amount Guaranteed";
                end;

                Security.Reset();
                Security.SetRange("Loan No.", Loans."Loan No.");
                Security.SetFilter("Guarantor Type", '%1|%2',
                    Security."guarantor type"::Guarantor,
                    Security."guarantor type"::Lien);
                Security.SetRange("Self Guarantee", false);
                Security.SetRange(Substituted, false);
                if Security.FindSet() then
                    repeat
                        Security.CalcFields("Total Loan Guarantorship");

                        RecoveryLines.Init();
                        RecoveryLines."Loan No." := Loans."Loan No.";
                        RecoveryLines."Header No." := "No.";
                        RecoveryLines."Outstanding Penalty" := Loans."Outstanding Penalty";
                        RecoveryLines."Guarantor Member No." := Security."Member No";
                        RecoveryLines."Guarantor Name" := Security.Name;

                        AssignGuarantorAccount(Security);

                        RecoveryLines."Amount Guaranteed" := Security."Amount Guaranteed";
                        GetSavingsBalances(Members."No.",
                            RecoveryLines."Withdrawable Savings",
                            RecoveryLines."Non-Withdrable Savings",
                            RecoveryLines."Committed Deposits");

                        // Proportional share of what remains after the defaulter's own deposit is applied.
                        // Denominator excludes the self-guarantee so guarantors' shares are not diluted.
                        /* if (Security."Total Loan Guarantorship" - SelfGuaranteeAmt) > 0 then
                            RecoveryLines."Loan Allocation" := Round(
                                Security."Amount Guaranteed" /
                                (Security."Total Loan Guarantorship" - SelfGuaranteeAmt) *
                                RemainingLoanBalance, 0.01, '>')
                        else
                            RecoveryLines."Loan Allocation" := 0; */
                        if (TotalGuarantorshipLessLonee) > 0 then
                            RecoveryLines."Loan Allocation" := Round(
                                Security."Amount Guaranteed" /
                                (TotalGuarantorshipLessLonee) *
                                RemainingLoanBalance, 0.01, '>')
                        else
                            RecoveryLines."Loan Allocation" := 0;

                        // A guarantor can never be asked beyond what they contractually guaranteed.
                        if RecoveryLines."Loan Allocation" > Security."Amount Guaranteed" then
                            RecoveryLines."Loan Allocation" := Security."Amount Guaranteed";

                        // Cannot recover funds the guarantor does not actually hold.
                        if "Recovery Source" = "Recovery Source"::"Defaulter Non-Withdrawable Deposits" then
                            GuarantorAvailableBal := RecoveryLines."Non-Withdrable Savings"
                        else begin
                            if "Recovery Source" = "Recovery Source"::"Recover & Issue Guarantor Defaulter Loan" then
                                GuarantorAvailableBal := RecoveryLines."Non-Withdrable Savings"
                            else
                                GuarantorAvailableBal := RecoveryLines."Withdrawable Savings";
                        end;

                        if RecoveryLines."Loan Allocation" > GuarantorAvailableBal then
                            RecoveryLines."Loan Allocation" := GuarantorAvailableBal;

                        RecoveryLines."Amount to Recover" := RecoveryLines."Loan Allocation";

                        RecoveryLines."Recovery Method" := RecoveryLines."Recovery Method"::Loan;
                        
                        if RecoveryLines."Amount to Recover" > 0 then
                            RecoveryLines.Insert();

                    until Security.Next() = 0;
            end;

        until OffsetLines.Next() = 0;

        if Rec."Amount to Recover" > 0 then
            "Deposit Balance" := MaxDec(EffectiveAvailable - Rec."Amount to Recover", 0)
        else
            "Deposit Balance" := MaxDec(EffectiveAvailable - "Outstanding Principal"
                                      - "Outstanding Interest" - "Share Capital Top Up", 0);
    end;

    procedure InitializeAmounts()
    begin
        "Member Deposits" := 0;
        "Member Savings" := 0;
        "Outstanding Principal" := 0;
        "Outstanding Appraisal" := 0;
        "Outstanding Interest" := 0;
        "Outstanding Penalty" := 0;
        "Outstanding Insurance" := 0;
        "Total Available" := 0;
        "Committed Deposits" := 0;
        "Deposit Balance" := 0;
        "Share Capital Top Up" := 0;
        "Self Guaranteed" := 0;
        "Total Deduction" := 0;
    end;

    procedure ClearExistingLines()
    begin
        RecoveryLines.Reset();
        RecoveryLines.SetRange("Header No.", "No.");
        if RecoveryLines.FindSet() then
            RecoveryLines.DeleteAll();

        OffsetLines.Reset();
        OffsetLines.SetRange("Header No.", "No.");
        if OffsetLines.FindSet() then
            OffsetLines.DeleteAll();
    end;

    procedure BuildOffsetLines(FreeShares: Decimal; EffectiveAvailable: Decimal)
    var
        OffsetLines: Record "Loans Offet List";
        Loans: Record Loans;
        Security: Record "Loan Security";
        AllocationPool: Decimal;
    begin
        OffsetLines.Reset();
        OffsetLines.SetRange("Header No.", "No.");
        if OffsetLines.FindFirst() then
            exit; // Lines already exist — nothing to build

        // First pass: total outstanding used as denominator for proportional split
        Loans.Reset();
        Loans.SetRange("Member No.", "Member No.");
        if "Recovery Type" = "Recovery Type"::"Single Loan" then
            Loans.SetRange("Loan No.", Rec."Loan No.");
        Loans.SetFilter("Total Outstanding Balance", '>0');
        Loans.SetAutoCalcFields("Outstanding Interest", "Outstanding Principal", "Total Outstanding Balance");
        if Loans.FindSet() then
            repeat
                "Total Deduction" += Loans."Total Outstanding Balance";
            until Loans.Next() = 0;

        // Second pass: create one offset line per loan
        Loans.Reset();
        Loans.SetRange("Member No.", "Member No.");
        if "Recovery Type" = "Recovery Type"::"Single Loan" then
            Loans.SetRange("Loan No.", Rec."Loan No.");
        Loans.SetFilter("Total Outstanding Balance", '>0');
        Loans.SetAutoCalcFields("Outstanding Interest", "Outstanding Principal", "Total Outstanding Balance");
        if not Loans.FindSet() then
            exit;

        repeat
            // Self-guaranteed loans draw from EffectiveAvailable so the full outstanding
            // is reachable. Third-party guaranteed loans are limited to FreeShares to
            // protect funds already committed to other guarantors.
            Security.Reset();
            Security.SetRange("Loan No.", Loans."Loan No.");
            Security.SetRange("Member No", "Member No.");
            Security.SetRange("Self Guarantee", true);
            Security.SetRange(Substituted, false);
            Security.SetFilter("Guarantor Type", '%1|%2',
                Security."guarantor type"::Guarantor,
                Security."guarantor type"::Lien);

            AllocationPool := FreeShares;
            if Security.FindFirst() then
                AllocationPool := EffectiveAvailable;

            OffsetLines.Init();
            OffsetLines."Header No." := "No.";
            OffsetLines."Member No" := "Member No.";
            OffsetLines.Validate("Loan No", Loans."Loan No.");

            if "Recovery Type" = "Recovery Type"::"Single Loan" then begin
                if "Amount to Recover" > 0 then
                    OffsetLines."Deposit Allocation Amount" := "Amount to Recover"
                else
                    OffsetLines."Deposit Allocation Amount" := AllocationPool;
            end else begin
                if "Total Deduction" > 0 then
                    OffsetLines."Deposit Allocation Amount" :=
                        Round((Loans."Total Outstanding Balance" / "Total Deduction")
                            * AllocationPool, 0.01)
                else
                    OffsetLines."Deposit Allocation Amount" := 0;
            end;

            if OffsetLines."Deposit Allocation Amount" > Loans."Total Outstanding Balance" then
                OffsetLines."Deposit Allocation Amount" := Loans."Total Outstanding Balance";

            OffsetLines."Amount to Recover" := OffsetLines."Deposit Allocation Amount";
            OffsetLines.Insert(true);
        until Loans.Next() = 0;
    end;

    procedure SetSelfGuaranteedFlag(var OffsetLines: Record "Loans Offet List"; LoanNo: Code[20])
    var
        Security: Record "Loan Security";
        IsNonWithdrawable: Boolean;
    begin
        IsNonWithdrawable :=
            "Recovery Source" = "Recovery Source"::"Defaulter Non-Withdrawable Deposits";

        Security.Reset();
        Security.SetRange("Loan No.", LoanNo);
        Security.SetFilter("Guarantor Type", '%1|%2',
            Security."guarantor type"::Guarantor,
            Security."guarantor type"::Lien);

        // No guarantors at all — treat as fully self-guaranteed
        if not Security.FindFirst() then begin
            if IsNonWithdrawable then
                OffsetLines."Recover From Guarantors" := false
            else
                OffsetLines."Self Guaranteed" := true;
            OffsetLines.Modify();
            exit;
        end;

        Security.SetRange("Self Guarantee", true);
        Security.SetRange(Substituted, false);
        if Security.FindFirst() then begin
            if IsNonWithdrawable then
                OffsetLines."Recover From Guarantors" := false
            else
                OffsetLines."Self Guaranteed" := true;
            OffsetLines.Modify();
        end;
    end;

    procedure GetSelfGuaranteeAmt(LoanNo: Code[20]): Decimal
    var
        Security: Record "Loan Security";
    begin
        Security.Reset();
        Security.SetRange("Loan No.", LoanNo);
        Security.SetFilter("Guarantor Type", '%1|%2',
            Security."guarantor type"::Guarantor,
            Security."guarantor type"::Lien);
        Security.SetRange("Self Guarantee", true);
        Security.SetRange(Substituted, false);
        Security.SetLoadFields("Current Committed");
        if Security.FindFirst() then
            exit(Security."Current Committed");
        exit(0);
    end;

    procedure AssignGuarantorAccount(Security: Record "Loan Security")
    begin
        Members.Get(Security."Member No");

        MemberAccounts.Reset();
        MemberAccounts.SetRange("Product Category",
            MemberAccounts."product category"::"Deposit Contribution");
        MemberAccounts.SetRange("Member No.", Members."No.");
        if MemberAccounts.FindFirst() then begin
            if Security."Guarantor Type" = Security."guarantor type"::Lien then
                RecoveryLines."Guarantor Savings Account" := Security."Account No."
            else
                RecoveryLines."Guarantor Savings Account" := MemberAccounts."No.";
            exit;
        end;

        // Fallback when member has no Deposit Contribution account
        MemberAccounts.Reset();
        MemberAccounts.SetRange("Product Category",
            MemberAccounts."product category"::"MFI Deposit");
        MemberAccounts.SetRange("Member No.", Members."No.");
        if MemberAccounts.FindFirst() then
            RecoveryLines."Guarantor Savings Account" := MemberAccounts."No.";
    end;

    procedure MaxDec(A: Decimal; B: Decimal): Decimal
    begin
        if A > B then exit(A);
        exit(B);
    end;

    procedure MinDec(A: Decimal; B: Decimal): Decimal
    begin
        if A < B then exit(A);
        exit(B);
    end;

    local procedure GetSavingsBalances(MNo: Code[20]; var Withdrawable: Decimal; var NonWithdrawable: Decimal; var "Committed Deposits": Decimal)
    var
        ProductSetup: Record "Product Setup";
    begin

        Withdrawable := 0;
        NonWithdrawable := 0;

        MemberAccounts.Reset;
        MemberAccounts.SetRange("Member No.", MNo);
        if MemberAccounts.FindFirst then begin
            repeat
                if ProductSetup.Get(MemberAccounts."Product Type") then begin
                    if ProductSetup."Can Offset Loan" then begin
                        if ProductSetup."Savings Type" = ProductSetup."savings type"::"Non-Withdrawable" then
                            NonWithdrawable += MemberActivities.GetAccountBalance(MemberAccounts."No.");
                        if ProductSetup."Savings Type" = ProductSetup."savings type"::Withdrawable then
                            Withdrawable += MemberActivities.GetAccountBalance(MemberAccounts."No.");
                    end;

                    "Committed Deposits" += MemberActivities.GetMemberCommittedDeposits(MemberAccounts."No.", true);
                    "Committed Deposits" += MemberActivities.GetMemberCommittedDeposits(MemberAccounts."No.", false);
                end;
            until MemberAccounts.Next = 0;
        end;
    end;

    procedure RecoverCombined(Post: Boolean)
    var
        sAcctivities: Codeunit "Sacco Activities";
        TotalRecovered: Decimal;
        AvailableDeposits: Decimal;
        DedAmt: Decimal;
        ProductSetup: Record "Product Setup";
        AcctType: Enum "Gen. Journal Account Type";
        BalAcctType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        LBal: Decimal;
        LoanAllocation: Decimal;
        LGurantors: Record "Loan Security";
        RunBal: Decimal;
        LRec: Record Loans;
        JTemplate: Code[20];
        JBatch: Code[20];
        TChannel: Enum "Transaction Channel";
    begin

        UserSetup.Get(UserId);

        JTemplate := UserSetup."General Journal Template";
        JBatch := UserSetup."General Journal Batch";

        sAcctivities.JournalInit(JTemplate, JBatch);


        //-----------------------------------Withdrawable
        TotalRecovered := 0;
        ProductSetup.Reset();
        ProductSetup.SetRange("Product Class", ProductSetup."Product Class"::Savings);
        ProductSetup.SetRange("Savings Type", ProductSetup."Savings Type"::"Withdrawable");
        ProductSetup.SetRange("Can Offset Loan", true);
        if ProductSetup.FindFirst() then begin
            repeat
                MemberAccounts.Reset;
                MemberAccounts.SetRange("Member No.", "Member No.");
                MemberAccounts.SetRange("Product Type", ProductSetup."Product ID");
                if MemberAccounts.FindFirst then begin
                    repeat
                        TotalRecovered := 0;
                        AvailableDeposits := MemberActivities.GetAccountBalance(MemberAccounts."No.");
                        AvailableDeposits -= MemberActivities.GetMemberCommittedDeposits(MemberAccounts."No.", true);
                        AvailableDeposits -= MemberActivities.GetMemberCommittedDeposits(MemberAccounts."No.", false);
                        AvailableDeposits -= sAcctivities.GetJournalDebits(JTemplate, JBatch, AcctType::Savings, MemberAccounts."No.");


                        if AvailableDeposits > 0 then begin

                            Loans.RESET;
                            Loans.SETRANGE(Loans."Member No.", "Member No.");
                            Loans.SetFilter(loans."Outstanding Principal", '>0');
                            Loans.SetFilter(loans."Outstanding Interest", '>0');
                            IF Loans.FIND('-') THEN BEGIN
                                TotalRecovered := 0;
                                REPEAT
                                    if AvailableDeposits > 0 then begin

                                        Loans.CALCFIELDS(Loans."OuTstanding Interest");
                                        Loans."Outstanding Interest" -= sAcctivities.GetJournalLoanCredits(JTemplate, JBatch, AcctType::Credit, Loans."Member No.", Loans."Loan No.", TransType::"Interest Paid");

                                        IF Loans."OuTstanding Interest" > 0 THEN BEGIN

                                            DedAmt := Loans."Outstanding Interest";
                                            if DedAmt > AvailableDeposits then
                                                DedAmt := AvailableDeposits;

                                            IF DedAmt > 0 THEN BEGIN
                                                sAcctivities.JournalInsert(JTemplate, JBatch, "No.", "Posting Date", AcctType::Credit, Loans."Member No.", CopyStr('Defaulter Interest Recovery From ' + ProductSetup.Description, 1, 50),
                                                BalAcctType::"G/L Account", '', -DedAmt, Loans."Loan No.", Loans."Loan No.", TransType::"Interest Paid", Loans."Global Dimension 1 Code", Loans."Booking Branch", true, TChannel::Recovery, "Dimension Set ID");

                                                TotalRecovered := TotalRecovered + DedAmt;
                                                AvailableDeposits := AvailableDeposits - DedAmt;
                                            END;
                                        END;
                                    end;
                                UNTIL Loans.NEXT = 0;
                                if TotalRecovered > 0 then begin
                                    sAcctivities.JournalInsert(JTemplate, JBatch, "No.", "Posting Date", AcctType::Savings, MemberAccounts."No.", CopyStr('Defaulter Interest Recovery', 1, 50),
                                    BalAcctType::"G/L Account", '', TotalRecovered, Loans."Loan No.", Loans."Loan No.", TransType::"Interest Paid", Loans."Global Dimension 1 Code", Loans."Booking Branch", true, TChannel::Recovery, "Dimension Set ID");
                                end;
                            END;
                        end;

                        if AvailableDeposits > 0 then begin
                            Loans.RESET;
                            Loans.SETRANGE(Loans."Member No.", "Member No.");
                            Loans.SetFilter(loans."Outstanding Principal", '>0');
                            Loans.SetFilter(loans."Outstanding Penalty", '>0');
                            IF Loans.FIND('-') THEN BEGIN
                                TotalRecovered := 0;
                                REPEAT
                                    if AvailableDeposits > 0 then begin

                                        Loans.CALCFIELDS(Loans."OuTstanding Penalty");
                                        Loans."Outstanding Penalty" -= sAcctivities.GetJournalLoanCredits(JTemplate, JBatch, AcctType::Credit, Loans."Member No.", Loans."Loan No.", TransType::"Penalty Paid");

                                        IF Loans."OuTstanding Penalty" > 0 THEN BEGIN

                                            DedAmt := Loans."Outstanding Penalty";
                                            if DedAmt > AvailableDeposits then
                                                DedAmt := AvailableDeposits;

                                            IF DedAmt > 0 THEN BEGIN
                                                sAcctivities.JournalInsert(JTemplate, JBatch, "No.", "Posting Date", AcctType::Credit, Loans."Member No.", CopyStr('Defaulter Penalty Recovery From ' + ProductSetup.Description, 1, 50),
                                                BalAcctType::"G/L Account", '', -DedAmt, Loans."Loan No.", Loans."Loan No.", TransType::"Penalty Paid", Loans."Global Dimension 1 Code", Loans."Booking Branch", true, TChannel::Recovery, "Dimension Set ID");

                                                TotalRecovered := TotalRecovered + DedAmt;
                                                AvailableDeposits := AvailableDeposits - DedAmt;
                                            END;
                                        END;
                                    end;
                                UNTIL Loans.NEXT = 0;
                                if TotalRecovered > 0 then begin
                                    sAcctivities.JournalInsert(JTemplate, JBatch, "No.", "Posting Date", AcctType::Savings, MemberAccounts."No.", CopyStr('Defaulter Penalty Recovery', 1, 50),
                                    BalAcctType::"G/L Account", '', TotalRecovered, Loans."Loan No.", Loans."Loan No.", TransType::"Penalty Paid", Loans."Global Dimension 1 Code", Loans."Booking Branch", true, TChannel::Recovery, "Dimension Set ID");
                                end;
                            END;
                        end;



                        if AvailableDeposits > 0 then begin
                            Loans.RESET;
                            Loans.SETRANGE(Loans."Member No.", "Member No.");
                            Loans.SetFilter(loans."Outstanding Principal", '>0');
                            IF Loans.FIND('-') THEN BEGIN
                                TotalRecovered := 0;
                                REPEAT
                                    if AvailableDeposits > 0 then begin

                                        Loans.CALCFIELDS(Loans."OuTstanding Principal");
                                        Loans."Outstanding Principal" -= sAcctivities.GetJournalLoanCredits(JTemplate, JBatch, AcctType::Credit, Loans."Member No.", Loans."Loan No.", TransType::"Principal Repayment");

                                        IF Loans."OuTstanding Penalty" > 0 THEN BEGIN

                                            DedAmt := Loans."Outstanding Penalty";
                                            if DedAmt > AvailableDeposits then
                                                DedAmt := AvailableDeposits;

                                            IF DedAmt > 0 THEN BEGIN
                                                sAcctivities.JournalInsert(JTemplate, JBatch, "No.", "Posting Date", AcctType::Credit, Loans."Member No.", CopyStr('Defaulter Penalty Recovery From ' + ProductSetup.Description, 1, 50),
                                                BalAcctType::"G/L Account", '', -DedAmt, Loans."Loan No.", Loans."Loan No.", TransType::"Principal Repayment", Loans."Global Dimension 1 Code", Loans."Booking Branch", true, TChannel::Recovery, "Dimension Set ID");

                                                TotalRecovered := TotalRecovered + DedAmt;
                                                AvailableDeposits := AvailableDeposits - DedAmt;
                                            END;
                                        END;
                                    end;
                                UNTIL Loans.NEXT = 0;
                                if TotalRecovered > 0 then begin
                                    sAcctivities.JournalInsert(JTemplate, JBatch, "No.", "Posting Date", AcctType::Savings, MemberAccounts."No.", CopyStr('Defaulter Principal Recovery', 1, 50),
                                    BalAcctType::"G/L Account", '', TotalRecovered, Loans."Loan No.", Loans."Loan No.", TransType::"Principal Repayment", Loans."Global Dimension 1 Code", Loans."Booking Branch", true, TChannel::Recovery, "Dimension Set ID");
                                end;
                            END;
                        end;
                    until MemberAccounts.Next = 0;
                end;
            until ProductSetup.Next() = 0;
        end;


        //-----------------------------------Non-Withdrawable
        TotalRecovered := 0;
        ProductSetup.Reset();
        ProductSetup.SetRange("Product Class", ProductSetup."Product Class"::Savings);
        ProductSetup.SetRange("Savings Type", ProductSetup."Savings Type"::"NOn-Withdrawable");
        ProductSetup.SetRange("Can Offset Loan", true);
        if ProductSetup.FindFirst() then begin
            repeat
                MemberAccounts.Reset;
                MemberAccounts.SetRange("Member No.", "Member No.");
                MemberAccounts.SetRange("Product Type", ProductSetup."Product ID");
                if MemberAccounts.FindFirst then begin
                    repeat
                        TotalRecovered := 0;
                        AvailableDeposits := MemberActivities.GetAccountBalance(MemberAccounts."No.");
                        AvailableDeposits -= MemberActivities.GetMemberCommittedDeposits(MemberAccounts."No.", true);
                        AvailableDeposits -= MemberActivities.GetMemberCommittedDeposits(MemberAccounts."No.", false);
                        AvailableDeposits -= sAcctivities.GetJournalDebits(JTemplate, JBatch, AcctType::Savings, MemberAccounts."No.");


                        if AvailableDeposits > 0 then begin
                            Loans.RESET;
                            Loans.SETRANGE(Loans."Member No.", "Member No.");
                            Loans.SetFilter(loans."Outstanding Principal", '>0');
                            Loans.SetFilter(loans."Outstanding Interest", '>0');
                            IF Loans.FIND('-') THEN BEGIN
                                TotalRecovered := 0;
                                REPEAT
                                    if AvailableDeposits > 0 then begin

                                        Loans.CALCFIELDS(Loans."OuTstanding Interest");
                                        Loans."Outstanding Interest" -= sAcctivities.GetJournalLoanCredits(JTemplate, JBatch, AcctType::Credit, Loans."Member No.", Loans."Loan No.", TransType::"Interest Paid");

                                        IF Loans."OuTstanding Interest" > 0 THEN BEGIN

                                            DedAmt := Loans."Outstanding Interest";
                                            if DedAmt > AvailableDeposits then
                                                DedAmt := AvailableDeposits;

                                            IF DedAmt > 0 THEN BEGIN
                                                sAcctivities.JournalInsert(JTemplate, JBatch, "No.", "Posting Date", AcctType::Credit, Loans."Member No.", CopyStr('Defaulter Interest Recovery From ' + ProductSetup.Description, 1, 50),
                                                BalAcctType::"G/L Account", '', -DedAmt, Loans."Loan No.", Loans."Loan No.", TransType::"Interest Paid", Loans."Global Dimension 1 Code", Loans."Booking Branch", true, TChannel::Recovery, "Dimension Set ID");

                                                TotalRecovered := TotalRecovered + DedAmt;
                                                AvailableDeposits := AvailableDeposits - DedAmt;
                                            END;
                                        END;
                                    end;
                                UNTIL Loans.NEXT = 0;
                                if TotalRecovered > 0 then begin
                                    sAcctivities.JournalInsert(JTemplate, JBatch, "No.", "Posting Date", AcctType::Savings, MemberAccounts."No.", CopyStr('Defaulter Interest Recovery', 1, 50),
                                    BalAcctType::"G/L Account", '', TotalRecovered, Loans."Loan No.", Loans."Loan No.", TransType::"Interest Paid", Loans."Global Dimension 1 Code", Loans."Booking Branch", true, TChannel::Recovery, "Dimension Set ID");
                                end;
                            END;
                        end;

                        if AvailableDeposits > 0 then begin
                            Loans.RESET;
                            Loans.SETRANGE(Loans."Member No.", "Member No.");
                            Loans.SetFilter(loans."Outstanding Principal", '>0');
                            Loans.SetFilter(loans."Outstanding Penalty", '>0');
                            IF Loans.FIND('-') THEN BEGIN
                                TotalRecovered := 0;
                                REPEAT
                                    if AvailableDeposits > 0 then begin

                                        Loans.CALCFIELDS(Loans."OuTstanding Penalty");
                                        Loans."Outstanding Penalty" -= sAcctivities.GetJournalLoanCredits(JTemplate, JBatch, AcctType::Credit, Loans."Member No.", Loans."Loan No.", TransType::"Penalty Paid");

                                        IF Loans."OuTstanding Penalty" > 0 THEN BEGIN

                                            DedAmt := Loans."Outstanding Penalty";
                                            if DedAmt > AvailableDeposits then
                                                DedAmt := AvailableDeposits;

                                            IF DedAmt > 0 THEN BEGIN
                                                sAcctivities.JournalInsert(JTemplate, JBatch, "No.", "Posting Date", AcctType::Credit, Loans."Member No.", CopyStr('Defaulter Penalty Recovery From ' + ProductSetup.Description, 1, 50),
                                                BalAcctType::"G/L Account", '', -DedAmt, Loans."Loan No.", Loans."Loan No.", TransType::"Penalty Paid", Loans."Global Dimension 1 Code", Loans."Booking Branch", true, TChannel::Recovery, "Dimension Set ID");

                                                TotalRecovered := TotalRecovered + DedAmt;
                                                AvailableDeposits := AvailableDeposits - DedAmt;
                                            END;
                                        END;
                                    end;
                                UNTIL Loans.NEXT = 0;
                                if TotalRecovered > 0 then begin
                                    sAcctivities.JournalInsert(JTemplate, JBatch, "No.", "Posting Date", AcctType::Savings, MemberAccounts."No.", CopyStr('Defaulter Penalty Recovery', 1, 50),
                                    BalAcctType::"G/L Account", '', TotalRecovered, Loans."Loan No.", Loans."Loan No.", TransType::"Penalty Paid", Loans."Global Dimension 1 Code", Loans."Booking Branch", true, TChannel::Recovery, "Dimension Set ID");
                                end;
                            END;
                        end;



                        if AvailableDeposits > 0 then begin
                            Loans.RESET;
                            Loans.SETRANGE(Loans."Member No.", "Member No.");
                            Loans.SetFilter(loans."Outstanding Principal", '>0');
                            IF Loans.FIND('-') THEN BEGIN
                                TotalRecovered := 0;
                                REPEAT
                                    if AvailableDeposits > 0 then begin

                                        Loans.CALCFIELDS(Loans."OuTstanding Principal");
                                        Loans."Outstanding Principal" -= sAcctivities.GetJournalLoanCredits(JTemplate, JBatch, AcctType::Credit, Loans."Member No.", Loans."Loan No.", TransType::"Principal Repayment");

                                        IF Loans."OuTstanding Penalty" > 0 THEN BEGIN

                                            DedAmt := Loans."Outstanding Penalty";
                                            if DedAmt > AvailableDeposits then
                                                DedAmt := AvailableDeposits;

                                            IF DedAmt > 0 THEN BEGIN
                                                sAcctivities.JournalInsert(JTemplate, JBatch, "No.", "Posting Date", AcctType::Credit, Loans."Member No.", CopyStr('Defaulter Penalty Recovery From ' + ProductSetup.Description, 1, 50),
                                                BalAcctType::"G/L Account", '', -DedAmt, Loans."Loan No.", Loans."Loan No.", TransType::"Principal Repayment", Loans."Global Dimension 1 Code", Loans."Booking Branch", true, TChannel::Recovery, "Dimension Set ID");

                                                TotalRecovered := TotalRecovered + DedAmt;
                                                AvailableDeposits := AvailableDeposits - DedAmt;
                                            END;
                                        END;
                                    end;
                                UNTIL Loans.NEXT = 0;
                                if TotalRecovered > 0 then begin
                                    sAcctivities.JournalInsert(JTemplate, JBatch, "No.", "Posting Date", AcctType::Savings, MemberAccounts."No.", CopyStr('Defaulter Principal Recovery', 1, 50),
                                    BalAcctType::"G/L Account", '', TotalRecovered, Loans."Loan No.", Loans."Loan No.", TransType::"Principal Repayment", Loans."Global Dimension 1 Code", Loans."Booking Branch", true, TChannel::Recovery, "Dimension Set ID");
                                end;
                            END;
                        end;
                    until MemberAccounts.Next = 0;
                end;
            until ProductSetup.Next() = 0;
        end;



        Loans.RESET;
        Loans.SETRANGE(Loans."Member No.", "Member No.");
        Loans.SetFilter("Outstanding Principal", '>0');
        Loans.SetFilter("Total Guarantor Count", '>0');
        IF Loans.FIND('-') THEN BEGIN
            REPEAT

                Loans.CALCFIELDS(Loans."Outstanding Principal", Loans."Outstanding Interest", Loans."Outstanding Penalty");
                Loans."Outstanding Interest" -= sAcctivities.GetJournalLoanCredits(JTemplate, JBatch, AcctType::Credit, Loans."Member No.", Loans."Loan No.", TransType::"Interest Paid");
                Loans."Outstanding Penalty" -= sAcctivities.GetJournalLoanCredits(JTemplate, JBatch, AcctType::Credit, Loans."Member No.", Loans."Loan No.", TransType::"Penalty Paid");
                Loans."Outstanding Principal" -= sAcctivities.GetJournalLoanCredits(JTemplate, JBatch, AcctType::Credit, Loans."Member No.", Loans."Loan No.", TransType::"Principal Repayment");
                LBal := Loans."Outstanding Interest" + Loans."Outstanding Penalty" + Loans."Outstanding Principal";


                if LBal > 0 then begin
                    //No Shares recovery
                    //Loans."Recovered Balance" := LBal;
                    //Loans."Guarantor Amount" := LBal;
                    Loans.MODIFY;

                    LGurantors.RESET;
                    LGurantors.SETRANGE(LGurantors."Loan No.", Loans."Loan No.");
                    LGurantors.SETRANGE(LGurantors.Substituted, FALSE);
                    LGurantors.SetRange("Guarantor Type", LGurantors."Guarantor Type"::Guarantor);
                    IF LGurantors.FIND('-') THEN BEGIN
                        REPEAT
                            DedAmt := 0;
                            LGurantors.calcfields("Total Loan Guarantorship");
                            if LGurantors."Total Loan Guarantorship" > 0 then
                                DedAmt := Round(LGurantors."Amount Guaranteed" / LGurantors."Total Loan Guarantorship" * LBal); //

                            MemberAccounts.Reset();
                            MemberAccounts.SetRange("No.", LGurantors."Account No.");
                            MemberAccounts.SetFilter("Balance (LCY)", '>0');
                            if DedAmt > 0 then
                                if MemberAccounts.FindFirst() then begin

                                    AvailableDeposits := MemberActivities.GetAccountBalance(MemberAccounts."No.");
                                    AvailableDeposits -= sAcctivities.GetJournalDebits(JTemplate, JBatch, AcctType::Savings, MemberAccounts."No.");
                                    if AvailableDeposits > 0 then begin
                                        if DedAmt > AvailableDeposits then
                                            DedAmt := AvailableDeposits;


                                        RunBal := DedAmt;
                                        TotalRecovered := 0;
                                        If RunBal > 0 then begin
                                            IF Loans."OuTstanding Interest" > 0 THEN BEGIN
                                                DedAmt := Loans."Outstanding Interest";
                                                if DedAmt > RunBal then
                                                    DedAmt := RunBal;

                                                IF DedAmt > 0 THEN BEGIN
                                                    sAcctivities.JournalInsert(JTemplate, JBatch, "No.", "Posting Date", AcctType::Credit, Loans."Member No.", CopyStr('Guarantor Interest Recovery From ' + MemberAccounts.Name, 1, 50),
                                                    BalAcctType::"G/L Account", '', -DedAmt, Loans."Loan No.", Loans."Loan No.", TransType::"Interest Paid", Loans."Global Dimension 1 Code", Loans."Booking Branch", true, TChannel::Recovery, "Dimension Set ID");

                                                    TotalRecovered := TotalRecovered + DedAmt;
                                                    RunBal := RunBal - DedAmt;
                                                END;
                                            END;
                                        end;

                                        If RunBal > 0 then begin
                                            IF Loans."OuTstanding Penalty" > 0 THEN BEGIN
                                                DedAmt := Loans."Outstanding Penalty";
                                                if DedAmt > RunBal then
                                                    DedAmt := RunBal;

                                                IF DedAmt > 0 THEN BEGIN
                                                    sAcctivities.JournalInsert(JTemplate, JBatch, "No.", "Posting Date", AcctType::Credit, Loans."Member No.", CopyStr('Guarantor Penalty Recovery From ' + MemberAccounts.Name, 1, 50),
                                                    BalAcctType::"G/L Account", '', -DedAmt, Loans."Loan No.", Loans."Loan No.", TransType::"Penalty Paid", Loans."Global Dimension 1 Code", Loans."Booking Branch", true, TChannel::Recovery, "Dimension Set ID");

                                                    TotalRecovered := TotalRecovered + DedAmt;
                                                    RunBal := RunBal - DedAmt;
                                                END;
                                            END;
                                        end;

                                        If RunBal > 0 then begin
                                            IF Loans."Outstanding Principal" > 0 THEN BEGIN
                                                DedAmt := Loans."Outstanding Principal";
                                                if DedAmt > RunBal then
                                                    DedAmt := RunBal;

                                                IF DedAmt > 0 THEN BEGIN
                                                    sAcctivities.JournalInsert(JTemplate, JBatch, "No.", "Posting Date", AcctType::Credit, Loans."Member No.", CopyStr('Guarantor Principal Recovery From ' + MemberAccounts.Name, 1, 50),
                                                    BalAcctType::"G/L Account", '', -DedAmt, Loans."Loan No.", Loans."Loan No.", TransType::"Principal Repayment", Loans."Global Dimension 1 Code", Loans."Booking Branch", true, TChannel::Recovery, "Dimension Set ID");

                                                    TotalRecovered := TotalRecovered + DedAmt;
                                                    RunBal := RunBal - DedAmt;
                                                END;
                                            END;
                                        end;

                                        if TotalRecovered > 0 then begin
                                            sAcctivities.JournalInsert(JTemplate, JBatch, "No.", "Posting Date", AcctType::Savings, MemberAccounts."No.", CopyStr('Guarantor Loan Recovery for ' + Loans."Member Name", 1, 50),
                                            BalAcctType::"G/L Account", '', TotalRecovered, Loans."Loan No.", Loans."Loan No.", TransType::"Interest Paid", Loans."Global Dimension 1 Code", Loans."Booking Branch", true, TChannel::Recovery, "Dimension Set ID");
                                        end;

                                    END;

                                end;

                        until LGurantors.Next() = 0;
                    end;
                END;
            UNTIL Loans.NEXT = 0;
        END;

        if Post then begin
            sAcctivities.JournalPost(JTemplate, JBatch);

            MESSAGE('Loan recovery posted successfully.');
        end;
    end;
}
