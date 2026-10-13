namespace UnitedWomen.UnitedWomen;

using Microsoft.FixedAssets.Ledger;
using Microsoft.FixedAssets.Reports;

reportextension 50865 "Fixed Asset Register Ext" extends "Fixed Asset Register"
{
    dataset
    {
        add("FA Ledger Entry")
        {
            column(AccumulatedDepreciation; AccumulatedDepreciation)
            {
                Caption = 'Accumulated Depreciation';
            }
            column(ChargeForYear; ChargeForYear)
            {
                Caption = 'Charge for the Year';
            }
        }

        modify("FA Ledger Entry")
        {
            trigger OnAfterAfterGetRecord()
            begin
                CalculateDepreciationValues("FA No.", "Posting Date");
            end;
        }
    }

    trigger OnPreReport()
    begin
        CurrentYearStartDate := DMY2Date(1, 1, Date2DMY(Today, 3));
        CurrentYearEndDate := DMY2Date(31, 12, Date2DMY(Today, 3));
    end;

    var
        FALedgerEntryCalc: Record "FA Ledger Entry";
        AccumulatedDepreciation: Decimal;
        ChargeForYear: Decimal;
        CurrentYearStartDate: Date;
        CurrentYearEndDate: Date;

    local procedure CalculateDepreciationValues(FANo: Code[20]; AsAtPostingDate: Date)
    begin
        AccumulatedDepreciation := 0;
        ChargeForYear := 0;

        if FANo = '' then
            exit;

        FALedgerEntryCalc.Reset();
        FALedgerEntryCalc.SetRange("FA No.", FANo);
        FALedgerEntryCalc.SetRange("FA Posting Type", FALedgerEntryCalc."FA Posting Type"::Depreciation);
        FALedgerEntryCalc.SetFilter("Posting Date", '..%1', AsAtPostingDate);
        FALedgerEntryCalc.CalcSums(Amount);
        AccumulatedDepreciation := FALedgerEntryCalc.Amount;

        FALedgerEntryCalc.Reset();
        FALedgerEntryCalc.SetRange("FA No.", FANo);
        FALedgerEntryCalc.SetRange("FA Posting Type", FALedgerEntryCalc."FA Posting Type"::Depreciation);
        FALedgerEntryCalc.SetRange("Posting Date", CurrentYearStartDate, CurrentYearEndDate);
        FALedgerEntryCalc.CalcSums(Amount);
        ChargeForYear := FALedgerEntryCalc.Amount;
    end;
}
