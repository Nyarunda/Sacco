page 50834 "Loan Security Buffer"
{
    Caption = 'Loan Guarantors & Security (Partial Disbursement)';
    PageType = List;
    SourceTable = "Loan Security Buffer";
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(SecurityLines)
            {
                field("Guarantor Type"; Rec."Guarantor Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Select whether this security is a Guarantor, Collateral, or Lien.';

                    trigger OnValidate()
                    begin
                        Rec."Account No." := '';
                        Rec."Collateral Reg. No." := '';

                        if Rec."Loan No." = '' then
                            Rec."Loan No." := CurrentLoanNo;

                        ClearDisplayFields();
                    end;
                }

                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the savings account or member number.';

                    trigger OnValidate()
                    begin
                        if Rec."Loan No." = '' then
                            Rec."Loan No." := CurrentLoanNo;

                        PopulateGuarantorDetails();
                    end;
                }

                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Staff/Payroll No."; Rec."Staff/Payroll No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Self Guarantee"; Rec."Self Guarantee")
                {
                    ApplicationArea = All;
                }

                field("Collateral Reg. No."; Rec."Collateral Reg. No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Collateral registration number. Only for Collateral type.';

                    trigger OnValidate()
                    begin
                        if Rec."Loan No." = '' then
                            Rec."Loan No." := CurrentLoanNo;

                        PopulateCollateralDetails();
                    end;
                }

                field("Current Guarantor Deposits"; Rec."Current Guarantor Deposits")
                {
                    ApplicationArea = All;
                    Editable = false;
                    BlankZero = true;
                }

                field("Total Guarantor Commitment"; Rec."Total Guarantor Commitment")
                {
                    ApplicationArea = All;
                    Editable = false;
                    BlankZero = true;
                    Style = Attention;
                    StyleExpr = Rec."Total Guarantor Commitment" > 0;
                }

                field("Available Guarantorship"; Rec."Available Guarantorship")
                {
                    ApplicationArea = All;
                    Editable = false;
                    BlankZero = true;
                    Style = Favorable;
                    StyleExpr = Rec."Available Guarantorship" > 0;
                }

                field("Amount Guaranteed"; Rec."Amount Guaranteed")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Style = Strong;

                    trigger OnValidate()
                    begin
                        if Rec."Loan No." = '' then
                            Rec."Loan No." := CurrentLoanNo;

                        ValidateAmountGuaranteed();
                    end;
                }

                field("Gua. Arrears"; Rec."Gua. Arrears")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Guarantor Arrears';
                    BlankZero = true;
                    Style = Unfavorable;
                    StyleExpr = Rec."Gua. Arrears" > 0;
                }

                field("Gua. Status"; Rec."Gua. Status")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Guarantor Status';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(TransferToLoanSecurity)
            {
                ApplicationArea = All;
                Caption = 'Post Guarantors to Loan';
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    SaveCurrentLine();
                    PostBufferToLoanSecurity();
                end;
            }

            action(ValidateAll)
            {
                ApplicationArea = All;
                Caption = 'Validate All Lines';
                Image = Refresh;
                Promoted = true;
                visible = false;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    SaveCurrentLine();
                    RevalidateAllLines();
                    CurrPage.Update(false);
                end;
            }

            action(ClearAll)
            {
                ApplicationArea = All;
                Caption = 'Clear All';
                Image = Delete;
                visible = false;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    BufferLine: Record "Loan Security Buffer";
                begin
                    if CurrentLoanNo = '' then
                        Error('Loan No. is missing.');

                    if Confirm('Clear all guarantor/security lines for loan %1?', false, CurrentLoanNo) then begin
                        BufferLine.Reset();
                        BufferLine.SetRange("Loan No.", CurrentLoanNo);
                        BufferLine.DeleteAll();

                        CurrPage.Update(false);
                    end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        if CurrentLoanNo <> '' then
            Rec.SetRange("Loan No.", CurrentLoanNo);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if CurrentLoanNo <> '' then
            Rec."Loan No." := CurrentLoanNo;

        Rec."Guarantor Type" := Rec."Guarantor Type"::Guarantor;
        ClearDisplayFields();
    end;

    var
        CurrentLoanNo: Code[20];

    procedure SetLoanNo(LoanNo: Code[20])
    begin
        CurrentLoanNo := LoanNo;

        if CurrentLoanNo <> '' then begin
            Rec.Reset();
            Rec.SetRange("Loan No.", CurrentLoanNo);
        end;
    end;

    procedure GetTotalGuaranteed(): Decimal
    var
        TotalAmt: Decimal;
        LoopRec: Record "Loan Security Buffer";
    begin
        TotalAmt := 0;

        LoopRec.Reset();
        LoopRec.SetRange("Loan No.", CurrentLoanNo);

        if LoopRec.FindSet() then
            repeat
                TotalAmt += LoopRec."Amount Guaranteed";
            until LoopRec.Next() = 0;

        exit(TotalAmt);
    end;

    local procedure SaveCurrentLine()
    begin
        if CurrentLoanNo = '' then
            Error('Loan No. is missing.');

        if Rec."Loan No." = '' then
            Rec."Loan No." := CurrentLoanNo;

        if (Rec."Account No." = '') and
           (Rec."Collateral Reg. No." = '') and
           (Rec."Amount Guaranteed" = 0)
        then
            exit;

        CurrPage.SaveRecord();
    end;

    local procedure PopulateGuarantorDetails()
    var
        Savings: Record "Savings Accounts";
        Members: Record Members;
        LoanRec: Record Loans;
        LoanSecurity: Record "Loan Security";
        ThirdPartyCommitment: Decimal;
        SelfGuaranteeCommitment: Decimal;
        SaccoSetup: Record "Sacco Setup";
        SpecificAvailable: Decimal;
        MaxTotalCapacity: Decimal;
        RemainingGlobalCapacity: Decimal;
        TotalDeposits: Decimal;
        ActiveCommitment: Decimal;
        PendingCommitment: Decimal;
        MemberActivities: Codeunit "Member Activities";
    begin
        if Rec."Account No." = '' then
            exit;

        if Rec."Loan No." = '' then
            Rec."Loan No." := CurrentLoanNo;

        ClearDisplayFields();

        case Rec."Guarantor Type" of
            Rec."Guarantor Type"::Guarantor:
                begin
                    if not Savings.Get(Rec."Account No.") then
                        Error('Savings account %1 not found.', Rec."Account No.");

                    if Savings.Status <> Savings.Status::Active then
                        Error('Member %1 is not Active.', Rec."Account No.");

                    Savings.CalcFields("Balance (LCY)", "ID No.", "Payroll/Staff No.", "Employer Code");

                    Rec.Name := Savings.Name;
                    Rec."Member No" := Savings."Member No.";
                    Rec."ID No." := Savings."ID No.";
                    Rec."Staff/Payroll No." := Savings."Payroll/Staff No.";
                    Rec."Gua. Employer Code" := Savings."Employer Code";
                    Rec."Gua. Status" := Format(Savings.Status);
                    Rec."Current Guarantor Deposits" := Savings."Balance (LCY)";
                    TotalDeposits := Savings."Balance (LCY)";

                    if LoanRec.Get(Rec."Loan No.") then begin
                        Rec."Member Guaranteed" := LoanRec."Member No.";
                        Rec."Loanee Name" := LoanRec."Member Name";
                        Rec."Self Guarantee" := Savings."Member No." = LoanRec."Member No.";
                    end;

                    ThirdPartyCommitment := 0;
                    SelfGuaranteeCommitment := 0;

                    LoanSecurity.Reset();
                    LoanSecurity.SetRange("Account No.", Rec."Account No.");
                    LoanSecurity.SetRange("Guarantor Type", LoanSecurity."Guarantor Type"::Guarantor);

                    if LoanSecurity.FindSet() then
                        repeat
                            LoanSecurity.CalcFields("Outstanding Principal");

                            if LoanSecurity."Outstanding Principal" > 0 then begin
                                if LoanSecurity."Member Guaranteed" = Savings."Member No." then
                                    SelfGuaranteeCommitment += LoanSecurity."Current Committed"
                                else
                                    ThirdPartyCommitment += LoanSecurity."Current Committed";
                            end;
                        until LoanSecurity.Next() = 0;

                    Rec."Total Guarantor Commitment" := ThirdPartyCommitment + SelfGuaranteeCommitment;
                    Rec."Application Amount Guaranteed" := ThirdPartyCommitment;

                    if SaccoSetup.Get() then begin
                        MaxTotalCapacity := TotalDeposits * (SaccoSetup."Max Total Exposure %" / 100);
                        RemainingGlobalCapacity := MaxTotalCapacity - ThirdPartyCommitment - SelfGuaranteeCommitment;

                        if RemainingGlobalCapacity < 0 then
                            RemainingGlobalCapacity := 0;

                        if Rec."Self Guarantee" then begin
                            SpecificAvailable :=
                                (TotalDeposits * (SaccoSetup."Self Guarantee Multiplier %" / 100)) -
                                SelfGuaranteeCommitment;

                            Rec."Deposit Multiplier" := SaccoSetup."Self Guarantee Multiplier %" / 100;
                        end else begin
                            SpecificAvailable :=
                                (TotalDeposits * (SaccoSetup."Third Party Multiplier %" / 100)) -
                                ThirdPartyCommitment;

                            Rec."Deposit Multiplier" := SaccoSetup."Third Party Multiplier %" / 100;
                        end;

                        if SpecificAvailable < 0 then
                            SpecificAvailable := 0;

                        if SpecificAvailable < RemainingGlobalCapacity then
                            Rec."Available Guarantorship" := SpecificAvailable
                        else
                            Rec."Available Guarantorship" := RemainingGlobalCapacity;
                    end else begin
                        Rec."Available Guarantorship" :=
                            (TotalDeposits * 1.5) - ThirdPartyCommitment - SelfGuaranteeCommitment;

                        if Rec."Available Guarantorship" < 0 then
                            Rec."Available Guarantorship" := 0;
                    end;
                end;

            Rec."Guarantor Type"::Collateral:
                begin
                    if not Members.Get(Rec."Account No.") then
                        Error('Member %1 not found.', Rec."Account No.");

                    Rec.Name := Members.Name;
                    Rec."Member No" := Rec."Account No.";
                    Rec."ID No." := Members."ID No.";
                    Rec."Staff/Payroll No." := Members."Payroll/Staff No.";
                    Rec."Gua. Status" := Format(Members.Status);

                    if LoanRec.Get(Rec."Loan No.") then begin
                        Rec."Member Guaranteed" := LoanRec."Member No.";
                        Rec."Loanee Name" := LoanRec."Member Name";
                    end;
                end;

            Rec."Guarantor Type"::Lien:
                begin
                    if not Savings.Get(Rec."Account No.") then
                        Error('Savings account %1 not found.', Rec."Account No.");

                    if Savings.Status <> Savings.Status::Active then
                        Error('Account %1 is not Active.', Rec."Account No.");

                    Savings.CalcFields("Balance (LCY)", "ID No.", "Payroll/Staff No.", "Employer Code");

                    if (Savings."Product Category" = Savings."Product Category"::"Junior Savings") and (Savings."Child Name" <> '') then
                        Rec.Name := Savings."Child Name"
                    else
                        Rec.Name := Savings.Name;
                    Rec."Member No" := Savings."Member No.";
                    Rec."ID No." := Savings."ID No.";
                    Rec."Staff/Payroll No." := Savings."Payroll/Staff No.";
                    Rec."Gua. Employer Code" := Savings."Employer Code";
                    Rec."Gua. Status" := Format(Savings.Status);
                    Rec."Current Guarantor Deposits" := Savings."Balance (LCY)";

                    ActiveCommitment := MemberActivities.GetMemberCommittedLien(Rec."Account No.", false);
                    PendingCommitment := MemberActivities.GetMemberCommittedLien(Rec."Account No.", true);

                    Rec."Application Amount Guaranteed" := ActiveCommitment;
                    Rec."Total Guarantor Commitment" := ActiveCommitment + PendingCommitment;
                    Rec."Available Guarantorship" := Savings."Balance (LCY)" - Rec."Total Guarantor Commitment";

                    if Rec."Available Guarantorship" < 0 then
                        Rec."Available Guarantorship" := 0;

                    if LoanRec.Get(Rec."Loan No.") then begin
                        Rec."Member Guaranteed" := LoanRec."Member No.";
                        Rec."Loanee Name" := LoanRec."Member Name";
                    end;
                end;
        end;

        if Rec."Guarantor Type" in [Rec."Guarantor Type"::Guarantor, Rec."Guarantor Type"::Lien] then
            CalcGuarantorArrears(Rec."Member No");
    end;

    local procedure PopulateCollateralDetails()
    var
        SecReg: Record "Loan Collateral Register";
        SaccoSetup: Record "Sacco Setup";
        CollateralAllocation: Record "Collateral Allocation";
        Members: Record Members;
        LoanRec: Record Loans;
        MemberActivities: Codeunit "Member Activities";
        MemberAllocatedValue: Decimal;
        HasAllocation: Boolean;
    begin
        if Rec."Collateral Reg. No." = '' then
            exit;

        if Rec."Loan No." = '' then
            Rec."Loan No." := CurrentLoanNo;

        if not SecReg.Get(Rec."Collateral Reg. No.") then
            Error('Collateral registration number %1 was not found.', Rec."Collateral Reg. No.");

        if Rec."Account No." = '' then
            Rec."Account No." := SecReg."Account No.";

        if Rec."Member No" = '' then
            Rec."Member No" := SecReg."Account No.";

        if Rec."Member No" <> '' then begin
            if Members.Get(Rec."Member No") then begin
                Rec.Name := Members.Name;
                Rec."ID No." := Members."ID No.";
                Rec."Staff/Payroll No." := Members."Payroll/Staff No.";
                Rec."Gua. Status" := Format(Members.Status);
            end else
                Rec.Name := SecReg."Account Name";
        end;

        if LoanRec.Get(Rec."Loan No.") then begin
            Rec."Member Guaranteed" := LoanRec."Member No.";
            Rec."Loanee Name" := LoanRec."Member Name";
            Rec."Self Guarantee" := Rec."Member No" = LoanRec."Member No.";
        end;

        if SecReg."Insurance Expiry Date" <> 0D then
            if SecReg."Insurance Expiry Date" <= Today then
                Error('Collateral Insurance Date has expired.');

        if SecReg."Next Valuation Date" <> 0D then
            if SecReg."Next Valuation Date" <= Today then
                Error('Collateral Next Valuation is due. Revalue to continue.');

        SaccoSetup.Get();

        if SaccoSetup."Collateral % of Limit To Use" <= 0 then
            SaccoSetup."Collateral % of Limit To Use" := 100;

        CollateralAllocation.Reset();
        CollateralAllocation.SetRange("Collateral No.", Rec."Collateral Reg. No.");
        CollateralAllocation.SetFilter("Collateral Allocation", '>0');
        HasAllocation := not CollateralAllocation.IsEmpty();

        if HasAllocation then begin
            CollateralAllocation.SetRange("Member No.", Rec."Member No");

            if CollateralAllocation.FindFirst() then
                MemberAllocatedValue := CollateralAllocation."Collateral Allocation"
            else
                MemberAllocatedValue := SecReg."Charged Value";

            Rec."Current Guarantor Deposits" := MemberAllocatedValue;
            Rec."Collateral Value" := MemberAllocatedValue;
            Rec."Available Guarantorship" :=
                MemberAllocatedValue -
                MemberActivities.GetCommittedCollateralWithAllocation(Rec."Collateral Reg. No.", Rec."Member No", false) -
                MemberActivities.GetCommittedCollateralWithAllocation(Rec."Collateral Reg. No.", Rec."Member No", true);
        end else begin
            Rec."Collateral Value" := SecReg."Charged Value";
            Rec."Current Guarantor Deposits" :=
                Round(SecReg."Charged Value" * SaccoSetup."Collateral % of Limit To Use" / 100);

            Rec."Available Guarantorship" :=
                Rec."Current Guarantor Deposits" -
                MemberActivities.GetCommittedCollateral(Rec."Collateral Reg. No.", false) -
                MemberActivities.GetCommittedCollateral(Rec."Collateral Reg. No.", true);
        end;

        if Rec."Available Guarantorship" < 0 then
            Rec."Available Guarantorship" := 0;
    end;

    local procedure ValidateAmountGuaranteed()
    begin
        if Rec."Amount Guaranteed" <= 0 then
            exit;

        if Rec."Loan No." = '' then
            Rec."Loan No." := CurrentLoanNo;

        if Rec."Amount Guaranteed" > Rec."Available Guarantorship" then
            Error(
                'Cannot guarantee more than available guarantorship of %1.',
                Rec."Available Guarantorship");

        if (Rec."Guarantor Type" = Rec."Guarantor Type"::Guarantor) and
           (Rec."Amount Guaranteed" > Rec."Current Guarantor Deposits")
        then
            Error(
                'Cannot guarantee more than guarantor deposits of %1.',
                Rec."Current Guarantor Deposits");

        Rec."Current Committed" := Rec."Amount Guaranteed";
    end;

    local procedure CalcGuarantorArrears(MemberNo: Code[20])
    var
        LoansRec: Record Loans;
    begin
        Rec."Gua. Arrears" := 0;

        LoansRec.Reset();
        LoansRec.SetRange("Member No.", MemberNo);
        LoansRec.SetRange(Posted, true);
        LoansRec.SetFilter("Outstanding Principal", '>0');

        if LoansRec.FindSet() then
            repeat
                LoansRec.CalcFields("Total Arrears");
                Rec."Gua. Arrears" += LoansRec."Total Arrears";
            until LoansRec.Next() = 0;

        if Rec."Gua. Arrears" > 0 then
            Error('Member %1 has loan arrears of %2 and cannot guarantee a loan.', MemberNo, Rec."Gua. Arrears");
    end;

    local procedure ClearDisplayFields()
    begin
        Rec.Name := '';
        Rec."Member No" := '';
        Rec."Member Guaranteed" := '';
        Rec."Loanee Name" := '';
        Rec."ID No." := '';
        Rec."Staff/Payroll No." := '';
        Rec."Gua. Employer Code" := '';
        Rec."Gua. Status" := '';
        Rec."Current Guarantor Deposits" := 0;
        Rec."Available Guarantorship" := 0;
        Rec."Total Guarantor Commitment" := 0;
        Rec."Application Amount Guaranteed" := 0;
        Rec."Gua. Arrears" := 0;
        Rec."Collateral Value" := 0;
        Rec."Deposit Multiplier" := 0;
        Rec."Self Guarantee" := false;
        Rec."Amount Guaranteed" := 0;
        Rec."Current Committed" := 0;
    end;

    local procedure RevalidateAllLines()
    var
        LoopRec: Record "Loan Security Buffer";
    begin
        if CurrentLoanNo = '' then
            Error('Loan No. is missing.');

        LoopRec.Reset();
        LoopRec.SetRange("Loan No.", CurrentLoanNo);

        if not LoopRec.FindSet() then
            exit;

        repeat
            Rec := LoopRec;

            if Rec."Account No." <> '' then
                PopulateGuarantorDetails();

            if Rec."Collateral Reg. No." <> '' then
                PopulateCollateralDetails();

            ValidateAmountGuaranteed();
            Rec.Modify(true);
        until LoopRec.Next() = 0;
    end;

    local procedure PostBufferToLoanSecurity()
    var
        LoanSecurity: Record "Loan Security";
        LoopRec: Record "Loan Security Buffer";
    begin
        if CurrentLoanNo = '' then
            Error('Loan No. is missing.');

        LoopRec.Reset();
        LoopRec.SetRange("Loan No.", CurrentLoanNo);

        if LoopRec.IsEmpty() then
            Error('No guarantor/security lines to post. Enter Account No./Collateral No. and Amount Guaranteed first.');

        LoopRec.SetFilter("Amount Guaranteed", '<=0');

        if not LoopRec.IsEmpty() then
            Error('One or more lines have no amount guaranteed.');

        LoopRec.SetRange("Amount Guaranteed");

        if not Confirm('Post guarantor/security lines to Loan %1?', true, CurrentLoanNo) then
            exit;

        if LoopRec.FindSet() then
            repeat
                LoanSecurity.Init();
                LoanSecurity."Loan No." := LoopRec."Loan No.";
                LoanSecurity."Account No." := LoopRec."Account No.";
                LoanSecurity."Collateral Reg. No." := LoopRec."Collateral Reg. No.";
                LoanSecurity."Guarantor Type" := LoopRec."Guarantor Type";
                LoanSecurity."Self Guarantee" := LoopRec."Self Guarantee";
                LoanSecurity."Member No" := LoopRec."Member No";

                LoanSecurity.Validate("Account No.", LoopRec."Account No.");

                if LoopRec."Collateral Reg. No." <> '' then
                    LoanSecurity.Validate("Collateral Reg. No.", LoopRec."Collateral Reg. No.");

                LoanSecurity.Validate("Amount Guaranteed", LoopRec."Amount Guaranteed");
                LoanSecurity.Insert(true);
            until LoopRec.Next() = 0;

        LoopRec.Reset();
        LoopRec.SetRange("Loan No.", CurrentLoanNo);
        LoopRec.DeleteAll();

        CurrPage.Update(false);
        Message('Guarantors/security lines successfully posted to Loan %1.', CurrentLoanNo);
    end;
}
