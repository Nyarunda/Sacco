namespace CentralDB.CentralDB;
using System.Security.User;

report 50406 "Loan Category Per Last Pay Day"
{
    Caption = 'SACCO Loan Category Per Last Pay Day';
    ProcessingOnly = true;
    UsageCategory = ReportsandAnalysis;

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
                ProductSetup: Record "Product Setup";
            begin

                if not Memb.Get(Loans."Member No.") then CurrReport.skip;

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


                if Loans."Disbursement Account No" = '' then begin
                    Accounts.Reset();
                    Accounts.SetRange("Product Category", Accounts."Product Category"::"Ordinary Savings");
                    Accounts.SetRange("Member No.", Loans."Member No.");
                    if Accounts.FindFirst() then begin
                        Loans."Disbursement Account No" := Accounts."No.";
                        Loans.Modify();
                    end;
                end
                else begin
                    if not Accounts.get(Loans."Disbursement Account No") then begin

                        Accounts.Reset();
                        Accounts.SetRange("Product Category", Accounts."Product Category"::"Ordinary Savings");
                        Accounts.SetRange("Member No.", Loans."Member No.");
                        if Accounts.FindFirst() then begin
                            Loans."Disbursement Account No" := Accounts."No.";
                            Loans.Modify();
                        end;
                    end;
                end;


                Loans.CalcFields("Outstanding Principal", "Outstanding Interest", "Outstanding Penalty", "Total Outstanding Balance", "Employer Code");


                if "Outstanding Principal" <= 0 then
                    CurrReport.Skip;

                if Loans."Disbursement Date" = 0D then
                    CurrReport.Skip;

                if Loans."Approved Amount" <= 0 then
                    CurrReport.Skip;


                ExpectedAmt := 0;
                AmtPaid := 0;
                DefAmount := 0;
                DaysInArrear := 0;
                ArrearsDate := 0D;
                MDef := 0;

                SaccoActivities.GetDefaultedAmount(Loans."Loan No.", CalcDate('-1D', AsAt), ExpectedAmt, AmtPaid, DefAmount, DaysInArrear, ArrearsDate, true, GracePeriod);

                ProductSetup.Get(Loans."Loan Product Type");


                if DefAmount > 0 then
                    MDef := ROUND(DaysInArrear / 30, 1, '=');

                InstallmentDefaulted := MDef;


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

                if InstallmentDefaulted <= 0 then
                    Loans."Loans Category-SASRA" := Loans."loans category-sasra"::Performing;

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
                SASRACategory."Deposit Balance" := MemberActivities.GetAccountBalance(Legacy.GetDepositAccounts(Loans."Member No."));
                SASRACategory."Interest Arrears" := SaccoActivities.GetInterestArrears(Loans."Loan No.", CalcDate('-1M+CM-1D', Today));
                SASRACategory."Days in Arrears" := DaysInArrear;
                SASRACategory."Months in Arrears" := MDef;
                SASRACategory."Total Arrears" := SASRACategory."Interest Arrears" + SASRACategory."Outstanding Penalty" + SASRACategory."Principal Arrears";
                SASRACategory."User Name" := UserId;
                SASRACategory."Account No." := Loans."Disbursement Account No";
                SASRACategory."Installments Defaulted" := InstallmentsDefaulted;
                SASRACategory."Issued Date" := "Disbursement Date";
                SASRACategory."As At" := AsAt;


                //SASRACategory."Total Arrears" := SASRACategory."Outstanding Interest" + SASRACategory."Outstanding Penalty" + SASRACategory."Principal Arrears";
                //if SASRACategory."Principal Arrears" = 0 then
                //   SASRACategory."Total Arrears" := 0;
                SASRACategory."Arrears Date" := ArrearsDate;
                SASRACategory."Issued Date" := "Disbursement Date";
                SASRACategory.Insert;

            end;

            trigger OnPostDataItem()
            begin
            end;

            trigger OnPreDataItem()
            begin
                /*SASRACategory.RESET;
                IF SASRACategory.FINDFIRST THEN
                SASRACategory.DELETEALL;*/


                //AsAt := CalcDate('-1M+CM', Today);
                if AsAt <> Today then
                    AsAt := Today;


                Loans.SetFilter("Date Filter", '..%1', Today);
                Loans.SetRange("Last Pay Date", Today);

                UserSetup.Get(UserId);
                if not UserSetup."Sacco Categorization" then
                    Error('You dont have have rights [Sacco Categorization]');

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

    trigger OnPostReport()
    begin

        Commit;
        //Report.Run(50097,true,false,Loans);
    end;


    var
        SaccoSetup: Record "Sacco Setup";
        Accounts: Record "Savings Accounts";
        SASRACategory: Record "SACCO Categorization";
        EndDate: Date;
        CheckDate: Date;
        InstallmentDefaulted: Integer;
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
        Memb: Record Members;
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        MemberActivities: Codeunit "Member Activities";
        Legacy: Codeunit Legacy;
        InstallmentsDefaulted: Integer;
        DTime: Time;
}
