
Report 50239 "Sasra - Annex 1 - 1"
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
                j: Integer;
                GracePeriod: DateFormula;
            begin
                /*
                SASRACategory.RESET;
                SASRACategory.SETRANGE("Loan No.",Loans."Loan No.");
                IF SASRACategory.FINDFIRST THEN
                SASRACategory.DELETE;*/


                Loans.CalcFields("Outstanding Principal", "Total Outstanding Balance", "Outstanding Interest", "Outstanding Penalty", "Total Outstanding Balance");


                //if Loans."Total Outstanding Balance" <= 0 then
                //  CurrReport.Skip;

                /*
                IF Loans."Disbursement Date" = 0D THEN
                CurrReport.SKIP;
                
                IF Loans."Approved Amount" <= 0 THEN
                CurrReport.SKIP;
                */


                ExpectedAmt := 0;
                AmtPaid := 0;
                DefAmount := 0;
                DaysInArrear := 0;
                ArrearsDate := 0D;


                if Loans."Approved Amount" > 0 then
                    if Loans."Disbursement Date" <> 0D then
                        SaccoActivities.GetDefaultedAmount(Loans."Loan No.", AsAt, ExpectedAmt, AmtPaid, DefAmount, DaysInArrear, ArrearsDate, false, GracePeriod);

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





                Members.Get(Loans."Member No.");

                Annex.Init;
                Annex."Loan Number" := Loans."Loan No.";
                Annex."Member Number" := Members."No.";
                Annex."Member Name" := Members.Name;
                Annex."Branch Name" := Members."Global Dimension 2 Code";

                DimensionValue.Reset;
                DimensionValue.SetRange("Dimension Code", 'BRANCH');
                DimensionValue.SetRange(Code, Members."Global Dimension 2 Code");
                if DimensionValue.FindFirst then
                    Annex."Branch Name" := DimensionValue.Name;

                Annex."Loan Officer" := Members."Relationship Officer Name";
                Annex."Employer Name" := Members."Employer Code";
                Annex."Loan Type" := Loans."Loan Product Type Name";
                ;


                //Type of amortization schedule (SLA=straight line – constant principal plus interest in each installment, FIA=fixed installment, BUL=bullet loan, OTHER)
                if Loans."Interest Calculation Method" = Loans."interest calculation method"::"Straight Line" then
                    Annex."Loan Amortization Type" := 'SLA';
                if Loans."Interest Calculation Method" = Loans."interest calculation method"::"Reducing Balance" then
                    Annex."Loan Amortization Type" := 'REDUCING';
                if Loans."Interest Calculation Method" = Loans."interest calculation method"::Amortised then
                    Annex."Loan Amortization Type" := 'FIA';
                if Loans."Interest Calculation Method" = Loans."interest calculation method"::"Reducing Flat" then
                    Annex."Loan Amortization Type" := 'OTHER';
                if Loans."Interest Calculation Method" = Loans."interest calculation method"::"Zero Interest" then
                    Annex."Loan Amortization Type" := 'OTHER';

                Annex."Loan Installments" := Loans.Installments;
                Annex."Annual Loan Rate" := Loans."Annual Interest %";
                Annex."Loan Frequency" := Format(Loans."Repayment Frequency");
                Annex."Date Loan Disbursed" := Loans."Disbursement Date";
                Annex."Loan Amount" := Loans."Approved Amount";
                Annex."Loan Maturity" := Loans."Completion Date";

                CLedger.Reset;
                CLedger.SetRange("Loan No.", Loans."Loan No.");
                CLedger.SetRange("Transaction Type", CLedger."transaction type"::"Principal Repayment");
                CLedger.SetRange(Reversed, false);
                if CLedger.FindFirst then begin
                    Annex."Loan First Pmt date" := CLedger."Posting Date";
                end;


                CLedger.Reset;
                CLedger.SetRange("Loan No.", Loans."Loan No.");
                CLedger.SetRange("Transaction Type", CLedger."transaction type"::"Principal Repayment");
                CLedger.SetFilter("Document No.", '<>%1', '');
                CLedger.SetRange(Reversed, false);
                if CLedger.FindLast then begin
                    Annex."Latest amount paid" := CLedger."Amount (LCY)" * -1;
                    Annex."Latest payment date" := CLedger."Posting Date";
                end;

                Loans.CalcFields("Outstanding Principal", "Outstanding Interest", "Total Guaranteed");

                Annex."Loan Balance" := Loans."Outstanding Principal";

                Annex."Days in Arrears" := DaysInArrear;
                Annex."Arrears date" := ArrearsDate;
                Annex."Loan-Classification" := Format(Loans."Loans Category-SASRA");
                if Loans."Loans Category-SASRA" = Loans."loans category-sasra"::Loss then
                    Annex."Loan loss Provision" := Annex."Loan Balance";

                if Loans."Loan Rescheduled" then
                    Annex."Loan Restructure Flag[1]" := 2;
                if Loans."Loan Restructured" then
                    Annex."Loan Restructure Flag[1]" := 2;

                Annex.Loan_Interest_Due := Loans."Outstanding Interest";

                LoanSecurity.Reset;
                LoanSecurity.SetRange("Loan No.", Loans."Loan No.");
                LoanSecurity.SetFilter("Account No.", '<>%1', '');
                LoanSecurity.SetRange(Substituted, false);
                if LoanSecurity.FindFirst then begin
                    Annex."No. of Loan Guarantors" := LoanSecurity.Count;
                end;

                Annex."Amount of guarantee" := Loans."Total Guaranteed" + Loans."Loanee Guaranteed";

                j := 0;
                LoanSecurity.Reset;
                LoanSecurity.SetRange("Loan No.", Loans."Loan No.");
                LoanSecurity.SetFilter("Account No.", '<>%1', '');
                LoanSecurity.SetRange(Substituted, false);
                LoanSecurity.SetRange("Guarantor Type", LoanSecurity."guarantor type"::Collateral);
                if LoanSecurity.FindFirst then begin
                    repeat
                        j += 1;
                        if LoanCollateralRegister.Get(LoanSecurity."Collateral Reg. No.") then begin
                            if LoanCollateralRegister."Collateral Type" <> LoanCollateralRegister."collateral type"::" " then
                                AddOtherCollateralSecurity(Annex, Format(LoanCollateralRegister."Collateral Type"));

                        end;
                    until LoanSecurity.Next = 0;
                end;

                Annex.Insert;



                CurrentRecordNo += 1;
                ProgressWindow.Update(2, CurrentRecordNo);
                ProgressWindow.Update(3, NoOfRecords);
                ProgressWindow.Update(1, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));

            end;

            trigger OnPostDataItem()
            begin
                ProgressWindow.Close;
                //MESSAGE('Done!!!');
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


                Annex.DeleteAll;
                Loans.SetFilter("Disbursement Date", '..%1', AsAt);
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
        //Report.Run(2000048, true, false)
    end;

    var
        ProgressWindow: Dialog;
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
        Annex: Record "Sasra - Annex 1 Tabke 1";
        CLedger: Record "Credit Ledger Entry";
        LoanSecurity: Record "Loan Security";
        LoanCollateralRegister: Record "Loan Collateral Register";
        DimensionValue: Record "Dimension Value";

    local procedure AddOtherCollateralSecurity(var AnnexRec: Record "Sasra - Annex 1 Tabke 1"; CollateralTypeText: Text)
    var
        CurrentText: Text;
        NewText: Text;
    begin
        CollateralTypeText := DelChr(CollateralTypeText, '<>');
        if CollateralTypeText = '' then
            exit;

        CurrentText := AnnexRec."Other Collateral_Security";
        if StrPos(',' + DelChr(CurrentText, '=', ' ') + ',', ',' + DelChr(CollateralTypeText, '=', ' ') + ',') <> 0 then
            exit;

        if CurrentText = '' then
            NewText := CollateralTypeText
        else
            NewText := CurrentText + ', ' + CollateralTypeText;

        AnnexRec."Other Collateral_Security" := CopyStr(NewText, 1, MaxStrLen(AnnexRec."Other Collateral_Security"));
    end;
}
