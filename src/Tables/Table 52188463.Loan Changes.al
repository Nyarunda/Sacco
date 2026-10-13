Table 50126 "Loan Changes"
{
    DrillDownPageID = "Loan Changes List";
    LookupPageID = "Loan Changes List";

    fields
    {
        field(1; "No."; Code[10])
        {
            Editable = false;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
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

        field(11; "Account Manager"; code[80])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }

        field(12; "New Account Manager"; code[80])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(5900; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(5901; "Interest Calculation Method"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Amortised,Reducing Balance,Straight Line,Reducing Flat';
            OptionMembers = Amortised,"Reducing Balance","Straight Line","Reducing Flat";
        }
        field(5902; "New Interest Calc. Method"; Option)
        {
            DataClassification = ToBeClassified;
            InitValue = "Reducing Balance";
            OptionCaption = 'Amortised,Reducing Balance,Straight Line,Reducing Flat';
            OptionMembers = Amortised,"Reducing Balance","Straight Line","Reducing Flat";
        }
        field(50001; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Members;

            trigger OnValidate()
            begin

                if Members.Get("Member No.") then begin
                    "Member Name" := Members.Name;
                end;


                Validate("Loan No.", '');
                Validate("Type of Change", "type of change"::" ");
                InitFields;
            end;
        }
        field(50002; "Member Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50003; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Loans."Loan No." where("Member No." = field("Member No.")
                                                    /*"Outstanding Principal" = filter(> 0)*/);

            trigger OnValidate()
            var
                SActivities: Codeunit "Sacco Activities";
                ExpectedAmt: Decimal;
                AmtPaid: Decimal;
                DefAmount: Decimal;
                DaysInArrear: Integer;
                ArrearsDate: Date;
                GracePeriod: DateFormula;
            begin

                InitFields;



                if Loans.Get("Loan No.") then begin

                    Loans.CalcFields(Loans."Outstanding Principal", Loans."Outstanding Interest", "Outstanding Insurance", "Outstanding Penalty");

                    "Outstanding Principal" := Loans."Outstanding Principal";
                    "Outstanding Interest" := Loans."Outstanding Interest";
                    "Outstanding Insurance" := Loans."Outstanding Insurance";
                    "Outstanding Penalty" := Loans."Outstanding Penalty";
                    "Total Outstanding" := "Outstanding Principal" + "Outstanding Interest" + "Outstanding Penalty" + "Outstanding Insurance";
                    "New Loan Amount" := "Total Outstanding";
                    "Old Repayment" := Loans.Repayment;
                    "Account No." := Loans."Member No.";
                    "Repay Mode" := Loans."Repay Mode";
                    "Interest Calculation Method" := Loans."Interest Calculation Method";
                    "Original Installments" := Loans.Installments;
                    "Interest Rate" := Loans."Annual Interest %";
                    "Principal Grace Period" := Loans."Principal Grace Period";
                    "Loan Product Type" := Loans."Loan Product Type";
                    "Loan Product Type Name" := Loans."Loan Product Type Name";
                    "Loan Suspended" := Loans."Loan Suspended";
                    "Loan Suspension End Date" := Loans."Loan Suspension Start Date";
                    "Loan Suspension End Date" := Loans."Loan Suspension End Date";
                    "Debt Coll. Date" := Loans."Debt Coll. Date";
                    "Account Manager" := Loans."Loan Officer";
                    //"Current Deposit Contribution" := Loans."Deposit COntribution";
                    GetCurrentDepositFromSchedule();
                    "Insurance Amount" := Loans."Total Insurance";
                    "Deposit Contribution" := Loans."Deposit COntribution";
                    "Interest Currently Stopped" := Loans."Stop Interest Due";
                    "Penalty Currently Stopped" := Loans."Stop Penalty";
                    "Insurance Currently Stopped" := Loans."Stop Insurance";


                    DefAmount := 0;
                    SActivities.GetDefaultedAmount("Loan No.", Today, ExpectedAmt, AmtPaid, DefAmount, DaysInArrear, ArrearsDate, true, GracePeriod);

                    "Debt Coll. Def Amount" := DefAmount + Loans."Outstanding Interest";

                    "Debt Collector" := Loans."Debt Collector";
                    "Debt Collector Name" := Loans."Debt Collector Name";
                    "Debt Collector Type" := Loans."Debt Collector Type";


                    if ProductSetup.Get(Loans."Loan Product Type") then
                        "Maximun Installments" := ProductSetup."Default Installments";

                    UpdateRemainingInstallments();
                end;
            end;
        }
        field(50004; "Outstanding Principal"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50005; "Outstanding Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50006; Processed; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50007; "Remaining Installments"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50008; "New Installments"; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                PastInstallments := 0;

                if "Original Installments" = "Maximun Installments" then begin
                    IF "New Installments" > "Remaining Installments" THEN
                        Message('New Installments cannot Exceed Remaining Installments');
                end
                else begin
                    PastInstallments := "Original Installments" - "Remaining Installments";
                    if "New Installments" > "Maximun Installments" then
                        Error('New Installments cannot Exceed Maximum Installments');
                end;


                GetRepayment;
            end;
        }
        field(50009; Status; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(50010; "Old Repayment"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "New Repayment"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                LoanAmount: Decimal;
                InterestRate: Decimal;
                LBalance: Decimal;
                RunDate: Date;
                InstalNo: Integer;
                TotalMRepay: Decimal;
                LInterest: Decimal;
                LPrincipal: Decimal;
                RepayPeriod: Integer;
                v: Integer;
            begin
                //"Adjusted Repayment" := "New Repayment";


                TestField("Rescheduling Date");
                GetInstallments;

                Loans.Get("Loan No.");
                Loans.CalcFields("Outstanding Principal");
                LBalance := Loans."Outstanding Principal";

                if Loans."Interest Calculation Method" = Loans."interest calculation method"::Amortised then begin
                    Loans.TestField(Loans."Annual Interest %");

                    TotalMRepay := "New Repayment";
                    LInterest := ROUND(LBalance / 1200 * InterestRate, 0.0001, '>');
                    LPrincipal := TotalMRepay - LInterest;


                end;

                if Loans."Interest Calculation Method" = Loans."interest calculation method"::"Straight Line" then begin
                    Loans.TestField(Loans."Annual Interest %");
                    TestField("New Installments");
                    LPrincipal := LoanAmount / RepayPeriod;
                    LInterest := (InterestRate / 1200) * LoanAmount;

                    //Update Reschedule
                    Loans.Repayment := LPrincipal;

                end;
            end;
        }
        field(50012; "Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50013; "Original Installments"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50014; "Maximun Installments"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50015; "Rescheduling Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Responsibility Center"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50018; "Requested Repaymet"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "New Recovery Mode"; Enum "Repay Mode Enum")
        {
            DataClassification = ToBeClassified;
            ValuesAllowed = " ", Salary, "Check Off", "Dividends", "Internal Standing Order", "External Standing Order", "Pension", Allowance, Cash;
        }
        field(50020; "Interest Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50021; Remarks; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "New Interest Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Rescheduling Type"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionMembers = " ","Create New Loan","Update Existing Loan";
        }
        field(50024; "Top Up Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "New Loan Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50045; "New Schedule Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "New Schedule Amount" < 0 then
                    Error('New Schedule Amount cannot be negative.');

                if ("Loan No." <> '') and ("New Installments" <> 0) then
                    GetRepayment();
            end;
        }
        field(50046; "Schedule Balance"; Decimal)
        {
            Caption = 'Schedule Balance';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Schedule Balance" < 0 then
                    Error('Schedule Balance cannot be negative.');
            end;
        }
        field(50026; "Outstanding Penalty"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50027; "Outstanding Insurance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50028; "Total Outstanding"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50029; "Adjusted Repayment"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50030; "Type of Change"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Loan Rescheduling,Stop Interest,Update Product Type,Debt Collector,Interest Calculation Method,Exempt Recovery,Update Account Manager,Adjust Deposit Contribution,Stop Interest and Penalty,Stop Interest & Penalty & Insurance,Stop Insurance,Insurance,Manage Interest Penalty Insurance,Loan Moratorium';

            OptionMembers = " ","Loan Rescheduling","Stop Interest","Update Product Type","Debt Collector","Interest Calculation Method","Exempt Recovery","Update Account Manager","Adjust Deposit Contribution","Stop Interest and Penalty","Stop Interest & Penalty & Insurance","Stop Insurance",Insurance,"Manage Interest Penalty Insurance","Loan Moratorium";

            ValuesAllowed = " ", "Loan Rescheduling", "Update Product Type", "Debt Collector", "Interest Calculation Method", "Exempt Recovery", "Update Account Manager", "Adjust Deposit Contribution", Insurance, "Manage Interest Penalty Insurance", "Loan Moratorium";
            trigger OnValidate()
            begin
                Validate("Loan No.");
            end;
        }
        field(50031; "Repay Mode"; Enum "Repay Mode Enum")
        {
            DataClassification = ToBeClassified;
            ValuesAllowed = " ", Salary, "Check Off", "Dividends", "Internal Standing Order", "External Standing Order", "Pension", Allowance, Cash;
        }
        field(50032; "Principal Grace Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50033; "New Principal Grace Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50034; "Charge Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Reschedule,Restructure;

            trigger OnValidate()
            var
                ChargeCode: Code[20];
                Value: Decimal;
                ChargeAmt: Decimal;
                ChargeDuty: Decimal;
                ChargeAcctType: Enum "Gen. Journal Account Type";
                ChargeAcct: Code[20];
                d: Integer;
            begin
                SaccoSetup.Get();
                Charges := 0;
                "New Interest Due" := 0;

                "Rescheduling Type" := "rescheduling type"::" ";
                Loans.Get("Loan No.");
                if "Charge Type" = "charge type"::Reschedule then begin
                    "Rescheduling Type" := "rescheduling type"::"Update Existing Loan";
                    ChargeCode := SaccoSetup."Loan Rescheduling Fee";
                    Value := "Total Outstanding";
                    ChargeAmt := 0;
                    ChargeDuty := 0;
                    Counter := 1;
                    Lines := 1;
                    Loans.Reset;
                    Loans.SetRange("Loan No.", "Loan No.");
                    if Loans.FindFirst then begin
                        Loans.CalcFields("Last Int. Due Date", "Outstanding Principal");

                        if Loans."Last Int. Due Date" = 0D then
                            Loans."Last Int. Due Date" := Loans."Disbursement Date";

                        if Loans."Last Int. Due Date" < CalcDate('-CM', Today) then begin
                            d := Today - Loans."Last Int. Due Date";
                            "New Interest Due" := ROUND(Loans."Annual Interest %" / 1200 * Loans."Outstanding Principal" * d / 30);
                        end;
                    end;
                    while Counter <= Lines do begin
                        MemberActivities.GetGeneralChargeAmountWithCounter(ChargeCode, Value, ChargeAmt, ChargeDuty, ChargeAcctType, ChargeAcct, Counter, Lines, Desc);
                        //MESSAGE(Desc+': %1',ChargeAmt);
                        Charges += ChargeAmt + ChargeDuty;
                    end;
                end;

                if "Charge Type" = "charge type"::Restructure then begin

                    "Rescheduling Type" := "rescheduling type"::"Create New Loan";
                    ChargeCode := SaccoSetup."Loan Restructure Fee";
                    Value := "Total Outstanding";
                    ChargeAmt := 0;
                    ChargeDuty := 0;
                    Counter := 1;
                    Lines := 1;
                    while Counter <= Lines do begin
                        MemberActivities.GetGeneralChargeAmountWithCounter(ChargeCode, Value, ChargeAmt, ChargeDuty, ChargeAcctType, ChargeAcct, Counter, Lines, Desc);
                        //MESSAGE(Desc+': %1',ChargeAmt);
                        Charges += ChargeAmt + ChargeDuty;
                    end;
                end;

                Loans.CalcFields("Total Outstanding Balance");
                "New Loan Amount" := Loans."Total Outstanding Balance" + Charges + "New Interest Due";
            end;
        }
        field(50035; Charges; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50036; "New Interest Due"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50037; "Test Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50038; "Loan Suspended"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50039; "Loan Suspension Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50040; "Loan Suspension End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50041; "Loan Product Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Product Setup" where("Product Class" = const(Credit));
            Editable = false;
            trigger OnValidate()
            var
                ProdSetup: Record "Product Setup";
            begin
                ProdSetup.Get("Loan Product Type");
                "Loan Product Type Name" := ProdSetup.Description;
            end;
        }
        field(50042; "Loan Product Type Name"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50043; "New Loan Product Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Product Setup";
            trigger OnValidate()
            var
                ProdSetup: Record "Product Setup";
            begin
                ProdSetup.Get("Loan Product Type");
                "Loan Product Type Name" := ProdSetup.Description;
            end;
        }
        field(50044; "New Loan Product Type Name"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }



        field(182; "Debt Collector Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Internal,External;
        }

        field(183; "Debt Collector Name"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(184; "Debt Collector"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Debt Collector Type" = const(External)) "Salesperson/Purchaser"
            else
            if ("Debt Collector Type" = const(Internal)) Employee;

            trigger OnValidate()
            var
                SalespersonPurchaser: Record "Salesperson/Purchaser";
                HREmployees: Record Employee;

            begin
                "Debt Collector Name" := '';

                if "Debt Collector Type" = "Debt Collector Type"::External then begin
                    SalespersonPurchaser.Reset;
                    SalespersonPurchaser.SetRange(Code, "Debt Collector");
                    if SalespersonPurchaser.Find('-') then begin
                        "Debt Collector Name" := SalespersonPurchaser.Name;
                    end;
                end
                else
                    if "Debt Collector Type" = "Debt Collector Type"::Internal then begin
                        HREmployees.Reset;
                        HREmployees.SetRange("No.", "Debt Collector");
                        if HREmployees.Find('-') then begin
                            "Debt Collector Name" := HREmployees."First Name" + ' ' + HREmployees."Middle Name" + ' ' + HREmployees."Last Name";
                        end;
                    end;
            end;
        }
        field(186; "Debt Coll. Def Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(187; "Debt Coll. Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(188; "Entered By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(190; "Repayment Start Date"; Date)
        {
            Caption = 'Schedule Start Date';
            DataClassification = ToBeClassified;
        }
        field(192; "Exempt Recovery"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(193; "Current Deposit Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(194; "New Deposit Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(195; "Insurance Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(196; "New Insurance Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(197; "Deposit Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(198; "New Dept Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(2067; "Dimension Set ID"; Integer)
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
                    Rec, "Dimension Set ID", "Loan No.", "Global Dimension 1 Code", "Global Dimension 1 Code");

                //IsChanged := OldDimSetID <> "Dimension Set ID";
            end;

            trigger OnValidate()
            var
                DimMgt: Codeunit DimensionManagement;
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Global Dimension 1 Code", "Global Dimension 2 Code");
            end;
        }
        field(2068; "Dont Send SMS"; Boolean)
        {
            Caption = 'Don''t Send SMS';
            DataClassification = ToBeClassified;
        }
        field(2069; APIRequestID; Text[20])
        {
            Caption = 'APIRequestID';
            DataClassification = ToBeClassified;
        }
        field(2070; "Interest Action"; Option)
        {
            Caption = 'Interest Action';
            DataClassification = ToBeClassified;
            OptionCaption = 'No Change,Stop,Resume';
            OptionMembers = "No Change",Stop,Resume;
        }
        field(2071; "Penalty Action"; Option)
        {
            Caption = 'Penalty Action';
            DataClassification = ToBeClassified;
            OptionCaption = 'No Change,Stop,Resume';
            OptionMembers = "No Change",Stop,Resume;
        }
        field(2072; "Insurance Action"; Option)
        {
            Caption = 'Insurance Action';
            DataClassification = ToBeClassified;
            OptionCaption = 'No Change,Stop,Resume';
            OptionMembers = "No Change",Stop,Resume;
        }
        field(2073; "Interest Currently Stopped"; Boolean)
        {
            Caption = 'Interest Currently Stopped';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2074; "Penalty Currently Stopped"; Boolean)
        {
            Caption = 'Penalty Currently Stopped';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2075; "Insurance Currently Stopped"; Boolean)
        {
            Caption = 'Insurance Currently Stopped';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2076; "Loan Moratorium Start Date"; Date)
        {
            Caption = 'Moratorium Start Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if ("Loan Moratorium Start Date" <> 0D) and
                   ("Loan Moratorium End Date" <> 0D) and
                   ("Loan Moratorium End Date" < "Loan Moratorium Start Date")
                then
                    Error('Moratorium End Date cannot be before Moratorium Start Date.');

                if ("Type of Change" = "Type of Change"::"Loan Moratorium") and ("Loan No." <> '') then
                    UpdateRemainingInstallments();
            end;
        }

        field(2077; "Loan Moratorium End Date"; Date)
        {
            Caption = 'Moratorium End Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if ("Loan Moratorium Start Date" <> 0D) and
                   ("Loan Moratorium End Date" <> 0D) and
                   ("Loan Moratorium End Date" < "Loan Moratorium Start Date")
                then
                    Error('Moratorium End Date cannot be before Moratorium Start Date.');

                if ("Type of Change" = "Type of Change"::"Loan Moratorium") and ("Loan No." <> '') then
                    UpdateRemainingInstallments();
            end;
        }
        field(111; "Schedule Start Date"; Date)
        {
            DataClassification = ToBeClassified;
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
        fieldgroup(Brick; "No.", Description, "Date Filter")
        {
        }
    }

    trigger OnInsert()
    begin


        if "No." = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField("Loan Rescheduling Nos");
            "No." := NoSeries.GetNextNo(SalesSetup."Loan Rescheduling Nos", WorkDate(), true);
        end;


        UserSetup.Get(UserId);
        UserSetup.TestField("Global Dimension 1 Code");
        UserSetup.TestField("Global Dimension 2 Code");

        if not UserSetup."Loan Changes" then
            Error(Text001);

        "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
        "Entered By" := UserId;
    end;

    var
        Text001: Label 'You do not permission to capture Loan Changes. Please contact ICT';
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";
        Members: Record Members;
        MemberAccounts: Record "Savings Accounts";
        MemberActivities: Codeunit "Member Activities";
        Loans: Record Loans;
        UserSetup: Record "User Setup";
        RemInstallments: Integer;
        ProductSetup: Record "Product Setup";
        LoanSched: Record "Loan Repayment Schedule";
        PastInstallments: Integer;
        SaccoSetup: Record "Sacco Setup";
        ChargeCode: Code[20];
        Value: Decimal;
        ChargeAmt: Decimal;
        ChargeDuty: Decimal;
        ChargeAcctType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Savings,Credit;
        ChargeAcct: Code[20];
        Counter: Integer;
        Lines: Integer;
        Desc: Text;

    local procedure GetInstallments()
    var
        LoanAmount: Decimal;
        InterestRate: Decimal;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Integer;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        Months: Integer;
        IntDen: Integer;
        InMoratorium: Boolean;
        LoanType: Record "Product Setup";
    begin
        Loans.Reset;
        Loans.SetRange("Loan No.", "Loan No.");
        if Loans.Find('-') then begin

            Loans.CalcFields("Outstanding Principal", "Outstanding Interest");
            LoanAmount := GetScheduleLoanAmount(Loans."Outstanding Principal");
            InterestRate := Loans."Annual Interest %";
            LBalance := LoanAmount;//LoansR."Approved Amount";
            RunDate := "Rescheduling Date";
            InstalNo := 0;
            IntDen := 12;
            if Loans."Repayment Frequency" = Loans."Repayment Frequency"::Daily then
                IntDen := 365
            else if Loans."Repayment Frequency" = Loans."Repayment Frequency"::Weekly then
                IntDen := 52
            else if Loans."Repayment Frequency" = Loans."Repayment Frequency"::Monthly then
                IntDen := 12
            else if Loans."Repayment Frequency" = Loans."Repayment Frequency"::Quarterly then
                IntDen := 4
            else if Loans."Repayment Frequency" = Loans."Repayment Frequency"::"Tri-Annual" then
                IntDen := 3
            else if Loans."Repayment Frequency" = Loans."Repayment Frequency"::"Bi-Annual" then
                IntDen := 2
            else if Loans."Repayment Frequency" = Loans."Repayment Frequency"::Yearly then
                IntDen := 1
            else if Loans."Repayment Frequency" = Loans."Repayment Frequency"::Bonus then
                IntDen := 1;

            repeat
                InstalNo := InstalNo + 1;
                InMoratorium := (RunDate >= Loans."Loan Moratorium Start Date") and (RunDate <= Loans."Loan Moratorium End Date");
                LoanType.Get(Loans."Loan Product Type");


                if Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::Amortised then
                    if Loans."Annual Interest %" = 0 then
                        Loans."Interest Calculation Method" := Loans."Interest Calculation Method"::"Reducing Balance";

                if Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::Amortised then begin
                    Loans.TestField("Annual Interest %");
                    if InMoratorium then begin
                        LPrincipal := 0;

                        if LoanType."Available on Mobile" then
                            LInterest := ROUND(((InterestRate / 100) * LBalance), 1, '>')
                        else
                            LInterest := ROUND(Months / 12 * LBalance * InterestRate / IntDen / 100, 0.01, '=');

                        TotalMRepay := LInterest;
                    end else begin
                        TotalMRepay := ROUND((InterestRate / IntDen / 100) / (1 - Power((1 + (InterestRate / IntDen / 100)), -Rec."New Installments")) * LBalance, 0.01, '=');

                        if LoanType."Available on Mobile" then
                            LInterest := ROUND(((InterestRate / 100) * LBalance), 1, '>')
                        else
                            LInterest := ROUND(Months / 12 * LBalance * InterestRate / IntDen / 100, 0.01, '=');

                        LPrincipal := TotalMRepay - LInterest;
                    end;
                end;

                if Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::"Straight Line" then begin
                    if InMoratorium then
                        LPrincipal := 0
                    else
                        LPrincipal := ROUND(LBalance / Rec."New Installments", 0.01, '=');

                    if LoanType."Available on Mobile" then
                        LInterest := ROUND(((InterestRate / 100) * LBalance), 1, '>')
                    else
                        LInterest := ROUND(LoanAmount * InterestRate / IntDen / 100, 1, '>');

                    TotalMRepay := LPrincipal + LInterest;
                end;

                if (Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::"Reducing Balance") or
                   (Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::"Reducing Flat")
                then begin
                    if InMoratorium then
                        LPrincipal := 0
                    else
                        LPrincipal := ROUND(LBalance / Rec."New Installments", 0.01, '=');

                    if LoanType."Available on Mobile" then
                        LInterest := ROUND(((InterestRate / 100) * LBalance), 1, '>')
                    else
                        LInterest := ROUND(Months / 12 * LBalance * InterestRate / IntDen / 100, 0.01, '=');

                    TotalMRepay := LPrincipal + LInterest;
                end;


                LBalance -= LPrincipal;

                "New Repayment" := TotalMRepay;
                "New Interest Due" := LInterest;


                //Repayment Frequency
                if Loans."Repayment Frequency" = Loans."repayment frequency"::Daily then
                    RunDate := CalcDate('1D', RunDate)
                else
                    if Loans."Repayment Frequency" = Loans."repayment frequency"::Weekly then
                        RunDate := CalcDate('1W', RunDate)
                    else
                        if Loans."Repayment Frequency" = Loans."repayment frequency"::Monthly then
                            RunDate := CalcDate('1M', RunDate)
                        else
                            if Loans."Repayment Frequency" = Loans."repayment frequency"::Quarterly then
                                RunDate := CalcDate('1Q', RunDate)
                            else
                                if Loans."Repayment Frequency" = Loans."repayment frequency"::"Bi-Annual" then
                                    RunDate := CalcDate('6M', RunDate)
                                else
                                    if Loans."Repayment Frequency" = Loans."repayment frequency"::Yearly then
                                        RunDate := CalcDate('1Y', RunDate)
                                    else
                                        if Loans."Repayment Frequency" = Loans."repayment frequency"::Bonus then begin
                                            RunDate := CalcDate('1Y', RunDate);
                                        end;

            until LBalance < 1;

            "New Installments" := InstalNo;
            GetRepayment;
            Modify;

        end;
    end;

    local procedure GetRepayment()
    var
        LoanAmount: Decimal;
        InterestRate: Decimal;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Integer;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        RepayPeriod: Integer;
        SaccoActivities: Codeunit "Sacco Activities";
    begin

        Loans.Get("Loan No.");


        LoanAmount := GetScheduleLoanAmount("Outstanding Principal");
        InterestRate := Loans."Annual Interest %";
        RepayPeriod := "New Installments";
        LBalance := LoanAmount;
        RunDate := "Rescheduling Date";

        if Rec."New Interest Calc. Method" <> Loans."Interest Calculation Method" then
            Loans."Interest Calculation Method" := Rec."New Interest Calc. Method";

        InstalNo := InstalNo + 1;
        if Loans."Interest Calculation Method" = Loans."interest calculation method"::Amortised then begin
            if Loans."Annual Interest %" = 0 then
                Loans."Interest Calculation Method" := Loans."interest calculation method"::"Reducing Balance"

        end;
        //kma
        if Loans."Interest Calculation Method" = Loans."interest calculation method"::Amortised then begin

            TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
            LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.0001, '>');
            LPrincipal := TotalMRepay - LInterest;
        end;

        if Loans."Interest Calculation Method" = Loans."interest calculation method"::"Straight Line" then begin
            LPrincipal := LoanAmount / RepayPeriod;
            LInterest := (InterestRate / 12 / 100) * LoanAmount;
            TotalMRepay := LPrincipal + LInterest
        end;

        if (Loans."Interest Calculation Method" = Loans."interest calculation method"::"Reducing Balance") or (Loans."Interest Calculation Method" = Loans."interest calculation method"::"Reducing Flat") then begin
            LPrincipal := LoanAmount / RepayPeriod;
            LInterest := ROUND((InterestRate / 12 / 100) * LBalance, 1.0, '>');
            TotalMRepay := LPrincipal + LInterest;

        end;
        TotalMRepay := SaccoActivities.SmartRound(TotalMRepay);
        if Rec."New Deposit Contribution" > 0 then
            "New Repayment" := TotalMRepay + Rec."New Deposit Contribution" + Loans."Total Insurance"
        else
            "New Repayment" := TotalMRepay + Loans."Deposit COntribution" + Loans."Total Insurance";
    end;

    local procedure GetScheduleLoanAmount(DefaultLoanAmount: Decimal): Decimal
    begin
        if "New Schedule Amount" > 0 then
            exit("New Schedule Amount");

        exit(DefaultLoanAmount);
    end;

    local procedure GetCurrentDepositFromSchedule()
    var
        Sched: Record "Loan Repayment Schedule";
    begin
        "Current Deposit Contribution" := 0;

        Sched.Reset();
        Sched.SetRange("Loan No.", "Loan No.");
        Sched.SetRange("Repayment Date", Today, 99991230D);   // outstanding / future installments
        if Sched.FindFirst() then
            "Current Deposit Contribution" := Sched."Deposit Amount";   // per-installment deposit from the schedule
    end;

    local procedure UpdateRemainingInstallments()
    begin
        RemInstallments := 0;
        "Remaining Installments" := 0;

        if "Loan No." = '' then
            exit;

        LoanSched.Reset();
        LoanSched.SetRange("Loan No.", "Loan No.");
        LoanSched.SetRange("Repayment Date", GetRemainingInstallmentsStartDate(), 99991230D);
        LoanSched.SetFilter("Line No.", '>0');
        RemInstallments := LoanSched.Count();
        "Remaining Installments" := RemInstallments;
    end;

    local procedure GetRemainingInstallmentsStartDate(): Date
    begin
        if ("Type of Change" = "Type of Change"::"Loan Moratorium") and ("Loan Moratorium Start Date" <> 0D) then
            exit("Loan Moratorium Start Date");

        exit(Today);
    end;

    local procedure InitFields()
    begin

        "Outstanding Principal" := 0;
        "Outstanding Interest" := 0;
        "Outstanding Insurance" := 0;
        "Outstanding Penalty" := 0;
        "Total Outstanding" := 0;
        "New Loan Amount" := 0;
        "New Schedule Amount" := 0;
        "Schedule Balance" := 0;
        "Old Repayment" := 0;
        "Account No." := '';
        "Repay Mode" := "Repay Mode"::" ";
        "Original Installments" := 0;
        "Interest Rate" := 0;
        "Maximun Installments" := 0;
        "New Recovery Mode" := "new recovery mode"::" ";
        "New Installments" := 0;
        "Adjusted Repayment" := 0;
        "New Repayment" := 0;
        "Interest Action" := "Interest Action"::"No Change";
        "Penalty Action" := "Penalty Action"::"No Change";
        "Insurance Action" := "Insurance Action"::"No Change";
        "Interest Currently Stopped" := false;
        "Penalty Currently Stopped" := false;
        "Insurance Currently Stopped" := false;
        "Loan Moratorium Start Date" := 0D;
        "Loan Moratorium End Date" := 0D;
    end;
}
