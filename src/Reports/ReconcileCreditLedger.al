report 50011 "Reconcile Credit Ledger"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("CLedger"; "Credit Ledger Entry")
        {

            RequestFilterFields = "posting date";

            trigger OnAfterGetRecord()
            begin

                if GLEntry.get(CLedger."Entry No.") then begin
                    if GLEntry."Document No." = CLedger."Document No." then
                        if GLEntry."Transaction No." = CLedger."Transaction No." then
                            if GLEntry."Posting Date" = CLedger."Posting Date" then
                                if GLEntry.Amount = CLedger.Amount then begin
                                    if Loans.Get(CLedger."Loan No.") then begin
                                        Acct := ProductSetup.GetReceivablesAccount(Loans."loan product type", CLedger."Transaction Type");
                                        if GLEntry."G/L Account No." <> Acct then begin
                                            GlAccount.Get(Acct);
                                            GLEntry."G/L Account No." := GlAccount."No.";
                                            GLEntry."G/L Account Name" := GlAccount.Name;
                                            GLentry.Modify();
                                            j := j + 1;
                                        end;
                                    end;
                                end;

                end;
            end;

            trigger OnPreDataItem()
            begin
                if CLedger.GetFilter("Posting Date") = '' then
                    error('Posting Date is required to run this report');
            end;

            trigger OnPostDataItem()
            begin
                MESSAGE('COMPLETED. Records Modified: %1', j);
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
        GLEntry: Record "G/L Entry";
        CreditAccount: Record "Credit Accounts";
        ProductSetup: record "Product setup";
        GLAccount: Record "G/L Account";
        Acct: code[20];
        Loans: Record "Loans";
        j: Integer;

}

