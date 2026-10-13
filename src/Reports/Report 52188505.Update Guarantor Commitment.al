report 50168 "Update Guarantor Commitment"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Update Guarantor Commitment';

    dataset
    {
        dataitem(LoanG; "Loan Security")
        {
            RequestFilterFields = "Loan No.", "Member No";

            trigger OnPreDataItem()
            begin
                RecordsProcessed := 0;
                Clear(GlobalProcessedLoans);

                //LoanG.SetFilter("Current Committed", '>0');
                LoanG.SetRange(Substituted, false);
            end;

            trigger OnAfterGetRecord()
            begin
                if not GlobalProcessedLoans.Contains(LoanG."Loan No.") then
                    GlobalProcessedLoans.Add(LoanG."Loan No.");
            end;

            trigger OnPostDataItem()
            var
                ProcessLoanNo: Code[20];
            begin
                foreach ProcessLoanNo in GlobalProcessedLoans do begin
                    RebalanceLoanGuarantors(ProcessLoanNo);
                    RecordsProcessed += 1;
                end;

                if ShowDebug then
                    Message('Success: %1 unique loans rebalanced successfully.', RecordsProcessed);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ShowDebugField; ShowDebug)
                    {
                        Caption = 'Show Debug Messages';
                        ApplicationArea = All;
                        ToolTip = 'Display summary popups at the end of execution.';
                    }
                }
            }
        }
    }

    var
        GlobalProcessedLoans: List of [Code[20]];
        RecordsProcessed: Integer;
        ShowDebug: Boolean;

    local procedure RebalanceLoanGuarantors(LoanNo: Code[20])
    var
        LoanRec: Record Loans;
        LoanSecurity: Record "Loan Security";
        ProductSetup: Record "Product Setup";
        OutstandingPrincipal: Decimal;
        LoaneeDepositTotalGuaranteed: Decimal;
        LoaneeOtherTotalGuaranteed: Decimal;
        ThirdPartyTotalGuaranteed: Decimal;
        LoaneeDepositCommitmentPool: Decimal;
        LoaneeOtherCommitmentPool: Decimal;
        ThirdPartyCommitmentPool: Decimal;
        IsL06Loan: Boolean;
    begin
        if not LoanRec.Get(LoanNo) then
            exit;

        LoanRec.CalcFields("Outstanding Principal");
        OutstandingPrincipal := MaxLimit(LoanRec."Outstanding Principal", 0);
        IsL06Loan := (LoanRec."Loan Product Type" = 'L06') and ProductSetup.Get(LoanRec."Loan Product Type");

        LoanSecurity.SetRange("Loan No.", LoanNo);
        LoanSecurity.SetRange(Substituted, false);
        if LoanSecurity.FindSet() then
            repeat
                if LoanSecurity."Member No" <> LoanRec."Member No." then
                    ThirdPartyTotalGuaranteed += MaxLimit(LoanSecurity."Amount Guaranteed", 0)
                else begin
                    if IsLoaneeDepositSecurity(LoanSecurity, LoanRec."Member No.") then
                        LoaneeDepositTotalGuaranteed += GetSecurityCapacity(LoanSecurity, LoanRec."Member No.")
                    else
                        LoaneeOtherTotalGuaranteed += MaxLimit(LoanSecurity."Amount Guaranteed", 0);
                end;
            until LoanSecurity.Next() = 0;

        // Loanee deposits are held first, so they are released last.
        if IsL06Loan and (ProductSetup."Deposit Multiplier" > 0) then
            LoaneeDepositCommitmentPool := GetMin(Round(OutstandingPrincipal / ProductSetup."Deposit Multiplier", 0.01, '='), LoaneeDepositTotalGuaranteed)
        else
            LoaneeDepositCommitmentPool := GetMin(OutstandingPrincipal, LoaneeDepositTotalGuaranteed);
        LoaneeOtherCommitmentPool := GetMin(MaxLimit(OutstandingPrincipal - LoaneeDepositCommitmentPool, 0), LoaneeOtherTotalGuaranteed);
        ThirdPartyCommitmentPool := GetMin(MaxLimit(OutstandingPrincipal - LoaneeDepositCommitmentPool - LoaneeOtherCommitmentPool, 0), ThirdPartyTotalGuaranteed);

        UpdateSecurityCommitments(LoanNo, LoanRec."Member No.", true, true, LoaneeDepositCommitmentPool, LoaneeDepositTotalGuaranteed);
        UpdateSecurityCommitments(LoanNo, LoanRec."Member No.", true, false, LoaneeOtherCommitmentPool, LoaneeOtherTotalGuaranteed);
        UpdateSecurityCommitments(LoanNo, LoanRec."Member No.", false, false, ThirdPartyCommitmentPool, ThirdPartyTotalGuaranteed);
    end;

    local procedure UpdateSecurityCommitments(LoanNo: Code[20]; LoaneeMemberNo: Code[20]; UpdateLoaneeLines: Boolean; UpdateDepositLines: Boolean; CommitmentPool: Decimal; TotalGuaranteed: Decimal)
    var
        LoanSecurity: Record "Loan Security";
        SecurityCapacity: Decimal;
        NewCommitment: Decimal;
    begin
        LoanSecurity.SetRange("Loan No.", LoanNo);
        LoanSecurity.SetRange(Substituted, false);
        if LoanSecurity.FindSet() then
            repeat
                if IsSecurityLineInGroup(LoanSecurity, LoaneeMemberNo, UpdateLoaneeLines, UpdateDepositLines) then begin
                    SecurityCapacity := GetSecurityCapacity(LoanSecurity, LoaneeMemberNo);
                    if TotalGuaranteed > 0 then
                        NewCommitment := Round(CommitmentPool * (SecurityCapacity / TotalGuaranteed), 0.01, '=')
                    else
                        NewCommitment := 0;

                    LoanSecurity."Current Committed" := GetMin(NewCommitment, SecurityCapacity);
                    LoanSecurity.Modify(false);
                end;
            until LoanSecurity.Next() = 0;
    end;

    local procedure IsSecurityLineInGroup(LoanSecurity: Record "Loan Security"; LoaneeMemberNo: Code[20]; CheckLoaneeLines: Boolean; CheckDepositLines: Boolean): Boolean
    begin
        if not CheckLoaneeLines then
            exit(LoanSecurity."Member No" <> LoaneeMemberNo);

        if CheckDepositLines then
            exit(IsLoaneeDepositSecurity(LoanSecurity, LoaneeMemberNo));

        exit(IsLoaneeOtherSecurity(LoanSecurity, LoaneeMemberNo));
    end;

    local procedure GetSecurityCapacity(LoanSecurity: Record "Loan Security"; LoaneeMemberNo: Code[20]): Decimal
    var
        Savings: Record "Savings Accounts";
    begin
        if LoanSecurity."Member No" <> LoaneeMemberNo then
            exit(MaxLimit(LoanSecurity."Amount Guaranteed", 0));

        if LoanSecurity."Guarantor Type" <> LoanSecurity."Guarantor Type"::Guarantor then
            exit(MaxLimit(LoanSecurity."Amount Guaranteed", 0));

        if LoanSecurity."Account No." = '' then
            exit(MaxLimit(LoanSecurity."Amount Guaranteed", 0));

        if not Savings.Get(LoanSecurity."Account No.") then
            exit(MaxLimit(LoanSecurity."Amount Guaranteed", 0));

        if Savings."Product Category" = Savings."Product Category"::"Deposit Contribution" then begin
            Savings.CalcFields("Balance (LCY)");
            exit(MaxLimit(Savings."Balance (LCY)", 0));
        end;

        exit(MaxLimit(LoanSecurity."Amount Guaranteed", 0));
    end;

    local procedure IsLoaneeDepositSecurity(LoanSecurity: Record "Loan Security"; LoaneeMemberNo: Code[20]): Boolean
    var
        Savings: Record "Savings Accounts";
    begin
        if LoanSecurity."Member No" <> LoaneeMemberNo then
            exit(false);

        if LoanSecurity."Guarantor Type" <> LoanSecurity."Guarantor Type"::Guarantor then
            exit(false);

        if LoanSecurity."Account No." = '' then
            exit(false);

        if not Savings.Get(LoanSecurity."Account No.") then
            exit(false);

        exit(Savings."Product Category" = Savings."Product Category"::"Deposit Contribution");
    end;

    local procedure IsLoaneeOtherSecurity(LoanSecurity: Record "Loan Security"; LoaneeMemberNo: Code[20]): Boolean
    begin
        if LoanSecurity."Member No" <> LoaneeMemberNo then
            exit(false);

        exit(not IsLoaneeDepositSecurity(LoanSecurity, LoaneeMemberNo));
    end;

    local procedure MaxLimit(Val: Decimal; Limit: Decimal): Decimal
    begin
        if Val < Limit then exit(Limit);
        exit(Val);
    end;

    local procedure GetMin(Val1: Decimal; Val2: Decimal): Decimal
    begin
        if Val1 < Val2 then exit(Val1);
        exit(Val2);
    end;
}
