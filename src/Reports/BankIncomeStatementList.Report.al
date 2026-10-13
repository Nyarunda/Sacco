Report 50338 "Bank Income Statement List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Bank Income Statement List.rdlc';
    Caption = 'Posted Bank Account Reconciliation Report';

    dataset
    {
        dataitem("Bank Account Statement"; "Bank Account Statement")
        {
            RequestFilterFields = "Statement No.";
            column(ReportForNavId_1; 1)
            {
            }
            column(BankAccountNo_BankAccountStatement; "Bank Account Statement"."Bank Account No.")
            {
            }
            column(StatementNo_BankAccountStatement; "Bank Account Statement"."Statement No.")
            {
            }
            column(StatementEndingBalance_BankAccountStatement; "Bank Account Statement"."Statement Ending Balance")
            {
            }
            column(StatementDate_BankAccountStatement; "Bank Account Statement"."Statement Date")
            {
            }
            column(BalanceLastStatement_BankAccountStatement; "Bank Account Statement"."Balance Last Statement")
            {
            }
            column(CashBookBalance_BankAccountStatement; "Bank Account Statement"."Cash Book Balance")
            {
            }
            column(BankCode; BankCode)
            {
            }
            column(BankAccountNo; BankAccountNo)
            {
            }
            column(BankName; BankName)
            {
            }
            column(BankAccountBalanceasperCashBook; BankAccountBalanceasperCashBook)
            {
            }
            column(UnpresentedChequesTotal; UnpresentedChequesTotal)
            {
            }
            column(UncreditedBanking; UncreditedBanking)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(Uncredited; Uncredited)
            {
            }
            column(Undebited; Undebited)
            {
            }
            dataitem("Bank Account Statement Line"; "Bank Account Statement Line")
            {
                DataItemLink = "Bank Account No." = field("Bank Account No."), "Statement No." = field("Statement No.");
                DataItemTableView = where(Difference = filter(> 0), "Statement Amount" = filter(< 0));
                column(ReportForNavId_14; 14)
                {
                }
                column(BankAccountNo_BankAccountStatementLine; "Bank Account Statement Line"."Bank Account No.")
                {
                }
                column(StatementLineNo_BankAccountStatementLine; "Bank Account Statement Line"."Statement Line No.")
                {
                }
                column(StatementNo_BankAccountStatementLine; "Bank Account Statement Line"."Statement No.")
                {
                }
                column(StatementAmount_BankAccountStatementLine; "Bank Account Statement Line"."Statement Amount")
                {
                }
                column(Description_BankAccountStatementLine; "Bank Account Statement Line".Description)
                {
                }
                column(TransactionDate_BankAccountStatementLine; "Bank Account Statement Line"."Transaction Date")
                {
                }
                column(DocumentNo_BankAccountStatementLine; "Bank Account Statement Line"."Document No.")
                {
                }
                /*
                column(Debit_BankAccountStatementLine; "Bank Account Statement Line".Debit)
                {
                }
                column(Credit_BankAccountStatementLine; "Bank Account Statement Line".Credit)
                {
                }
                column(OpenType_BankAccountStatementLine; "Bank Account Statement Line"."Open Type")
                {
                }
                */
            }
            dataitem("<Bank Account Statement Line1>"; "Bank Account Statement Line")
            {
                DataItemLink = "Bank Account No." = field("Bank Account No."), "Statement No." = field("Statement No.");
                DataItemTableView = where(Difference = filter(> 0), "Statement Amount" = filter(> 0));
                column(ReportForNavId_35; 35)
                {
                }
                column(BankAccountNo_BankAccountStatementLine1; "<Bank Account Statement Line1>"."Bank Account No.")
                {
                }
                column(StatementLineNo_BankAccountStatementLine1; "<Bank Account Statement Line1>"."Statement Line No.")
                {
                }
                column(StatementNo_BankAccountStatementLine1; "<Bank Account Statement Line1>"."Statement No.")
                {
                }
                column(StatementAmount_BankAccountStatementLine1; "<Bank Account Statement Line1>"."Statement Amount")
                {
                }
                column(Description_BankAccountStatementLine1; "<Bank Account Statement Line1>".Description)
                {
                }
                column(TransactionDate_BankAccountStatementLine1; "<Bank Account Statement Line1>"."Transaction Date")
                {
                }
                column(DocumentNo_BankAccountStatementLine1; "<Bank Account Statement Line1>"."Document No.")
                {
                }
                /*
                column(Debit_BankAccountStatementLine1; "<Bank Account Statement Line1>".Debit)
                {
                }
                column(OpenType_BankAccountStatementLine1; "<Bank Account Statement Line1>"."Open Type")
                {
                }
                */
            }
            dataitem("Posted Bank Acc. Recon Line"; "Posted Bank Acc. Recon Line Ne")
            {
                DataItemLink = "Bank Account No." = field("Bank Account No."), "Statement No." = field("Statement No.");
                DataItemTableView = where(Difference = filter(> 0));
                column(ReportForNavId_39; 39)
                {
                }
                column(PBA_BankAcountNo; "Posted Bank Acc. Recon Line"."Bank Account No.")
                {
                }
                column(PBA_StatementLineNo; "Posted Bank Acc. Recon Line"."Statement Line No.")
                {
                }
                column(PBA_StatementNo; "Posted Bank Acc. Recon Line"."Statement No.")
                {
                }
                column(PBA_StatementAmount; "Posted Bank Acc. Recon Line"."Statement Amount")
                {
                }
                column(PBA_StatementDescp; "Posted Bank Acc. Recon Line".Description)
                {
                }
                column(PBA_TransDate; "Posted Bank Acc. Recon Line"."Transaction Date")
                {
                }
                column(PBA_DocNo; "Posted Bank Acc. Recon Line"."Document No.")
                {
                }
                column(Debit_Amount; "Posted Bank Acc. Recon Line".Difference)
                {
                }
                column(Open_Type; "Posted Bank Acc. Recon Line"."Open Type")
                {
                }
            }
            dataitem("<Posted Bank Acc. Recon Line1>"; "Posted Bank Acc. Recon Line Ne")
            {
                DataItemLink = "Bank Account No." = field("Bank Account No."), "Statement No." = field("Statement No.");
                DataItemTableView = where(Difference = filter(< 0));
                column(ReportForNavId_58; 58)
                {
                }
                column(PBA_BankAcountNo1; "<Posted Bank Acc. Recon Line1>"."Bank Account No.")
                {
                }
                column(PBA_StatementLineNo1; "<Posted Bank Acc. Recon Line1>"."Statement Line No.")
                {
                }
                column(PBA_StatementNo1; "<Posted Bank Acc. Recon Line1>"."Statement No.")
                {
                }
                column(PBA_StatementAmount1; "<Posted Bank Acc. Recon Line1>"."Statement Amount")
                {
                }
                column(PBA_StatementDescp1; "<Posted Bank Acc. Recon Line1>".Description)
                {
                }
                column(PBA_TransDate1; "<Posted Bank Acc. Recon Line1>"."Transaction Date")
                {
                }
                column(PBA_DocNo1; "<Posted Bank Acc. Recon Line1>"."Document No.")
                {
                }
                column(Debit_Amount1; "<Posted Bank Acc. Recon Line1>".Difference)
                {
                }
                column(Open_Type1; "<Posted Bank Acc. Recon Line1>"."Open Type")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                BankCode := '';
                BankAccountNo := '';
                BankName := '';
                BankAccountBalanceasperCashBook := 0;
                UnpresentedChequesTotal := 0;
                UncreditedBanking := 0;

                Bank.Reset;
                Bank.SetRange(Bank."No.", "Bank Account No.");
                if Bank.Find('-') then begin
                    BankCode := Bank."No.";
                    BankAccountNo := Bank."Bank Account No.";
                    BankName := Bank.Name;
                    // Bank.CALCFIELDS(Bank.Balance);
                    // BankAccountBalanceasperCashBook:="Cash Book Balance";
                    BankAccountBalanceasperCashBook := "Bank Account Statement"."Cash Book Balance";

                    BankStatementLine.Reset;
                    BankStatementLine.SetRange(BankStatementLine."Bank Account No.", Bank."No.");
                    BankStatementLine.SetRange(BankStatementLine."Statement No.", "Statement No.");
                    BankStatementLine.Setfilter(BankStatementLine.Difference, '>0');
                    if BankStatementLine.Find('-') then
                        repeat
                            if BankStatementLine."Statement Amount" < 0 then
                                UnpresentedChequesTotal := UnpresentedChequesTotal + BankStatementLine."Statement Amount"
                            else
                                if BankStatementLine."Statement Amount" > 0 then
                                    UncreditedBanking := UncreditedBanking + BankStatementLine."Statement Amount";
                        until BankStatementLine.Next = 0;

                    "Posted Bank Acc. Recon Line".Reset;
                    "Posted Bank Acc. Recon Line".SetRange("Posted Bank Acc. Recon Line"."Bank Account No.", Bank."No.");
                    "Posted Bank Acc. Recon Line".SetRange("Posted Bank Acc. Recon Line"."Statement No.", "Statement No.");
                    "Posted Bank Acc. Recon Line".SetFilter("Posted Bank Acc. Recon Line".Difference, '<>0');
                    if "Posted Bank Acc. Recon Line".Find('-') then
                        repeat
                            if "Posted Bank Acc. Recon Line".Difference < 0 then
                                Undebited := Undebited + "Posted Bank Acc. Recon Line".Difference
                            else
                                if "Posted Bank Acc. Recon Line".Difference > 0 then
                                    Uncredited := Uncredited + "Posted Bank Acc. Recon Line".Difference;
                        until "Posted Bank Acc. Recon Line".Next = 0;

                    UnpresentedChequesTotal := UnpresentedChequesTotal * -1;

                    //BankStatementLine


                end;
            end;

            trigger OnPostDataItem()
            begin
                //if BankAccountNo <> '' then
                //CurrReport.Newpage;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get;
                CompanyInfo.CalcFields(Picture);
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

    var
        Bank: Record "Bank Account";
        BankCode: Code[20];
        BankAccountNo: Code[20];
        BankName: Text;
        BankAccountBalanceasperCashBook: Decimal;
        UnpresentedChequesTotal: Decimal;
        UncreditedBanking: Decimal;
        BankStatementLine: Record "Bank Account Statement Line";
        CompanyInfo: Record "Company Information";
        Uncredited: Decimal;
        Undebited: Decimal;
}

