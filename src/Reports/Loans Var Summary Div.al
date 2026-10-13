report 50044 "Loans Var Summary Div"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loans Var Summary Div.rdlc';

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = WHERE(Posted = CONST(true));
            RequestFilterFields = "Loan No.", "Application Date", "Loan Product Type", "Member No.", "Disbursement Date", Status, "Outstanding Principal", "Date Filter";
            column(Topup; TopUpAmnt)
            {
            }
            column(NetAmount; NetAmount)
            {
            }
            column(Repayment; Loans.Repayment)
            {
            }
            column(OutInt; Loans."Outstanding Interest")
            {
            }
            column(OutBal; Loans."Outstanding Principal")
            {
            }
            column(Picture; Company.Picture)
            {
            }
            column(Address; Company.Address)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(snos; sno)
            {
            }
            column(ArrearsDays; ArrearsDays)
            {
            }
            column(Variance; Variance)
            {
            }
            column(Loan_princ; TotExp)
            {
            }
            column(Loan_Int; Loans."Loan Interest Repayment")
            {
            }
            column(Int_Due; Loans."Interest Due")
            {
            }
            column(Total_Expected; TotExp)
            {
            }
            column(CurrentOutstandingBalance_Loans; Loans."Outstanding Principal")
            {
            }
            column(DateFilter; DateFilter)
            {
            }
            column(EmployerCode; EmployerCode)
            {
            }
            column(PrincPay; Loans."Principal Paid")
            {
            }
            column(IntPay; Loans."Interest Paid")
            {
            }
            column(TotalPaid; Loans."Principal Paid" + Loans."Interest Paid")
            {
            }
            column(PreviousMonthTotal; PreviousMonthTotal)
            {
            }
            column(PositiveAdjustmentsForCurrentMonth; PositiveAdjustmentsForCurrentMonth)
            {
            }
            column(NewLoansNotRecoveredInPreviousMonthAdvisedForCurrentMonth; NewLoansNotRecoveredInPreviousMonthAdvisedForCurrentMonth)
            {
            }
            column(NegativeAdjustmentsForCurrentMonth; NegativeAdjustmentsForCurrentMonth)
            {
            }
            column(LoansClearedThoughCashPayments; LoansClearedThoughCashPayments)
            {
            }
            column(LoansThatHaveEndedWithinThePeriod; LoansThatHaveEndedWithinThePeriod)
            {
            }
            column(TotExp; TotExp)
            {
            }

            trigger OnAfterGetRecord()
            begin

                InitializeVariables;
                Myfilter := FORMAT(PreviousMonthStartDate) + '..' + FORMAT(PreviousMonthEndDate);
                Loans.CALCFIELDS("Outstanding Principal", "Outstanding Interest", "Total Outstanding Balance");
                IF Loans.Installments <> 0 THEN
                    ArrearsDays := ROUND((((Loans.Repayment) / Loans.Installments) * 30), 1, '<');
                IF ArrearsDays < 0 THEN ArrearsDays := 0;

                Topup.RESET;
                Topup.SETRANGE(Topup."Loan No.", "Loan No.");
                IF Topup.FIND('-') THEN BEGIN
                    REPEAT
                        TopUpAmnt := TopUpAmnt + Topup."Total Top Up";
                    UNTIL
                    Topup.NEXT = 0;
                END;

                NetAmount := Loans."Approved Amount" - TopUpAmnt;
                LoanApp.RESET;
                LoanApp.SETRANGE("Loan No.", Loans."Loan No.");
                IF LoanApp.FIND('-') THEN BEGIN
                    REPEAT
                        //LoanApp.CALCSUMS(LoanApp."Loan Principle Repayment");
                        TotExp += (LoanApp.Repayment);
                    UNTIL LoanApp.NEXT = 0;
                END;

                //TotExp:=Loans.Repayment;
                Variance := TotExp - (Loans."Principal Paid" + Loans."Interest Paid");

                GetPreviousMonthTotal;
                GetPositiveAdjustmentsForCurrentMonth;
                GetNewLoansNotRecoveredInPreviousMonthAdvisedForCurrentMonth;
                GetNegativeAdjustmentsForCurrentMonth;
                GetLoansClearedThoughCashPayments;
                GetLoansThatHaveEndedWithinThePeriod;
                //MESSAGE(FORMAT(TotExp));
            end;

            trigger OnPreDataItem()
            begin
                IF PreviousMonthStartDate = 0D THEN ERROR('Kind specify Previous Month Start Date');
                IF PreviousMonthEndDate = 0D THEN ERROR('Kind specify Previous Month End Date');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Previous Month Start Date"; PreviousMonthStartDate)
                {
                    ApplicationArea = All;
                }
                field("Previous Month End Date"; PreviousMonthEndDate)
                {
                    ApplicationArea = All;
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

        IF Loans.GETFILTER(Loans."Date Filter") = '' THEN
            ERROR('Please specify a date filter before proceeding');

        DateFilter := Loans.GETFILTER("Date Filter");
        EmployerCode := Loans.GETFILTER("Employer Code");
        Company.GET;
        //Company.CALCFIELDS(Picture);
    end;

    var
        ProductType: Text;
        MemberBiodata: Text;
        Company: Record "Company Information";
        sno: Integer;
        ArrearsDays: Integer;
        Topup: Record "Loan Top Up";
        NetAmount: Decimal;
        TopUpAmnt: Decimal;
        ABBR: Code[10];
        ProdFac: Record "Product Setup";
        Cust: Record Customer;
        ABBRC: Code[20];
        Variance: Decimal;
        TotExp: Decimal;
        EmpCode: Code[20];
        Members: Record Members;
        DateFilter: Code[50];
        EmployerCode: Code[50];
        PreviousMonthTotal: Decimal;
        PositiveAdjustmentsForCurrentMonth: Decimal;
        NewLoansNotRecoveredInPreviousMonthAdvisedForCurrentMonth: Decimal;
        NegativeAdjustmentsForCurrentMonth: Decimal;
        LoansClearedThoughCashPayments: Decimal;
        LoansThatHaveEndedWithinThePeriod: Decimal;
        LoanApp: Record Loans;
        PreviousMonthStartDate: Date;
        PreviousMonthEndDate: Date;
        Myfilter: Text;

    local procedure InitializeVariables()
    begin
        ArrearsDays := 0;
        TopUpAmnt := 0;
        NetAmount := 0;
        sno += 1;
        ABBR := '';
        ABBRC := '';
        Variance := 0;
        TotExp := 0;
        PreviousMonthTotal := 0;
        PositiveAdjustmentsForCurrentMonth := 0;
        NewLoansNotRecoveredInPreviousMonthAdvisedForCurrentMonth := 0;
        NegativeAdjustmentsForCurrentMonth := 0;
        LoansClearedThoughCashPayments := 0;
        LoansThatHaveEndedWithinThePeriod := 0;
    end;

    local procedure GetPreviousMonthTotal()
    var
        CreditLedgerEntry: Record "Credit Ledger Entry";
    begin
        CreditLedgerEntry.RESET;
        CreditLedgerEntry.SETRANGE(CreditLedgerEntry."Loan No.", Loans."Loan No.");
        CreditLedgerEntry.SETFILTER(CreditLedgerEntry."Transaction Type", '%1|%2', CreditLedgerEntry."Transaction Type"::"Interest Paid", CreditLedgerEntry."Transaction Type"::"Principal Repayment");
        CreditLedgerEntry.SETRANGE("Posting Date", PreviousMonthStartDate, PreviousMonthEndDate);//CALCDATE('-1M',Loans.GETRANGEMIN("Date Filter")),Loans.GETRANGEMIN("Date Filter"));
        IF CreditLedgerEntry.FINDFIRST THEN
            REPEAT
                PreviousMonthTotal += (CreditLedgerEntry.Amount * -1);
            UNTIL CreditLedgerEntry.NEXT = 0;
    end;

    local procedure GetPositiveAdjustmentsForCurrentMonth()
    var
        CreditLedgerEntry: Record "Credit Ledger Entry";
    begin
        IF (Loans."Disbursement Date" >= PreviousMonthStartDate/*Loans.GETRANGEMIN("Date Filter")*/) AND (Loans."Disbursement Date" <= /*Loans.GETRANGEMAX("Date Filter")*/PreviousMonthEndDate) THEN BEGIN
            CreditLedgerEntry.RESET;
            CreditLedgerEntry.SETRANGE(CreditLedgerEntry."Loan No.", Loans."Loan No.");
            CreditLedgerEntry.SETFILTER(CreditLedgerEntry."Transaction Type", '%1|%2', CreditLedgerEntry."Transaction Type"::"Interest Paid", CreditLedgerEntry."Transaction Type"::"Principal Repayment");
            CreditLedgerEntry.SETRANGE("Posting Date", PreviousMonthStartDate, PreviousMonthEndDate);//Loans.GETRANGEMIN("Date Filter"),Loans.GETRANGEMAX("Date Filter"));
            IF CreditLedgerEntry.FINDFIRST THEN
                REPEAT
                    PositiveAdjustmentsForCurrentMonth += (CreditLedgerEntry.Amount * -1);
                UNTIL CreditLedgerEntry.NEXT = 0;
        END;

    end;

    local procedure GetNewLoansNotRecoveredInPreviousMonthAdvisedForCurrentMonth()
    var
        CreditLedgerEntry: Record "Credit Ledger Entry";
    begin
        IF (Loans."Disbursement Date" >= /*CALCDATE('-1M+5D',Loans.GETRANGEMIN("Date Filter")))*/PreviousMonthStartDate) AND (Loans."Disbursement Date" < PreviousMonthEndDate/*Loans.GETRANGEMIN("Date Filter")*/) THEN BEGIN
            CreditLedgerEntry.RESET;
            CreditLedgerEntry.SETRANGE(CreditLedgerEntry."Loan No.", Loans."Loan No.");
            CreditLedgerEntry.SETFILTER(CreditLedgerEntry."Transaction Type", '%1|%2', CreditLedgerEntry."Transaction Type"::"Interest Paid", CreditLedgerEntry."Transaction Type"::"Principal Repayment");
            //CreditLedgerEntry.SETRANGE("Posting Date",Loans.GETRANGEMIN("Date Filter"),Loans.GETRANGEMAX("Date Filter"));
            IF CreditLedgerEntry.FINDFIRST THEN
                REPEAT
                    NewLoansNotRecoveredInPreviousMonthAdvisedForCurrentMonth += (CreditLedgerEntry.Amount * -1);
                UNTIL CreditLedgerEntry.NEXT = 0;
        END;

    end;

    local procedure GetNegativeAdjustmentsForCurrentMonth()
    var
        CreditLedgerEntry: Record "Credit Ledger Entry";
    begin
        IF Variance > 0 THEN
            NegativeAdjustmentsForCurrentMonth := Variance;
    end;

    local procedure GetLoansClearedThoughCashPayments()
    var
        CashierTransactions: Record "Teller Transaction";
        CashierTransactionLines: Record "Teller Lines";
    begin
        CashierTransactions.RESET;
        CashierTransactions.SETRANGE("Date Posted", PreviousMonthStartDate/*Loans.GETRANGEMIN("Date Filter")*/, PreviousMonthEndDate/*Loans.GETRANGEMAX("Date Filter")*/);
        CashierTransactions.SETRANGE(Posted, TRUE);
        IF CashierTransactions.FINDFIRST THEN
            REPEAT
                CashierTransactionLines.RESET;
                CashierTransactionLines.SETRANGE("Loan No.", Loans."Loan No.");
                IF CashierTransactionLines.FINDFIRST THEN
                    REPEAT
                        LoansClearedThoughCashPayments += CashierTransactionLines.Amount;
                    UNTIL CashierTransactionLines.NEXT = 0;
            UNTIL CashierTransactions.NEXT = 0;

    end;

    local procedure GetLoansThatHaveEndedWithinThePeriod()
    var
        CreditLedgerEntry: Record "Credit Ledger Entry";
    begin
        IF Loans."Outstanding Principal" <= 0 THEN BEGIN
            CreditLedgerEntry.RESET;
            CreditLedgerEntry.SETRANGE(CreditLedgerEntry."Loan No.", Loans."Loan No.");
            CreditLedgerEntry.SETFILTER(CreditLedgerEntry."Transaction Type", '%1|%2', CreditLedgerEntry."Transaction Type"::"Interest Paid", CreditLedgerEntry."Transaction Type"::"Principal Repayment");
            CreditLedgerEntry.SETRANGE("Posting Date", PreviousMonthStartDate/*Loans.GETRANGEMIN("Date Filter")*/,/*Loans.GETRANGEMAX("Date Filter")*/PreviousMonthEndDate);
            IF CreditLedgerEntry.FINDFIRST THEN
                REPEAT
                    LoansThatHaveEndedWithinThePeriod += (CreditLedgerEntry.Amount * -1);
                UNTIL CreditLedgerEntry.NEXT = 0;
        END;

    end;
}

