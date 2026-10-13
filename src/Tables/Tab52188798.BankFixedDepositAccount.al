table 50480 "Bank Fixed Deposit Account"
{
    Caption = 'Bank Fixed Deposit Account';
    DrillDownPageID = "Bank Fixed Deposit Accounts";
    LookupPageID = "Bank Fixed Deposit Accounts";

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
        field(2; "Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;

            trigger OnValidate()
            begin

                "FD Type" := '';
                "FD Start Date" := 0D;
                "FD Maturity Date" := 0D;
                "FD Amount" := 0;
                "Fixed Account No." := '';
                "Savings Account" := '';

                if Customer.Get("Account No.") then begin

                    ProductSetup.Reset;
                    ProductSetup.SetRange("Product Category", ProductSetup."product category"::"Fixed Deposit");
                    ProductSetup.FindFirst;
                    "Global Dimension 1 Code" := ProductSetup."Global Dimension 1 Code";
                    "Fixed Account No." := "Account No.";

                end;
            end;
        }
        field(3; "Fixed Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer where("No." = field("Account No."));
        }
        field(4; Name; Text[200])
        {
            CalcFormula = lookup(Customer.Name where("No." = field("Account No.")));
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
            TableRelation = Customer where("No." = field("Account No."));
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
            OptionMembers = " ",Active,Matured,Closed;
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
        field(92; "Source Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";

            trigger OnValidate()
            var
                Bank: Record "Bank Account";
            begin
                bank.Get("Source Account");
                "Source Account Name" := Bank.Name;
            end;
        }
        field(93; "Source Account Name"; Text[100])
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
    }

    trigger OnInsert()
    begin



        if "No." = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField("Fixed Deposit Nos");
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
        Customer: Record Customer;


    procedure CalculateFD()
    var
        InitDF: DateFormula;
        FDInterestRates: Record "FD Interest Rates";
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
                    "Total Expected Interest" := "Monthly Interest" * Months;
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
        Customer: Record Customer;
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

        Customer.Get("Savings Account");
        Customer.CalcFields("Balance (LCY)");

        AccBal := Customer."Balance (LCY)";

        if AccBal < "FD Amount" then
            Error('Not Enough Funds in Ordinary Account to enable placement of Fixed Deposit. Current Balance is %1', AccBal);

        SaccoActivities.JournalInit(JTemplate, JBatch);

        AcctType := Accttype::Customer;

        SaccoActivities.JournalInsert(JTemplate, JBatch, "No.", "FD Start Date", AcctType, "Savings Account", 'Fixed Deposit Placement', BalAcctType, '', "FD Amount", ExtDocNo,
                                      '', TransType, "Global Dimension 1 Code", "Global Dimension 2 Code", true, TChannel::" ", UserSetup."Dimension Set ID");

        SaccoActivities.JournalInsert(JTemplate, JBatch, "No.", "FD Start Date", AcctType, "Fixed Account No.", 'Fixed Deposit Placement', BalAcctType, '', -"FD Amount", ExtDocNo,
                                      '', TransType, "Global Dimension 1 Code", "Global Dimension 2 Code", true, TChannel::" ", UserSetup."Dimension Set ID");

        "FD Status" := "fd status"::Active;

        Posted := true;
        "Posted By" := UserId;

        SaccoActivities.JournalPost(JTemplate, JBatch);

        Message('FD Placed Successfully');
    end;
}

