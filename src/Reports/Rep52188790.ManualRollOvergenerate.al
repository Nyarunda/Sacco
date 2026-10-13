report 50472 "Manual RollOver generate"
{
    Caption = 'Manual RollOver generate';


    ApplicationArea = All;
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(LoansApp; Loans)
        {
            DataItemTableView = where(Posted = filter(true), "Loan Product Type" = filter('L30'), "Rollover Count" = filter(< 3));
            column(Loan_No_; "Loan No.")
            {
            }
            column(Member_No_; "Member No.")
            {
            }
            column(Member_Name; "Member Name")
            {
            }
            column(Disbursement_Date; "Disbursement Date")
            {
            }
            column(Loan_Product_Type_Name; "Loan Product Type Name")
            {
            }
            column(LoanBal; LoanBal)
            {
            }
            column(ExpInterest; ExpInterest)
            {
            }
            column(CurrentInterest; CurrentInterest)
            {
            }
            column(InterestAmount; InterestAmount)
            {
            }
            column(IntDueDate; IntDueDate)
            {
            }


            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                UserSetup.Get(UserId);
                UserSetup.TestField("General Journal Template");
                UserSetup.TestField("General Journal Batch");

                JTemplate := UserSetup."General Journal Template";
                JBatch := UserSetup."General Journal Batch";
                SaccoActivities.JournalInit(JTemplate, JBatch);

                if StartDate = 0D then
                    Error('Start date must have a value');

                if StartDate <> CalcDate('-CM', StartDate) then
                    Error('Start date must be at the start of month');

                if EndDate = 0D then
                    Error('End date must have a value');

                if EndDate <> CalcDate('CM', EndDate) then
                    Error('End date must be at the End of month');

            end;

            trigger OnAfterGetRecord()
            var
                DocNo: Code[20];
                "Document No.": Code[20];
                LoansInterest: Record "Loan Interest Buffer";
                LoanAmount: Decimal;
                LoanType: Record "Product Setup";
                LineNo: Integer;
                CheckBal: Decimal;
                CheckingDate: Date;
                Logs: Record "Rollover Logs";
                i: Integer;
            begin
                LoansApp.CalcFields("Last Int. Paid Date", "Last Principal Pay Date", "Outstanding Interest", "Outstanding Principal", "Rollover Count");

                if LoansApp."Outstanding Interest" >= LoansApp."Outstanding Principal" then
                    CurrReport.Skip;

                ProductSetup.Get(LoansApp."Loan Product Type");


                BalDate := 0D;
                PDate := 0D;
                CurrentInterest := 0;
                LoanBal := 0;
                ExpInterest := 0;
                InterestAmount := 0;
                CheckBal := 0;
                CheckingDate := 0D;
                IntDueDate := 0D;
                i := 0;

                if LoansApp."Disbursement Date" < DMY2Date(01, 09, 2024) then
                    CheckingDate := CalcDate('-1D', StartDate)
                else
                    CheckingDate := EndDate;

                IntDueDate := SaccoActivities.GetLoanRePaymentDate(LoansApp, EndDate) + 3;

                if IntDueDate > Today then
                    CurrReport.Skip();

                Loans.Reset;
                Loans.SetRange("Loan No.", LoansApp."Loan No.");
                Loans.SetFilter("Date Filter", '..%1', IntDueDate);
                Loans.SetFilter("Outstanding Principal", '>0');
                //Loans.SetFilter("Last Pay Date", '<%1', CalcDate('6M', Today));
                if Loans.FindSet() then begin
                    Loans.CalcFields("Outstanding Principal");
                    LoanBal := Loans."Outstanding Principal";
                end;

                if LoanBal <= 0 then begin

                    Loans.Reset;
                    Loans.SetRange("Loan No.", LoansApp."Loan No.");
                    Loans.SetFilter("Date Filter", '..%1', IntDueDate - 1);
                    Loans.SetFilter("Outstanding Principal", '>0');
                    //Loans.SetFilter("Last Pay Date", '<%1', CalcDate('6M', Today));
                    if Loans.FindSet() then begin
                        Loans.CalcFields("Outstanding Principal");
                        LoanBal := Loans."Outstanding Principal";
                    end;
                end;

                ExpInterest := LoanBal * (ProductSetup."Rollover Fee %" / 100);

                Loans.Reset;
                Loans.SetRange("Loan No.", LoansApp."Loan No.");
                Loans.SetFilter("Date Filter", '%1..%2', StartDate, EndDate);
                if Loans.FindFirst() then begin
                    Loans.CalcFields("Interest Due");
                    CurrentInterest := Loans."Interest Due";
                end;

                InterestAmount := ExpInterest - CurrentInterest;

                /*   LSchedule.Reset();
                  LSchedule.SetRange("Loan No.", LoansApp."Loan No.");
                  LSchedule.SetFilter("Repayment Date", '%1..%2', StartDate, EndDate);
                  if LSchedule.FindFirst() then begin
                      BalDate := LSchedule."Repayment Date"
                  end
                  else begin
                      BalDate := LoansApp."Last Principal Pay Date";
                  end; */

                if InterestAmount < 0 then begin
                    CheckBal := InterestAmount * -1;
                    if CheckBal < 1 then CurrReport.Skip();
                end;

                if InterestAmount > 0 then begin
                    if InterestAmount < 1 then CurrReport.Skip();
                end;


                if LoansApp."Schedule Start Date" >= IntDueDate then
                    CurrReport.Skip();

                Loans.Reset;
                Loans.SetRange("Loan No.", LoansApp."Loan No.");
                if Loans.FindSet() then begin

                    Loans.CalcFields("Loans Category-SACCO");

                    begin
                        if LoanType.Get(Loans."Loan Product Type") then begin

                            Loans.CalcFields(Loans."Outstanding Principal", Loans."Outstanding Interest");

                            PDate := IntDueDate;

                            SaccoSetup.Get;

                            if (InterestAmount <> 0) then begin

                                if CustMember.Get(Loans."Member No.") then begin

                                    if Loans."Global Dimension 1 Code" = '' then begin
                                        Loans."Global Dimension 1 Code" := LoanType."Global Dimension 1 Code";
                                        Loans.Modify();
                                    end;

                                    Loans."Completion Date" := CalcDate('+1M', Loans."Completion Date");
                                    Loans.Installments += 1;


                                    if Loans."Booking Branch" = '' then begin
                                        Loans."Booking Branch" := CustMember."Global Dimension 2 Code";
                                    end;

                                    Loans.Modify();


                                    SaccoActivities.JournalInsert(
                                    JTemplate,
                                    JBatch,
                                    'R-FEE ' + Loans."Loan No.",
                                    Today,
                                    Accttype::Credit,
                                    Loans."Loan Account",
                                    CopyStr('Rollover Fee', 1, 50),
                                    BalAcctType::"G/L Account",
                                    LoanType."Loan Interest Income [G/L]",
                                    InterestAmount,
                                    "Loan No.",
                                    "Loan No.",
                                    Transtype::"Interest Due",
                                    Loans."Global Dimension 1 Code",
                                    Loans."Booking Branch",
                                    true,
                                    TChannel::"Interest Billing",
                                    "Dimension Set ID"
                                    );

                                    Logs.Reset();
                                    if Logs.FindLast() then
                                        i := Logs."Entry No." + 1;

                                    Logs.init();
                                    Logs."Loan no." := Loans."Loan No.";
                                    Logs."Entry No." := i;
                                    Logs."Date Processed" := today;
                                    Logs.Insert();

                                    SaccoActivities.GenerateMobileRepaymentSchedule(Loans);

                                end;
                            end;
                        end;
                    end;
                end;
            end;
        }

    }



    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = Basic;
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = Basic;
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }

    trigger OnInitReport()
    var
        myInt: Integer;
    begin
        UserSetup.Get(UserId);
        if not UserSetup."Bill Interest" then
            Error('You do not have permission to Loan Interest Billing. Contact your administrator');
    end;

    var
        BalDate: Date;
        PDate: Date;
        StartDate: Date;
        EndDate: Date;
        InterestAmount: Decimal;
        CurrentInterest: Decimal;
        Loans: Record Loans;
        IntDueDate: Date;
        LoanBal: Decimal;
        ExpInterest: Decimal;
        JBatch: Code[20];
        JTemplate: code[20];
        TransType: Enum "Transaction Type Enum";
        TChannel: enum "Transaction Channel";
        UserSetup: Record "User Setup";
        AcctType: Enum "Gen. Journal Account Type";
        BalAcctType: Enum "Gen. Journal Account Type";
        SaccoSetup: record "Sacco Setup";
        CLedger: Record "Credit Ledger Entry";
        CustMember: record Members;
        ProductSetup: record "Product Setup";
        SaccoActivities: Codeunit "Sacco Activities";
        LSchedule: Record "Loan Repayment Schedule";
}
