table 50586 "Loan Security Buffer"
{

    DataClassification = CustomerContent;

    fields
    {
        field(1; "Loan No."; Code[20]) { }

        field(2; "Account No."; Code[20])
        {
            TableRelation =
        if ("Guarantor Type" = const(Guarantor))
            "Savings Accounts"."No." where(
                "Product Category" = filter("Deposit Contribution"),
                Status = filter(Active | Dormant))
            else if ("Guarantor Type" = const(Collateral))
            Members."No."
            else if ("Guarantor Type" = const(Lien))
            "Savings Accounts"."No." where(
                "Product Category" = filter("Fixed Deposit" | "Holiday Savings" | "Ordinary Savings" | "Junior Savings"),
                Status = filter(Active | Dormant));

            trigger OnValidate()
            var
                TempSecurity: Record "Loan Security";
                Savings: Record "Savings Accounts";
                Members: Record Members;
                MemberActivities: Codeunit "Member Activities";
                ThirdPartyCommitment: Decimal;
                SelfGuaranteeCommitment: Decimal;
            begin
                ClearDisplayFields();

                if "Account No." = '' then
                    exit;

                // ── GUARANTOR & LIEN: pull directly from Savings Accounts ──
                case "Guarantor Type" of

                    "Guarantor Type"::Guarantor, "Guarantor Type"::Lien:
                        begin
                            if not Savings.Get("Account No.") then
                                Error('Savings account %1 not found.', "Account No.");

                            if Savings.Status <> Savings.Status::Active then
                                Error('Member %1 is not Active.', "Account No.");

                            Savings.CalcFields("Balance (LCY)", "ID No.", "Payroll/Staff No.", "Employer Code");

                            // Basic info
                            if ("Guarantor Type" = "Guarantor Type"::Lien) and
                               (Savings."Product Category" = Savings."Product Category"::"Junior Savings") and
                               (Savings."Child Name" <> '')
                            then
                                Rec.Name := Savings."Child Name"
                            else
                                Rec.Name := Savings.Name;
                            Rec."Member No" := Savings."Member No.";
                            Rec."ID No." := Savings."ID No.";
                            Rec."Staff/Payroll No." := Savings."Payroll/Staff No.";
                            Rec."Gua. Employer Code" := Savings."Employer Code";
                            Rec."Gua. Status" := Format(Savings.Status);
                            Rec."Current Guarantor Deposits" := Savings."Balance (LCY)";

                            // Set loanee info from the loan header
                            SetLoaneeInfo();

                            // Now delegate the full commitment/availability calculation
                            // to the main table by building a temp Loan Security record
                            PopulateTempSecurityHeader(TempSecurity);
                            TempSecurity.InitializeGuarantorFields();
                            TempSecurity.SetLoaneeInformation();

                            if "Guarantor Type" = "Guarantor Type"::Guarantor then
                                TempSecurity.CalculateAvailableGuarantorship(TempSecurity)
                            else
                                TempSecurity.ProcessLienType(TempSecurity);

                            // Sync computed values back onto Rec
                            Rec."Available Guarantorship" := TempSecurity."Available Guarantorship";
                            Rec."Total Guarantor Commitment" := TempSecurity."Total Guarantor Commitment";
                            Rec."Application Amount Guaranteed" := TempSecurity."Application Amount Guaranteed";
                            Rec."Deposit Multiplier" := TempSecurity."Deposit Multiplier";
                            Rec."Gua. Arrears" := TempSecurity."Gua. Arrears";
                        end;

                    "Guarantor Type"::Collateral:
                        begin
                            if not Members.Get("Account No.") then
                                Error('Member %1 not found.', "Account No.");

                            Rec.Name := Members.Name;
                            Rec."Member No" := "Account No.";
                            Rec."ID No." := Members."ID No.";
                            Rec."Staff/Payroll No." := Members."Payroll/Staff No.";
                            Rec."Gua. Status" := Format(Members.Status);

                            SetLoaneeInfo();
                        end;
                end;
            end;
        }
        field(3; "Member No"; Code[20]) { }

        field(4; "Guarantor Type"; Option)
        {
            OptionMembers = Guarantor,Collateral,Lien;
            OptionCaption = 'Guarantor,Collateral,Lien';

            trigger OnValidate()
            begin
                "Account No." := '';
                "Collateral Reg. No." := '';
                ClearDisplayFields();
            end;
        }

        field(5; "Amount Guaranteed"; Decimal)
        {
            trigger OnValidate()
            var
                TempSecurity: Record "Loan Security";
            begin
                // Delegate the full amount check to the main table's field trigger
                // by building a matching temp record and validating through it
                PopulateTempSecurityHeader(TempSecurity);
                TempSecurity."Amount Guaranteed" := "Amount Guaranteed";
                // This runs the full CheckControl, Available Guarantorship,
                // and deposit cap checks from the main table
                TempSecurity.Validate("Amount Guaranteed");
                // If we get here, validation passed — sync committed value
                "Current Committed" := "Amount Guaranteed";
            end;
        }

        field(6; "Current Committed"; Decimal) { }

        field(7; "Collateral Reg. No."; Code[20])
        {
            TableRelation =
                if ("Guarantor Type" = const(Collateral))
                    "Collateral Allocation" where("Member No." = field("Member No"));

            trigger OnValidate()
            var
                TempSecurity: Record "Loan Security";
                SecReg: Record "Loan Collateral Register";
                Members: Record Members;
            begin
                if "Collateral Reg. No." <> '' then begin
                    if not SecReg.Get("Collateral Reg. No.") then
                        Error('Collateral registration number %1 was not found.', "Collateral Reg. No.");

                    if "Account No." = '' then
                        "Account No." := SecReg."Account No.";

                    if "Member No" = '' then
                        "Member No" := SecReg."Account No.";

                    if "Member No" <> '' then
                        if Members.Get("Member No") then begin
                            Name := Members.Name;
                            "ID No." := Members."ID No.";
                            "Staff/Payroll No." := Members."Payroll/Staff No.";
                            "Gua. Status" := Format(Members.Status);
                        end else
                            Name := SecReg."Account Name";

                    SetLoaneeInfo();
                end;

                // Delegate collateral validation entirely to main table trigger
                PopulateTempSecurityHeader(TempSecurity);
                TempSecurity.Validate("Collateral Reg. No.", "Collateral Reg. No.");
                SyncFromTempSecurity(TempSecurity);
            end;
        }

        field(8; "Substituted Member"; Code[20]) { TableRelation = Members; }
        field(9; Name; Text[200]) { Editable = false; }
        field(10; "Available Guarantorship"; Decimal) { Editable = false; }
        field(11; "ID No."; Code[50]) { Editable = false; }
        field(12; "Staff/Payroll No."; Code[20]) { Editable = false; }
        field(13; "Current Guarantor Deposits"; Decimal) { Editable = false; }
        field(14; "Self Guarantee"; Boolean) { DataClassification = ToBeClassified; }
        field(15; "Gua. Employer Code"; Code[20]) { Editable = false; }
        field(16; "Gua. Status"; Code[20]) { Editable = false; }
        field(17; "Total Guarantor Commitment"; Decimal) { Editable = false; }
        field(18; "Application Amount Guaranteed"; Decimal) { Editable = false; }
        field(19; "Collateral Value"; Decimal) { Editable = false; }
        field(20; "Deposit Multiplier"; Decimal) { Editable = false; }
        field(21; "Member Guaranteed"; Code[50]) { Editable = false; }
        field(22; "Loanee Name"; Text[150]) { Editable = false; }
        field(23; "Gua. Arrears"; Decimal) { Editable = false; }
    }

    keys
    {
        key(PK; "Loan No.", "Account No.", "Collateral Reg. No.") { Clustered = true; }
    }

    // ─────────────────────────────────────────────
    //  Bridge helpers
    // ─────────────────────────────────────────────

    local procedure ClearDisplayFields()
    begin
        Name := '';
        "Member No" := '';
        "Member Guaranteed" := '';
        "Loanee Name" := '';
        "Available Guarantorship" := 0;
        "Current Guarantor Deposits" := 0;
        "Total Guarantor Commitment" := 0;
        "Application Amount Guaranteed" := 0;
        "Gua. Arrears" := 0;
        "ID No." := '';
        "Staff/Payroll No." := '';
        "Gua. Employer Code" := '';
        "Gua. Status" := '';
        "Collateral Value" := 0;
        "Deposit Multiplier" := 0;
    end;

    local procedure SetLoaneeInfo()
    var
        LoanRec: Record Loans;
    begin
        if "Loan No." = '' then
            exit;
        if LoanRec.Get("Loan No.") then begin
            Rec."Member Guaranteed" := LoanRec."Member No.";
            Rec."Loanee Name" := LoanRec."Member Name";
            // Self-guarantee detection
            Rec."Self Guarantee" := (Rec."Member No" = LoanRec."Member No.");
        end;
    end;

    local procedure PopulateTempSecurityHeader(var TempSecurity: Record "Loan Security")
    begin
        TempSecurity.Init();
        TempSecurity."Loan No." := Rec."Loan No.";
        TempSecurity."Account No." := Rec."Account No.";
        TempSecurity."Collateral Reg. No." := Rec."Collateral Reg. No.";
        TempSecurity."Guarantor Type" := Rec."Guarantor Type";
        TempSecurity."Self Guarantee" := Rec."Self Guarantee";
        TempSecurity."Member No" := Rec."Member No";
        TempSecurity."Member Guaranteed" := Rec."Member Guaranteed";
        TempSecurity."Amount Guaranteed" := Rec."Amount Guaranteed";
        TempSecurity."Current Committed" := Rec."Current Committed";
        TempSecurity."Available Guarantorship" := Rec."Available Guarantorship";
        // Pass the already-fetched deposit balance so CalculateAvailableGuarantorship
        // doesn't need to re-fetch — it will CalcFields itself anyway, but this
        // ensures the record key fields are present
        TempSecurity."Current Guarantor Deposits" := Rec."Current Guarantor Deposits";
        TempSecurity."Guarantor Deposits" := Rec."Current Guarantor Deposits";
    end;

    local procedure SyncFromTempSecurity(TempSecurity: Record "Loan Security")
    begin
        // Pull all computed/validated values back from the temp record
        Name := TempSecurity.Name;
        "Member No" := TempSecurity."Member No";
        "Member Guaranteed" := TempSecurity."Member Guaranteed";
        "Loanee Name" := TempSecurity."Loanee Name";
        "ID No." := TempSecurity."ID No.";
        "Staff/Payroll No." := TempSecurity."Staff/Payroll No.";
        "Current Guarantor Deposits" := TempSecurity."Current Guarantor Deposits";
        "Available Guarantorship" := TempSecurity."Available Guarantorship";
        "Total Guarantor Commitment" := TempSecurity."Total Guarantor Commitment";
        "Application Amount Guaranteed" := TempSecurity."Application Amount Guaranteed";
        "Gua. Employer Code" := TempSecurity."Gua. Employer Code";
        "Gua. Status" := TempSecurity."Gua. Status";
        "Gua. Arrears" := TempSecurity."Gua. Arrears";
        "Collateral Value" := TempSecurity."Collateral Value";
        "Deposit Multiplier" := TempSecurity."Deposit Multiplier";
        "Self Guarantee" := TempSecurity."Self Guarantee";
    end;

    // ─────────────────────────────────────────────
    //  Posting procedure (called from your codeunit)
    // ─────────────────────────────────────────────

    procedure TransferToLoanSecurity()
    var
        LoanSecurity: Record "Loan Security";
        BufferRec: Record "Loan Security Buffer";
    begin
        // Loop through all buffer lines for this loan and insert
        // into the real Loan Security table — full OnValidate fires there
        BufferRec.Copy(Rec);
        BufferRec.Reset();
        if BufferRec.FindSet() then
            repeat
                LoanSecurity.Init();
                LoanSecurity."Loan No." := BufferRec."Loan No.";
                LoanSecurity."Account No." := BufferRec."Account No.";
                LoanSecurity."Collateral Reg. No." := BufferRec."Collateral Reg. No.";
                LoanSecurity."Guarantor Type" := BufferRec."Guarantor Type";
                LoanSecurity."Self Guarantee" := BufferRec."Self Guarantee";
                LoanSecurity."Member No" := BufferRec."Member No";
                LoanSecurity."Amount Guaranteed" := BufferRec."Amount Guaranteed";
                LoanSecurity."Current Committed" := BufferRec."Current Committed";
                // Validate "Account No." so the main table re-runs all
                // eligibility, commitment and guarantorship calculations
                LoanSecurity.Validate("Account No.", BufferRec."Account No.");
                LoanSecurity.Validate("Amount Guaranteed", BufferRec."Amount Guaranteed");
                LoanSecurity.Insert(true);
            until BufferRec.Next() = 0;
    end;
}
