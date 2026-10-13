
Report 50165 "Update Sacco Categories"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where(Posted = const(true));
            RequestFilterFields = "Loan No.", "Date Filter", "Member No.", "Relationship Officer";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            var
                GracePeriod: DateFormula;
            begin

                SASRACategory.Reset;
                SASRACategory.SetRange("Loan No.", Loans."Loan No.");
                if SASRACategory.FindFirst then
                    SASRACategory.Delete;


                Loans.CalcFields("Outstanding Principal", "Outstanding Interest", "Outstanding Penalty", "Total Outstanding Balance");

                if "Outstanding Principal" = 0 then
                    CurrReport.Skip;

                //if Loans."Disbursement Date" = 0D then
                //  CurrReport.Skip;

                //if Loans."Approved Amount" <= 0 then
                //  CurrReport.Skip;


                ExpectedAmt := 0;
                AmtPaid := 0;
                DefAmount := 0;
                DaysInArrear := 0;
                ArrearsDate := 0D;
                MDef := 0;

                SaccoActivities.GetDefaultedAmount(Loans."Loan No.", CalcDate('-1D', AsAt), ExpectedAmt, AmtPaid, DefAmount, DaysInArrear, ArrearsDate, true, GracePeriod);

                if DefAmount > 0 then
                    MDef := ROUND(DaysInArrear / 30, 1, '=');

                case DaysInArrear of
                    0:
                        Loans."Loans Category-SASRA" := Loans."Loans Category-SASRA"::Performing;

                    1 .. 30:
                        Loans."Loans Category-SASRA" := Loans."Loans Category-SASRA"::Watch;

                    31 .. 180:
                        Loans."Loans Category-SASRA" := Loans."Loans Category-SASRA"::Substandard;

                    181 .. 360:
                        Loans."Loans Category-SASRA" := Loans."Loans Category-SASRA"::Doubtful;

                    else
                        Loans."Loans Category-SASRA" := Loans."Loans Category-SASRA"::Loss;
                end;

                if DaysInArrear < 0 then
                    Loans."Loans Category-SASRA" := Loans."loans category-sasra"::Performing;


                LockTimeout(false);
                SASRACategory.Init;
                SASRACategory."Loan No." := Loans."Loan No.";
                SASRACategory."Loan Category" := Loans."Loans Category-SASRA";
                SASRACategory."Loan Product Type" := Loans."Loan Product Type";
                SASRACategory."As At" := AsAt;
                SASRACategory."Member No." := Loans."Member No.";
                SASRACategory."Member Name" := Loans."Member Name";
                SASRACategory."Approved Amount" := Loans."Approved Amount";
                SASRACategory."Outstanding Principal" := Loans."Outstanding Principal";
                SASRACategory."Outstanding Interest" := Loans."Outstanding Interest";
                SASRACategory."Outstanding Penalty" := Loans."Outstanding Penalty";
                SASRACategory."Total Outstanding Balance" := Loans."Total Outstanding Balance";
                SASRACategory."Principal Expected" := ExpectedAmt;
                SASRACategory."Principal Paid" := AmtPaid;
                SASRACategory."Principal Arrears" := DefAmount;
                SASRACategory."Days in Arrears" := DaysInArrear;
                SASRACategory."Issued Date" := "Disbursement Date";


                SASRACategory."Total Arrears" := SASRACategory."Outstanding Interest" + SASRACategory."Outstanding Penalty" + SASRACategory."Principal Arrears";


                if SASRACategory."Principal Arrears" <= 0 then
                    SASRACategory."Total Arrears" := 0;


                SASRACategory."User Name" := UserId;
                SASRACategory.Insert;

                CurrentRecordNo += 1;
                ProgressWindow.Update(2, CurrentRecordNo);
                ProgressWindow.Update(3, NoOfRecords);
                ProgressWindow.Update(1, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));
            end;

            trigger OnPostDataItem()
            begin
                ProgressWindow.Close;
            end;

            trigger OnPreDataItem()
            begin

                SASRACategory.Reset;
                SASRACategory.SetFilter("Total Balance", '<=0');
                if SASRACategory.FindFirst then
                    SASRACategory.DeleteAll;


                ProgressWindow.Open('Generating Categories:     @1@@@@@@@@@\'
                                            + 'Counter           #2#########'
                                            + 'Total             #3#########'
                                            + 'Press Esc to abort');

                NoOfRecords := Loans.Count;


                if AsAt <> Today then
                    AsAt := Today;




                Loans.SetFilter("Date Filter", '..%1', AsAt);
            end;
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

    var
        ProgressWindow: Dialog;
        Counter: Integer;
        SASRACategory: Record "SACCO Categorization";
        EndDate: Date;
        CheckDate: Date;
        NoOfRecords: Integer;
        CurrentRecordNo: Integer;
        SaccoActivities: Codeunit "Sacco Activities";
        AmtDefaulted: Decimal;
        UserSetup: Record "User Setup";
        ExpectedAmt: Decimal;
        AmtPaid: Decimal;
        DefAmount: Decimal;
        DaysInArrear: Integer;
        ArrearsDate: Date;
        AsAt: Date;
        MDef: Integer;

    local procedure UpdateUserPostingDates()
    var
        GenSetup: Record "Sacco Setup";
        DF: DateFormula;
        FromDate: Date;
    begin

        FromDate := Today;
        GenSetup.Get;
        if GenSetup."Posting Date Limit" <> DF then begin
            FromDate := CalcDate('-' + Format(GenSetup."Posting Date Limit"), Today);
        end;

        UserSetup.Reset;
        UserSetup.SetFilter("Allow Posting From", '<>%1', FromDate);
        if UserSetup.FindFirst then
            UserSetup.ModifyAll("Allow Posting From", FromDate);


        UserSetup.Reset;
        UserSetup.SetFilter("Allow Posting To", '<>%1', Today);
        if UserSetup.FindFirst then
            UserSetup.ModifyAll("Allow Posting To", Today);
    end;
}

