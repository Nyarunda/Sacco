
Report 50146 "Teller Report 2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Teller Report 2.rdlc';
    Caption = 'Cashier Report 2';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem("Bank Account"; "Bank Account")
        {
            DataItemTableView = sorting("No.");
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
            column(Bank_Account_Date_Filter; BankAccDateFilter)
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
            column(BankType_BankAccount; "Bank Account"."Bank Type")
            {
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

                //CurrReport.PRINTONLYIFDETAIL := ExcludeBalanceOnly OR (StartBalance = 0);
                BankAccBalance := StartBalance;
                BankAccBalanceLCY := StartBalanceLCY;

                "Bank Account".CalcFields("Cashier ID");
                if "Bank Account"."Cashier ID" = '' then
                    CurrReport.Skip;

                if Branch <> '' then
                    if USet.Get("Bank Account"."Cashier ID") then begin
                        if USet."Global Dimension 2 Code" <> Branch then
                            CurrReport.Skip;
                    end;

                //MESSAGE("Bank Account"."Cashier ID");
            end;

            trigger OnPreDataItem()
            begin
                //CurrReport.NEWPAGEPERRECORD := PrintOnlyOnePerPage;

                if CompanyInfo.Get() then
                    CompanyInfo.CalcFields(CompanyInfo.Picture);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Branch; Branch)
                {
                    ApplicationArea = Basic;
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = filter(2));
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
        Names: Text[50];
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
        Accountant_Manager__Sign_Date_CaptionLbl: label 'Accountant/Manager (Sign/Date)';
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
        "Bank Account Ledger Entry": Record "Bank Account Ledger Entry";
        Branch: Code[10];
        USet: Record "User Setup";
}

