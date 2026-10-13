
report 50473 "Recover Wrong Posted Arrears"
{
    Caption = 'Recover Wrong Posted Arrears';
    ProcessingOnly = true;
    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where("Principal Arrears" = filter(> 0));

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                if StartDate = 0D then Error('StartDate must not be empty');
                if Enddate = 0D then Error('End must not be empty');
            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                GracePeriod: DateFormula;
            begin
                UserSetup.get(UserId);
                Jtemplate := UserSetup."General Journal Template";
                JBatch := UserSetup."General Journal Batch";
                AsAt := today;

                ExpectedAmt := 0;
                AmtPaid := 0;
                DefAmount := 0;
                DaysInArrear := 0;
                ArrearsDate := 0D;
                MDef := 0;
                DocNo := '';
                Desc := '';
                Dim1 := '';
                Dim2 := '';
                Amount := 0;
                PDate := Today;

                DocNo := 'FUND TR : ' + Loans."Member No.";
                TransactionType := TransactionType::"Principal Repayment";
                SaccoActivities.JournalInit(Jtemplate, JBatch);


                Savings.Reset();
                Savings.SetRange("Member No.", Loans."Member No.");
                Savings.SetRange("Product Category", Savings."Product Category"::"Deposit Contribution");
                Savings.SetRange("Date Filter", StartDate, Enddate);
                Savings.CalcFields("Balance (LCY)");
                if Savings.FindFirst() then begin

                    SaccoActivities.GetDefaultedAmount(Loans."Loan No.", AsAt, ExpectedAmt, AmtPaid, DefAmount, DaysInArrear, ArrearsDate, true, GracePeriod);
                    Amount := Savings."Balance (LCY)";
                    Dim1 := Savings."Global Dimension 1 Code";
                    Dim2 := Savings."Global Dimension 2 Code";
                    DimID := UserSetup."Dimension Set ID";

                    if DefAmount > 0 then begin

                        if DefAmount > Amount then
                            DefAmount := Amount;

                        Desc := CopyStr(Format(TransactionType) + ' Fund transfer from - ' + Savings."Product Name", 1, 50);

                        SaccoActivities.JournalInsert(JTemplate, JBatch, DocNo, Pdate, Accttype::Credit, "Loan Account", Desc, Balaccttype::"G/L Account", '', -DefAmount,
                        ExtDocNo, "Loan No.", TransactionType, Dim1, Dim2, true, TChannel::" ", DimID);

                        SaccoActivities.JournalInsert(JTemplate, JBatch, DocNo, Pdate, Accttype::Savings, Savings."No.", Desc, Balaccttype::"G/L Account", '', DefAmount,
                        ExtDocNo, '', TransactionType::" ", Dim1, Dim2, true, TChannel::" ", DimID);

                        SaccoActivities.JournalPost(Jtemplate, JBatch);
                    end;


                end;


            end;

            trigger OnPostDataItem()
            var
                myInt: Integer;
            begin
                Message('Done...');
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
                    field(Enddate; Enddate)
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
    var
        Savings: record "Savings Accounts";
        SaccoActivities: Codeunit "Sacco Activities";
        AmtDefaulted: Decimal;
        ExtDocNo: code[20];
        TChannel: enum "Transaction Channel";
        ExpectedAmt: Decimal;
        StartDate: Date;
        Enddate: Date;
        AmtPaid: Decimal;
        DefAmount: Decimal;
        DaysInArrear: Integer;
        ArrearsDate: Date;
        Jtemplate: Code[20];
        JBatch: Code[20];
        DocNo: Code[20];
        PDate: Date;
        Desc: Text[50];
        Amount: Decimal;
        AcctType: Enum "Gen. Journal Account Type";
        BalAcctType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        LoanNo: Code[20];
        AsAt: Date;
        MDef: Integer;
        Txt0001: label 'Interest Recovery from deposits';
        Txt0003: label 'Principle Recovery from deposits';
        Txt0004: label 'Principle Recovery:-';
        Txt0002: label 'Interest Recovered:-';
        JnlAmt: Decimal;
        LoanAllocation: Decimal;
        ExistPac: Boolean;
        ProductFactory: Record "Product Setup";
        AcctNo: Code[25];
        CreditAccounts: Record Loans;
        NewLoans: Record Loans;
        Txt0005: label 'Principle Amount';
        Txt0006: label 'Cleared by Guarantor loan:';
        CreditAcc: Code[20];
        RecoveryLines: Record "Defaulter Recovery Lines";
        CountNo: Integer;
        Dim1: Code[20];
        Dim2: Code[20];
        UserSetup: Record "User Setup";
        LoansLoop: Record Loans;
        LoanAmount: Decimal;
        GurAmount: Decimal;
        LoanAmountBal: Decimal;
        Members: Record Members;
        Txt0007: label 'Bill Recoverd:-';
        ProdFac: Record "Product Setup";
        SavingsAcc: Code[20];
        SavingsAmt: Decimal;
        Txt0008: label 'Interest Recovery from Savings';
        Txt0009: label 'Principle Recovery from Savings';
        TotalRecoveryAmount: Decimal;
        Err001: label 'There are no loan to recover';
        ProductSetup: Record "Product Setup";
        LoanSched: Record "Loan Repayment Schedule";
        MonthRepay: Decimal;
        Install: Integer;
        TotalBalanceLoan: Decimal;
        NoLoop: Integer;
        LoanAllocationT: Decimal;
        AccountTypes: Record "Product Setup";
        GuarantorAmount: Decimal;
        Skip: Boolean;
        DimID: Integer;
        TransactionType: enum "Transaction Type Enum";
}
