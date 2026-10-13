namespace UnitedWomen.UnitedWomen;

using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.Foundation.Company;

report 50600 "Form 2H Other Disclosures"
{
    ApplicationArea = All;
    Caption = 'FORM 2H - Statement of Other Disclosures';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/FORM 2H Statement of Other Disclosure.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(CompanyInformation; "Company Information")
        {
            column(SaccoName; Name) { }
            column(FinancialYear; Date2DMY(EndDate, 3)) { }
            column(StartDate; StartDate) { }
            column(EndDate; EndDate) { }
            column(PriorStartDate; PriorStartDate) { }
            column(PriorEndDate; PriorEndDate) { }
            column(CurrentGrossNPL; CurrentGrossNPL) { }
            column(PriorGrossNPL; PriorGrossNPL) { }
            column(CurrentInterestSuspense; CurrentInterestSuspense) { }
            column(PriorInterestSuspense; PriorInterestSuspense) { }
            column(CurrentNetNPLBeforeAllowance; CurrentGrossNPL - CurrentInterestSuspense) { }
            column(PriorNetNPLBeforeAllowance; PriorGrossNPL - PriorInterestSuspense) { }
            column(CurrentLoanLossAllowance; CurrentLoanLossAllowance) { }
            column(PriorLoanLossAllowance; PriorLoanLossAllowance) { }
            column(CurrentNetNPL; CurrentGrossNPL - CurrentInterestSuspense - CurrentLoanLossAllowance) { }
            column(PriorNetNPL; PriorGrossNPL - PriorInterestSuspense - PriorLoanLossAllowance) { }
            column(CurrentDirectorLoans; CurrentDirectorLoans) { }
            column(PriorDirectorLoans; PriorDirectorLoans) { }
            column(CurrentEmployeeLoans; CurrentEmployeeLoans) { }
            column(PriorEmployeeLoans; PriorEmployeeLoans) { }
            column(CurrentTotalInsiderLoans; CurrentDirectorLoans + CurrentEmployeeLoans) { }
            column(PriorTotalInsiderLoans; PriorDirectorLoans + PriorEmployeeLoans) { }
            column(CurrentGuarantees; CurrentGuarantees) { }
            column(PriorGuarantees; PriorGuarantees) { }
            column(CurrentOtherContingent; CurrentOtherContingent) { }
            column(PriorOtherContingent; PriorOtherContingent) { }
            column(CurrentTotalContingent; CurrentGuarantees + CurrentOtherContingent) { }
            column(PriorTotalContingent; PriorGuarantees + PriorOtherContingent) { }
            column(CurrentCoreCapital; CurrentCoreCapital) { }
            column(PriorCoreCapital; PriorCoreCapital) { }
            column(CurrentCoreCapitalAssetRatio; CurrentCoreCapitalAssetRatio) { }
            column(PriorCoreCapitalAssetRatio; PriorCoreCapitalAssetRatio) { }
            column(CurrentCoreCapitalDepositRatio; CurrentCoreCapitalDepositRatio) { }
            column(PriorCoreCapitalDepositRatio; PriorCoreCapitalDepositRatio) { }
            column(CurrentLiquidityRatio; CurrentLiquidityRatio) { }
            column(PriorLiquidityRatio; PriorLiquidityRatio) { }
            column(CoreCapitalAssetMinimum; 0.08) { }
            column(CoreCapitalDepositMinimum; 0.05) { }
            column(LiquidityMinimum; 0.10) { }

            trigger OnAfterGetRecord()
            begin
                CalculatePeriod(EndDate, CurrentGrossNPL, CurrentInterestSuspense,
                    CurrentLoanLossAllowance, CurrentDirectorLoans, CurrentEmployeeLoans);
                CalculatePeriod(PriorEndDate, PriorGrossNPL, PriorInterestSuspense,
                    PriorLoanLossAllowance, PriorDirectorLoans, PriorEmployeeLoans);

                CurrentCoreCapital := GetGLBalance(CoreCapitalGLFilter, EndDate);
                PriorCoreCapital := GetGLBalance(CoreCapitalGLFilter, PriorEndDate);
                CurrentTotalAssets := GetGLBalance(TotalAssetsGLFilter, EndDate);
                PriorTotalAssets := GetGLBalance(TotalAssetsGLFilter, PriorEndDate);
                CurrentDeposits := GetGLBalance(DepositLiabilitiesGLFilter, EndDate);
                PriorDeposits := GetGLBalance(DepositLiabilitiesGLFilter, PriorEndDate);

                CurrentCoreCapitalAssetRatio := SafeRatio(CurrentCoreCapital, CurrentTotalAssets);
                PriorCoreCapitalAssetRatio := SafeRatio(PriorCoreCapital, PriorTotalAssets);
                CurrentCoreCapitalDepositRatio := SafeRatio(CurrentCoreCapital, CurrentDeposits);
                PriorCoreCapitalDepositRatio := SafeRatio(PriorCoreCapital, PriorDeposits);
                CurrentLiquidityRatio := SafeRatio(
                    GetGLBalance(LiquidAssetsGLFilter, EndDate),
                    GetGLBalance(ShortTermLiabilitiesGLFilter, EndDate));
                PriorLiquidityRatio := SafeRatio(
                    GetGLBalance(LiquidAssetsGLFilter, PriorEndDate),
                    GetGLBalance(ShortTermLiabilitiesGLFilter, PriorEndDate));

                if LoanLossProvisionGLFilter <> '' then begin
                    CurrentLoanLossAllowance := Abs(GetGLBalance(LoanLossProvisionGLFilter, EndDate));
                    PriorLoanLossAllowance := Abs(GetGLBalance(LoanLossProvisionGLFilter, PriorEndDate));
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Period)
                {
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                    }
                }
            }
        }
    }

    trigger OnInitReport()
    begin
        EndDate := Today;
        StartDate := DMY2Date(1, 1, Date2DMY(EndDate, 3));
    end;

    trigger OnPreReport()
    begin
        if EndDate = 0D then
            Error('End Date must be specified.');
        if StartDate = 0D then
            StartDate := DMY2Date(1, 1, Date2DMY(EndDate, 3));
        if StartDate > EndDate then
            Error('Start Date cannot be after End Date.');

        PriorStartDate := CalcDate('-1Y', StartDate);
        PriorEndDate := CalcDate('-1Y', EndDate);

        if GuiAllowed then
            ProgressDialog.Open(
                'Calculating FORM 2H...\\' +
                'Period ending: #1################\\' +
                'Loans processed: #2######## of #3########\\' +
                'Progress: #4###%');
    end;

    trigger OnPostReport()
    begin
        if GuiAllowed then
            ProgressDialog.Close();
    end;

    local procedure CalculatePeriod(AsAtDate: Date; var GrossNPL: Decimal; var InterestSuspense: Decimal; var LoanLossAllowance: Decimal; var DirectorLoans: Decimal; var EmployeeLoans: Decimal)
    var
        Loan: Record Loans;
        Member: Record Members;
        ProvisionRate: Decimal;
        TotalLoans: Integer;
        ProcessedLoans: Integer;
        ProgressPercent: Integer;
    begin
        Clear(GrossNPL);
        Clear(InterestSuspense);
        Clear(LoanLossAllowance);
        Clear(DirectorLoans);
        Clear(EmployeeLoans);

        Loan.SetRange(Posted, true);
        Loan.SetFilter("Disbursement Date", '..%1', AsAtDate);
        Loan.SetFilter("Date Filter", '..%1', AsAtDate);
        Loan.SetFilter("Outstanding Principal", '>0');
        TotalLoans := Loan.Count();
        if GuiAllowed then begin
            ProgressDialog.Update(1, AsAtDate);
            ProgressDialog.Update(2, 0);
            ProgressDialog.Update(3, TotalLoans);
            ProgressDialog.Update(4, 0);
        end;

        if Loan.FindSet() then
            repeat
                ProcessedLoans += 1;
                Loan.CalcFields("Outstanding Principal", "Outstanding Interest", "Loans Category-SASRA");
                if Loan."Outstanding Principal" > 0 then begin
                    if Loan."Loans Category-SASRA" in
                       [Loan."Loans Category-SASRA"::Substandard,
                        Loan."Loans Category-SASRA"::Doubtful,
                        Loan."Loans Category-SASRA"::Loss]
                    then begin
                        GrossNPL += Loan."Outstanding Principal" + Loan."Outstanding Interest";
                        InterestSuspense += Loan."Outstanding Interest";

                        case Loan."Loans Category-SASRA" of
                            Loan."Loans Category-SASRA"::Substandard:
                                ProvisionRate := 0.25;
                            Loan."Loans Category-SASRA"::Doubtful:
                                ProvisionRate := 0.50;
                            Loan."Loans Category-SASRA"::Loss:
                                ProvisionRate := 1.00;
                        end;
                        LoanLossAllowance += Loan."Outstanding Principal" * ProvisionRate;
                    end;

                    if Member.Get(Loan."Member No.") then
                        case Member."Member Category" of
                            Member."Member Category"::"Board Members":
                                DirectorLoans += Loan."Outstanding Principal";
                            Member."Member Category"::"Staff Members":
                                EmployeeLoans += Loan."Outstanding Principal";
                        end;
                end;

                if GuiAllowed then
                    if (ProcessedLoans mod 50 = 0) or (ProcessedLoans = TotalLoans) then begin
                        if TotalLoans > 0 then
                            ProgressPercent := Round(ProcessedLoans / TotalLoans * 100, 1);
                        ProgressDialog.Update(2, ProcessedLoans);
                        ProgressDialog.Update(4, ProgressPercent);
                    end;
            until Loan.Next() = 0;
    end;

    local procedure GetGLBalance(AccountFilter: Text; AsAtDate: Date): Decimal
    var
        GLAccount: Record "G/L Account";
        Balance: Decimal;
    begin
        if AccountFilter = '' then
            exit(0);

        GLAccount.SetFilter("No.", AccountFilter);
        GLAccount.SetFilter("Date Filter", '..%1', AsAtDate);
        if GLAccount.FindSet() then
            repeat
                GLAccount.CalcFields("Balance at Date");
                Balance += GLAccount."Balance at Date";
            until GLAccount.Next() = 0;
        exit(Abs(Balance));
    end;

    local procedure SafeRatio(Numerator: Decimal; Denominator: Decimal): Decimal
    begin
        if Denominator = 0 then
            exit(0);
        exit(Numerator / Denominator);
    end;

    var
        StartDate: Date;
        EndDate: Date;
        PriorStartDate: Date;
        PriorEndDate: Date;
        CoreCapitalGLFilter: Text[250];
        TotalAssetsGLFilter: Text[250];
        DepositLiabilitiesGLFilter: Text[250];
        LiquidAssetsGLFilter: Text[250];
        ShortTermLiabilitiesGLFilter: Text[250];
        LoanLossProvisionGLFilter: Text[250];
        CurrentGrossNPL: Decimal;
        PriorGrossNPL: Decimal;
        CurrentInterestSuspense: Decimal;
        PriorInterestSuspense: Decimal;
        CurrentLoanLossAllowance: Decimal;
        PriorLoanLossAllowance: Decimal;
        CurrentDirectorLoans: Decimal;
        PriorDirectorLoans: Decimal;
        CurrentEmployeeLoans: Decimal;
        PriorEmployeeLoans: Decimal;
        CurrentGuarantees: Decimal;
        PriorGuarantees: Decimal;
        CurrentOtherContingent: Decimal;
        PriorOtherContingent: Decimal;
        CurrentCoreCapital: Decimal;
        PriorCoreCapital: Decimal;
        CurrentTotalAssets: Decimal;
        PriorTotalAssets: Decimal;
        CurrentDeposits: Decimal;
        PriorDeposits: Decimal;
        CurrentCoreCapitalAssetRatio: Decimal;
        PriorCoreCapitalAssetRatio: Decimal;
        CurrentCoreCapitalDepositRatio: Decimal;
        PriorCoreCapitalDepositRatio: Decimal;
        CurrentLiquidityRatio: Decimal;
        PriorLiquidityRatio: Decimal;
        ProgressDialog: Dialog;
}
