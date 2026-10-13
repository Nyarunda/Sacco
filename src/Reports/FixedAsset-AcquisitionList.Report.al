Report 50329 "Fixed Asset - Acquisition"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Fixed Asset - Acquisition List.rdlc';
    Caption = 'Fixed Asset - Acquisition List';

    dataset
    {
        dataitem("Fixed Asset"; "Fixed Asset")
        {
            RequestFilterFields = "No.", "FA Class Code", "FA Subclass Code", "Budgeted Asset";
            column(ReportForNavId_3794; 3794)
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(DeprBookText; DeprBookText)
            {
            }
            column(FixAssetTableCaptFaFilter; TableCaption + ': ' + FAFilter)
            {
            }
            column(No_FixedAsset; "No.")
            {
                IncludeCaption = true;
            }
            column(Desc_FixedAsset; Description)
            {
                IncludeCaption = true;
            }
            column(LocCode_FixedAsset; "FA Location Code")
            {
                IncludeCaption = true;
            }
            column(RespEmp_FixedAsset; "Responsible Employee")
            {
                IncludeCaption = true;
            }
            column(SerialNo_FixedAsset; "Serial No.")
            {
                IncludeCaption = true;
            }
            column(FaDeprBookAcquDate; Format(FADeprBook."Acquisition Date"))
            {
            }
            column(FixedAssetAcqListCptn; FixedAssetAcqListCptnLbl)
            {
            }
            column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
            {
            }
            column(FADeprBkAcquisitionDtCptn; FADeprBkAcquisitionDtCptnLbl)
            {
            }
            column(BookValue; BookValue)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Clear(FADeprBook);
                PrintFA := false;
                if not FADeprBook.Get("No.", DeprBookCode) then begin
                    if FAWithoutAcqDate then
                        PrintFA := true;
                end else begin
                    if FADeprBook."Acquisition Date" = 0D then begin
                        if FAWithoutAcqDate then
                            PrintFA := true;
                    end else
                        PrintFA := (FADeprBook."Acquisition Date" >= StartingDate) and
                          (FADeprBook."Acquisition Date" <= EndingDate);
                end;

                FADeprBook.CalcFields("Book Value");

                BookValue := FADeprBook."Book Value";

                if not PrintFA then
                    CurrReport.Skip;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(DeprBookCode; DeprBookCode)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Depreciation Book';
                        TableRelation = "Depreciation Book";
                    }
                    group(AcquisitionPeriod)
                    {
                        Caption = 'Acquisition Period';
                        field(StartingDate; StartingDate)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Starting Date';
                        }
                        field(EndingDate; EndingDate)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Ending Date';
                        }
                    }
                    field(FAWithoutAcqDate; FAWithoutAcqDate)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Include Fixed Assets Not Yet Acquired';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            if DeprBookCode = '' then begin
                FASetup.Get;
                DeprBookCode := FASetup."Default Depr. Book";
            end;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        FAGenReport.AppendFAPostingFilter("Fixed Asset", StartingDate, EndingDate);
        FAFilter := "Fixed Asset".GetFilters;
        DeprBookText := StrSubstNo('%1%2 %3', DeprBook.TableCaption, ':', DeprBookCode);
        ValidateDates(StartingDate, EndingDate);
        FAGenReport.ValidateDates(StartingDate, EndingDate);
    end;

    var
        FASetup: Record "FA Setup";
        DeprBook: Record "Depreciation Book";
        FADeprBook: Record "FA Depreciation Book";
        FAGenReport: Codeunit "FA General Report";
        DeprBookCode: Code[10];
        DeprBookText: Text[50];
        FAFilter: Text;
        StartingDate: Date;
        EndingDate: Date;
        FAWithoutAcqDate: Boolean;
        PrintFA: Boolean;
        Text001: label 'You must specify a Starting Date.';
        Text002: label 'You must specify an Ending Date.';
        Text003: label 'You must specify an Ending Date that is later than the Starting Date.';
        FixedAssetAcqListCptnLbl: label 'Fixed Asset - Acquisition List';
        CurrReportPageNoCaptionLbl: label 'Page';
        FADeprBkAcquisitionDtCptnLbl: label 'Acquisition Date';
        BookValue: Decimal;


    procedure ValidateDates(StartingDate: Date; EndingDate: Date)
    begin
        if StartingDate = 0D then
            Error(Text001);

        if EndingDate = 0D then
            Error(Text002);

        if StartingDate > EndingDate then
            Error(Text003);
    end;
}

