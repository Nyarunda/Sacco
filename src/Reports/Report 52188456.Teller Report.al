
Report 50119 "Teller Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Teller Report.rdlc';
    Caption = 'Cashier Report';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem("Bank Account"; "Bank Account")
        {
            DataItemTableView = sorting("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Cashier ID", "Bank Acc. Posting Group", "Date Filter";
            column(ReportForNavId_4558; 4558)
            {
            }
            column(TRNo; TRNo)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(STRSUBSTNO_Text000_BankAccDateFilter_; StrSubstNo(Text000, BankAccDateFilter))
            {
            }
            column(CurrReport_PAGENO; 0)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(UserId; UserId)
            {
            }
            column(STRSUBSTNO___1___2___Bank_Account__TABLECAPTION_BankAccFilter_; StrSubstNo('%1: %2', "Bank Account".TableCaption, BankAccFilter))
            {
            }
            column(Bank_Account__No__; "No.")
            {
            }
            column(Bank_Account_Name; Name)
            {
            }
            column(Bank_Account__Currency_Code_; "Currency Code")
            {
            }
            column(StartBalance; StartBalance)
            {
                AutoFormatExpression = "Bank Account Ledger Entry"."Currency Code";
                AutoFormatType = 1;
            }
            column(Cashier_ReportCaption; Cashier_ReportCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Bank_Account_Ledger_Entry__Posting_Date_Caption; "Bank Account Ledger Entry".FieldCaption("Posting Date"))
            {
            }
            column(Bank_Account_Ledger_Entry__Document_No__Caption; "Bank Account Ledger Entry".FieldCaption("Document No."))
            {
            }
            column(Bank_Account_Ledger_Entry_DescriptionCaption; "Bank Account Ledger Entry".FieldCaption(Description))
            {
            }
            column(BankAccBalance_StartBalance_tellerIssuesCaption; BankAccBalance_StartBalance_tellerIssuesCaptionLbl)
            {
            }
            column(Bank_Account_Ledger_Entry__Entry_No__Caption; "Bank Account Ledger Entry".FieldCaption("Entry No."))
            {
            }
            column(Account_NameCaption; Account_NameCaptionLbl)
            {
            }
            column(Bank_Account_Ledger_Entry__Debit_Amount_Caption; "Bank Account Ledger Entry".FieldCaption("Debit Amount"))
            {
            }
            column(Bank_Account_Ledger_Entry__Credit_Amount_Caption; "Bank Account Ledger Entry".FieldCaption("Credit Amount"))
            {
            }
            column(Account_No_Caption; Account_No_CaptionLbl)
            {
            }
            column(Bank_Account__Currency_Code_Caption; FieldCaption("Currency Code"))
            {
            }
            column(Teller__Sign_Date_Caption; Teller__Sign_Date_CaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(Accountant_Manager__Sign_Date_Caption; Accountant_Manager__Sign_Date_CaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102760026; EmptyStringCaption_Control1102760026Lbl)
            {
            }
            column(Bank_Account_Date_Filter; "Date Filter")
            {
            }
            column(Bank_Account_Global_Dimension_2_Filter; "Global Dimension 2 Filter")
            {
            }
            column(Bank_Account_Global_Dimension_1_Filter; "Global Dimension 1 Filter")
            {
            }
            column(Balance_At_date; "Bank Account"."Balance at Date (LCY)")
            {
            }
            column(Bank_Account_Cashier_ID; "Bank Account"."Cashier ID")
            {
            }
            column(BankBal; BankAccBalance)
            {
            }
            column(CashierID; "Bank Account"."Cashier ID")
            {
            }
            dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
            {
                DataItemLink = "Bank Account No." = field("No."), "Posting Date" = field("Date Filter"), "Global Dimension 2 Code" = field("Global Dimension 2 Filter"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter");
                DataItemTableView = sorting("Bank Account No.", "Posting Date");
                column(ReportForNavId_4920; 4920)
                {
                }
                column(ExtDocNo; "Bank Account Ledger Entry"."External Document No.")
                {
                }
                column(StartBalance____Bank_Account_Ledger_Entry__Amount; StartBalance + "Bank Account Ledger Entry".Amount)
                {
                    AutoFormatExpression = "Bank Account Ledger Entry"."Currency Code";
                    AutoFormatType = 1;
                }
                column(Bank_Account_Ledger_Entry__Posting_Date_; "Posting Date")
                {
                }
                column(Bank_Account_Ledger_Entry__Document_No__; "Document No.")
                {
                }
                column(Bank_Account_Ledger_Entry_Description; Description)
                {
                }
                column(BankAccBalance_StartBalance_tellerIssues; BankAccBalance)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(Bank_Account_Ledger_Entry__Entry_No__; "Entry No.")
                {
                }
                column(Bank_Account_Ledger_Entry_Amount; Amount)
                {
                }
                column(Names_Control1102760001; Names)
                {
                }
                column(Bank_Account_Ledger_Entry__Debit_Amount_; "Debit Amount")
                {
                }
                column(Bank_Account_Ledger_Entry__Credit_Amount_; "Credit Amount")
                {
                }
                column(Bank_Account_Ledger_Entry__Bank_Account_Ledger_Entry___Bal__Account_No__; "Bank Account Ledger Entry"."Bal. Account No.")
                {
                }
                column(StartBalance____Bank_Account_Ledger_Entry__Amount_Control47; StartBalance + "Bank Account Ledger Entry".Amount)
                {
                    AutoFormatExpression = "Bank Account Ledger Entry"."Currency Code";
                    AutoFormatType = 1;
                }
                column(ContinuedCaption; ContinuedCaptionLbl)
                {
                }
                column(ContinuedCaption_Control46; ContinuedCaption_Control46Lbl)
                {
                }
                column(Bank_Account_Ledger_Entry_Bank_Account_No_; "Bank Account No.")
                {
                }
                column(Bank_Account_Ledger_Entry_Global_Dimension_2_Code; "Global Dimension 2 Code")
                {
                }
                column(Bank_Account_Ledger_Entry_Global_Dimension_1_Code; "Global Dimension 1 Code")
                {
                }

                trigger OnAfterGetRecord()
                begin

                    if not PrintReversedEntries and Reversed then
                        CurrReport.Skip;
                    BankAccLedgEntryExists := true;
                    BankAccBalance := BankAccBalance + Amount;
                    BankAccBalanceLCY := BankAccBalanceLCY + "Amount (LCY)";

                    Names := '';
                    if "Bank Account Ledger Entry"."Bal. Account Type" = "Bank Account Ledger Entry"."bal. account type"::Customer then begin
                        if Cust.Get("Bank Account Ledger Entry"."Bal. Account No.") then
                            Names := Cust.Name;
                    end else
                        if "Bank Account Ledger Entry"."Bal. Account Type" = "Bank Account Ledger Entry"."bal. account type"::Vendor then begin
                            if Vend.Get("Bank Account Ledger Entry"."Bal. Account No.") then
                                Names := Vend.Name;
                        end else
                            if "Bank Account Ledger Entry"."Bal. Account Type" = "Bank Account Ledger Entry"."bal. account type"::"Bank Account" then begin
                                if Bank.Get("Bank Account Ledger Entry"."Bal. Account No.") then
                                    Names := Bank.Name;
                            end;

                    if "Bank Account Ledger Entry"."Bal. Account No." <> '' then begin
                        if Names = '' then begin
                            if SavingsAccounts.Get("Bank Account Ledger Entry"."Bal. Account No.") then
                                Names := SavingsAccounts.Name;
                        end;
                    end;

                    if "Bank Account Ledger Entry"."Bal. Account No." = '' then begin
                        if Trans.Get("Document No.") then begin
                            Trans.CalcFields(Trans."Allocated Amount");
                            if Trans."Allocated Amount" <> 0 then begin
                                "Bank Account Ledger Entry"."Bal. Account No." := Trans."Account No.";
                                Names := Trans."Account Name";
                            end;
                            if "Bank Account Ledger Entry"."Bal. Account No." = '' then begin

                            end;
                        end;
                    end;

                    //**
                    /*
                    IF ReceiptsPayments.GET("Document No.") THEN BEGIN
                     IF ReceiptsPayments."Account Type" = ReceiptsPayments."Account Type"::Member THEN
                      Names:=ReceiptsPayments.Name;
                      "Bank Account Ledger Entry"."Bal. Account No.":=ReceiptsPayments."Account No.";
                    END;
                    
                    IF BOSATransfers.GET("Document No.") THEN BEGIN
                    BTranSSchedule.RESET;
                    BTranSSchedule.SETRANGE("No.",BOSATransfers.No);
                     IF BTranSSchedule.FINDFIRST THEN
                     Names:=BTranSSchedule."Source Account Name";
                     "Bank Account Ledger Entry"."Bal. Account No.":=BTranSSchedule."Source Account No.";
                     END;   //**
                    */
                    TCredit := TCredit + "Bank Account Ledger Entry"."Credit Amount";
                    TDebit := TDebit + "Bank Account Ledger Entry"."Debit Amount";
                    if "Bank Account Ledger Entry"."Bal. Account No." = '40013' then
                        Names := 'Tender Fees';

                    TRNo += 1;

                end;

                trigger OnPreDataItem()
                begin
                    BankAccLedgEntryExists := false;
                end;
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(ReportForNavId_5444; 5444)
                {
                }
                column(Bank_Account__Name; "Bank Account".Name)
                {
                }
                column(Bank_Account_Ledger_Entry__Amount; "Bank Account Ledger Entry".Amount)
                {
                }
                column(StartBalance____Bank_Account_Ledger_Entry__Amount_tellerIssues; StartBalance + "Bank Account Ledger Entry".Amount + tellerIssues)
                {
                    AutoFormatExpression = "Bank Account Ledger Entry"."Currency Code";
                    AutoFormatType = 1;
                }
                column(TDebit; TDebit)
                {
                }
                column(TCredit; TCredit)
                {
                }
                column(Integer_Number; Number)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if not BankAccLedgEntryExists and ((StartBalance = 0) or ExcludeBalanceOnly) then begin
                        StartBalanceLCY := 0;
                        CurrReport.Skip;
                    end;
                end;
            }

            dataitem("Teller Transaction"; "Teller Transaction")
            {
                DataItemLink = "Transaction Date" = field("Date Filter"), Cashier = field("Cashier ID");
                DataItemTableView = sorting("Transaction No.") where(Type = filter("Cheque Deposit" | "Credit Cheque"), Posted = const(true));
                column(ReportForNavId_5806; 5806)
                {
                }
                column(Transactions_No; "Transaction No.")
                {
                }
                column(Transactions__Account_No_; "Account No.")
                {
                }
                column(Transactions__Account_Name_; "Account Name")
                {
                }
                column(Transactions__Account_Type_; "Account Type")
                {
                }
                column(Transactions__Cheque_Type_; "Cheque Type")
                {
                }
                column(Transactions__Cheque_No_; "Cheque No")
                {
                }
                column(Transactions__Cheque_Date_; "Cheque Date")
                {
                }
                column(Transactions_Amount; Amount)
                {
                }
                column(Transactions__Expected_Maturity_Date_; "Expected Maturity Date")
                {
                }
                column(Transactions_Amount_Control1102755015; Amount)
                {
                }
                column(Transactions__Cheque_Date_Caption; FieldCaption("Cheque Date"))
                {
                }
                column(Transactions__Cheque_No_Caption; FieldCaption("Cheque No"))
                {
                }
                column(Transactions__Cheque_Type_Caption; FieldCaption("Cheque Type"))
                {
                }
                column(Transactions__Account_Name_Caption; FieldCaption("Account Name"))
                {
                }
                column(Transactions__Account_No_Caption; FieldCaption("Account No."))
                {
                }
                column(Transactions_NoCaption; FieldCaption("Transaction No."))
                {
                }
                column(CHEQUE_DEPOSITSCaption; CHEQUE_DEPOSITSCaptionLbl)
                {
                }
                column(Transactions_AmountCaption; FieldCaption(Amount))
                {
                }
                column(Maturity_DateCaption; Maturity_DateCaptionLbl)
                {
                }
                column(Total_Cheque_DepositsCaption; Total_Cheque_DepositsCaptionLbl)
                {
                }
                column(Transactions_Transaction_Date; "Transaction Date")
                {
                }
                column(Transactions_Cashier; Cashier)
                {
                }
                column(DatePosted_TransactionsNEW; "Date Posted")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    RNo += 1;
                    TRNo += 1;
                end;
            }

            dataitem(Bankers; "Teller Transaction")
            {
                DataItemLink = "Transaction Date" = field("Date Filter"), Cashier = field("Cashier ID");
                DataItemTableView = sorting("Transaction No.") where(Type = filter("Bankers Cheque"), Posted = const(true));
                column(ReportForNavId_58; 58)
                {
                }
                column(Bankers_No; "Transaction No.")
                {
                }
                column(Bankers__Account_No_; "Account No.")
                {
                }
                column(Bankers__Account_Name_; "Account Name")
                {
                }
                column(Bankers__Cheque_Type_; "Cheque Type")
                {
                }
                column(Bankers_Cheqe_No; "Bankers Cheque No")
                {
                }
                column(Bankers__Cheque_No_; "Bankers Cheque No")
                {
                }
                column(Bankers__Cheque_Date_; "Cheque Date")
                {
                }
                column(Bankers_Amount; Amount)
                {
                }
                column(Bankers__Expected_Maturity_Date_; "Expected Maturity Date")
                {
                }
                column(Bankers_Amount_Control1102755015; Amount)
                {
                }
                column(Bankers__Cheque_Date_Caption; FieldCaption("Cheque Date"))
                {
                }
                column(Bankers__Cheque_No_Caption; FieldCaption("Cheque No"))
                {
                }
                column(Bankers__Cheque_Type_Caption; FieldCaption("Cheque Type"))
                {
                }
                column(Bankers__Account_Name_Caption; FieldCaption("Account Name"))
                {
                }
                column(Bankers__Account_No_Caption; FieldCaption("Account No."))
                {
                }
                column(Bankers_NoCaption; FieldCaption("Transaction No."))
                {
                }
                column(BankersCHEQUE_DEPOSITSCaption; CHEQUE_DEPOSITSCaptionLbl)
                {
                }
                column(BankersTransactions_AmountCaption; FieldCaption(Amount))
                {
                }
                column(BankersMaturity_DateCaption; Maturity_DateCaptionLbl)
                {
                }
                column(BankersTotal_Cheque_DepositsCaption; Total_Cheque_DepositsCaptionLbl)
                {
                }
                column(BankersTransactions_Transaction_Date; "Transaction Date")
                {
                }
                column(BankersTransactions_Cashier; Cashier)
                {
                }
                column(BankersDatePosted_TransactionsNEW; "Date Posted")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    RNo += 1;
                    TRNo += 1;
                    //MESSAGE('t');
                end;
            }

            dataitem("Inter-Bank Transfers"; "IBT Header")
            {
                DataItemLink = "Paying Account" = field("No."), "Transfer Release Date" = field("Date Filter");
                DataItemTableView = sorting("No.");
                column(IBT_No; "Inter-Bank Transfers"."No.")
                {
                }
                column(IBT_Date_Posted; "Inter-Bank Transfers"."Date Posted")
                {
                }
                column(IBT_Paying_Account; "Inter-Bank Transfers"."Paying Account")
                {
                }
                column(IBT_Paying__Bank_Account_Name; "Inter-Bank Transfers"."Paying Account Name")
                {
                }
                column(IBT_Remarks; "Inter-Bank Transfers".Remarks)
                {
                }
                column(IBT_Amount; "Inter-Bank Transfers"."Amount to Transfer")
                {
                }
            }
            dataitem(PaymentHeader; "Payment Header")
            {
                DataItemLink = "Paying Bank Account" = field("No."), Date = field("Date Filter");
                DataItemTableView = sorting("No.") where(Posted = filter(true));
                column(PaymentHeader_No_; PaymentHeader."No.")
                {
                }
                column(PaymentHeader_Date_Posted_; PaymentHeader."Date Posted")
                {
                }
                column(PaymentHeader_Payee; PaymentHeader.Payee)
                {
                }
                column(PaymentHeader_Paying_Bank_Account_; PaymentHeader."Paying Bank Account")
                {
                }
                column(PaymentHeader_Total_Net_Amount_; PaymentHeader."Total Net Amount")
                {
                }
                column(PaymentHeader_Payment_Narration_; PaymentHeader."Payment Narration")
                {
                }
            }
            trigger OnAfterGetRecord()
            begin
                StartBalance := 0;
                TCredit := 0;
                TDebit := 0;

                if BankAccDateFilter <> '' then
                    if GetRangeMin("Date Filter") <> 0D then begin
                        SetRange("Date Filter", 0D, GetRangeMin("Date Filter") - 1);
                        CalcFields("Net Change", "Net Change (LCY)");
                        StartBalance := "Net Change";
                        StartBalanceLCY := "Net Change (LCY)";
                        SetFilter("Date Filter", BankAccDateFilter);
                    end;
                CurrReport.PrintonlyIfDetail := ExcludeBalanceOnly or (StartBalance = 0);
                BankAccBalance := StartBalance;
                BankAccBalanceLCY := StartBalanceLCY;

                "Bank Account".CalcFields("Cashier ID");

                //MESSAGE("Bank Account"."Cashier ID");
            end;

            trigger OnPreDataItem()
            begin

                if CompanyInfo.Get() then
                    CompanyInfo.CalcFields(CompanyInfo.Picture);
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

    trigger OnPreReport()
    begin
        BankAccFilter := "Bank Account".GetFilters;
        BankAccDateFilter := "Bank Account".GetFilter("Date Filter");
    end;

    var
        Text000: label 'Period: %1';
        PrintOnlyOnePerPage: Boolean;
        ExcludeBalanceOnly: Boolean;
        BankAccFilter: Text[250];
        BankAccDateFilter: Text[30];
        BankAccBalance: Decimal;
        BankAccBalanceLCY: Decimal;
        StartBalance: Decimal;
        StartBalanceLCY: Decimal;
        BankAccLedgEntryExists: Boolean;
        PrintReversedEntries: Boolean;
        Cust: Record Members;
        Bank: Record "Bank Account";
        Vend: Record "Savings Accounts";
        Names: Text[200];
        TCredit: Decimal;
        TDebit: Decimal;
        CompanyInfo: Record "Company Information";
        tellerIssues: Decimal;
        IssueAmount: Decimal;
        Cashier_ReportCaptionLbl: label 'Cashier Report';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        BankAccBalance_StartBalance_tellerIssuesCaptionLbl: label 'Balance';
        Account_NameCaptionLbl: label 'Account Name';
        Account_No_CaptionLbl: label 'Account No.';
        Teller__Sign_Date_CaptionLbl: label 'Teller (Sign/Date)';
        EmptyStringCaptionLbl: label '.....................................................................';
        Accountant_Manager__Sign_Date_CaptionLbl: label 'Approved By (Sign/Date)';
        EmptyStringCaption_Control1102760026Lbl: label '.....................................................................';
        Teller_IssuesCaptionLbl: label 'Teller Issues';
        Total_Teller_IssuesCaptionLbl: label 'Total Teller Issues';
        ContinuedCaptionLbl: label 'Continued';
        ContinuedCaption_Control46Lbl: label 'Continued';
        CHEQUE_DEPOSITSCaptionLbl: label 'CHEQUE DEPOSITS';
        Maturity_DateCaptionLbl: label 'Maturity Date';
        Total_Cheque_DepositsCaptionLbl: label 'Total Cheque Deposits';
        Trans: Record "Teller Transaction";
        RNo: Integer;
        ReceiptsPayments: Record "Receipt Header";
        TRNo: Integer;
        SavingsAccounts: Record "Savings Accounts";
        DateFil: Date;
}

