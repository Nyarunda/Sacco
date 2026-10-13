//namespace CentralDB.CentralDB;

report 50471 "Manual Loans Interest"
{
    ApplicationArea = All;
    Caption = 'Manual Loans Interest';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Manual Loans Interest.rdlc';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(LoansApp; Loans)
        {
            DataItemTableView = where(Posted = filter(true), "Loan Product Type" = filter(<> 'L30' & <> 'L43'));
            RequestFilterFields = "Loan No.", "Member No.";
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
                Rate: Decimal;
                LoansBillingDates: Record "Loans Billing Date";
                Members: Record Members;
            begin
                LoansApp.CalcFields("Last Int. Paid Date", "Last Principal Pay Date", "Outstanding Interest", "Outstanding Principal", "Rollover Count");

                if LoansApp."Outstanding Interest" >= LoansApp."Outstanding Principal" then
                    CurrReport.Skip;

                if LoansApp."Loan Product Type" = 'L30' then
                    CurrReport.Skip();

                ProductSetup.Get(LoansApp."Loan Product Type");

                if "Outstanding Interest" >= "Outstanding Principal" then
                    CurrReport.Skip();

                BalDate := 0D;
                PDate := 0D;
                CurrentInterest := 0;
                LoanBal := 0;
                ExpInterest := 0;
                InterestAmount := 0;
                CheckBal := 0;
                CheckingDate := 0D;
                Rate := 0;

                if LoansApp."Disbursement Date" < DMY2Date(01, 09, 2024) then
                    CheckingDate := CalcDate('-1D', StartDate)
                else
                    CheckingDate := EndDate;


                IntDueDate := SaccoActivities.GetLoanRePaymentDate(LoansApp, StartDate);

                if PostingDate <> 0D then
                    if PostingDate <> IntDueDate then
                        CurrReport.Skip();


                if IntDueDate < StartDate then
                    PDate := StartDate
                else
                    PDate := IntDueDate;

                if PostingDate <> 0D then
                    PDate := PostingDate;


                if IntDueDate < DMY2Date(01, 09, 2024) then
                    IntDueDate := DMY2Date(31, 08, 2024);

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

                if LoansApp."Annual Interest %" > 0 then
                    Rate := LoansApp."Annual Interest %"
                else
                    Rate := ProductSetup."Interest Rate (Min.)";

                ExpInterest := Round(LoanBal * (Rate / 1200), 0.01, '=');

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

                if InterestAmount < ExpInterest then
                    CurrReport.Skip();

                Members.Reset();
                Members.setrange("No.", LoansApp."Member No.");
                Members.Setrange("Member Status", Members."Member Status"::Deceased);
                if Members.findfirst() then
                    InterestAmount := 0;

                if InterestAmount < 0 then begin
                    CurrReport.Skip();
                end;

                if CheckBal > 0 then begin
                    if CheckBal < 1 then CurrReport.Skip();
                end;


                LoansBillingDates.Reset();
                LoansBillingDates.SetRange("Loan No", Loans."Loan No.");
                if LoansBillingDates.FindFirst() then begin
                    IntDueDate := LoansBillingDates."Expected Billing Date";
                    PostingDate := LoansBillingDates."Current Billing Date";
                end;

                if LoansApp."Schedule Start Date" > IntDueDate then
                    CurrReport.Skip();

                Loans.Reset;
                Loans.SetRange("Loan No.", LoansApp."Loan No.");
                if Loans.FindSet() then begin

                    Loans.CalcFields("Loans Category-SACCO");

                    begin
                        if LoanType.Get(Loans."Loan Product Type") then begin

                            Loans.CalcFields(Loans."Outstanding Principal", Loans."Outstanding Interest");


                            if (InterestAmount <> 0) and (InsertJournals) then begin

                                if CustMember.Get(Loans."Member No.") then begin

                                    if Loans."Global Dimension 1 Code" = '' then begin
                                        Loans."Global Dimension 1 Code" := LoanType."Global Dimension 1 Code";
                                        Loans.Modify();
                                    end;

                                    if Loans."Booking Branch" = '' then begin
                                        Loans."Booking Branch" := CustMember."Global Dimension 2 Code";
                                        Loans.Modify();
                                    end;


                                    SaccoActivities.JournalInsert(
                                    JTemplate,
                                    JBatch,
                                    "Loan No." + ' REF',
                                    PostingDate,
                                    Accttype::Credit,
                                    Loans."Loan Account",
                                    'Interest Due' + ' ' + CopyStr(Format(PostingDate, 0, '<Month Text>'), 1, 3) + ' ' + Format(Date2dmy(PostingDate, 3)),
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
                group("Posting Date")
                {
                    field(PostingDate; PostingDate)
                    {
                        ApplicationArea = basic;
                        ToolTip = 'When the posting date is not black it will check and post the interest for that specific DAY!';
                    }
                }
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
                    field("Insert To Journals"; InsertJournals)
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
        InsertJournals: Boolean;
        BalDate: Date;
        PDate: Date;
        PostingDate: Date;
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
