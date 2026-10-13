//namespace CentralDB.CentralDB;

report 50464 "Transfer Overpaid Interest"
{
    ApplicationArea = All;
    Caption = 'Transfer Overpaid Interest/Principal ';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where(Posted = filter(true));
            RequestFilterFields = "Outstanding Interest", "Outstanding Principal";
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                if PDate = 0D then
                    PDate := Today;

                JTemplate := 'GENERAL';
                JBatch := 'OVERPAYINT';

                GenJournalBatch.Reset;
                GenJournalBatch.SetRange("Journal Template Name", JTemplate);
                GenJournalBatch.SetRange(Name, JBatch);
                if not GenJournalBatch.FindFirst then begin
                    GenJournalBatch.Init;
                    GenJournalBatch."Journal Template Name" := JTemplate;
                    GenJournalBatch.Name := JBatch;
                    GenJournalBatch.Description := 'OVERPAYMENT INTEREST Batch';
                    GenJournalBatch.Insert;
                end;

                SaccoActivities.JournalInit(Jtemplate, JBatch);

                if Interest then
                    SetFilter("Outstanding Interest", '<0');

                if Principal then
                    SetFilter("Outstanding Principal", '<0');

            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;

            begin

                LoanNo := '';
                RunBal := 0;

                Loans.CalcFields("Outstanding Interest", "Outstanding Principal");
                LoanNo := Loans."Loan No.";
                DocNo := 'OVERPAYMENT ' + Format(Today);
                Desc := 'Overpayment transfer for loan ' + Loans."Loan No.";

                if Interest then begin
                    RunBal := Loans."Outstanding Interest" * -1;
                    if RunBal > 0 then begin
                        Amt := 0;
                        if (RunBal > Loans."Outstanding Principal") and ("Outstanding Principal" > 0) then
                            Amt := Loans."Outstanding Principal";


                        SaccoActivities.JournalInsert(Jtemplate, Jbatch, DocNo, PDate, AcctType::Credit, Loans."Loan Account", Desc, BalAcctType::"G/L Account", '', Amt, ExtDocNo, Loans."Loan No.", TransType::"Interest Paid", Dim1, Dim2, true, TChannel::Recovery, DimID);


                        SaccoActivities.JournalInsert(Jtemplate, Jbatch, DocNo, PDate, AcctType::Credit, Loans."Loan Account", Desc, BalAcctType, '', Amt * -1, ExtDocNo, Loans."Loan No.", TransType::"Principal Repayment", Dim1, Dim2, true, TChannel::Recovery, DimID);

                        RunBal -= Amt;

                        if RunBal > 0 then begin
                            AcctNo := Legacy.GetDepositAccounts(Loans."Member No.");
                            AcctType := AcctType::Savings;

                            SaccoActivities.JournalInsert(Jtemplate, Jbatch, DocNo, PDate, AcctType::Credit, Loans."Loan Account", Desc, BalAcctType::"G/L Account", '', RunBal, ExtDocNo, Loans."Loan No.", TransType::"Interest Paid", Dim1, Dim2, true, TChannel::Recovery, DimID);

                            SaccoActivities.JournalInsert(Jtemplate, Jbatch, DocNo, PDate, AcctType, AcctNo, Desc, BalAcctType, '', RunBal * -1, ExtDocNo, '', TransType, Dim1, Dim2, true, TChannel::Recovery, DimID);
                            RunBal -= RunBal;
                        end;
                    end;
                end;

                if Principal then begin
                    RunBal := Loans."Outstanding Principal" * -1;
                    if RunBal > 0 then begin
                        Amt := 0;
                        if (Loans."Outstanding interest" > 0) and (RunBal > Loans."Outstanding interest") then
                            Amt := Loans."Outstanding Interest";


                        SaccoActivities.JournalInsert(Jtemplate, Jbatch, DocNo, PDate, AcctType::Credit, Loans."Loan Account", Desc, BalAcctType::"G/L Account", '', Amt, ExtDocNo, Loans."Loan No.", TransType::"Principal Repayment", Dim1, Dim2, true, TChannel::Recovery, DimID);


                        SaccoActivities.JournalInsert(Jtemplate, Jbatch, DocNo, PDate, AcctType::Credit, Loans."Loan Account", Desc, BalAcctType, '', Amt * -1, ExtDocNo, Loans."Loan No.", TransType::"Interest Paid", Dim1, Dim2, true, TChannel::Recovery, DimID);

                        RunBal -= Amt;

                        if RunBal > 0 then begin
                            AcctNo := Legacy.GetDepositAccounts(Loans."Member No.");
                            AcctType := AcctType::Savings;

                            SaccoActivities.JournalInsert(Jtemplate, Jbatch, DocNo, PDate, AcctType::Credit, Loans."Loan Account", Desc, BalAcctType::"G/L Account", '', RunBal, ExtDocNo, Loans."Loan No.", TransType::"Principal Repayment", Dim1, Dim2, true, TChannel::Recovery, DimID);

                            SaccoActivities.JournalInsert(Jtemplate, Jbatch, DocNo, PDate, AcctType, AcctNo, Desc, BalAcctType, '', RunBal * -1, ExtDocNo, '', TransType, Dim1, Dim2, true, TChannel::Recovery, DimID);

                        end;
                    end;
                end;
            end;

            trigger OnPostDataItem()
            var
                myInt: Integer;
            begin
                Message('Done Processing');
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
                    field(PDate; PDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Date';
                    }
                    field(Interest; Interest)
                    {
                        ApplicationArea = All;
                    }
                    field(Principal; Principal)
                    {
                        ApplicationArea = All;
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

    var
        GenJournalBatch: Record "Gen. Journal Batch";
        TChannel: Enum "Transaction Channel";
        PDate: Date;
        Jtemplate: Code[20];
        JBatch: Code[20];
        DocNo: Code[20];
        LoanNo: Code[20];
        LoansApp: Record Loans;
        AcctType: Enum "Gen. Journal Account Type";
        AcctNo: Code[20];
        Desc: Text[150];
        BalAcctType: Enum "Gen. Journal Account Type";
        BalAcctNo: Code[20];
        Amt: Decimal;
        ExtDocNo: Code[20];
        Loan: Code[20];
        TransType: Enum "Transaction Type Enum";
        Dim1: Code[20];
        Dim2: Code[20];
        SystemCreated: Boolean;
        Channel: Enum "Transaction Channel";
        DimID: Integer;
        ArrearsDate: Date;
        ExpectedAmt: Decimal;
        AmtPaid: decimal;
        DefAmount: decimal;
        PSetup: Record "Product Setup";
        DaysInArrear: Integer;
        SADepsits: Record "Savings Accounts";
        CurMonthDeposits: Record "Savings Accounts";
        RunBal: Decimal;
        Legacy: Codeunit Legacy;
        Interest: Boolean;
        Principal: Boolean;
        SaccoActivities: Codeunit "Sacco Activities";
}

