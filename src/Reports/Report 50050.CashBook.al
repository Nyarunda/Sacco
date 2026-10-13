Report 50050 "Cash Book"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Cash Book.rdlc';
    Caption = 'Bank Acc. - Detail Trial Bal.';

    dataset
    {
        dataitem("Bank Account"; "Bank Account")
        {
            DataItemTableView = sorting("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", "Bank Acc. Posting Group", "Date Filter";
            column(ReportForNavId_4558; 4558)
            {
            }
            column(FilterPeriod_BankAccLedg; StrSubstNo(Text000, DateFilter_BankAccount))
            {
            }
            column(CompanyName; CompanyProperty.DisplayName)
            {
            }
            column(ExcludeBalanceOnly; ExcludeBalanceOnly)
            {
            }
            column(BankAccFilter; BankAccFilter)
            {
            }
            column(StartBalanceLCY; StartBalanceLCY)
            {
            }
            column(StartBalance; StartBalance)
            {
            }
            column(PrintOnlyOnePerPage; PrintOnlyOnePerPage)
            {
            }
            column(ReportFilter; StrSubstNo('%1: %2', TableCaption, BankAccFilter))
            {
            }
            column(No_BankAccount; "No.")
            {
            }
            column(Name_BankAccount; Name)
            {
            }
            column(PhNo_BankAccount; "Phone No.")
            {
                IncludeCaption = true;
            }
            column(CurrencyCode_BankAccount; "Currency Code")
            {
                IncludeCaption = true;
            }
            column(StartBalance2; StartBalance)
            {
                AutoFormatExpression = "Bank Account Ledger Entry"."Currency Code";
                AutoFormatType = 1;
            }
            column(BankAccDetailTrialBalCap; BankAccDetailTrialBalCapLbl)
            {
            }
            column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
            {
            }
            column(RepInclBankAcchavingBal; RepInclBankAcchavingBalLbl)
            {
            }
            column(BankAccLedgPostingDateCaption; BankAccLedgPostingDateCaptionLbl)
            {
            }
            column(BankAccBalanceCaption; BankAccBalanceCaptionLbl)
            {
            }
            column(OpenFormatCaption; OpenFormatCaptionLbl)
            {
            }
            column(BankAccBalanceLCYCaption; BankAccBalanceLCYCaptionLbl)
            {
            }
            dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
            {
                DataItemLink = "Bank Account No." = field("No."), "Posting Date" = field("Date Filter"), "Global Dimension 2 Code" = field("Global Dimension 2 Filter"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter");
                DataItemTableView = sorting("Bank Account No.", "Posting Date");
                column(ReportForNavId_4920; 4920)
                {
                }
                column(DebitAmountLCY_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Debit Amount (LCY)")
                {
                }
                column(CreditAmountLCY_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Credit Amount (LCY)")
                {
                }
                column(Total; Total)
                {
                }
                column(PostingDate_BankAccLedg; Format("Posting Date"))
                {
                }
                column(DocType_BankAccLedg; "Document Type")
                {
                    IncludeCaption = true;
                }
                column(DocNo_BankAccLedg; "Document No.")
                {
                    IncludeCaption = true;
                }
                column(External_Document_No_; "External Document No.")
                {
                    IncludeCaption = true;
                }
                column(Desc_BankAccLedg; Description)
                {
                    IncludeCaption = true;
                }
                column(BankAccBalance; BankAccBalance)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(RemaningAmt_BankAccLedg; "Remaining Amount")
                {
                    IncludeCaption = true;
                }
                column(EntryNo_BankAccLedg; "Entry No.")
                {
                    IncludeCaption = true;
                }
                column(OpenFormat; Format(Open))
                {
                    // OptionCaption = 'Open';
                }
                column(Amount_BankAccLedg; Amount)
                {
                    IncludeCaption = true;
                }
                column(EntryAmtLcy_BankAccLedg; "Amount (LCY)")
                {
                    IncludeCaption = true;
                }
                column(BankAccBalanceLCY; BankAccBalanceLCY)
                {
                    AutoFormatType = 1;
                }
                column(ContinuedCaption; ContinuedCaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    if Filter <> Filter::All then
                        if Filter = Filter::Payments then
                            if "Bank Account Ledger Entry"."Amount (LCY)" > 0 then
                                CurrReport.Skip;


                    if Filter <> Filter::All then
                        if Filter = Filter::Receipts then
                            if "Bank Account Ledger Entry"."Amount (LCY)" < 0 then
                                CurrReport.Skip;



                    if not PrintReversedEntries and Reversed then
                        CurrReport.Skip;
                    BankAccLedgEntryExists := true;
                    BankAccBalance := BankAccBalance + Amount;
                    BankAccBalanceLCY := BankAccBalanceLCY + "Amount (LCY)";

                    Total := BankAccBalance;
                    //MESSAGE(FORMAT("Posting Date"));
                end;

                trigger OnPreDataItem()
                begin
                    BankAccLedgEntryExists := false;
                    //CurrReport.CreateTotals(Amount, "Amount (LCY)");
                end;
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(ReportForNavId_5444; 5444)
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

            trigger OnAfterGetRecord()
            begin
                StartBalance := 0;

                if Filter = Filter::All then
                    if DateFilter_BankAccount <> '' then
                        if GetRangeMin("Date Filter") <> 0D then begin
                            SetRange("Date Filter", 0D, GetRangeMin("Date Filter") - 1);
                            CalcFields("Net Change", "Net Change (LCY)");
                            StartBalance := "Net Change";
                            StartBalanceLCY := "Net Change (LCY)";
                            SetFilter("Date Filter", DateFilter_BankAccount);
                        end;
                CurrReport.PrintonlyIfDetail := ExcludeBalanceOnly or (StartBalance = 0);
                BankAccBalance := StartBalance;
                BankAccBalanceLCY := StartBalanceLCY;

                if PrintOnlyOnePerPage then
                    PageGroupNo := PageGroupNo + 1;
            end;

            trigger OnPreDataItem()
            begin
                //CurrReport.NewPagePerRecord := PrintOnlyOnePerPage;
                //CurrReport.CreateTotals("Bank Account Ledger Entry"."Amount (LCY)", StartBalanceLCY);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field("Filter"; Filter)
                {
                    ApplicationArea = Basic;
                }
                group(Options)
                {
                    Caption = 'Options';
                    field(PrintOnlyOnePerPage; PrintOnlyOnePerPage)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'New Page per Bank Account';
                        ToolTip = 'Specifies if you want to print each bank account on a separate page.';
                    }
                    field(ExcludeBalanceOnly; ExcludeBalanceOnly)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Exclude Bank Accs. That Have a Balance Only';
                        MultiLine = true;
                        ToolTip = 'Specifies if you do not want the report to include entries for bank accounts that have a balance but do not have a net change during the selected time period.';
                    }
                    field(PrintReversedEntries; PrintReversedEntries)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Include Reversed Entries';
                        ToolTip = 'Specifies if you want to include reversed entries in the report.';
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

    trigger OnInitReport()
    begin
        PageGroupNo := 1;
    end;

    trigger OnPreReport()
    begin
        BankAccFilter := "Bank Account".GetFilters;
        DateFilter_BankAccount := "Bank Account".GetFilter("Date Filter");
    end;

    var
        Text000: label 'Period: %1';
        PrintOnlyOnePerPage: Boolean;
        ExcludeBalanceOnly: Boolean;
        BankAccFilter: Text;
        DateFilter_BankAccount: Text;
        BankAccBalance: Decimal;
        BankAccBalanceLCY: Decimal;
        StartBalance: Decimal;
        StartBalanceLCY: Decimal;
        BankAccLedgEntryExists: Boolean;
        PrintReversedEntries: Boolean;
        PageGroupNo: Integer;
        BankAccDetailTrialBalCapLbl: label 'Bank Acc. - Detail Trial Bal.';
        CurrReportPageNoCaptionLbl: label 'Page';
        RepInclBankAcchavingBalLbl: label 'This report also includes bank accounts that only have balances.';
        BankAccLedgPostingDateCaptionLbl: label 'Posting Date';
        BankAccBalanceCaptionLbl: label 'Balance';
        OpenFormatCaptionLbl: label 'Open';
        BankAccBalanceLCYCaptionLbl: label 'Balance (LCY)';
        ContinuedCaptionLbl: label 'Continued';
        Total: Decimal;
        "Filter": Option All,Receipts,Payments;


    procedure InitializeRequest(NewPrintOnlyOnePerPage: Boolean; NewExcludeBalanceOnly: Boolean; NewPrintReversedEntries: Boolean)
    begin
        PrintOnlyOnePerPage := NewPrintOnlyOnePerPage;
        ExcludeBalanceOnly := NewExcludeBalanceOnly;
        PrintReversedEntries := NewPrintReversedEntries;
    end;
}

