page 50438 "Sacco Journal Line"
{
    Caption = 'Sacco Journal Line';
    PageType = ListPart;
    SourceTable = "Sacco Journal Line";

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer CID field.';
                    LookupPageId = "Member Listing";
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.';
                    Enabled = false;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account Type field.';
                }

                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan No field.';
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account No. field.';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Members: Record Members;
                        Accounts: Record "Savings Accounts";
                        Customer: Record Customer;
                        Vendor: Record "Savings Accounts";
                        GLAcc: Record "G/L Account";
                        Bank: Record "Bank Account";
                        CAcc: Record "Credit Accounts";
                    begin
                        if Rec."Account Type" = Rec."Account Type"::"G/L Account" then begin
                            Rec."Account No." := '';
                            GLAcc.Reset();
                            if Page.RunModal(Page::"Chart of Accounts", GLAcc) = Action::LookupOK then
                                Rec."Account No." := GLAcc."No.";
                        end
                        else
                            if Rec."Account Type" = Rec."Account Type"::Customer then begin
                                Rec."Account No." := '';
                                Customer.Reset();
                                if Page.RunModal(Page::"Customer Listing", Customer) = Action::LookupOK then
                                    Rec."Account No." := Customer."No.";
                            end
                            else
                                if Rec."Account Type" = Rec."Account Type"::Vendor then begin
                                    Rec."Account No." := '';
                                    Vendor.Reset();
                                    if Page.RunModal(Page::"Vendor List", Vendor) = Action::LookupOK then
                                        Rec."Account No." := Vendor."No.";
                                end
                                else
                                    if Rec."Account Type" = Rec."Account Type"::"Bank Account" then begin
                                        Rec."Account No." := '';
                                        Bank.Reset();
                                        if Page.RunModal(Page::"Bank Account List", Bank) = Action::LookupOK then
                                            Rec."Account No." := Bank."No.";
                                    end

                                    else
                                        if Rec."Account Type" = Rec."Account Type"::Savings then begin

                                            Rec."Account No." := '';
                                            Accounts.Reset();
                                            if Rec."Member No." <> '' then
                                                Accounts.SetRange("Member No.", Rec."Member No.");
                                            if Page.RunModal(Page::"Member Accounts List", Accounts) = Action::LookupOK then
                                                Rec."Account No." := Accounts."No.";
                                        end
                                        else
                                            if Rec."Account Type" = Rec."Account Type"::Credit then begin
                                                CAcc.Reset();
                                                if Rec."Member No." <> '' then
                                                    CAcc.SetRange("Member No.", Rec."Member No.");
                                                if Page.RunModal(Page::"Credit Accounts List", CAcc) = Action::LookupOK then
                                                    Rec."Account No." := CAcc."No.";
                                            end;

                        Rec.Validate("Account No.");
                    end;

                }

                field("Account Name."; Rec."Account Name")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Debit Amount"; Rec."Debit Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Debit Amount field.';
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Credit Amount field.';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction Type field.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
            }


            group(Control30)
            {
                ShowCaption = false;
                fixed(Control1901776101)
                {
                    ShowCaption = false;
                    group("Number of Lines")
                    {
                        Caption = 'Number of Lines';
                        field(NumberOfJournalRecords; NumberOfRecords)
                        {
                            ApplicationArea = All;
                            AutoFormatType = 1;
                            ShowCaption = false;
                            Editable = false;
                            ToolTip = 'Specifies the number of lines in the current journal batch.';
                        }
                    }
                    group("Account Name")
                    {
                        Caption = 'Account Name';
                        Visible = false;
                        field(AccName; AccName)
                        {
                            ApplicationArea = Basic, Suite;
                            Editable = false;
                            ShowCaption = false;
                            ToolTip = 'Specifies the name of the account.';
                        }
                    }
                    group("Bal. Account Name")
                    {
                        Caption = 'Bal. Account Name';
                        Visible = false;
                        field(BalAccName; BalAccName)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Bal. Account Name';
                            Editable = false;
                            ToolTip = 'Specifies the name of the balancing account that has been entered on the journal line.';
                        }
                    }
                    group("Total Debit")
                    {
                        Caption = 'Total Debit';
                        field(DisplayTotalDebit; GetTotalDebitAmt)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Total Debit';
                            Editable = false;
                            ToolTip = 'Specifies the total debit amount in the general journal.';
                        }
                    }
                    group("Total Credit")
                    {
                        Caption = 'Total Credit';
                        field(DisplayTotalCredit; GetTotalCreditAmt)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Total Credit';
                            Editable = false;
                            ToolTip = 'Specifies the total credit amount in the general journal.';
                        }
                    }
                    group(Control1902759701)
                    {
                        Caption = 'Balance';
                        field(Balance; Balance)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Balance';
                            Editable = false;
                            ToolTip = 'Specifies the balance that has accumulated in the general journal on the line where the cursor is.';

                        }
                    }
                    group("Total Balance")
                    {
                        Caption = 'Total Balance';
                        field(TotalBalance; TotalBalance)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Total Balance';
                            Editable = false;
                            ToolTip = 'Specifies the total balance in the general journal.';
                        }
                    }
                }
            }
        }
    }


    trigger OnAfterGetCurrRecord()
    begin
        UpdateBalance();

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UpdateBalance;
        Rec.SetUpNewLine(xRec);
    end;

    local procedure UpdateBalance()
    begin
        CalcBalance(Rec, xRec, Balance, TotalBalance, ShowBalance, ShowTotalBalance);
        BalanceVisible := ShowBalance;
        TotalBalanceVisible := ShowTotalBalance;
        if ShowTotalBalance then
            NumberOfRecords := Rec.Count();
    end;


    procedure CalcBalance(var GenJnlLine: Record "Sacco Journal Line"; LastGenJnlLine: Record "Sacco Journal Line"; var Balance: Decimal; var TotalBalance: Decimal; var ShowBalance: Boolean; var ShowTotalBalance: Boolean)
    var
        [SecurityFiltering(SecurityFilter::Filtered)]
        TempGenJnlLine: Record "Sacco Journal Line";
    begin
        TempGenJnlLine.CopyFilters(GenJnlLine);
        ShowTotalBalance := TempGenJnlLine.CalcSums("Balance (LCY)");

        TotalBalance := TempGenJnlLine."Balance (LCY)";
        if GenJnlLine."Line No." = 0 then
            TotalBalance := TotalBalance + LastGenJnlLine."Balance (LCY)";

        if GenJnlLine."Line No." <> 0 then begin
            TempGenJnlLine.SetRange("Line No.", 0, GenJnlLine."Line No.");
            ShowBalance := TempGenJnlLine.CalcSums("Balance (LCY)");
            if ShowBalance then
                Balance := TempGenJnlLine."Balance (LCY)";
        end else begin
            TempGenJnlLine.SetRange("Line No.", 0, LastGenJnlLine."Line No.");
            ShowBalance := TempGenJnlLine.CalcSums("Balance (LCY)");
            if ShowBalance then begin
                Balance := TempGenJnlLine."Balance (LCY)";
                TempGenJnlLine.CopyFilters(GenJnlLine);
                TempGenJnlLine := LastGenJnlLine;
                if TempGenJnlLine.Next() = 0 then
                    Balance := Balance + LastGenJnlLine."Balance (LCY)";
            end;
        end;

    end;


    local procedure GetTotalDebitAmt(): Decimal
    var
        [SecurityFiltering(SecurityFilter::Filtered)]
        GenJournalLine: Record "Sacco Journal Line";
    begin
        GenJournalLine.SetRange("Batch No.", Rec."Batch No.");
        GenJournalLine.SetRange("Document No.", Rec."Document No.");
        GenJournalLine.CalcSums("Debit Amount");
        exit(GenJournalLine."Debit Amount");
    end;

    local procedure GetTotalCreditAmt(): Decimal
    var
        GenJournalLine: Record "Sacco Journal Line";
    begin

        GenJournalLine.SetRange("Batch No.", Rec."Batch No.");
        GenJournalLine.SetRange("Document No.", Rec."Document No.");
        GenJournalLine.CalcSums("Credit Amount");
        exit(GenJournalLine."Credit Amount");

    end;


    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        GenJnlManagement: Codeunit Microsoft.Finance.GeneralLedger.Journal.GenJnlManagement;
        ReportPrint: Codeunit Microsoft.Foundation.Reporting."Test Report-Print";
        PayrollManagement: Codeunit "Payroll Management";
        ClientTypeManagement: Codeunit System.Environment."Client Type Management";
        //NoSeriesMgt: Codeunit NoSeriesManagement;
        JournalErrorsMgt: Codeunit Microsoft.Finance.GeneralLedger.Journal."Journal Errors Mgt.";
        BackgroundErrorHandlingMgt: Codeunit Microsoft.Utilities."Background Error Handling Mgt.";
        ChangeExchangeRate: Page Microsoft.Finance.Currency."Change Exchange Rate";
        GLReconcile: Page Reconciliation;
        CurrentJnlBatchName: Code[10];
        AccName: Text[100];
        BalAccName: Text[100];
        Balance: Decimal;
        TotalBalance: Decimal;
        NumberOfRecords: Integer;
        ShowBalance: Boolean;
        ShowTotalBalance: Boolean;
        Text000: Label 'General Journal lines have been successfully inserted from Standard General Journal %1.';
        Text001: Label 'Standard General Journal %1 has been successfully created.';
        HasIncomingDocument: Boolean;
        ApplyEntriesActionEnabled: Boolean;

        BalanceVisible: Boolean;

        TotalBalanceVisible: Boolean;
        StyleTxt: Text;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesOnJnlBatchExist: Boolean;
        OpenApprovalEntriesOnJnlLineExist: Boolean;
        OpenApprovalEntriesOnBatchOrCurrJnlLineExist: Boolean;
        OpenApprovalEntriesOnBatchOrAnyJnlLineExist: Boolean;
        ShowWorkflowStatusOnBatch: Boolean;
        ShowWorkflowStatusOnLine: Boolean;
        CanCancelApprovalForJnlBatch: Boolean;
        CanCancelApprovalForJnlLine: Boolean;
        ImportPayrollTransactionsAvailable: Boolean;
        IsSaaSExcelAddinEnabled: Boolean;
        CanRequestFlowApprovalForBatch: Boolean;
        CanRequestFlowApprovalForBatchAndAllLines: Boolean;
        CanRequestFlowApprovalForBatchAndCurrentLine: Boolean;
        CanCancelFlowApprovalForBatch: Boolean;
        CanCancelFlowApprovalForLine: Boolean;
        AmountVisible: Boolean;
        DebitCreditVisible: Boolean;
        IsSaaS: Boolean;
        JobQueuesUsed: Boolean;
        JobQueueVisible: Boolean;
        BackgroundErrorCheck: Boolean;
        ShowAllLinesEnabled: Boolean;
        CurrentDocNo: Code[20];
        CurrentPostingDate: Date;
        CurrentCurrencyCode: Code[10];
        IsChangingDocNo: Boolean;
        MissingExchangeRatesQst: Label 'There are no exchange rates for currency %1 and date %2. Do you want to add them now? Otherwise, the last change you made will be reverted.', Comment = '%1 - currency code, %2 - posting date';
        PostedFromSimplePage: Boolean;
        DocumentNumberMsg: Label 'Document No. must have a value in Gen. Journal Line.';


}
