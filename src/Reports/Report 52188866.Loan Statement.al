Report 50568 "Loan Statement"
{
    ApplicationArea = All;
    Caption = 'Member Loan Statement';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loan Statement.rdlc';
    PreviewMode = Normal;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = sorting("Loan No.") where(Posted = const(true), "Total Outstanding Balance" = filter(<> 0));
            RequestFilterFields = "Loan No.", "Member No.", "Date Filter";
            column(ReportForNavId_1102755024; 1102755024)
            {
            }
            column(UserId; UserId)
            {
            }
            column(PayrollStaffNo_Members; Members."Payroll/Staff No.")
            {
            }
            column(No_Members; Members."No.")
            {
            }
            column(Name_Members; Members.Name)
            {
            }
            column(PageNo_Members; '')
            {
            }
            column(IDNo_Members; Members."ID No.")
            {
            }
            column(DimName; DimName)
            {
            }
            column(Department; Members."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_Members; Members."Global Dimension 2 Code")
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(MobilePhoneNo_Members; Members."Mobile Phone No.")
            {
            }
            column(PhoneNo_Members; Members."Phone No.")
            {
            }
            column(OutstandingPenalty_Loans; Loans."Outstanding Penalty")
            {
            }
            column(OutstandingAppraisal_Loans; Loans."Outstanding Appraisal")
            {
            }
            column(OutstandingBalance_Loans; Loans."Outstanding Principal")
            {
            }
            column(OutstandingInterest_Loans; Loans."Outstanding Interest")
            {
            }
            column(OutstandingInsurance_Loans; Loans."Outstanding Insurance")
            {
            }
            column(PrincipleBF; PrincipleBF)
            {
            }
            column(LoanNumber; Loans."Loan No.")
            {
            }
            column(ProductType; Loans."Loan Product Type")
            {
            }
            column(LoanProductTypeName_Loans; Loans."Loan Product Type Name")
            {
            }
            column(RequestedAmount; Loans."Requested Amount")
            {
            }
            column(AInterest; Loans."Annual Interest %")
            {
            }
            column(Installments; Loans.Installments)
            {
            }
            column(LoanPrincipleRepayment; Loans."Loan Principle Repayment")
            {
            }
            dataitem(loan; "Credit Ledger Entry")
            {
                DataItemLink = "Loan No." = field("Loan No.");
                DataItemTableView = sorting("Posting Date") order(ascending) where("Transaction Type" = filter("Principal Repayment" | "Loan Disbursement"), Reversed = const(false));
                column(ReportForNavId_1102755031; 1102755031)
                {
                }
                column(PostingDate_loan; "Posting Date")
                {
                }
                column(DocumentNo_loan; "Document No.")
                {
                }
                column(Description_loan; Description)
                {
                }
                column(BankCode_loan; GetBankAccountNo("Document No.", "Posting Date"))
                {
                }
                column(UserID_loan; "User ID")
                {
                }
                column(DebitAmount_Loan; "Debit Amount")
                {
                }
                column(CreditAmount_Loan; "Credit Amount")
                {
                }
                column(Amount_Loan; Amount)
                {
                }
                column(openBalance_loan; OpenBalance)
                {
                }
                column(CLosingBalance_loan; CLosingBalance)
                {
                }
                column(TransactionType_loan; "Transaction Type")
                {
                }
                column(LoanNo; "Loan No.")
                {
                }
                column(PrincipleBF_loans; PrincipleBF)
                {
                }
                column(EntryNo_loan; "Entry No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CLosingBalance := CLosingBalance + Amount;
                end;

                trigger OnPreDataItem()
                begin
                    CLosingBalance := PrincipleBF;
                    OpeningBal := PrincipleBF;

                    SetRange("Posting Date", StartDate, EndDate);
                end;
            }
            dataitem(Interest; "Credit Ledger Entry")
            {
                DataItemLink = "Loan No." = field("Loan No.");
                DataItemTableView = sorting("Posting Date") order(ascending) where("Transaction Type" = filter("Interest Due" | "Interest Paid"), Reversed = const(false));
                column(ReportForNavId_18; 18)
                {
                }
                column(Int_PostingDate; "Posting Date")
                {
                }
                column(Int_DocumentNo_loan; "Document No.")
                {
                }
                column(Int_Description_loan; Description)
                {
                }
                column(Int_BankCode_loan; GetBankAccountNo("Document No.", "Posting Date"))
                {
                }
                column(Int_UserID_loan; "User ID")
                {
                }
                column(Int_DebitAmount_Loan; "Debit Amount")
                {
                }
                column(Int_CreditAmount_Loan; "Credit Amount")
                {
                }
                column(Int_Amount_Loan; Amount)
                {
                }
                column(Int_openBalance_loan; OpenBalance)
                {
                }
                column(Int_CLosingBalance_loan; CLosingBalance)
                {
                }
                column(Int_TransactionType_loan; "Transaction Type")
                {
                }
                column(Int_LoanNo; "Loan No.")
                {
                }
                column(InterestBF; InterestBF)
                {
                }
                column(Int_EntryNo_loan; "Entry No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CLosingBalance := CLosingBalance + Amount;
                end;

                trigger OnPreDataItem()
                begin
                    CLosingBalance := InterestBF;
                    OpeningBal := InterestBF;


                    SetRange("Posting Date", StartDate, EndDate);
                end;
            }
            dataitem(Insurance; "Credit Ledger Entry")
            {
                DataItemLink = "Loan No." = field("Loan No.");
                DataItemTableView = sorting("Posting Date") order(ascending) where("Transaction Type" = filter("Insurance Due" | "Insurance Paid"), Reversed = const(false));

                column(Ins_PostingDate; "Posting Date")
                {
                }
                column(Ins_DocumentNo_loan; "Document No.")
                {
                }
                column(Ins_Description_loan; Description)
                {
                }
                column(Ins_BankCode_loan; GetBankAccountNo("Document No.", "Posting Date"))
                {
                }
                column(Ins_UserID_loan; "User ID")
                {
                }
                column(Ins_DebitAmount_Loan; "Debit Amount")
                {
                }
                column(Ins_CreditAmount_Loan; "Credit Amount")
                {
                }
                column(Ins_Amount_Loan; Amount)
                {
                }
                column(Ins_openBalance_loan; OpenBalance)
                {
                }
                column(Ins_CLosingBalance_loan; CLosingBalance)
                {
                }
                column(Ins_TransactionType_loan; "Transaction Type")
                {
                }
                column(Ins_LoanNo; "Loan No.")
                {
                }
                column(InsuranceBF; InsuranceBF)
                {
                }
                column(Ins_EntryNo_loan; "Entry No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CLosingBalance += Amount;
                end;

                trigger OnPreDataItem()
                begin
                    CLosingBalance := InsuranceBF;
                    OpeningBal := InsuranceBF;
                    SetRange("Posting Date", StartDate, EndDate);
                end;
            }
            dataitem(Appraisal; "Credit Ledger Entry")
            {
                DataItemLink = "Loan No." = field("Loan No.");
                DataItemTableView = sorting("Posting Date") order(ascending) where("Transaction Type" = filter("Appraisal Due" | "Appraisal Paid"), Reversed = const(false));
                column(ReportForNavId_44; 44)
                {
                }
                column(Appr_PostingDate_loan; "Posting Date")
                {
                }
                column(Appr_DocumentNo_loan; "Document No.")
                {
                }
                column(Appr_Description_loan; Description)
                {
                }
                column(Appr_BankCode_loan; GetBankAccountNo("Document No.", "Posting Date"))
                {
                }
                column(Appr_UserID_loan; "User ID")
                {
                }
                column(Appr_DebitAmount_Loan; "Debit Amount")
                {
                }
                column(Appr_CreditAmount_Loan; "Credit Amount")
                {
                }
                column(Appr_Amount_Loan; Amount)
                {
                }
                column(Appr_openBalance_loan; OpenBalance)
                {
                }
                column(Appr_CLosingBalance_loan; CLosingBalance)
                {
                }
                column(Appr_TransactionType_loan; "Transaction Type")
                {
                }
                column(Appr_LoanNo; "Loan No.")
                {
                }
                column(AppraisalBF; AppraisalBF)
                {
                }
                column(Appr_EntryNo_loan; "Entry No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CLosingBalance := CLosingBalance + Amount;
                end;

                trigger OnPreDataItem()
                begin
                    CLosingBalance := AppraisalBF;
                    OpeningBal := AppraisalBF;


                    SetRange("Posting Date", StartDate, EndDate);
                end;
            }
            dataitem(Penalty; "Credit Ledger Entry")
            {
                DataItemLink = "Loan No." = field("Loan No.");
                DataItemTableView = sorting("Posting Date") order(ascending) where("Transaction Type" = filter("Penalty Due" | "Penalty Paid"), Reversed = const(false));
                column(ReportForNavId_31; 31)
                {
                }
                column(Pen_PostingDate_loan; "Posting Date")
                {
                }
                column(Pen_DocumentNo_loan; "Document No.")
                {
                }
                column(Pen_Description_loan; Description)
                {
                }
                column(Pen_BankCode_loan; GetBankAccountNo("Document No.", "Posting Date"))
                {
                }
                column(Pen_UserID_loan; "User ID")
                {
                }
                column(Pen_DebitAmount_Loan; "Debit Amount")
                {
                }
                column(Pen_CreditAmount_Loan; "Credit Amount")
                {
                }
                column(Pen_Amount_Loan; Amount)
                {
                }
                column(Pen_openBalance_loan; OpenBalance)
                {
                }
                column(Pen_CLosingBalance_loan; CLosingBalance)
                {
                }
                column(Pen_TransactionType_loan; "Transaction Type")
                {
                }
                column(Pen_LoanNo; "Loan No.")
                {
                }
                column(PenaltyBf; PenaltyBF)
                {
                }
                column(Pen_EntryNo_loan; "Entry No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CLosingBalance := CLosingBalance + Amount;
                end;

                trigger OnPreDataItem()
                begin
                    CLosingBalance := PenaltyBF;
                    OpeningBal := PenaltyBF;


                    SetRange("Posting Date", StartDate, EndDate);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Loans.CalcFields("Outstanding Appraisal", "Outstanding Principal", "Outstanding Interest", "Outstanding Insurance", "Outstanding Penalty", "Total Outstanding Balance");

                PrincipleBF := 0;
                InterestBF := 0;
                PenaltyBF := 0;
                AppraisalBF := 0;
                InsuranceBF := 0;
                Members.Get(Loans."Member No.");


                if DateFilterBF <> '' then begin
                    LoansR.Reset;
                    LoansR.SetRange(LoansR."Loan No.", "Loan No.");
                    LoansR.SetFilter(LoansR."Date Filter", DateFilterBF);
                    if LoansR.Find('-') then begin
                        LoansR.CalcFields("Outstanding Appraisal", "Outstanding Principal", "Outstanding Interest", "Outstanding Insurance", "Outstanding Penalty");
                        PrincipleBF := LoansR."Outstanding Principal";
                        InterestBF := LoansR."Outstanding Interest";
                        AppraisalBF := LoansR."Outstanding Appraisal";
                        InsuranceBF := LoansR."Outstanding Insurance";
                        PenaltyBF := LoansR."Outstanding Penalty";
                    end;
                end;

            end;

            trigger OnPreDataItem()
            begin

                if (StartDate <> 0D) or (EndDate <> 0D) then begin
                    if StartDate = 0D then
                        StartDate := 00000101D;
                    if EndDate = 0D then
                        EndDate := Today;

                    Loans.SetRange("Date Filter", StartDate, EndDate);
                    if StartDate > 00000101D then
                        DateFilterBF := '..' + Format(CalcDate('-1D', StartDate))
                    else
                        DateFilterBF := '';
                end;

                if LNo <> '' then
                    Loans.SetRange("Loan No.", LNo);
            end;
        }
        dataitem(LoansSummary; Loans)
        {
            DataItemTableView = sorting("Loan No.") where(Posted = const(true), "Total Outstanding Balance" = filter(<> 0));
            RequestFilterFields = "Date Filter";
            column(ReportForNavId_61; 61)
            {
            }
            column(OutstandingPenalty; "Outstanding Penalty")
            {
            }
            column(OutstandingAppraisal; "Outstanding Appraisal")
            {
            }
            column(OutstandingBalance; "Outstanding principal")
            {
            }
            column(OutstandingInterest; "Outstanding Interest")
            {
            }
            column(OutstandingInsurance; "Outstanding Insurance")
            {
            }
            column(Loan_No; "Loan No.")
            {
            }
            column(LoanProduct; "Loan Product Type Name")
            {
            }
            column(TotalBalance; LoansSummary."Total Outstanding Balance")
            {
            }

            trigger OnPreDataItem()
            begin
                LoansSummary.CopyFilters(Loans);
            end;

            trigger OnAfterGetRecord()
            begin
                LoansSummary.CalcFields("Outstanding Appraisal", "Outstanding Principal", "Outstanding Interest", "Outstanding Insurance", "Outstanding Penalty", "Total Outstanding Balance");
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Period)
                {
                    Caption = 'Statement Period';

                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
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

    trigger OnPreReport()
    begin
        if StartDate = 0D then
            StartDate := 00000101D;
        if EndDate = 0D then
            EndDate := Today;

        Company.Get();
        Company.CalcFields(Company.Picture);
    end;

    var
        no: Integer;
        OpenBalance: Decimal;
        CLosingBalance: Decimal;
        OpenBalanceXmas: Decimal;
        CLosingBalanceXmas: Decimal;
        Cust: Record Members;
        OpeningBal: Decimal;
        ClosingBal: Decimal;
        FirstRec: Boolean;
        PrevBal: Integer;
        BalBF: Decimal;
        LoansR: Record Loans;
        DateFilterBF: Text[150];
        SharesBF: Decimal;
        InsuranceBF: Decimal;
        LoanBF: Decimal;
        PrincipleBF: Decimal;
        InterestBF: Decimal;
        ShowZeroBal: Boolean;
        ClosingBalSHCAP: Decimal;
        ShareCapBF: Decimal;
        XmasBF: Decimal;
        Company: Record "Company Information";
        OpenBalInt: Decimal;
        ClosingBalInt: Decimal;
        IntBF: Integer;
        UnnalocatedBF: Decimal;
        ClosingBalUnna: Decimal;
        DimName: Text;
        DimensionValue: Record "Dimension Value";
        PenaltyBF: Decimal;
        AppraisalBF: Decimal;
        StartDate: Date;
        EndDate: Date;
        LNo: Code[20];
        Members: Record Members;


    procedure SetDateFilter(SDate: Date; EDate: Date; LoanNo: Code[20])
    begin
        LNo := LoanNo;
        StartDate := SDate;
        EndDate := EDate;
    end;

    local procedure GetBankAccountNo(DocumentNo: Code[20]; PostingDate: Date): Code[20]
    var
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
    begin
        BankAccountLedgerEntry.SetRange("Document No.", DocumentNo);
        BankAccountLedgerEntry.SetRange("Posting Date", PostingDate);
        if BankAccountLedgerEntry.FindFirst() then
            exit(BankAccountLedgerEntry."Bank Account No.");

        exit('');
    end;
}
