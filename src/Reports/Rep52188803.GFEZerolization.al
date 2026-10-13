
report 50485 "GFE Zerolization"
{
    Caption = 'GFE Zerolization';
    ProcessingOnly = true;
    dataset
    {
        dataitem(Savings; "Savings Accounts")
        {
            DataItemTableView = where("Product Category" = filter("Benevolent Fund"), "Balance (LCY)" = filter(> 0));
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                if PDate = 0D then Error('Posting Date is required');

                UserSetup.Get(UserId);
                UserSetup.TestField("General Journal Template");
                UserSetup.TestField("General Journal Batch");

                JTemplate := UserSetup."General Journal Template";
                JBatch := UserSetup."General Journal Batch";

                SaccoActivities.JournalInit(JTemplate, JBatch);
                SaccoSetup.Get();
            end;

            trigger OnAfterGetRecord()

            var
                Amt: decimal;
            begin
                Amt := 0;
                Savings.CalcFields("Balance (LCY)");
                Amt := Savings."Balance (LCY)";
                Members.Get(Savings."Member No.");
                if Members.Type <> Members.Type::Group then
                    if Amt > 1200 then
                        Amt := 1200;

                if Savings."Balance (LCY)" <> 0 then begin
                    Savings.TestField("Customer Posting Group");
                    //CustPostingGr.Get(Savings."Customer Posting Group");
                    SaccoSetup.TestField("GFE Income Acc.");
                    BalAcctNo := SaccoSetup."GFE Income Acc.";//CustPostingGr.GetPayablesAccount;

                    SaccoActivities.JournalInsert(
                        JTemplate,
                        JBatch,
                        'GFE: ' + format(date2dmy(PDate, 3)),
                        PDate,
                        Accttype::Savings,
                        Savings."No.",
                        CopyStr('Zerolize GFE Fund ' + Format(PDate), 1, 50),
                        Balaccttype::"G/L Account",
                        BalAcctNo,
                        Amt,
                        ExtDocNo,
                        '',
                        Transtype::" ",
                        "Global Dimension 1 Code",
                        "Global Dimension 2 Code",
                        true,
                        TChannel::" ",
                        0
                        );

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
                group(GroupName)
                {
                    field(PDate; PDate)
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
        PDate: Date;
        SaccoSetup: Record "Sacco Setup";
        ErrTxt0000: label 'Account already Posted';
        ErrTxt0001: label 'Account cannot be colsed, insufficient funds';
        ErrTxt0002: label 'The request must be approved';
        ConfmTxt0003: label 'Are you sure you want to recover the loans from the members shares?';
        Txt0004: label 'Account Closure ';
        Txt0005: label 'Interest Recovery from deposits';
        Txt0006: label 'Principle Recovery from deposits';
        Txt0007: label 'Member Withdrawal Account No';
        Txt0008: label 'Funeral Expenses';
        DocMustbeOpen: label 'This application request must be open';
        DocMustbePending: label 'This application request must be Pending';
        Txt0000: label 'Checkoff has been posted';
        Txt0001: label 'Excise Duty';
        Txt0002: label 'Member cannot close the account before clearing the loans';
        Txt0009: label 'Withdrawal Fee';
        Txt0010: label 'Account Closure Fee';
        Members: Record Members;
        UserSetup: Record "User Setup";
        SaccoActivities: Codeunit "Sacco Activities";
        JTemplate: Code[10];
        JBatch: Code[10];
        AvailBal: Decimal;
        MemberActivities: Codeunit "Member Activities";
        ProductSetup: Record "Product Setup";
        SavingsAmt: Decimal;
        AcctType: Enum "Gen. Journal Account Type";
        BalAcctType: Enum "Gen. Journal Account Type";
        BalAcctNo: Code[20];
        ExtDocNo: Code[20];
        TransType: Enum "Transaction Type Enum";
        RunBal: Decimal;
        Loans: Record Loans;
        CustPostingGr: Record "Vendor Posting Group";
        Withdrawal: Record "Member Exit";
        TChannel: Enum "Transaction Channel";

}
