namespace CentralDB.CentralDB;
using System.Security.User;

report 50409 "SASRA Ln Cat. Per Last Pay Dat"
{
    Caption = 'SASRA Ln Cat. Per Last Pay Dat';
    ProcessingOnly = true;
    UsageCategory = ReportsandAnalysis;

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

                SASRACategory.RESET;
                SASRACategory.SETRANGE("Loan No.", Loans."Loan No.");
                IF SASRACategory.FINDFIRST THEN
                    SASRACategory.DELETE;


                Loans.CalcFields("Outstanding Principal", "Outstanding Interest", "Outstanding Penalty", "Total Outstanding Balance");

                if "Outstanding Principal" = 0 then
                    CurrReport.Skip;

                if Loans."Disbursement Date" = 0D then begin
                    Loans."Disbursement Date" := Loans."Application Date";
                    Loans.Modify();
                end;

                if Loans."Approved Amount" = 0 then begin
                    Loans."Approved Amount" := Loans."Requested Amount";

                    If Loans."Approved Amount" = 0 then begin
                        LoanLedger.Reset();
                        LoanLedger.SetRange("Loan No.", "Loan No.");
                        LoanLedger.SetRange("Account No.", "Member No.");
                        LoanLedger.SetRange("Transaction Type", LoanLedger."Transaction Type"::"Loan Disbursement");
                        if LoanLedger.FindFirst() then
                            Loans."Approved Amount" := LoanLedger.Amount;

                    end;
                    Modify();
                end;

                ExpectedAmt := 0;
                AmtPaid := 0;
                DefAmount := 0;
                DaysInArrear := 0;
                ArrearsDate := 0D;

                SaccoActivities.GetDefaultedAmount(Loans."Loan No.", AsAt, ExpectedAmt, AmtPaid, DefAmount, DaysInArrear, ArrearsDate, false, GracePeriod);

                if (DaysInArrear > 0) and (DaysInArrear < 30) then
                    MDef := 1
                else
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

                if DaysInArrear < 0 then
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
                SASRACategory."Days in Arrears" := DaysInArrear;
                SASRACategory."As At" := AsAt;
                SASRACategory."Total Arrears" := SASRACategory."Outstanding Interest" + SASRACategory."Outstanding Penalty" + SASRACategory."Principal Arrears";
                SASRACategory."User Name" := UserId;

                if SASRACategory."Loan Category" = SASRACategory."Loan Category"::Performing then
                    SASRACategory."IFRS Stage" := SASRACategory."IFRS Stage"::"Stage 1";


                if SASRACategory."Loan Category" = SASRACategory."Loan Category"::Watch then
                    SASRACategory."IFRS Stage" := SASRACategory."IFRS Stage"::"Stage 1";


                if SASRACategory."Loan Category" = SASRACategory."Loan Category"::Substandard then
                    SASRACategory."IFRS Stage" := SASRACategory."IFRS Stage"::"Stage 2";


                if SASRACategory."Loan Category" = SASRACategory."Loan Category"::Doubtful then
                    SASRACategory."IFRS Stage" := SASRACategory."IFRS Stage"::"Stage 3";


                if SASRACategory."Loan Category" = SASRACategory."Loan Category"::Loss then
                    SASRACategory."IFRS Stage" := SASRACategory."IFRS Stage"::"Stage 3";


                if SASRACategory."Principal Arrears" <= 0 then
                    SASRACategory."Total Arrears" := 0;

                SASRACategory."Issued Date" := "Disbursement Date";


                SASRACategory."Total Arrears" := SASRACategory."Outstanding Interest" + SASRACategory."Outstanding Penalty" + SASRACategory."Principal Arrears";



                if SASRACategory."IFRS Stage" = SASRACategory."IFRS Stage"::"Stage 1" then begin
                    IFRSModel.Reset();
                    IFRSModel.SetRange(Stage, 1);
                    if IFRSModel.FindFirst() then begin
                        SASRACategory.ECL := Round(SASRACategory."Total Outstanding Balance" * IFRSModel.PD / 100 * IFRSModel.LGD / 100);
                    end;
                end;
                if SASRACategory."IFRS Stage" = SASRACategory."IFRS Stage"::"Stage 2" then begin
                    IFRSModel.Reset();
                    IFRSModel.SetRange(Stage, 2);
                    if IFRSModel.FindFirst() then begin
                        SASRACategory.ECL := Round(SASRACategory."Total Outstanding Balance" * IFRSModel.PD / 100 * IFRSModel.LGD / 100);
                    end;
                end;
                if SASRACategory."IFRS Stage" = SASRACategory."IFRS Stage"::"Stage 3" then begin
                    IFRSModel.Reset();
                    IFRSModel.SetRange(Stage, 3);
                    if IFRSModel.FindFirst() then begin
                        SASRACategory.ECL := Round(SASRACategory."Outstanding Principal" * IFRSModel.LGD / 100);
                    end;
                end;


                SASRACategory."Account No." := Loans."Disbursement Account No";
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


                ProgressWindow.Open('Generating Categories:     @1@@@@@@@@@\'
                                            + 'Counter           #2#########'
                                            + 'Total             #3#########'
                                            + 'Press Esc to abort');

                NoOfRecords := Loans.Count;


                if AsAt = 0D then
                    AsAt := Today;



                Loans.SetRange("Last Principal Pay Date", AsAt);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(AsAt; AsAt)
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
        //Report.Run(Report::"Loans Defaulter Aging - SASRA", true, false);
    end;

    var
        ProgressWindow: Dialog;
        IFRSModel: Record "IFRS-9 Model";
        Counter: Integer;
        SASRACategory: Record "Sasra Categorization";
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
        RShipOfficer: Code[20];
        Members: Record Members;
        Accounts: Record "Savings Accounts";
        LoanLedger: Record "Credit Ledger Entry";

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

