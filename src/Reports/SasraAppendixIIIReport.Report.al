report 50194 "Sasra Appendix III Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Sasra Appendix III Report..rdlc';

    dataset
    {
        dataitem(Classification; "Sasra Sectorial Level 2")
        {
            column(ReportForNavId_1; 1) 
            { }
            column(MainSector_Classification; Classification."Main Sector") 
            { }
            column(MainSectorName_Classification; Classification."Main Sector Description") 
            { }
            column(SubSectorLevel1_Classification; Classification."Sub-Sector Level 1 Code") 
            { }
            column(SubSectorLevel1Name_Classification; Classification."Sub-Sector Level 1 Description")
             { }
            column(SubSectorLevel2_Classification; Classification."Sub-Sector Level 2 Code") 
            { }
            column(SubSectorLevel2Name_Classification; Classification."Sub-Sector Level 2 Description") 
            { }
            column(Amt; Amt)
             { }
            column(Q1; Q1) 
            { }
            column(Q2; Q2) 
            { }
            column(Q3; Q3) 
            { }
            column(Q4; Q4) 
            { }
            column(AsAt; AsAt) 
            { }
            column(QuarterText; QuarterText) 
            { }
            column(DateRangeText; DateRangeText) 
            { }
            column(QuarterNo; GetQuarterFilterNo())
             { }

            trigger OnAfterGetRecord()
            var
                QtrBaseDate: Date;
                FilterYear: Integer;
                LoanReportDate: Date;
            begin
                Amt := 0;
                LoanBal := 0;
                LoanCount := 0;
                PerformingBal := 0;
                NonPerformingBal := 0;
                Q1 := 0;
                Q2 := 0;
                Q3 := 0;
                Q4 := 0;

                // Quarters are calendar quarters for the year of the report date.
                FilterYear := Date2DMY(AsAt, 3);
                QtrBaseDate := DMY2Date(1, 1, FilterYear);

                Loans.Reset();
                Loans.SetRange(Posted, true);
                if LoanNo <> '' then
                    Loans.SetRange("Loan No.", LoanNo);

                if Loans.FindFirst() then
                    repeat
                        if LoanMatchesClassification(Loans, Classification) then begin
                            LoanReportDate := GetLoanReportDate(Loans);
                            if LoanDateIsWithinRequestFilter(LoanReportDate) then begin
                                TestDate := QtrBaseDate;
                                if (LoanReportDate >= CalcDate('-CM', TestDate)) and (LoanReportDate <= CalcDate('3M-1D', TestDate)) then
                                    Q1 += Loans."Net To Be Disbursed";

                                TestDate := CalcDate('3M', TestDate);
                                if (LoanReportDate >= CalcDate('-CM', TestDate)) and (LoanReportDate <= CalcDate('3M-1D', TestDate)) then
                                    Q2 += Loans."Net To Be Disbursed";

                                TestDate := CalcDate('3M', TestDate);
                                if (LoanReportDate >= CalcDate('-CM', TestDate)) and (LoanReportDate <= CalcDate('3M-1D', TestDate)) then
                                    Q3 += Loans."Net To Be Disbursed";

                                TestDate := CalcDate('3M', TestDate);
                                if (LoanReportDate >= CalcDate('-CM', TestDate)) and (LoanReportDate <= CalcDate('3M-1D', TestDate)) then
                                    Q4 += Loans."Net To Be Disbursed";

                                Loans.CalcFields("Outstanding Principal");
                                LoanBal += Loans."Outstanding Principal";
                                LoanCount += 1;
                            end;
                        end;
                    until Loans.Next() = 0;

                // Quarter filter: when a specific quarter is chosen, keep only that column.
                case QuarterFilter of
                    QuarterFilter::Q1:
                        begin
                            Q2 := 0;
                            Q3 := 0;
                            Q4 := 0;
                        end;
                    QuarterFilter::Q2:
                        begin
                            Q1 := 0;
                            Q3 := 0;
                            Q4 := 0;
                        end;
                    QuarterFilter::Q3:
                        begin
                            Q1 := 0;
                            Q2 := 0;
                            Q4 := 0;
                        end;
                    QuarterFilter::Q4:
                        begin
                            Q1 := 0;
                            Q2 := 0;
                            Q3 := 0;
                        end;
                end;

                Amt := Q1 + Q2 + Q3 + Q4;
            end;

            trigger OnPreDataItem()
            begin
                if AsAt = 0D then
                    AsAt := Today;

                // Display the end date of the selected calendar quarter in the report header.
                case QuarterFilter of
                    QuarterFilter::Q1:
                        AsAt := DMY2Date(31, 3, Date2DMY(AsAt, 3));
                    QuarterFilter::Q2:
                        AsAt := DMY2Date(30, 6, Date2DMY(AsAt, 3));
                    QuarterFilter::Q3:
                        AsAt := DMY2Date(30, 9, Date2DMY(AsAt, 3));
                    QuarterFilter::Q4:
                        AsAt := DMY2Date(31, 12, Date2DMY(AsAt, 3));
                end;

                case QuarterFilter of
                    QuarterFilter::All:
                        QuarterText := 'All Quarters';
                    QuarterFilter::Q1:
                        QuarterText := 'Q1';
                    QuarterFilter::Q2:
                        QuarterText := 'Q2';
                    QuarterFilter::Q3:
                        QuarterText := 'Q3';
                    QuarterFilter::Q4:
                        QuarterText := 'Q4';
                end;

                DateRangeText := StrSubstNo('Calendar Year %1', Date2DMY(AsAt, 3));
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Filters)
                {
                    field(Quarter; QuarterFilter)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Quarter';
                        OptionCaption = 'All,Q1,Q2,Q3,Q4';
                        ToolTip = 'Show only the selected quarter. Leave as All to show all four quarters.';
                    }
                    field(LoanNo; LoanNo)
                    {
                        ApplicationArea = Basic;
                        TableRelation = Loans;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Q1: Decimal;
        TestDate: Date;
        Q2: Decimal;
        Q3: Decimal;
        Q4: Decimal;
        Amt: Decimal;
        Loans: Record Loans;
        AsAt: Date;
        QuarterFilter: Option "All",Q1,Q2,Q3,Q4;
        QuarterText: Text;
        DateRangeText: Text;
        SasraSectorialTemplate: Record "Sasra - Annex 1 Tabke 1";
        LoanBal: Decimal;
        LoanCount: Integer;
        PerformingBal: Decimal;
        NonPerformingBal: Decimal;
        SActivities: Codeunit "Sacco Activities";
        LoanNo: Code[20];

    local procedure GetQuarterFilterNo(): Integer
    begin
        case QuarterFilter of
            QuarterFilter::All:
                exit(0);
            QuarterFilter::Q1:
                exit(1);
            QuarterFilter::Q2:
                exit(2);
            QuarterFilter::Q3:
                exit(3);
            QuarterFilter::Q4:
                exit(4);
        end;

        exit(0);
    end;

    local procedure GetLoanReportDate(LoanRec: Record Loans): Date
    begin
        if LoanRec."Disbursement Date" <> 0D then
            exit(LoanRec."Disbursement Date");

        exit(LoanRec."Issued Date");
    end;

    local procedure LoanDateIsWithinRequestFilter(LoanReportDate: Date): Boolean
    begin
        if LoanReportDate = 0D then
            exit(false);

        exit(true);
    end;

    local procedure LoanMatchesClassification(LoanRec: Record Loans; ClassificationRec: Record "Sasra Sectorial Level 2"): Boolean
    begin
        if ClassificationRec."Sub-Sector Level 2 Code" = '' then
            exit(false);

        if ClassificationRec."Sub-Sector Level 2 Code" = ClassificationRec."Main Sector" then
            exit(LoanRec."Main Sector Code" = ClassificationRec."Main Sector");

        if ClassificationRec."Sub-Sector Level 2 Code" = ClassificationRec."Sub-Sector Level 1 Code" then
            exit((LoanRec."Main Sector Code" = ClassificationRec."Main Sector") and
                 (LoanRec."Sub-Sector Level 1 Code" = ClassificationRec."Sub-Sector Level 1 Code"));

        exit((LoanRec."Main Sector Code" = ClassificationRec."Main Sector") and
             (LoanRec."Sub-Sector Level 1 Code" = ClassificationRec."Sub-Sector Level 1 Code") and
             (LoanRec."Sub-Sector Level 2 Code" = ClassificationRec."Sub-Sector Level 2 Code"));
    end;
}
