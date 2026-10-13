Report 50334 "Fixed Assets Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Fixed Assets Register.rdlc';

    dataset
    {
        dataitem("Fixed Asset"; "Fixed Asset")
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_1; 1)
            {
            }
            dataitem("FA Depreciation Book"; "FA Depreciation Book")
            {
                DataItemLink = "FA No." = field("No.");

                column(No_FixedAsset; "Fixed Asset"."No.")
                {
                }
                column(Depreciation; Depreciation)
                {
                }
                column(SerialNo_FixedAsset; "Fixed Asset"."Serial No.")
                {
                }
                column(Description_FixedAsset; "Fixed Asset".Description)
                {
                }
                column(AssetType; "Fixed Asset"."Asset Type")
                {
                }
                column(FA_Subclass_Code; "Fixed Asset"."FA Subclass Code")
                {
                }
                column(FA_Class_Code; "Fixed Asset"."FA Class Code")
                {
                }

                column(Active_Life_Time; round("No. of Depreciation Years", 1, '>'))
                {
                }

                column(No__of_Depreciation_Years; "No. of Depreciation Years")
                {
                }

                column(Acquisition_Date; "Acquisition Date")
                {
                }

                column(Acquisition_Cost; "Acquisition Cost")
                {
                }

                column(Disposal_Date; "Disposal Date")
                {
                }

                column(Proceeds_on_Disposal; "Proceeds on Disposal")
                {
                }
                column(Last_Transaction_Date; "Last Transaction Date")
                {
                }

                column(Book_Value; "Book Value")
                {
                }
                column(LastDateModified_FixedAsset; "Fixed Asset"."Last Date Modified")
                {
                }
                column(DepartSection_FixedAsset; "Fixed Asset"."Depart. / Section")
                {
                }
                column(Custodian_FixedAsset; "Fixed Asset".Custodian)
                {
                }
                column(YearOfPurchase_FixedAsset; "Fixed Asset"."Year Of Purchase")
                {
                }
                column(FAPostingGroup_FixedAsset; "Fixed Asset"."FA Posting Group")
                {
                }
                column(ReportForNavId_10; 10)
                {
                }
                column(DepreciationStartingDate_FADepreciationBook; "FA Depreciation Book"."Depreciation Starting Date")
                {
                }
                column(DepreciationMethod_FADepreciationBook; "FA Depreciation Book"."Depreciation Method")
                {
                }
                column(DecliningBalance_FADepreciationBook; "FA Depreciation Book"."Declining-Balance %")
                {
                }
                column(StraightLine_FADepreciationBook; "FA Depreciation Book"."Straight-Line %")
                {
                }
                column(CompanyInfo_Picture; CompanyInfo.Picture)
                {
                }
                column(AccumulatedDepreciation; AccumulatedDepreciation)
                {
                    Caption = 'Accumulated Depreciation';
                }
                column(ChargeForYear; ChargeForYear)
                {
                    Caption = 'Charge for the Year';
                }

                trigger OnAfterGetRecord()
                begin
                    CalculateDepreciationValues("FA No.", "Last Transaction Date");
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CurrentYearStartDate := DMY2Date(1, 1, Date2DMY(Today, 3));
        CurrentYearEndDate := DMY2Date(31, 12, Date2DMY(Today, 3));

        if CompanyInfo.Get() then
            CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
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

        if AsAtPostingDate = 0D then
            AsAtPostingDate := CurrentYearEndDate;

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

