namespace UnitedWomen.UnitedWomen;

codeunit 50144 "Loan Graduation Calculator"
{

    trigger OnRun()
    begin
    end;

    var
        MembersRegister: Record Members;
        MemberLedgerEntry: Record "Credit Ledger Entry";
        LoansRegister: Record Loans;
        LoanRepaySchedule: Record "Loan Repayment Schedule";
        GraduationScore: Record "Loan Graduation Score";
        MissingModelErr: Label 'No active loan graduation model has been configured.';
        MissingWeightErr: Label 'Score weight %1 has not been configured for model %2.';
        InvalidRawMaxErr: Label 'Maximum raw score cannot be zero for score area %1 in model %2.';
        CRBCleanLbl: Label 'Clean Record';
        CRBArrearsLbl: Label 'Has Active Arrears';
        CRBDefaultLbl: Label 'Has Default History';


    procedure CalculateGraduationScore(MemberNo: Code[20]): Decimal
    var
        Model: Record "Loan Graduation Model";
        RepaymentRawScore: Decimal;
        SavingsRawScore: Decimal;
        CRBRawScore: Decimal;
        RatioRawScore: Decimal;
        MembershipRawScore: Decimal;
        RepaymentScore: Decimal;
        SavingsScore: Decimal;
        CRBScore: Decimal;
        RatioScore: Decimal;
        MembershipScore: Decimal;
        FinalScore: Decimal;
    begin
        GetActiveModel(Model);

        if GraduationScore.Get(MemberNo, Today) then
            GraduationScore.Delete();

        GraduationScore.Init();
        GraduationScore."Member No" := MemberNo;
        GraduationScore."Evaluation Date" := Today;
        GraduationScore."Computed By" := UserId;
        GraduationScore."Computed At" := CurrentDateTime;
        GraduationScore."Calculation Version" := Model."Version No.";

        RepaymentRawScore := CalculateRepaymentHistoryScore(MemberNo, Model);
        SavingsRawScore := CalculateSavingsConsistencyScore(MemberNo, Model);
        CRBRawScore := CalculateCRBScore(MemberNo);
        RatioRawScore := CalculateLoanToSavingsRatioScore(MemberNo);
        MembershipRawScore := CalculateMembershipLengthScore(MemberNo);

        RepaymentScore := GetWeightedScore(Model."Code", 0, RepaymentRawScore);
        SavingsScore := GetWeightedScore(Model."Code", 1, SavingsRawScore);
        CRBScore := GetWeightedScore(Model."Code", 2, CRBRawScore);
        RatioScore := GetWeightedScore(Model."Code", 3, RatioRawScore);
        MembershipScore := GetWeightedScore(Model."Code", 4, MembershipRawScore);

        FinalScore := RepaymentScore + SavingsScore + CRBScore + RatioScore + MembershipScore;

        GraduationScore."Repayment History Score" := RepaymentScore;
        GraduationScore."Savings Consistency Score" := SavingsScore;
        GraduationScore."CRB Score" := CRBScore;
        GraduationScore."Loan To Savings Ratio Score" := RatioScore;
        GraduationScore."Membership Length Score" := MembershipScore;
        GraduationScore."Final Score" := FinalScore;
        GraduationScore."Score Percentage" := FinalScore;
        GraduationScore."Eligible Hela Amount" := CalculateEligibleAmount(Model."Code", FinalScore);
        GraduationScore."Qualification Tier" := DetermineQualificationTier(Model."Code", FinalScore);
        GraduationScore."Risk Category" := DetermineRiskCategory(Model."Code", FinalScore);
        GraduationScore."Is Qualified" := (FinalScore >= Model."Minimum Qualifying Score");

        GraduationScore.Insert();

        exit(FinalScore);
    end;

    local procedure CalculateRepaymentHistoryScore(MemberNo: Code[20]; Model: Record "Loan Graduation Model"): Decimal
    var
        TotalMobileLoans: Integer;
        LoansInArrears: Integer;
        DefaultedLoans: Integer;
        MaxArrearsDays: Integer;
        TotalRepayments: Integer;
        OnTimeRepayments: Integer;
        OnTimePercentage: Decimal;
        HasRollovers: Boolean;
        HasRestructuring: Boolean;
        Score: Decimal;
        Category: Integer;
        CurrentArrearsDays: Integer;
        TotalTopups: Integer;
        TotalBridging: Integer;
        EvaluationStartDate: Date;
    begin
        TotalMobileLoans := 0;
        LoansInArrears := 0;
        DefaultedLoans := 0;
        MaxArrearsDays := 0;
        TotalRepayments := 0;
        OnTimeRepayments := 0;
        HasRollovers := FALSE;
        HasRestructuring := FALSE;
        TotalTopups := 0;
        TotalBridging := 0;
        EvaluationStartDate := GetEvaluationStartDate(Model);

        LoansRegister.Reset;
        LoansRegister.SetRange("Member No.", MemberNo);
        LoansRegister.SetFilter("Application Date", '>=%1', EvaluationStartDate);
        if LoansRegister.FindSet then begin
            repeat
                CheckForRolloversAndBridging(LoansRegister."Loan No.", HasRollovers, HasRestructuring,
                    TotalTopups, TotalBridging);

                if IsScoredProduct(Model."Code", LoansRegister."Loan Product Type") then begin
                    TotalMobileLoans += 1;

                    if LoansRegister.Defaulted then
                        DefaultedLoans += 1;

                    LoansRegister.CalcFields("Outstanding Principal");

                    if LoansRegister."Loans Category-SASRA" in [
                        LoansRegister."Loans Category-SASRA"::Watch,
                        LoansRegister."Loans Category-SASRA"::Substandard,
                        LoansRegister."Loans Category-SASRA"::Doubtful,
                        LoansRegister."Loans Category-SASRA"::Loss]
                    then begin
                        LoansInArrears += 1;

                        LoanRepaySchedule.Reset;
                        LoanRepaySchedule.SetRange("Loan No.", LoansRegister."Loan No.");
                        LoanRepaySchedule.SetFilter("Repayment Date", '<%1', Today);

                        if LoanRepaySchedule.FindSet then begin
                            repeat
                                if not HasRepaymentBeenMade(LoansRegister."Loan No.", LoanRepaySchedule."Repayment Date", Model) then begin
                                    CurrentArrearsDays := Today - LoanRepaySchedule."Repayment Date";
                                    if CurrentArrearsDays > MaxArrearsDays then
                                        MaxArrearsDays := CurrentArrearsDays;
                                end;
                            until LoanRepaySchedule.Next = 0;
                        end;
                    end;

                    AnalyzeLoanRepaymentTiming(LoansRegister."Loan No.", TotalRepayments, OnTimeRepayments, Model);
                end;
            until LoansRegister.Next = 0;
        end;

        if TotalRepayments > 0 then
            OnTimePercentage := (OnTimeRepayments / TotalRepayments) * 100
        else
            OnTimePercentage := 0;

        if (MaxArrearsDays = 0) and (TotalMobileLoans >= 2) and
           (DefaultedLoans = 0) and (not HasRollovers) and (not HasRestructuring) then begin
            Score := 45;
            Category := 3;
        end
        else
            if (MaxArrearsDays > 0) and (MaxArrearsDays <= 30) and
               (LoansInArrears <= 1) and (DefaultedLoans = 0) and
               (OnTimePercentage >= 80) then begin
                Score := 25 + ((OnTimePercentage - 80) / 20) * 8;
                if Score > 33 then
                    Score := 33;
                Category := 2;
            end
            else
                if (MaxArrearsDays > 30) and (MaxArrearsDays <= 60) and
                   (DefaultedLoans = 0) then begin
                    Score := 22 - ((MaxArrearsDays - 30) / 30) * 11;
                    if Score < 11 then
                        Score := 11;
                    Category := 1;
                end
                else begin
                    if MaxArrearsDays > 60 then
                        Score := 0
                    else
                        if DefaultedLoans > 0 then
                            Score := 6
                        else
                            if LoansInArrears >= 3 then
                                Score := 9
                            else
                                Score := 11;
                    Category := 0;
                end;

        GraduationScore."Total Topups" := TotalTopups;
        GraduationScore."No Of Mobile Loans" := TotalMobileLoans;
        GraduationScore."Max Arrears Days" := MaxArrearsDays;
        GraduationScore."Loans In Arrears" := LoansInArrears;
        GraduationScore."Defaulted Loans" := DefaultedLoans;
        GraduationScore."On Time Payment %" := OnTimePercentage;
        GraduationScore."Repayment Category" := Category;
        GraduationScore."Has Rollovers" := HasRollovers;
        GraduationScore."Has Restructuring" := HasRestructuring;

        exit(Score);
    end;

    local procedure CheckForRolloversAndBridging(LoanNo: Code[20]; var HasRollovers: Boolean; var HasRestructuring: Boolean; var TotalTopups: Integer; var TotalBridging: Integer)
    var
        TempLoansRegister: Record Loans;
        TopupAmount: Decimal;
        HasTopupFromAmount: Boolean;
        HasTopupFromOffset: Boolean;
        CurrentLoanRestructured: Boolean;
    begin
        HasTopupFromAmount := false;
        HasTopupFromOffset := false;

        if TempLoansRegister.Get(LoanNo) then begin
            TempLoansRegister.CalcFields("Top Up Amount", "Outstanding Principal");
            TopupAmount := TempLoansRegister."Top Up Amount";

            if (TempLoansRegister."Completion Date" <> 0D) and
               (TempLoansRegister."Completion Date" < Today) and
               (TempLoansRegister."Outstanding Principal" > 0)
            then
                HasRollovers := true;

            if TopupAmount > 0 then
                HasTopupFromAmount := true;

            CurrentLoanRestructured := TempLoansRegister."Loan Rescheduled";
            if CurrentLoanRestructured then
                HasRestructuring := true;
        end;

        if HasTopupFromAmount or HasTopupFromOffset then
            TotalTopups += 1;

        if CurrentLoanRestructured then
            TotalBridging += 1;
    end;

    local procedure HasRepaymentBeenMade(LoanNo: Code[20]; ExpectedDate: Date; Model: Record "Loan Graduation Model"): Boolean
    var
        TotalPaid: Decimal;
    begin
        TotalPaid := 0;

        MemberLedgerEntry.Reset;
        MemberLedgerEntry.SetRange("Loan No.", LoanNo);
        MemberLedgerEntry.SetFilter("Transaction Type", '%1|%2',
          MemberLedgerEntry."Transaction Type"::"Principal Repayment",
          MemberLedgerEntry."Transaction Type"::"Interest Paid");
        MemberLedgerEntry.SetFilter("Posting Date", '%1..%2',
          ExpectedDate - Model."Grace Days Before Due",
          ExpectedDate + Model."Grace Days After Due");

        if MemberLedgerEntry.FindSet then begin
            repeat
                TotalPaid += Abs(MemberLedgerEntry.Amount);
            until MemberLedgerEntry.Next = 0;
        end;

        exit(TotalPaid > 0);
    end;

    local procedure AnalyzeLoanRepaymentTiming(LoanNo: Code[20]; var TotalRepayments: Integer; var OnTimeRepayments: Integer; Model: Record "Loan Graduation Model")
    var
        RepaySchedule: Record "Loan Repayment Schedule";
        ExpectedDate: Date;
        ActualDate: Date;
        LoansRegister2: Record Loans;
        RepaymentInterval: Text;
        CompletionDate: Date;
        EntryNo: Text;
        TotalRepaymentsCheck: Integer;
    begin
        RepaySchedule.Reset;
        RepaySchedule.SetRange("Loan No.", LoanNo);
        if RepaySchedule.FindSet then begin
            repeat
                TotalRepayments += 1;
                ExpectedDate := RepaySchedule."Repayment Date";
                MemberLedgerEntry.Reset;
                MemberLedgerEntry.SetRange("Loan No.", LoanNo);
                MemberLedgerEntry.SetFilter("Transaction Type", '%1|%2',
                  MemberLedgerEntry."Transaction Type"::"Principal Repayment",
                  MemberLedgerEntry."Transaction Type"::"Interest Paid");
                MemberLedgerEntry.SetFilter("Posting Date", '%1..%2',
                  ExpectedDate - Model."Grace Days Before Due",
                  ExpectedDate + Model."Grace Days After Due");
                if MemberLedgerEntry.FindFirst then begin
                    ActualDate := MemberLedgerEntry."Posting Date";
                    if ActualDate <= (ExpectedDate + Model."On Time Grace Days") then
                        OnTimeRepayments += 1;
                end;
            until RepaySchedule.Next = 0;
        end else begin
            LoansRegister2.Get(LoanNo);
            LoansRegister2.CalcFields("Outstanding Principal");

            RepaymentInterval := '<1M>';
            if LoansRegister2."Repayment Frequency" = LoansRegister2."Repayment Frequency"::Daily then
                RepaymentInterval := '<1D>'
            else
                if LoansRegister2."Repayment Frequency" = LoansRegister2."Repayment Frequency"::Weekly then
                    RepaymentInterval := '<1W>'
                else
                    if LoansRegister2."Repayment Frequency" = LoansRegister2."Repayment Frequency"::Quarterly then
                        RepaymentInterval := '<3M>';

            if LoansRegister2."Repayment Start Date" <> 0D then
                ExpectedDate := LoansRegister2."Repayment Start Date"
            else
                if LoansRegister2."Disbursement Date" <> 0D then
                    ExpectedDate := CalcDate(RepaymentInterval, LoansRegister2."Disbursement Date");

            if ExpectedDate <> 0D then begin
                if LoansRegister2."Completion Date" <> 0D then
                    CompletionDate := LoansRegister2."Completion Date"
                else
                    if LoansRegister2.Installments > 0 then
                        CompletionDate := CalcDate('<' + Format(LoansRegister2.Installments) + 'M>', ExpectedDate)
                    else
                        CompletionDate := Today;
            end else
                CompletionDate := Today;

            if ExpectedDate = 0D then
                exit;

            while (ExpectedDate <= CompletionDate) and (ExpectedDate <= Today) do begin
                TotalRepaymentsCheck += 1;

                MemberLedgerEntry.Reset;
                MemberLedgerEntry.SetRange("Loan No.", LoanNo);
                MemberLedgerEntry.SetFilter("Transaction Type", '%1',
                  MemberLedgerEntry."Transaction Type"::"Principal Repayment");
                MemberLedgerEntry.SetFilter("Posting Date", '%1..%2',
                    ExpectedDate - Model."Grace Days Before Due",
                    ExpectedDate + Model."On Time Grace Days");

                if MemberLedgerEntry.FindFirst then begin
                    if StrPos(EntryNo, Format(MemberLedgerEntry."Entry No.")) = 0 then begin
                        if EntryNo = '' then
                            EntryNo += Format(MemberLedgerEntry."Entry No.")
                        else
                            EntryNo += '|' + Format(MemberLedgerEntry."Entry No.");
                        TotalRepayments += 1;
                        ActualDate := MemberLedgerEntry."Posting Date";
                        if ActualDate <= (ExpectedDate + Model."On Time Grace Days") then
                            OnTimeRepayments += 1;
                    end;
                end;

                ExpectedDate := CalcDate(RepaymentInterval, ExpectedDate);

                if TotalRepaymentsCheck >= 100 then
                    exit;
            end;
        end;
    end;

    local procedure CalculateSavingsConsistencyScore(MemberNo: Code[20]; Model: Record "Loan Graduation Model"): Decimal
    var
        MonthsWithDeposits: Integer;
        TotalMonths: Integer;
        ConsistencyPercentage: Decimal;
        Score: Decimal;
        Category: Integer;
        CurrentMonth: Date;
        MonthCounter: Integer;
        SavAccLedgerEntry: Record "Savings Ledger Entry";
    begin
        MonthsWithDeposits := 0;
        TotalMonths := Model."Evaluation Period Months";

        if TotalMonths <= 0 then
            TotalMonths := 12;

        for MonthCounter := 0 to (TotalMonths - 1) do begin
            CurrentMonth := CalcDate('-' + Format(MonthCounter) + 'M', Today);

            SavAccLedgerEntry.Reset;
            SavAccLedgerEntry.SetRange("Member No.", MemberNo);
            SavAccLedgerEntry.SetRange("Posting Date",
              CalcDate('-CM', CurrentMonth),
              CalcDate('CM', CurrentMonth));

            if SavAccLedgerEntry.FindFirst then
                MonthsWithDeposits += 1;
        end;

        if TotalMonths > 0 then
            ConsistencyPercentage := (MonthsWithDeposits / TotalMonths) * 100
        else
            ConsistencyPercentage := 0;

        if ConsistencyPercentage = 100 then begin
            Score := 20;
            Category := 3;
        end
        else
            if ConsistencyPercentage >= 75 then begin
                Score := 15 + ((ConsistencyPercentage - 75) / 25) * 5;
                Category := 2;
            end
            else
                if ConsistencyPercentage >= 50 then begin
                    Score := 8 + ((ConsistencyPercentage - 50) / 25) * 7;
                    Category := 1;
                end
                else begin
                    Score := (ConsistencyPercentage / 50) * 8;
                    if Score > 8 then
                        Score := 8;
                    Category := 0;
                end;

        GraduationScore."Months With Deposits" := MonthsWithDeposits;
        GraduationScore."Total Months Evaluated" := TotalMonths;
        GraduationScore."Savings Consistency %" := ConsistencyPercentage;
        GraduationScore."Savings Category" := Category;

        exit(Score);
    end;

    local procedure CalculateLoanToSavingsRatioScore(MemberNo: Code[20]): Decimal
    var
        TotalLoanBalance: Decimal;
        TotalSavings: Decimal;
        Ratio: Decimal;
        Score: Decimal;
        Category: Integer;
        SavingsRegister: Record "Savings Accounts";
    begin
        TotalLoanBalance := 0;
        TotalSavings := 0;

        LoansRegister.Reset;
        LoansRegister.SetRange("Member No.", MemberNo);
        LoansRegister.SetAutoCalcFields("Outstanding Principal");
        LoansRegister.SetFilter("Outstanding Principal", '>0');
        if LoansRegister.FindSet then begin
            repeat
                TotalLoanBalance += LoansRegister."Outstanding Principal";
            until LoansRegister.Next = 0;
        end;

        SavingsRegister.Reset;
        SavingsRegister.SetRange("Member No.", MemberNo);
        SavingsRegister.SetRange(
            "Product Category",
            SavingsRegister."Product Category"::"Deposit Contribution");
        SavingsRegister.SetAutoCalcFields("Balance (LCY)");
        if SavingsRegister.FindSet then begin
            repeat
                TotalSavings += SavingsRegister."Balance (LCY)";
            until SavingsRegister.Next = 0;
        end;

        if TotalSavings > 0 then
            Ratio := TotalLoanBalance / TotalSavings
        else
            if TotalLoanBalance > 0 then
                Ratio := 999
            else
                Ratio := 0;

        if Ratio <= 1 then begin
            Score := 9 + (1 - Ratio);
            if Score > 10 then
                Score := 10;
            Category := 3;
        end
        else
            if (Ratio > 1) and (Ratio <= 2) then begin
                Score := 6 + ((2 - Ratio) * 3);
                Category := 2;
            end
            else
                if (Ratio > 2) and (Ratio <= 3) then begin
                    Score := 3 + ((3 - Ratio) * 3);
                    Category := 1;
                end
                else begin
                    if Ratio < 999 then
                        Score := 3 / Ratio
                    else
                        Score := 0;
                    if Score > 3 then
                        Score := 3;
                    Category := 0;
                end;

        GraduationScore."Total Loan Balance" := TotalLoanBalance;
        GraduationScore."Total Savings" := TotalSavings;
        GraduationScore."Loan To Savings Ratio" := Ratio;
        GraduationScore."Ratio Category" := Category;

        exit(Score);
    end;

    local procedure CalculateMembershipLengthScore(MemberNo: Code[20]): Decimal
    var
        MembershipYears: Decimal;
        Score: Decimal;
        Category: Integer;
        RegistrationDate: Date;
    begin
        if MembersRegister.Get(MemberNo) then
            RegistrationDate := MembersRegister."Registration Date"
        else
            exit(0);

        if RegistrationDate <> 0D then
            MembershipYears := (Today - RegistrationDate) / 365
        else
            MembershipYears := 0;

        if MembershipYears >= 3 then begin
            Score := 5;
            Category := 2;
        end
        else
            if MembershipYears >= 1 then begin
                Score := 3 + ((MembershipYears - 1) / 2) * 2;
                if Score > 5 then
                    Score := 5;
                Category := 1;
            end
            else begin
                Score := MembershipYears * 3;
                if Score > 3 then
                    Score := 3;
                Category := 0;
            end;

        GraduationScore."Membership Start Date" := RegistrationDate;
        GraduationScore."Membership Years" := MembershipYears;
        GraduationScore."Membership Category" := Category;

        exit(Score);
    end;

    local procedure CalculateCRBScore(MemberNo: Code[20]): Decimal
    var
        Score: Decimal;
        Category: Integer;
        CRBStatus: Text[50];
    begin
        LoansRegister.Reset;
        LoansRegister.SetRange("Member No.", MemberNo);
        LoansRegister.SetRange("Loans Category-SASRA", LoansRegister."Loans Category-SASRA"::Loss);
        LoansRegister.SetFilter("Outstanding Principal", '>0');
        if LoansRegister.FindFirst then begin
            Score := 0;
            Category := 0;
            CRBStatus := CRBDefaultLbl;
        end else begin
            LoansRegister.Reset;
            LoansRegister.SetRange("Member No.", MemberNo);
            LoansRegister.SetFilter("Loans Category-SASRA", '<>%1', LoansRegister."Loans Category-SASRA"::Performing);
            LoansRegister.SetFilter("Outstanding Principal", '>0');

            if LoansRegister.FindFirst then begin
                Score := 10;
                Category := 2;
                CRBStatus := CRBArrearsLbl;
            end else begin
                Score := 20;
                Category := 3;
                CRBStatus := CRBCleanLbl;
            end;
        end;

        GraduationScore."CRB Category" := Category;
        GraduationScore."CRB Status" := CRBStatus;
        GraduationScore."CRB Last Check Date" := Today;

        exit(Score);
    end;

    local procedure CalculateEligibleAmount(ModelCode: Code[20]; ScorePercentage: Decimal): Decimal
    var
        Band: Record "Loan Graduation Band";
    begin
        Band.Reset();
        Band.SetRange("Model Code", ModelCode);
        Band.SetFilter("Min Score", '<=%1', ScorePercentage);
        Band.SetFilter("Max Score", '>=%1', ScorePercentage);

        if Band.FindFirst() then
            exit(Band."Eligible Amount");

        exit(0);
    end;

    local procedure DetermineQualificationTier(ModelCode: Code[20]; ScorePercentage: Decimal): Integer
    var
        Band: Record "Loan Graduation Band";
    begin
        Band.Reset();
        Band.SetRange("Model Code", ModelCode);
        Band.SetFilter("Min Score", '<=%1', ScorePercentage);
        Band.SetFilter("Max Score", '>=%1', ScorePercentage);

        if Band.FindFirst() then
            exit(Band."Tier");

        exit(0);
    end;

    local procedure DetermineRiskCategory(ModelCode: Code[20]; ScorePercentage: Decimal): Integer
    var
        Band: Record "Loan Graduation Band";
    begin
        Band.Reset();
        Band.SetRange("Model Code", ModelCode);
        Band.SetFilter("Min Score", '<=%1', ScorePercentage);
        Band.SetFilter("Max Score", '>=%1', ScorePercentage);

        if Band.FindFirst() then
            exit(Band."Risk Category");

        exit(0);
    end;

    procedure GetLatestScore(MemberNo: Code[20]): Decimal
    begin
        GraduationScore.Reset;
        GraduationScore.SetRange("Member No", MemberNo);
        GraduationScore.SetCurrentKey("Member No", "Evaluation Date");
        GraduationScore.Ascending(false);

        if GraduationScore.FindFirst then
            exit(GraduationScore."Final Score");

        exit(0);
    end;

    procedure GetEligibleHelaAmount(MemberNo: Code[20]): Decimal
    begin
        GraduationScore.Reset;
        GraduationScore.SetRange("Member No", MemberNo);
        GraduationScore.SetRange("Evaluation Date", Today);
        if GraduationScore.FindLast then
            exit(GraduationScore."Eligible Hela Amount");

        CalculateGraduationScore(MemberNo);
        if GraduationScore.Get(MemberNo, Today) then
            exit(GraduationScore."Eligible Hela Amount");

        exit(0);
    end;

    local procedure GetActiveModel(var Model: Record "Loan Graduation Model")
    var
        SetupMgt: Codeunit "Loan Graduation Setup Mgt";
    begin
        Model.Reset();
        Model.SetRange(Active, true);
        if not Model.FindFirst() then begin
            SetupMgt.EnsureDefaultModel();
            Model.Reset();
            Model.SetRange(Active, true);
            if not Model.FindFirst() then
                Error(MissingModelErr);
        end;
    end;

    local procedure GetWeightedScore(ModelCode: Code[20]; ScoreArea: Integer; RawScore: Decimal): Decimal
    var
        Weight: Record "Loan Graduation Score Weight";
    begin
        Weight.Reset();
        Weight.SetRange("Model Code", ModelCode);
        Weight.SetRange("Score Area", ScoreArea);
        if not Weight.FindFirst() then
            Error(MissingWeightErr, ScoreArea, ModelCode);

        if Weight."Maximum Raw Score" = 0 then
            Error(InvalidRawMaxErr, ScoreArea, ModelCode);

        exit((RawScore / Weight."Maximum Raw Score") * Weight.Weight);
    end;

    local procedure GetEvaluationStartDate(Model: Record "Loan Graduation Model"): Date
    begin
        exit(CalcDate('-' + Format(Model."Evaluation Period Months") + 'M', Today));
    end;

    local procedure IsScoredProduct(ModelCode: Code[20]; LoanProductType: Code[20]): Boolean
    var
        Product: Record "Loan Graduation Product";
    begin
        if Product.Get(ModelCode, LoanProductType) then
            exit(Product."Product Role" = Product."Product Role"::Scored);

        exit(false);
    end;
}
