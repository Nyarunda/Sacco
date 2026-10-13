report 50583 "Treasurer Report V2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Treasurer Report V2.rdlc';
    Caption = 'Treasurer Report V2';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {

        dataitem(BankAccount; "Bank Account")
        {
            RequestFilterFields = "Date Filter";

            // Bank account fields
            column(BankAccount_Name; BankAccount.Name) { }
            column(BankAccount_NetChangeLCY; BankAccount."Net Change (LCY)") { }
            column(BankAccount_BalanceAtDateLCY; BankAccount."Balance at Date (LCY)") { }
            column(BankAccount_DateFilter; BankAccount."Date Filter") { }
            column(BankAccTableCaption; TableCaption + ': ' + DateFilter) { }

            // Company Info — fetched once in OnPreReport, surfaced here for the header
            column(CompanyInfo_Name; CompanyInfo.Name) { }
            column(CompanyInfo_Address; CompanyInfo.Address) { }
            column(CompanyInfo_Address2; CompanyInfo."Address 2") { }
            column(CompanyInfo_Picture; CompanyInfo.Picture) { }
            column(CompanyInfo_Email; CompanyInfo."E-Mail") { }
            column(CompanyInfo_Phone; CompanyInfo."Phone No.") { }
            column(CompanyInfo_SMS; CompanyInfo."SMS Line") { }

            // Report parameters / summary totals
            column(Asat; Asat) { }
            column(DateFilter; DateFilter) { }
            column(ShareDepositBalance; ShareDepositBalance) { }
            column(ShareCapitalBalance; ShareCapitalBalance) { }
            column(TotalLoanBalance; TotalLoanBalance) { }

            trigger OnPreDataItem()
            begin
                BankAccount.SetFilter("Date Filter", DateFilter);
                // Summary balances are calculated once here and shared across the layout
                CalcSummaryBalances();
            end;
        }


        dataitem(GLAccount; "G/L Account")
        {
            DataItemTableView = where("No." = filter('10505|10510|10515|10516|20151|20856|20857|20152'));
            column(GLAccount_No; GLAccount."No.") { }
            column(GLAccount_Name; GLAccount.Name) { }
            column(GLAccount_Balance; GLAccountBalance) { }


            trigger OnAfterGetRecord()
            begin
                GLAccount.CalcFields("Balance at Date");

                GLAccountBalance := GLAccount."Balance at Date";
                if GLAccountBalance < 0 then
                    GLAccountBalance := GLAccountBalance * -1;
            end;

            trigger OnPreDataItem()
            begin
                GLAccount.SetFilter("Date Filter", DateFilter);
            end;
        }


        dataitem(LoansRegister; Loans)
        {
            // CalcFields: pulled once per record at the dataset level — avoids
            // extra CalcFields calls inside triggers.
            CalcFields = "Total Disbursed", "Outstanding Principal", "Outstanding Interest", "Total Outstanding Balance", "Latest Disb. Posting Date";
            DataItemTableView = sorting("Loan No.") order(Ascending) where(Posted = const(true));
            RequestFilterFields = "Loan No.", "Application Date", "Loan Product Type", "Latest Disb. Posting Date";

            // Core loan fields
            column(LoansRegister_LoanNo; LoansRegister."Loan No.") { }
            column(LoansRegister_MemberNo; LoansRegister."Member No.") { }
            column(LoansRegister_MemberName; LoansRegister."Member Name") { }
            column(LoansRegister_ApplicationDate; LoansRegister."Application Date") { }
            column(LoansRegister_RequestedAmount; LoansRegister."Requested Amount") { }
            column(LoansRegister_ApprovedAmount; LoansRegister."Approved Amount") { }
            column(LoansRegister_AmountToDisburse; LoansRegister."Amount To Disburse") { }
            column(LoansRegister_TotalDisbursed; LoansRegister."Total Disbursed") { }
            column(LoansRegister_DisbursementDate; LoansRegister."Latest Disb. Posting Date") { }
            column(LoansRegister_LoanProductType; LoansRegister."Loan Product Type Name") { }
            column(LoansRegister_Installments; LoansRegister.Installments) { }
            column(LoansRegister_OutstandingPrincipal; LoansRegister."Outstanding Principal") { }
            column(LoansRegister_OutstandingInterest; LoansRegister."Outstanding Interest") { }
            column(LoansRegister_TotalOutstandingBalance; LoansRegister."Total Outstanding Balance") { }
            column(LoansRegister_LastPayDate; LoansRegister."Last Pay Date") { }
            column(LoansRegister_TopUpAmount; LoansRegister."Top Up Amount") { }
            column(LoansRegister_ApprovedOn; Format(LoansRegister."Approved On")) { }
            column(LoansRegister_Status; LoansRegister.Status) { }
            column(LoansRegister_EmployerCode; LoansRegister."Employer Code") { }
            column(LoansRegister_EmployerName; LoansRegister."Employer Name") { }
            column(LoansRegister_NetToBeDisburse; LoansRegister."Net To Be Disbursed") { }

            // Computed per-row values (set in CalcLoanDisbursementDetails)
            column(LoanIssueDate; LoanIssueDate) { }
            column(NetDisbursedToBank; NetDisbursedToBank) { }
            column(RefinancingCommission; RefinancingCommission) { }
            column(ExciseDutyAmount; ExciseDutyAmount) { }
            column(LoanOffsetCharges; LoanOffsetCharges) { }
            column(TotalLoanDisbursed; TotalLoanDisbursed) { }

            // Running counters
            column(LoanCount; LoanCount) { }
            column(RowNo; RowNo) { }

            // Field captions — lets the RDLC layout use localised labels automatically
            column(Caption_LoanNo; FieldCaption("Loan No.")) { }
            column(Caption_MemberName; FieldCaption("Member Name")) { }
            column(Caption_RequestedAmount; FieldCaption("Requested Amount")) { }
            column(Caption_ApprovedAmount; FieldCaption("Approved Amount")) { }
            column(Caption_LoanStatus; FieldCaption(Status)) { }
            column(Caption_ApplicationDate; FieldCaption("Application Date")) { }
            column(Caption_OutstandingInterest; FieldCaption("Outstanding Interest")) { }
            column(Caption_LastPayDate; FieldCaption("Last Pay Date")) { }
            column(Caption_TopUpAmount; FieldCaption("Top Up Amount")) { }


            dataitem(MembersRegister; Members)
            {
                DataItemLink = "No." = field("Member No.");
                column(MemberShareCapital; MemberShareCapital) { }
                column(MemberRetainedShareCapital; MemberRetainedShareCapital) { }

            }

            trigger OnAfterGetRecord()
            begin
                ClearLoanLineVars();
                ResolveLoanIssueDate();
                CalcLoanDisbursementDetails(); // may call CurrReport.Skip() if no disbursement found

                LoanCount += 1;
                RowNo += 1;
            end;

            trigger OnPreDataItem()
            begin
                SetFilter("Date Filter", DateFilter);
                if GetFilter("Latest Disb. Posting Date") = '' then
                    SetRange("Latest Disb. Posting Date", CalcDate('<-CM>', Asat), CalcDate('<CM>', Asat));
            end;
        }


        dataitem(Vendor; "Savings Accounts")
        {
            // "Last Transaction Date" CalcField removed — it was declared but never
            // used in any column or trigger logic.
            DataItemTableView = sorting("No.") order(Ascending) where(Balance = filter(> 1), "Product Category" = filter("Ordinary Savings" | "Fixed Deposit"));
            RequestFilterFields = "Date Filter";

            column(Vendor_No; Vendor."No.") { }
            column(Vendor_Name; Vendor.Name) { }
            column(Vendor_Balance; Vendor.Balance) { }
            column(Vendor_AccountType; Vendor."Product Category") { }
            column(WDNumber; WDNumber) { }
            column(WDName; WDName) { }
            column(WDBalance; WDBalance) { }
            column(FDNumber; FDNumber) { }
            column(FDName; FDName) { }
            column(FDBalance; FDBalance) { }

            trigger OnAfterGetRecord()
            begin
                // Reset every row so stale values from the previous row are not carried forward
                ClearVendorLineVars();

                case Vendor."Product Category" of
                    Vendor."Product Category"::"Ordinary Savings":
                        begin
                            WDNumber := Vendor."No.";
                            WDName := Vendor.Name;
                            WDBalance := Vendor.Balance;
                        end;
                    Vendor."Product Category"::"Fixed Deposit":
                        begin
                            FDNumber := Vendor."No.";
                            FDName := Vendor.Name;
                            FDBalance := Vendor.Balance;
                        end;
                end;
            end;

            trigger OnPreDataItem()
            begin
                Vendor.SetFilter("Date Filter", DateFilter);
            end;
        }

        dataitem(PaymentLine; "Document Line")
        {
            DataItemTableView = where(Type = filter('WD REFUND' | 'FD REFUND'));
            RequestFilterFields = "Posting Date";

            column(PaymentLine_AccountNo; PaymentLine."Account No.") { }
            // NOTE: column uses "Account Name" field (not .Name) — consistent with
            // the case block below that also reads "Account Name"
            column(PaymentLine_AccountName; PaymentLine.Description) { }
            column(PaymentLine_Amount; PaymentLine.Amount) { }
            column(PaymentLine_Date; PaymentLine."Posting Date") { }
            column(PaymentLine_Type; PaymentLine.Type) { }
            column(PaymentLine_WDNo; PaymentLineWDNo) { }
            column(PaymentLine_WDName; PaymentLineWDName) { }
            column(PaymentLine_WDBalance; PaymentLineWDBalance) { }
            column(PaymentLine_FDNo; PaymentLineFDNo) { }
            column(PaymentLine_FDName; PaymentLineFDName) { }
            column(PaymentLine_FDBalance; PaymentLineFDBalance) { }
            column(PaymentLine_DatePosted; PaymentsHeader."Date Posted") { }

            trigger OnAfterGetRecord()
            begin
                ClearPaymentLineVars();

                // Only include lines whose parent header falls within the As-at month
                PaymentsHeader.Reset();
                PaymentsHeader.SetRange("No.", PaymentLine."Header No.");
                PaymentsHeader.SetRange("Date Posted", CalcDate('<-CM>', Asat), CalcDate('<CM>', Asat));
                if not PaymentsHeader.FindFirst() then
                    CurrReport.Skip();

                case PaymentLine.Type of
                    'WD REFUND':
                        begin
                            PaymentLineWDNo := PaymentLine."Account No.";
                            PaymentLineWDName := PaymentLine.Description;
                            PaymentLineWDBalance := PaymentLine.Amount;
                        end;
                    'FD REFUND':
                        begin
                            PaymentLineFDNo := PaymentLine."Account No.";
                            PaymentLineFDName := PaymentLine.Description;
                            PaymentLineFDBalance := PaymentLine.Amount;
                        end;
                end;
            end;
        }


        dataitem(PaymentsHeaderShares; "Payment Header")
        {
            DataItemTableView = where(Posted = const(true), Type = filter('MEXIT'));
            RequestFilterFields = "Date Posted";

            column(PaymentsHeader_Payee; PaymentsHeaderShares.Payee) { }
            column(PaymentsHeader_DatePosted; PaymentsHeaderShares."Date Posted") { }
            column(PaymentsHeader_TotalNetAmount; PaymentsHeaderShares."Total Net Amount") { }
            column(PaymentsHeader_SharesRefund; PaymentsHeaderShares."Shares Refund") { }
            column(PaymentsHeader_No; PaymentsHeaderShares."No.") { }
            column(PaymentsHeader_PaymentReleaseDate; PaymentsHeaderShares."Payment Release Date") { }

            dataitem(SharesPaymentLine; "Document Line")
            {
                DataItemLink = "Header No." = field("No.");

                column(SharesPaymentLine_No; SharesPaymentLine."Header No.") { }
                column(SharesPaymentLine_Type; SharesPaymentLine.Type) { }
                column(SharesPaymentLine_Amount; SharesPaymentLine.Amount) { }
                column(SharesPaymentLine_Remarks; SharesPaymentLine.Description) { }
                column(SharesPaymentLine_AccountNo; SharesPaymentLine."Account No.") { }
                column(SharesPaymentLine_AccountName; SharesPaymentLine.Description) { }
                column(SharesPaymentLine_TransactionType; SharesPaymentLine."Transaction Type") { }
            }

            trigger OnPreDataItem()
            begin
                PaymentsHeaderShares.SetRange(
                    "Payment Release Date",
                    CalcDate('<-CM>', Asat),
                    CalcDate('<CM>', Asat));
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(AsAtField; Asat)
                    {
                        Caption = 'Generate As at';
                        ApplicationArea = All;
                        ToolTip = 'Specify the date to generate the report as at. All balances and transactions are evaluated up to and including this date.';
                    }
                }
            }
        }
    }


    trigger OnPreReport()
    begin
        if Asat = 0D then
            Asat := WorkDate();

        if CompanyInfo.Get() then
            CompanyInfo.CalcFields(Picture);

        // DateFilter drives all "up to As-at" filtering across every dataitem
        DateFilter := '..' + Format(Asat);
    end;

    local procedure CalcSummaryBalances()
    var
        Legacy: Codeunit Legacy;
    begin

        ShareCapitalBalance := Legacy.GetShareCapitalAccountBookBalance(Asat);
        ShareDepositBalance := Legacy.GetShareDepositAccountBookBalance(Asat);
        TotalLoanBalance := Legacy.GetTotalOutstandingBalance(Asat);
    end;


    local procedure ClearLoanLineVars()
    begin
        LoanIssueDate := 0D;
        NetDisbursedToBank := 0;
        RefinancingCommission := 0;
        ExciseDutyAmount := 0;
        LoanOffsetCharges := 0;
        TotalLoanDisbursed := 0;
        TransNo := 0;
        PostingDate := 0D;
        DocumentNo := '';
        MemberShareCapital := 0;
        MemberRetainedShareCapital := 0;
    end;


    local procedure ClearVendorLineVars()
    begin
        WDNumber := '';
        WDName := '';
        WDBalance := 0;
        FDNumber := '';
        FDName := '';
        FDBalance := 0;
    end;

    local procedure ClearPaymentLineVars()
    begin
        PaymentLineWDNo := '';
        PaymentLineWDName := '';
        PaymentLineWDBalance := 0;
        PaymentLineFDNo := '';
        PaymentLineFDName := '';
        PaymentLineFDBalance := 0;
    end;


    local procedure ResolveLoanIssueDate()
    begin
        LoanIssueDate := LoansRegister."Disbursement Date";

        if LoansRegister."Disbursement Date" > Asat then begin
            MemberLedgerEntry.Reset();
            MemberLedgerEntry.SetRange("Loan No.", LoansRegister."Loan No.");
            MemberLedgerEntry.SetFilter("Transaction Type", '%1', MemberLedgerEntry."Transaction Type"::"Loan Disbursement");
            MemberLedgerEntry.SetRange("Posting Date", CalcDate('<-CM>', Asat), CalcDate('<CM>', Asat));
            MemberLedgerEntry.SetRange(Reversed, false);
            if MemberLedgerEntry.FindLast() then
                LoanIssueDate := MemberLedgerEntry."Posting Date";
        end;
    end;


    local procedure CalcLoanDisbursementDetails()
    var
        PartialHeader: Record "Partial Loans Disb. Header";
        PartialLine: Record "Partial Loans Disb. Lines";
    begin
        MemberLedgerEntry.Reset();
        MemberLedgerEntry.SetRange("Loan No.", LoansRegister."Loan No.");
        MemberLedgerEntry.SetFilter("Transaction Type", '%1', MemberLedgerEntry."Transaction Type"::"Loan Disbursement");
        LoansRegister.CopyFilter("Latest Disb. Posting Date", MemberLedgerEntry."Posting Date");
        MemberLedgerEntry.SetRange(Reversed, false);
        if not MemberLedgerEntry.FindFirst() then
            CurrReport.Skip(); // no disbursement found within the selected posting-date filter

        TransNo := Calculator.FnGetLoanDisbursementTransactionNo(LoansRegister."Loan No.", Asat);
        Calculator.FnGetLoanDocumentNoAndPostingDate(TransNo, LoansRegister."Loan No.", PostingDate, DocumentNo);

        NetDisbursedToBank := LoansRegister."Net To Be Disbursed";
        PartialHeader.SetRange("Loan No.", LoansRegister."Loan No.");
        PartialHeader.SetRange(Posted, true);
        PartialHeader.SetRange(Reversed, false);
        LoansRegister.CopyFilter("Latest Disb. Posting Date", PartialHeader."Posting Date");
        if PartialHeader.FindSet() then begin
            NetDisbursedToBank := 0;
            repeat
                PartialLine.Reset();
                PartialLine.SetRange("Header No.", PartialHeader."No.");
                PartialLine.SetRange("Loan No.", LoansRegister."Loan No.");
                if PartialLine.FindSet() then
                    repeat
                        NetDisbursedToBank += PartialLine."Expected Net Take Home";
                    until PartialLine.Next() = 0;
            until PartialHeader.Next() = 0;
        end;

        RefinancingCommission := Calculator.FnGetOffsetCommissionByALoan(TransNo, DocumentNo, PostingDate, LoansRegister."Loan No.");
        ExciseDutyAmount := GetExciseDutyAmount(TransNo, DocumentNo, PostingDate);
        LoanOffsetCharges := Calculator.FnGetOffsetChargesByALoanExcludingOffsetCommision(TransNo, DocumentNo, PostingDate, LoansRegister."Member No.");
        TotalLoanDisbursed := LoansRegister."Amount To Disburse"; //Calculator.FnGetTotalLoanDisbursementsDisbursedToMemberSoFar(LoansRegister."Loan No.", Asat);
    end;

    local procedure GetExciseDutyAmount(TransNo: Integer; DocumentNo: Code[50]; PostingDate: Date): Decimal
    var
        GLEntry: Record "G/L Entry";
        Total: Decimal;
    begin
        GLEntry.Reset();
        GLEntry.SetRange("Transaction No.", TransNo);
        GLEntry.SetRange("Document No.", DocumentNo);
        GLEntry.SetRange("Posting Date", PostingDate);
        GLEntry.SetRange("G/L Account No.", '20238');
        GLEntry.SetRange(Reversed, false);
        if GLEntry.FindSet() then
            repeat
                Total += GLEntry.Amount * -1;
            until GLEntry.Next() = 0;

        exit(Total);
    end;


    var
        // System records
        CompanyInfo: Record "Company Information";
        MemberLedgerEntry: Record "Credit Ledger Entry";
        PaymentsHeader: Record "Payment Header";
        Calculator: Codeunit Legacy;
        Asat: Date;
        DateFilter: Text;
        ShareDepositBalance: Decimal;
        ShareCapitalBalance: Decimal;
        TotalLoanBalance: Decimal;
        LoanIssueDate: Date;
        NetDisbursedToBank: Decimal;
        RefinancingCommission: Decimal;
        ExciseDutyAmount: Decimal;
        LoanOffsetCharges: Decimal;
        TotalLoanDisbursed: Decimal;
        TransNo: Integer;
        PostingDate: Date;
        DocumentNo: Code[50];

        MemberShareCapital: Decimal;
        MemberRetainedShareCapital: Decimal;

        WDNumber: Code[20];
        WDName: Text;
        WDBalance: Decimal;
        FDNumber: Code[20];
        FDName: Text;
        FDBalance: Decimal;
        PaymentLineWDNo: Code[20];
        PaymentLineWDName: Text;
        PaymentLineWDBalance: Decimal;
        PaymentLineFDNo: Code[20];
        PaymentLineFDName: Text;
        PaymentLineFDBalance: Decimal;

        LoanCount: Integer;
        RowNo: Integer;
        GLAccountBalance: Decimal;
}
