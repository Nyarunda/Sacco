
report 50010 "Reconcile Savings Ledger"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("SLedger"; "Savings Ledger Entry")
        {

            RequestFilterFields = "posting date";

            trigger OnAfterGetRecord()
            begin

                if GLEntry.get(SLedger."Entry No.") then begin
                    if GLEntry."Document No." = sledger."Document No." then
                        if GLEntry."Transaction No." = SLedger."Transaction No." then
                            if GLEntry."Posting Date" = SLedger."Posting Date" then
                                if GLEntry.Amount = SLedger.Amount then begin
                                    if SavingsAccount.Get(SLedger."Account No.") then begin
                                        PostingGroup.Get(SavingsAccount."Customer Posting Group");
                                        PostingGroup.TestField("Receivables Account");

                                        if GLEntry."G/L Account No." <> PostingGroup."Receivables Account" then begin
                                            GlAccount.Get(PostingGroup."Receivables Account");
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
                if SLedger.GetFilter("Posting Date") = '' then
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
        SavingsAccount: Record "Savings Accounts";
        PostingGroup: record "Customer Posting Group";
        GLAccount: Record "G/L Account";
        j: Integer;
}

