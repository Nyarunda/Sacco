
Table 50132 "Micro Credit Transactions"
{
    LookupPageID = "Micro Transactions List";
    DrillDownPageId = "Micro Transactions List";

    fields
    {
        field(1; "No."; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(2; "Transaction Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(3; "Transaction Time"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(4; "Micro Saver Control Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = true;
            TableRelation = Vendor."No.";
        }
        field(5; "Group Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = true;
            TableRelation = Members."No." where(Type = const(Group));

            trigger OnValidate()
            var
                GracePeriod: DateFormula;
                Classes: Record "Member Class";
            begin
                if Posted <> true then begin
                    MicroSubform.Reset;
                    MicroSubform.SetRange(MicroSubform."No.", "No.");
                    if MicroSubform.Find('-') then
                        MicroSubform.DeleteAll;

                    if Members.Get("Group Code") then
                        "Group Name" := Members.Name;

                    Members.TestField("Member Class");

                    if "Payment Type" = "payment type"::Normal then begin
                        SavingsAccounts.Reset;
                        SavingsAccounts.SetRange("Product Category", SavingsAccounts."product category"::"Micro Member Deposit");
                        SavingsAccounts.SetRange(SavingsAccounts."Group No.", "Group Code");
                        if SavingsAccounts.Find('-') then begin
                            repeat
                                SavingsAccounts.CalcFields("Balance (LCY)");
                                MicroSubform.Init;
                                MicroSubform."No." := "No.";
                                MicroSubform."Account Number" := SavingsAccounts."No.";
                                MicroSubform."Account Name" := SavingsAccounts.Name;
                                MicroSubform."Group Code" := "Group Code";
                                MicroSubform."Member No." := SavingsAccounts."Member No.";
                                MicroSubform.Savings := SavingsAccounts."Balance (LCY)";
                                MicroSubform."Branch/Agent" := "Deposited By";
                                MicroSubform."Date Banked" := "Date Banked";

                                "Signing Instructions" := SavingsAccounts."Signing Instructions";
                                "Signing Instruction narration" := SavingsAccounts."Signing Instructions Narration";

                                ProductFactory.Get(SavingsAccounts."Product Type");
                                ProductFactory.TestField("Minimum Contribution");

                                AmtPaid := 0;
                                SLedger.Reset;
                                SLedger.SetRange("Account No.", SavingsAccounts."No.");
                                SLedger.SetRange("Posting Date", CalcDate('-CM', Today), CalcDate('CM', Today));
                                if SLedger.FindFirst then begin
                                    SLedger.CalcSums(Amount);
                                    AmtPaid := SLedger.Amount * -1;
                                end;

                                Classes.Reset();
                                Classes.SetRange("Member Class", Members."Member Class");
                                if Classes.FindFirst() then;

                                // MicroSubform."Expected Deposits" :=  ProductFactory."Minimum Contribution"- AmtPaid;
                                MicroSubform."Expected Deposits" := Classes."Minimum Share Deposits" - AmtPaid;

                                if MicroSubform."Expected Deposits" < 0 then
                                    MicroSubform."Expected Deposits" := 0;


                                LoanApplic.Reset;
                                LoanApplic.SetRange("Member No.", SavingsAccounts."Member No.");
                                //LoanApplic.SETRANGE(LoanApplic."Group Code","Group Code");
                                LoanApplic.SetFilter(LoanApplic."Outstanding Principal", '>0');
                                LoanApplic.SetRange(Source, LoanApplic.Source::MICRO);
                                LoanApplic.SetFilter("Date Filter", '..%1', Today);
                                if LoanApplic.Find('-') then begin
                                    repeat
                                        MicroSubform."Loan No." := LoanApplic."Loan No.";

                                        LoanApplic.CalcFields("Interest Paid", "Schedule Interest", "Outstanding Principal", "Outstanding Interest", "Outstanding Penalty", "Outstanding Appraisal");


                                        if LoanApplic."Outstanding Appraisal" < 0 then
                                            LoanApplic."Outstanding Appraisal" := 0;
                                        if LoanApplic."Outstanding Interest" < 0 then
                                            LoanApplic."Outstanding Interest" := 0;
                                        if LoanApplic."Outstanding Penalty" < 0 then
                                            LoanApplic."Outstanding Penalty" := 0;

                                        LoanApplic."Interest Paid" := (LoanApplic."Loan Interest Repayment" * LoanApplic.Installments) - LoanApplic."Outstanding Interest";

                                        InterestDue := LoanApplic."Outstanding Interest";

                                        if InterestDue < 0 then
                                            InterestDue := 0;

                                        MicroSubform."Outstanding Interest" := InterestDue;
                                        MicroSubform."Outstanding Appraisal" := LoanApplic."Outstanding Appraisal";

                                        AppraisalDue := LoanApplic."Outstanding Appraisal";


                                        if AppraisalDue < 0 then
                                            AppraisalDue := 0;

                                        AsAt := CalcDate('CM', Today);
                                        SaccoActivities.GetDefaultedAmount(LoanApplic."Loan No.", AsAt, ExpectedAmt, AmtPaid, DefAmount, DaysInArrear, ArrearsDate, true, GracePeriod);
                                        PrAmt := DefAmount;

                                        if PrAmt < SaccoActivities.GetLoanPrincipal(LoanApplic, Today) then
                                            PrAmt := SaccoActivities.GetLoanPrincipal(LoanApplic, Today);

                                        if PrAmt > LoanApplic."Outstanding Principal" then
                                            PrAmt := LoanApplic."Outstanding Principal";

                                        MicroSubform."Expected Penalty" += LoanApplic."Outstanding Penalty";
                                        MicroSubform."Expected Appraisal Fee" += AppraisalDue;
                                        MicroSubform."Expected Interest" += InterestDue;
                                        MicroSubform."Expected Principle Amount" += PrAmt;
                                        MicroSubform."Outstanding Balance" += LoanApplic."Outstanding Principal";

                                        MicroSubform."Branch Code" := "Transacting Branch";

                                    until LoanApplic.Next = 0;
                                end;

                                MicroSubform.Insert;
                            until SavingsAccounts.Next = 0;
                        end;
                    end;


                    if "Payment Type" = "payment type"::"Pass Book" then begin
                        SavingsAccounts.Reset;
                        SavingsAccounts.SetRange("Product Category", SavingsAccounts."product category"::"Micro Member Deposit");
                        SavingsAccounts.SetRange(SavingsAccounts."Group No.", "Group Code");
                        if SavingsAccounts.Find('-') then begin
                            repeat
                                SavingsAccounts.CalcFields("Balance (LCY)");
                                MicroSubform.Init;
                                MicroSubform."No." := "No.";
                                MicroSubform."Account Number" := SavingsAccounts."No.";
                                MicroSubform."Account Name" := SavingsAccounts.Name;
                                MicroSubform."Group Code" := "Group Code";
                                MicroSubform."Member No." := SavingsAccounts."Member No.";
                                MicroSubform.Savings := SavingsAccounts."Balance (LCY)";
                                MicroSubform."Branch/Agent" := "Deposited By";
                                MicroSubform."Date Banked" := "Date Banked";
                                MicroSubform."Branch Code" := "Transacting Branch";
                                MicroSubform.Insert;
                            until SavingsAccounts.Next = 0;
                        end;
                    end;

                    /*
                    IF "Payment Type"="Payment Type"::Savings THEN BEGIN
                        SavingsAccounts.RESET;
                        SavingsAccounts.SETRANGE("Product Category",SavingsAccounts."Product Category"::"Micro Credit Deposits");
                        SavingsAccounts.SETRANGE(SavingsAccounts."Group Account No","Group Code");
                        IF SavingsAccounts.FIND('-') THEN BEGIN
                            REPEAT
                                SavingsAccounts.CALCFIELDS("Balance (LCY)");
                                MicroSubform.INIT;
                                MicroSubform."No.":="No.";
                                MicroSubform."Account Number":=SavingsAccounts."No.";
                                MicroSubform."Account Name":=SavingsAccounts.Name;
                                MicroSubform."Group Code":="Group Code";
                                MicroSubform."Member No.":=SavingsAccounts."Member No.";
                                MicroSubform.Savings:=SavingsAccounts."Balance (LCY)";
                                MicroSubform."Branch/Agent":="Deposited By";
                                MicroSubform."Date Banked":="Date Banked";
                                IF "Group Code"<>'' THEN
                                  Members.GET("Group Code");
                                "Group Name":=Members.Name;
                                MicroSubform.INSERT;
                            UNTIL SavingsAccounts.NEXT=0;
                        END;
                    END
                    ELSE BEGIN
                        LoanApplic.RESET;
                        LoanApplic.SETRANGE(LoanApplic."Group Code","Group Code");
                        LoanApplic.SETFILTER(LoanApplic."Outstanding Principal",'>0');
                        IF LoanApplic.FIND('-') THEN BEGIN
                            REPEAT
                                LoanApplic.CALCFIELDS(LoanApplic."Outstanding Principal",LoanApplic."Outstanding Bills",LoanApplic."Outstanding Interest");
                                MicroSubform.INIT;
                                MicroSubform."No.":="No.";
                                MicroSubform."Account Number":=LoanApplic."Loan Account";
                                MicroSubform."Account Name":=LoanApplic."Member Name";
                                MicroSubform."Group Code":="Group Code";
                                MicroSubform."Branch/Agent":="Deposited By";
                                MicroSubform."Date Banked":="Date Banked";
                                IF "Group Code"<>'' THEN
                                Members.GET("Group Code");
                                "Group Name":=Members.Name;
                                MicroSubform."Expected Principle Amount":=LoanApplic."Outstanding Bills";
                                MicroSubform."Expected Interest":=LoanApplic."Outstanding Interest";
                                MicroSubform."Outstanding Principal":=LoanApplic."Outstanding Principal";
                                MicroSubform."Branch Code":="Transacting Branch";
                                MicroSubform."Member No.":=LoanApplic."Member No.";
                                MicroSubform."Loan No.":=LoanApplic."Loan No.";
                                MicroSubform.INSERT;
                            UNTIL LoanApplic.NEXT=0;
                        END;
                    END;
                    */
                end;

            end;
        }
        field(6; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(7; Balance; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Posted By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Total Repayment"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account"
            else
            if ("Account Type" = const(Customer)) Customer
            else
            if ("Account Type" = const(Credit)) Customer
            else
            if ("Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Account Type" = const("Fixed Asset")) "Fixed Asset";

            trigger OnValidate()
            begin
                if "Account Type" = "account type"::"Bank Account" then begin
                    BANKACC.Reset;
                    BANKACC.SetRange(BANKACC."No.", "Account No");
                    if BANKACC.Find('-') then begin
                        "Account Name" := BANKACC.Name;
                    end
                    else
                        if "Account Type" = "account type"::Credit then begin
                            SavingsAccounts.Reset;
                            SavingsAccounts.SetRange(SavingsAccounts."No.", "Account No");
                            if SavingsAccounts.Find('-') then begin
                                "Account Name" := SavingsAccounts.Name;
                            end;
                        end;
                end;
            end;
        }
        field(12; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Savings/Loan Rep"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Savings,"Loan Repayment";
        }
        field(14; "Post to InterBranch Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Transacting Branch"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(16; "Total Savings"; Decimal)
        {
            CalcFormula = sum("Micro Credit Transaction Lines".Amount where("No." = field("No.")));
            FieldClass = FlowField;
        }
        field(17; "Account Type"; Enum "Gen. Journal Account Type")
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(18; "Account Name"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(19; "Total Penalty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Total Principle"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Total Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(22; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(23; "Total Amount"; Decimal)
        {
            CalcFormula = sum("Micro Credit Transaction Lines".Amount where("No." = field("No."),
                                                                             "Group Code" = field("Group Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(24; "Group Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Total Amount Received"; Decimal)
        {
            CalcFormula = sum("Micro Credit Transaction Lines".Amount where("No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(26; Cashier; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Date Banked"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Deposited By"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            Description = 'Stores the reference to the first global dimension in the database';
            Enabled = false;
            NotBlank = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50009; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            Description = 'Stores the reference of the second global dimension in the database';
            Editable = false;
            NotBlank = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50010; "Payment Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Normal,Pass Book';
            OptionMembers = " ",Normal,"Pass Book";

            trigger OnValidate()
            begin
                if "Group Code" <> '' then
                    Validate("Group Code");
            end;
        }
        field(50011; "Loan Clearance"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Signing Instructions"; Option)
        {
            OptionMembers = Single,"All must Sign","Either Must Sign";
        }
        field(50013; "Signing Instruction Narration"; Text[250])
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
        fieldgroup(DropDown; "No.", "Transaction Date")
        {
        }
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Micro Finance Transactions");
            "No." := noseries.GetNextNo(SalesSetup."Micro Finance Transactions", WorkDate(), true);
        end;

        "Transaction Date" := Today;
        "Transaction Time" := Time;
        Cashier := UserId;


        //"Posted By":= USERID;
        BankingUserSetup.Get(UserId);
        BankingUserSetup.TestField("Default  Bank");
        "Account Type" := "account type"::"Bank Account";
        "Account No" := BankingUserSetup."Default  Bank";
        "Date Banked" := Today;
        Validate("Account No");

        UserSetup.Get(UserId);
        "Transacting Branch" := UserSetup."Global Dimension 2 Code";
        "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
        "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
    end;

    var
        SavingsAccounts: Record "Savings Accounts";
        LoanApplic: Record Loans;
        noseries: Codeunit "No. Series";
        SalesSetup: Record "Sales & Receivables Setup";
        MicroSubform: Record "Micro Credit Transaction Lines";
        BANKACC: Record "Bank Account";
        Members: Record Members;
        UserSetup: Record "User Setup";
        AppraisalDue: Decimal;
        ProductFactory: Record "Product Setup";
        InterestDue: Decimal;
        SLedger: Record "Savings Ledger Entry";
        AmtPaid: Decimal;
        TransType: Option " ",Loan,Repayment,"Interest Due","Interest Paid",Bills,"Appraisal Due","Ledger Fee","Appraisal Paid","Pre-Earned Interest","Penalty Due","Penalty Paid";
        BankingUserSetup: Record "Banking User Setup";
        PrAmt: Decimal;
        MemberActivities: Codeunit "Member Activities";
        SaccoActivities: Codeunit "Sacco Activities";
        ExpectedAmt: Decimal;
        DefAmount: Decimal;
        DaysInArrear: Integer;
        ArrearsDate: Date;
        AsAt: Date;
}

