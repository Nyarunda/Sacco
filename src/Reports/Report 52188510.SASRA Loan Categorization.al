
Report 50173 "SASRA Loan Categorization"
{
    ProcessingOnly = true;
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where(Posted = const(true));
            RequestFilterFields = "Loan No.", "Date Filter", "Member No.", "Relationship Officer", Source, "Loan Product Type";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            var
                GracePeriod: DateFormula;
                SACCOCategory: Record "SACCO Categorization";
                ProductSetup: Record "Product Setup";
            begin

                SASRACategory.RESET;
                SASRACategory.SETRANGE("Loan No.", Loans."Loan No.");
                IF SASRACategory.FINDFIRST THEN
                    SASRACategory.Delete();

                if not Memb.Get(Loans."Member No.") then CurrReport.skip;

                Loans.CalcFields("Outstanding Principal", "Outstanding Insurance", "Outstanding Interest", "Outstanding Penalty", "Total Outstanding Balance", "Principal Paid", "Interest Paid");

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
                MDef := 0;

                SaccoActivities.GetDefaultedAmount(Loans."Loan No.", AsAt, ExpectedAmt, AmtPaid, DefAmount, DaysInArrear, ArrearsDate, false, GracePeriod);

                /* if (DaysInArrear > 0) and (DaysInArrear < 30) then
                    MDef := 1
                else
                    if DefAmount > 0 then
                        MDef := ROUND(DaysInArrear / 30, 1, '='); */

                MDef := SaccoActivities.GetMonthsInDefault(Loans."Loan No.", AsAt, GracePeriod, DefAmount);

                MDef := ROUND(MDef, 1, '=');

                DaysInArrear := ROUND(MDef * 30, 1, '=');

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

                //Loans."Loans Category-SACCO" := Loans."Loans Category-SASRA";

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
                SASRACategory."Interest Paid" := Loans."Interest Paid";
                SASRACategory."Principal Arrears" := DefAmount;
                SASRACategory."Interest Arrears" := SaccoActivities.GetInterestArrearsSASRA(Loans."Loan No.", calcdate('-CM-1D',AsAt));
                SASRACategory."Days in Arrears" := DaysInArrear;
                SASRACategory."Months in Arrears" := MDef;
                SASRACategory."As At" := AsAt;
                SASRACategory."Total Arrears" := SASRACategory."Interest Arrears" + SaccoActivities.GetInsuranceArrears(Loans."Loan No.", CalcDate('-CM-1D', AsAt)) + SASRACategory."Outstanding Penalty" + SASRACategory."Principal Arrears";
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

                //SASRACategory."Total Arrears" := SASRACategory."Outstanding Interest" + SASRACategory."Outstanding Penalty" + SASRACategory."Principal Arrears";

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
                /* 
                SACCOCategory.Reset();
                SACCOCategory.SetRange("Loan No.", Loans."Loan No.");
                if SACCOCategory.FindFirst() then
                    SACCOCategory.Delete();



                SACCOCategory.Init;
                SACCOCategory."Loan No." := Loans."Loan No.";
                SACCOCategory."Loan Category" := Loans."Loans Category-SASRA";
                SACCOCategory."Loan Product Type" := Loans."Loan Product Type";
                SACCOCategory."As At" := AsAt;
                SACCOCategory."Member No." := Loans."Member No.";
                SACCOCategory."Member Name" := Loans."Member Name";
                SACCOCategory."Approved Amount" := Loans."Approved Amount";
                SACCOCategory."Outstanding Principal" := Loans."Outstanding Principal";
                SACCOCategory."Outstanding Interest" := Loans."Outstanding Interest";
                SACCOCategory."Outstanding Penalty" := Loans."Outstanding Penalty";
                SACCOCategory."Total Outstanding Balance" := Loans."Total Outstanding Balance";
                SACCOCategory."Principal Expected" := ExpectedAmt;
                SACCOCategory."Principal Paid" := AmtPaid;
                SACCOCategory."Principal Arrears" := DefAmount;
                SACCOCategory."Days in Arrears" := DaysInArrear;
                SACCOCategory."Issued Date" := "Disbursement Date";

                SACCOCategory."Total Arrears" := SACCOCategory."Outstanding Interest" + SACCOCategory."Outstanding Penalty" + SACCOCategory."Principal Arrears";

                if SACCOCategory."Principal Arrears" <= 0 then
                    SACCOCategory."Total Arrears" := 0;


                SACCOCategory."User Name" := UserId;
                SACCOCategory.Insert; 
                */

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

                /* SASRACategory.Reset;
                 if SASRACategory.FindFirst then
                     SASRACategory.DeleteAll;
                     */


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
                field(AsAt; AsAt)
                {
                    ApplicationArea = Basic;
                }
                field(ShowSasraReport; ShowSasraReport)
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies whether to show the SASRA report after generating the categories.';
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
        if ShowSasraReport then
            Report.Run(Report::"Loans Defaulter Aging - SASRA", true, false);
    end;

    var
        InstallmentDefaulted: Integer;
        ProgressWindow: Dialog;
        IFRSModel: Record "IFRS-9 Model";
        Counter: Integer;
        SASRACategory: Record "Sasra Categorization";
        EndDate: Date;
        CheckDate: Date;
        NoOfRecords: Integer;
        ShowSasraReport: Boolean;
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
        MDef: decimal;
        RShipOfficer: Code[20];
        Members: Record Members;
        Accounts: Record "Savings Accounts";
        LoanLedger: Record "Credit Ledger Entry";
        Memb: Record Members;
        Scope: Text;


    procedure setScope(CurrScope: Text)
    var
    Begin
        Scope := CurrScope;
    End;

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

