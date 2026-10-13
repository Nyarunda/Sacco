/// <summary>
/// Codeunit PostCustom (ID 50093).
/// </summary>
codeunit 50093 PostCustom
{


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterPostGenJnlLine', '', false, false)]
    local procedure OnAfterPostGenJnlLine(var GenJournalLine: Record "Gen. Journal Line"; Balancing: Boolean)
    begin

    end;



    local procedure PostCredit(var GenJournalLine: Record "Gen. Journal Line"; Balancing: Boolean)
    var
        Cust: Record Members;
        Loans: Record Loans;
        CustLedgEntry: Record "Credit Ledger Entry";
        ReceivablesAccount: Code[20];
        ShouldCheckDocNo: Boolean;
        IsHandled: Boolean;
        ProductSetup: Record "Product Setup";
    begin


        Cust.Get(GenJournalLine."Account No.");
        Cust.CheckBlockedCust(Cust);

        ReceivablesAccount := '';
        GenJournalLine.TestField("Loan No.");
        if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
            Error('Transaction Type Missing for A/C ' + GenJournalLine."Account No." + ', Line No. %1', GenJournalLine."Line No.");

        Loans.Get(GenJournalLine."Loan No.");
        ProductSetup.Get(Loans."Loan Product Type");
        ReceivablesAccount := ProductSetup.GetReceivablesAccount(ProductSetup."Product ID", GenJournalLine."Transaction Type");



        CustLedgEntry.LockTable();

        InitCustLedgEntry(GenJournalLine, CustLedgEntry);

    end;



    local procedure InitCustLedgEntry(GenJnlLine: Record "Gen. Journal Line"; var CustLedgEntry: Record "Credit Ledger Entry")
    begin
        InitNextEntryNo;
        CustLedgEntry.Init();
        CustLedgEntry.CopyFromGenJnlLine(GenJnlLine);
        CustLedgEntry."Entry No." := NextEntryNo;
        CustLedgEntry."Transaction No." := NextTransactionNo;



        if ((GenJnlLine.Amount > 0) or (GenJnlLine."Amount (LCY)" > 0)) and not GenJnlLine.Correction or
           ((GenJnlLine.Amount < 0) or (GenJnlLine."Amount (LCY)" < 0)) and GenJnlLine.Correction
        then begin
            CustLedgEntry."Debit Amount" := GenJnlLine.Amount;
            CustLedgEntry."Credit Amount" := 0;
            CustLedgEntry."Debit Amount (LCY)" := GenJnlLine."Amount (LCY)";
            CustLedgEntry."Credit Amount (LCY)" := 0;
        end else begin
            CustLedgEntry."Debit Amount" := 0;
            CustLedgEntry."Credit Amount" := -GenJnlLine.Amount;
            CustLedgEntry."Debit Amount (LCY)" := 0;
            CustLedgEntry."Credit Amount (LCY)" := -GenJnlLine."Amount (LCY)";
        end;

    end;

    local procedure InitNextEntryNo()
    var
        GLEntry: Record "G/L Entry";
        LastEntryNo: Integer;
        LastTransactionNo: Integer;
    begin
        GLEntry.LockTable();
        GLEntry.GetLastEntry(LastEntryNo, LastTransactionNo);
        NextEntryNo := LastEntryNo + 1;
        NextTransactionNo := LastTransactionNo + 1;
    end;







    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforePostGenJnlLine', '', false, false)]
    local procedure OnBeforePostGenJnlLine(var GenJournalLine: Record "Gen. Journal Line"; Balancing: Boolean)
    var
        Savings: Record "Savings Accounts";
    begin


        case GenJournalLine."Account Type" of
            GenJournalLine."Account Type"::Savings:
                begin
                    if Savings.Get(GenJournalLine."Account No.") then
                        GenJournalLine."Member No." := Savings."Member No.";
                    GenJournalLine."Account Type" := GenJournalLine."Account Type"::Savings;
                    GenJournalLine.Modify();
                end;
            GenJournalLine."Account Type"::Credit:
                begin
                    GenJournalLine."Account Type" := GenJournalLine."Account Type"::Credit;
                    GenJournalLine."Credit Entry" := true;
                    GenJournalLine.Modify();
                end;
        end;

        /*if GenJournalLine."Credit Amount" > 0 then
            GenJournalLine.TestField(Channel);
            */

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterGetCustomerReceivablesAccount', '', false, false)]

    local procedure OnAfterGetCustomerReceivablesAccount(GenJournalLine: Record "Gen. Journal Line"; CustomerPostingGroup: Record "Customer Posting Group"; var ReceivablesAccount: Code[20])
    var
        Loans: Record Loans;
        ProductSetup: Record "Product Setup";
    begin
        if GenJournalLine."Credit Entry" then begin

            ReceivablesAccount := '';
            GenJournalLine.TestField("Loan No.");
            if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
                Error('Transaction Type Missing for A/C ' + GenJournalLine."Account No.");

            Loans.Get(GenJournalLine."Loan No.");
            ProductSetup.Get(Loans."Loan Product Type");
            ReceivablesAccount := ProductSetup.GetReceivablesAccount(ProductSetup."Product ID", GenJournalLine."Transaction Type");
        end;
    end;



    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnValidateAccountNoOnAfterAssignValue', '', false, false)]
    local procedure OnValidateAccountNoOnAfterAssignValue(var GenJournalLine: Record "Gen. Journal Line"; var xGenJournalLine: Record "Gen. Journal Line")
    begin

        case GenJournalLine."Account Type" of
            GenJournalLine."Account Type"::Savings:
                GenJournalLine.GetSavingsAccount();
            GenJournalLine."Account Type"::credit:
                GenJournalLine.GetLoanAccount();
        end;
        //GenJournalLine.Modify();

    end;



    [EventSubscriber(ObjectType::Table, Database::"Credit Ledger Entry", 'OnAfterCopyCustLedgerEntryFromGenJnlLine', '', false, false)]
    local procedure OnAfterCopyCustLedgerEntryFromGenJnlLine(var CustLedgerEntry: Record "Credit Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin


        CustLedgerEntry."Transaction Type" := GenJournalLine."Transaction Type";
        CustLedgerEntry."Loan No." := GenJournalLine."Loan No.";
        CustLedgerEntry."Member No." := GenJournalLine."Member No.";
        CustLedgerEntry."Group Code" := GenJournalLine."Group Code";
        CustLedgerEntry."Creation Date" := Today;
        CustLedgerEntry."Creation Time" := Time;
        //CustLedgerEntry.Modify();

    end;


    //[EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertDtldCustLedgEntry', '', false, false)]

    /*
    local procedure OnBeforeInsertDtldCustLedgEntry(var DtldCustLedgEntry: Record "Credit Ledger Entry"; GenJournalLine: Record "Gen. Journal Line"; DtldCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer")
    begin

        DtldCustLedgEntry."Transaction Type" := GenJournalLine."Transaction Type";
        DtldCustLedgEntry."Loan No." := GenJournalLine."Loan No.";
        DtldCustLedgEntry."Member No." := GenJournalLine."Member No.";
        DtldCustLedgEntry."Group Code" := GenJournalLine."Group Code";
        DtldCustLedgEntry."Creation Date" := Today;
        DtldCustLedgEntry."Creation Time" := Time;
        //DtldCustLedgEntry.Modify();

    end;
    */




    //[EventSubscriber(ObjectType::Table, Database::"Savings Ledger Entry", 'OnAfterCopyVendLedgerEntryFromGenJnlLine', '', false, false)]
    local procedure OnAfterCopyVendLedgerEntryFromGenJnlLine(var VendorLedgerEntry: Record "Savings Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        /*
        VendorLedgerEntry."Member No." := GenJournalLine."Member No.";
        VendorLedgerEntry."Group Code" := GenJournalLine."Group Code";
        VendorLedgerEntry."Creation Date" := Today;
        VendorLedgerEntry."Creation Time" := Time;
        //VendorLedgerEntry.Modify();
        */
    end;



    /*
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertDtldVendLedgEntry', '', false, false)]

    local procedure OnBeforeInsertDtldVendLedgEntry(var DtldVendLedgEntry: Record "Savings Ledger Entry"; GenJournalLine: Record "Gen. Journal Line"; DtldCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer")
    begin

        DtldVendLedgEntry."Member No." := GenJournalLine."Member No.";
        DtldVendLedgEntry."Group Code" := GenJournalLine."Group Code";
        DtldVendLedgEntry."Creation Date" := Today;
        DtldVendLedgEntry."Creation Time" := Time;
        //DtldVendLedgEntry.Modify();

    end;
    */


    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnGetCustomerAccountOnAfterCustGet', '', false, false)]
    local procedure OnGetCustomerAccountOnAfterCustGet(var GenJournalLine: Record "Gen. Journal Line"; var Customer: Record Customer; CallingFieldNo: Integer)
    begin
        if Customer."Account Type" = Customer."Account Type"::Members then
            Error('Invalid Account For Customer. Selected Account is a Member.');
    end;


    /* [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterAccountNoOnValidateGetVendorAccount', '', false, false)]

     local procedure OnAfterAccountNoOnValidateGetVendorAccount(var GenJournalLine: Record "Gen. Journal Line"; var Vendor: Record "Savings Accounts"; CallingFieldNo: Integer)
     begin
         if Vendor."Creditor Type" = Vendor."Creditor Type"::FOSA then
             Error('Invalid Account For Vendor. Selected Account is a Fosa Account.');

     end;
     */



    [EventSubscriber(ObjectType::Table, Database::"Reversal Entry", 'OnBeforeReverseEntries', '', false, false)]

    procedure OnBeforeReverseEntries(Number: Integer; RevType: Integer; var IsHandled: Boolean; HideDialog: Boolean)
    begin
        HideDialog := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::GenJnlManagement, 'OnAfterGetAccounts', '', false, false)]
    local procedure OnAfterGetAccounts(var GenJournalLine: Record "Gen. Journal Line"; var AccName: Text[100]; var BalAccName: Text[100])
    var
        Savings: Record "Savings Accounts";
        Credit: Record "Credit Accounts";
    begin
        if GenJournalLine."Account No." <> '' then begin
            case GenJournalLine."Account Type" of

                GenJournalLine."Account Type"::Credit:
                    begin
                        if Credit.Get(GenJournalLine."Account No.") then
                            AccName := Credit.Name;
                    end;
                GenJournalLine."Account Type"::Savings:
                    begin
                        if Savings.Get(GenJournalLine."Account No.") then
                            AccName := Savings.Name;
                        GenJournalLine."Member No." := Savings."Member No.";
                    end;

            end;
        end;

        if GenJournalLine."Bal. Account No." <> '' then begin
            case GenJournalLine."Bal. Account Type" of

                GenJournalLine."Bal. Account Type"::Credit:
                    begin
                        if Credit.get(GenJournalLine."Bal. Account No.") then
                            BalAccName := Credit.Name
                    end;
                GenJournalLine."Bal. Account Type"::Savings:
                    begin
                        if Savings.Get(GenJournalLine."Bal. Account No.") then
                            BalAccName := Savings.Name;
                    end;

            end;
        end;
    end;



    var

        NextEntryNo: Integer;
        NextVATEntryNo: Integer;
        FirstNewVATEntryNo: Integer;
        FirstTransactionNo: Integer;
        NextTransactionNo: Integer;

}
