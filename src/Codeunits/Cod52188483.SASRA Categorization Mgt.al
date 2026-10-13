
namespace UnitedWomen.UnitedWomen;

codeunit 50614 "SASRA Categorization Mgt."
{
    procedure CategorizeLoanAsAt(
    var Loan: Record Loans;
    AsAtDate: Date;
    var DefAmount: Decimal;
    var DaysInArrear: Integer;
    var MonthsInArrears: Integer;
    var IntArrears: Decimal;
    var LoanCategory: Option Performing,Watch,Substandard,Doubtful,Loss)
    var
        ProductSetup: Record "Product Setup";
        SaccoActivities: Codeunit "Sacco Activities";
        GracePeriod: DateFormula;
        ExpectedAmt: Decimal;
        AmtPaid: Decimal;
        ArrearsDate: Date;
        MDef: Decimal;
        InstallmentDefaulted: Integer;
    begin
        if AsAtDate = 0D then
            Error('As At Date must not be blank.');

        Clear(DefAmount);
        Clear(DaysInArrear);
        Clear(MonthsInArrears);
        Clear(IntArrears);
        Clear(ExpectedAmt);
        Clear(AmtPaid);
        Clear(ArrearsDate);
        Clear(GracePeriod);
        Clear(MDef);
        Clear(InstallmentDefaulted);

        Loan.SetFilter("Date Filter", '..%1', AsAtDate);
        Loan.CalcFields(
            "Outstanding Principal",
            "Outstanding Interest",
            "Outstanding Penalty",
            "Total Outstanding Balance",
            "Principal Paid",
            "Interest Paid");

        if Loan."Outstanding Principal" <= 0 then begin
            LoanCategory := LoanCategory::Performing;
            exit;
        end;

        SaccoActivities.GetDefaultedAmount(
            Loan."Loan No.",
            AsAtDate,
            ExpectedAmt,
            AmtPaid,
            DefAmount,
            DaysInArrear,
            ArrearsDate,
            false,
            GracePeriod);

        MDef := SaccoActivities.GetMonthsInDefault(Loan."Loan No.", AsAtDate, GracePeriod, DefAmount);
        MDef := ROUND(MDef, 1, '=');
        DaysInArrear := ROUND(MDef * 30, 1, '=');
        InstallmentDefaulted := MDef;

        MonthsInArrears := InstallmentDefaulted;

        IntArrears := SaccoActivities.GetInterestArrears(Loan."Loan No.", AsAtDate);

        case DaysInArrear of
            0:
                LoanCategory := LoanCategory::Performing;

            1 .. 30:
                LoanCategory := LoanCategory::Watch;

            31 .. 180:
                LoanCategory := LoanCategory::Substandard;

            181 .. 360:
                LoanCategory := LoanCategory::Doubtful;

            else
                LoanCategory := LoanCategory::Loss;
        end;
    end;

    procedure GenerateSnapshot(AsAtDate: Date; LoanOfficerFilter: Code[50]; ShowProgress: Boolean)
    var
        Loan: Record Loans;
        Snapshot: Record "SASRA Category Snapshot";
        Member: Record Members;
        ProductSetup: Record "Product Setup";
        LoanLedger: Record "Credit Ledger Entry";
        IFRSModel: Record "IFRS-9 Model";
        AccountNo: Code[20];
        ProgressWindow: Dialog;
        GracePeriod: DateFormula;
        ExpectedAmt: Decimal;
        AmtPaid: Decimal;
        DefAmount: Decimal;
        DaysInArrear: Integer;
        ArrearsDate: Date;
        MonthsInArrears: Integer;
        InterestArrears: Decimal;
        MDef: Decimal;
        LoanCategory: Option Performing,Watch,Substandard,Doubtful,Loss;
        IFRSStage: Option "Stage 1","Stage 2","Stage 3";
        ApprovedAmount: Decimal;
        TotalArrears: Decimal;
        ECLAmount: Decimal;
        IntPaid: Decimal;
        NoOfRecords: Integer;
        CurrentRecordNo: Integer;
        RunId: Guid;
        Loans: Record Loans;
        SaccoActivities: Codeunit "Sacco Activities";
    begin
        TotalArrears := 0;

        if AsAtDate = 0D then
            Error('As At Date must not be blank.');

        RunId := CreateGuid();

        DeleteSnapshot(AsAtDate, LoanOfficerFilter);

        Loan.Reset();
        Loan.SetRange(Posted, true);
        Loan.SetFilter("Date Filter", '..%1', AsAtDate);
        Loan.SetFilter("Disbursement Date", '..%1', AsAtDate);
        if LoanOfficerFilter <> '' then
            Loan.SetRange("Loan Officer", LoanOfficerFilter);

        NoOfRecords := Loan.Count();

        if ShowProgress then
            ProgressWindow.Open(
                'Generating SASRA Snapshot: @1@@@@@@@@@\' +
                'Counter                 #2#########\' +
                'Total                   #3#########');

        if Loan.FindSet(false) then
            repeat
                CurrentRecordNo += 1;

                if ShowProgress then begin
                    ProgressWindow.Update(2, CurrentRecordNo);
                    ProgressWindow.Update(3, NoOfRecords);

                    if NoOfRecords > 0 then
                        ProgressWindow.Update(1, Round(CurrentRecordNo / NoOfRecords * 10000, 1));
                end;

                if not Member.Get(Loan."Member No.") then
                    continue;

                Loan.CalcFields(
                    "Outstanding Principal",
                    "Outstanding Interest",
                    "Outstanding Penalty",
                    "Total Outstanding Balance",
                    "Outstanding Insurance",
                    "Principal Paid",
                    "Interest Paid");

                if Loan."Outstanding Principal" <= 0 then
                    continue;

                Clear(ExpectedAmt);
                Clear(AmtPaid);
                Clear(DefAmount);
                Clear(DaysInArrear);
                Clear(ArrearsDate);
                Clear(MonthsInArrears);
                Clear(InterestArrears);
                Clear(MDef);
                clear(intPaid);

                MDef := SaccoActivities.GetMonthsInDefault(Loan."Loan No.", AsAtDate, GracePeriod, DefAmount);
                MDef := Round(MDef, 1, '=');

                MonthsInArrears := MDef;
                DaysInArrear := Round(MDef * 30, 1, '=');

                InterestArrears := SaccoActivities.GetInterestArrears(Loan."Loan No.", AsAtDate);

                if ProductSetup.Get(Loan."Loan Product Type") then
                    if ProductSetup."Loan Type" = ProductSetup."Loan Type"::Mavuno then begin
                        DefAmount := 0;
                        DaysInArrear := 0;
                        MonthsInArrears := 0;
                        InterestArrears := 0;
                    end;

                case DaysInArrear of
                    0:
                        LoanCategory := LoanCategory::Performing;
                    1 .. 30:
                        LoanCategory := LoanCategory::Watch;
                    31 .. 180:
                        LoanCategory := LoanCategory::Substandard;
                    181 .. 360:
                        LoanCategory := LoanCategory::Doubtful;
                    else
                        LoanCategory := LoanCategory::Loss;
                end;

                IFRSStage := GetIFRSStage(LoanCategory);

                ApprovedAmount := Loan."Approved Amount";
                if ApprovedAmount = 0 then
                    ApprovedAmount := Loan."Requested Amount";

                if ApprovedAmount = 0 then begin
                    LoanLedger.Reset();
                    LoanLedger.SetRange("Loan No.", Loan."Loan No.");
                    LoanLedger.SetRange("Account No.", Loan."Member No.");
                    LoanLedger.SetRange(reversed, false);
                    LoanLedger.SetRange("Transaction Type", LoanLedger."Transaction Type"::"Loan Disbursement");
                    if LoanLedger.FindFirst() then begin
                        loanledger.CalcSums(Amount);
                        ApprovedAmount := LoanLedger.Amount;
                    end
                end;

                TotalArrears :=
                    InterestArrears +
                    Loan."Outstanding Penalty" +
                    Loans."Outstanding Insurance" +
                    DefAmount;

                if DefAmount <= 0 then
                    TotalArrears := 0;

                ECLAmount := CalculateECL(
                    IFRSStage,
                    Loan."Outstanding Principal",
                    Loan."Total Outstanding Balance",
                    IFRSModel);

                AccountNo := GetDisbursementAccountNo(Loan);

                Snapshot.Init();
                Snapshot."As At" := AsAtDate;
                Snapshot."Loan No." := Loan."Loan No.";
                Snapshot."Member No." := Loan."Member No.";
                Snapshot."Member Name" := Loan."Member Name";
                Snapshot."Loan Product Type" := Loan."Loan Product Type";
                Snapshot."Relationship Officer" := Loan."Relationship Officer";
                Snapshot."Loan Officer" := Loan."Loan Officer";
                Snapshot."Approved Amount" := ApprovedAmount;
                Snapshot."Outstanding Principal" := Loan."Outstanding Principal";
                Snapshot."Outstanding Interest" := Loan."Outstanding Interest";
                Snapshot."Outstanding Penalty" := Loan."Outstanding Penalty";
                Snapshot."Total Outstanding Balance" := Loan."Total Outstanding Balance";
                Snapshot."Principal Expected" := ExpectedAmt;
                Snapshot."Principal Paid" := AmtPaid;
                Snapshot."Interest Paid" := IntPaid;
                Snapshot."Principal Arrears" := DefAmount;
                Snapshot."Total Arrears" := TotalArrears;
                Snapshot."Days in Arrears" := DaysInArrear;
                Snapshot."Months in Arrears" := MonthsInArrears;
                Snapshot."Account No." := AccountNo;
                Snapshot."Issued Date" := GetIssuedDate(Loan);
                Snapshot.ECL := ECLAmount;
                Snapshot."User Name" := UserId;
                Snapshot."Created At" := CurrentDateTime;
                Snapshot."Run ID" := RunId;

                SetSnapshotLoanCategory(Snapshot, LoanCategory);
                SetSnapshotIFRSStage(Snapshot, IFRSStage);

                Snapshot.Insert();
            until Loan.Next() = 0;

        if ShowProgress then
            ProgressWindow.Close();
    end;

    local procedure DeleteSnapshot(AsAtDate: Date;
LoanOfficerFilter: Code[50])
    var
        Snapshot: Record "SASRA Category Snapshot";
    begin
        Snapshot.Reset();
        Snapshot.SetRange("As At", AsAtDate);

        if LoanOfficerFilter <> '' then
            Snapshot.SetRange("Loan Officer", LoanOfficerFilter);

        if not Snapshot.IsEmpty() then
            Snapshot.DeleteAll();
    end;

    local procedure GetLoanCategory(DaysInArrears: Integer): Option Performing,Watch,Substandard,Doubtful,Loss
    var
        LoanCategory: Option Performing,Watch,Substandard,Doubtful,Loss;
    begin
        case DaysInArrears of
            0:
                LoanCategory := LoanCategory::Performing;

            1 .. 30:
                LoanCategory := LoanCategory::Watch;

            31 .. 180:
                LoanCategory := LoanCategory::Substandard;

            181 .. 360:
                LoanCategory := LoanCategory::Doubtful;

            else
                LoanCategory := LoanCategory::Loss;
        end;

        exit(LoanCategory);
    end;

    local procedure GetIFRSStage(LoanCategory: Option Performing,Watch,Substandard,Doubtful,Loss): Option "Stage 1","Stage 2","Stage 3"
    var
        IFRSStage: Option "Stage 1","Stage 2","Stage 3";
    begin
        case LoanCategory of
            LoanCategory::Performing,
            LoanCategory::Watch:
                IFRSStage := IFRSStage::"Stage 1";

            LoanCategory::Substandard:
                IFRSStage := IFRSStage::"Stage 2";

            LoanCategory::Doubtful,
            LoanCategory::Loss:
                IFRSStage := IFRSStage::"Stage 3";
        end;

        exit(IFRSStage);
    end;

    local procedure CalculateECL(IFRSStage: Option "Stage 1","Stage 2","Stage 3"; OutstandingPrincipal: Decimal; TotalOutstandingBalance: Decimal; var IFRSModel: Record "IFRS-9 Model"): Decimal
    begin
        case IFRSStage of
            IFRSStage::"Stage 1":
                begin
                    IFRSModel.Reset();
                    IFRSModel.SetRange(Stage, 1);
                    if IFRSModel.FindFirst() then
                        exit(Round(TotalOutstandingBalance * IFRSModel.PD / 100 * IFRSModel.LGD / 100));
                end;

            IFRSStage::"Stage 2":
                begin
                    IFRSModel.Reset();
                    IFRSModel.SetRange(Stage, 2);
                    if IFRSModel.FindFirst() then
                        exit(Round(TotalOutstandingBalance * IFRSModel.PD / 100 * IFRSModel.LGD / 100));
                end;

            IFRSStage::"Stage 3":
                begin
                    IFRSModel.Reset();
                    IFRSModel.SetRange(Stage, 3);
                    if IFRSModel.FindFirst() then
                        exit(Round(OutstandingPrincipal * IFRSModel.LGD / 100));
                end;
        end;

        exit(0);
    end;

    local procedure GetDisbursementAccountNo(Loan: Record Loans): Code[20]
    var
        Accounts: Record "Savings Accounts";
    begin
        if Loan."Disbursement Account No" <> '' then
            if Accounts.Get(Loan."Disbursement Account No") then
                exit(Loan."Disbursement Account No");

        Accounts.Reset();
        Accounts.SetRange("Product Category", Accounts."Product Category"::"Ordinary Savings");
        Accounts.SetRange("Member No.", Loan."Member No.");

        if Accounts.FindFirst() then
            exit(Accounts."No.");

        exit('');
    end;

    local procedure GetIssuedDate(Loan: Record Loans): Date
    begin
        if Loan."Disbursement Date" <> 0D then
            exit(Loan."Disbursement Date");

        exit(Loan."Application Date");
    end;

    local procedure SetSnapshotLoanCategory(var Snapshot: Record "SASRA Category Snapshot"; LoanCategory: Option Performing,Watch,Substandard,Doubtful,Loss)
    begin
        case LoanCategory of
            LoanCategory::Performing:
                Snapshot."Loan Category" := Snapshot."Loan Category"::Performing;
            LoanCategory::Watch:
                Snapshot."Loan Category" := Snapshot."Loan Category"::Watch;
            LoanCategory::Substandard:
                Snapshot."Loan Category" := Snapshot."Loan Category"::Substandard;
            LoanCategory::Doubtful:
                Snapshot."Loan Category" := Snapshot."Loan Category"::Doubtful;
            LoanCategory::Loss:
                Snapshot."Loan Category" := Snapshot."Loan Category"::Loss;
        end;
    end;

    local procedure SetSnapshotIFRSStage(var Snapshot: Record "SASRA Category Snapshot"; IFRSStage: Option "Stage 1","Stage 2","Stage 3")
    begin
        case IFRSStage of
            IFRSStage::"Stage 1":
                Snapshot."IFRS Stage" := Snapshot."IFRS Stage"::"Stage 1";
            IFRSStage::"Stage 2":
                Snapshot."IFRS Stage" := Snapshot."IFRS Stage"::"Stage 2";
            IFRSStage::"Stage 3":
                Snapshot."IFRS Stage" := Snapshot."IFRS Stage"::"Stage 3";
        end;
    end;
}
