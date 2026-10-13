
Report 50181 "SACCO Loan Categorization Audi"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where(Posted = const(true));
            RequestFilterFields = "Loan No.", "Date Filter", "Member No.", "Relationship Officer", "Booking Branch";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            var
                GracePeriod: DateFormula;
            begin
                LoanRepaymentSchedule.Reset;
                LoanRepaymentSchedule.SetRange("Loan No.", Loans."Loan No.");
                if LoanRepaymentSchedule.FindLast then begin
                    if LoanRepaymentSchedule."Repayment Date" <> 0D then
                        if Loans."Completion Date" <> LoanRepaymentSchedule."Repayment Date" then begin
                            Loans."Completion Date" := LoanRepaymentSchedule."Repayment Date";
                            Loans.Modify;
                        end;
                end;




                SASRACategory.Reset;
                SASRACategory.SetRange("Loan No.", Loans."Loan No.");
                if SASRACategory.FindFirst then
                    SASRACategory.Delete;


                Loans.CalcFields("Outstanding Principal", "Outstanding Interest", "Outstanding Penalty", "Total Outstanding Balance");




                ExpectedAmt := 0;
                AmtPaid := 0;
                DefAmount := 0;
                DaysInArrear := 0;
                ArrearsDate := 0D;


                if "Outstanding Principal" > 0 then
                    if Loans."Disbursement Date" <> 0D then
                        if Loans."Approved Amount" > 0 then begin





                            SaccoActivities.GetDefaultedAmount(Loans."Loan No.", AsAt, ExpectedAmt, AmtPaid, DefAmount, DaysInArrear, ArrearsDate, false, GracePeriod);

                        end;

                /*0..30: Loans."Loans Category-SASRA":=Loans."Loans Category-SASRA"::Perfoming;
                31..90: Loans."Loans Category-SASRA":=Loans."Loans Category-SASRA"::Watch;
                91..180: Loans."Loans Category-SASRA":=Loans."Loans Category-SASRA"::Substandard;
                181..360: Loans."Loans Category-SASRA":=Loans."Loans Category-SASRA"::Doubtful;
                ELSE Loans."Loans Category-SASRA":=Loans."Loans Category-SASRA"::Loss;
              END;

              IF DaysInArrear < 0 THEN
                  Loans."Loans Category-SASRA":=Loans."Loans Category-SASRA"::Perfoming;
              */

                Loans."Loans Category-SASRA" := Loans."loans category-sasra"::Performing;

                SaccoCategory_New.Reset;
                if SaccoCategory_New.FindFirst then begin
                    repeat
                        if (DaysInArrear >= SaccoCategory_New.From_Days) and (DaysInArrear <= SaccoCategory_New.To_Days) then
                            Loans."Loans Category-SASRA" := SaccoCategory_New."Loan Category";
                    until SaccoCategory_New.Next = 0;
                end;

                SASRACategory.Init;
                SASRACategory."Loan No." := Loans."Loan No.";
                SASRACategory."Loan Category" := Loans."Loans Category-SASRA";
                SASRACategory."Loan Product Type" := Loans."Loan Product Type";
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
                SASRACategory."As At" := AsAt;
                SASRACategory."Total Arrears" := SASRACategory."Outstanding Interest" + SASRACategory."Outstanding Penalty" + SASRACategory."Principal Arrears";
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
                /*SASRACategory.RESET;
                IF SASRACategory.FINDFIRST THEN
                SASRACategory.DELETEALL;*/


                ProgressWindow.Open('Generating Categories:     @1@@@@@@@@@\'

                                            + 'Counter           #2#########'
                                            + 'Total             #3#########'
                                            + 'Press Esc to abort');

                NoOfRecords := Loans.Count;


                if AsAt = 0D then
                    AsAt := Today;




                Loans.SetFilter("Date Filter", '..%1', AsAt);

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("As At"; AsAt)
                {
                    ApplicationArea = Basic;
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

    trigger OnPostReport()
    begin

        Commit;
        Report.Run(50449, true, false, Loans);
    end;

    var
        ProgressWindow: Dialog;
        Counter: Integer;
        SASRACategory: Record "SACCO Categories Audit";
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
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        SaccoCategory_New: Record "Sacco Category _New";

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

