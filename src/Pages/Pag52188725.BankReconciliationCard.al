page 52005 "Bank Reconciliation Card"
{
    PageType = Document;
    SourceTable = "Bank Reconciliation";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = All;
                }
                field("Statement No."; Rec."Statement No.")
                {
                    ApplicationArea = All;
                }
                field("Balance Last Statement"; Rec."Balance Last Statement")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    //StyleExpr = StatusStyleExpr;
                    ToolTip = 'Specifies the status of the bank reconciliation.';
                    Editable = false;
                }

                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = All;
                    //Visible = IsPosted;
                    ToolTip = 'Specifies who posted the bank reconciliation.';
                }

                field("Posted Date"; Rec."Posted Date")
                {
                    ApplicationArea = All;
                    //Visible = IsPosted;
                    ToolTip = 'Specifies when the bank reconciliation was posted.';
                }
            }
            grid(Reconciliation)
            {
                GridLayout = Columns;
                group(StatementSide)
                {
                    Caption = 'Bank Statement Lines';

                    part(Lines; "Bank Reconciliation Subform")
                    {
                        ApplicationArea = All;
                        SubPageLink = "Document No." = field("No.");
                    }
                }
                group(EntriesSide)
                {
                    Caption = 'Bank Account Entries';

                    part(BankEntries; "Bank Acc. Ledger Entries")
                    {
                        ApplicationArea = All;
                        SubPageLink = "Bank Account No." = FIELD("Bank Account No."),
                                     "Statement Status" = CONST(Open);
                    }
                }
            }

            group(BalanceSummary)
            {
                Caption = 'Balance Summary';

                field("Last Statement Balance"; Rec."Last Statement Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the balance from the previous bank statement.';
                }

                field("Last Statement Date"; Rec."Last Statement Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date of the previous bank statement.';
                }

                field("Statement Date"; Rec."Statement Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date of the current bank statement.';

                    trigger OnValidate()
                    begin
                        // Update bank entries when statement date changes
                        UpdateBankAccountLedgerEntrySubpage(Rec."Statement Date");

                        // Recalculate ending balance if needed
                        if Rec."Statement Ending Balance" <> 0 then
                            Rec.CalculateEndingBalance();
                    end;
                }

                field("Statement Ending Balance"; Rec."Statement Ending Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ending balance of the current bank statement.';

                    trigger OnValidate()
                    begin
                        Rec.CalculateEndingBalance();
                    end;
                }

                field("Calculated Statement Balance"; Rec."Calculated Statement Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows the total of all statement lines.';
                }

                field("Calculated Ending Balance"; Rec."Calculated Ending Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows the calculated ending balance (Last statement balance + Statement total).';
                    Style = Strong;
                    ////StyleExpr = EndingBalanceStyle;
                }

                field(Difference; Rec."Statement Ending Balance" - Rec."Calculated Ending Balance")
                {
                    ApplicationArea = All;
                    Caption = 'Difference';
                    ToolTip = 'Shows the difference between the statement ending balance and calculated ending balance.';
                    Editable = false;
                    Style = Unfavorable;
                    ////StyleExpr = DifferenceStyle;
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            group(Process)
            {
                action(Post)
                {
                    ApplicationArea = All;
                    Image = PostDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Caption = 'Post Reconciliation';
                    ToolTip = 'Post the bank reconciliation and update bank account statement information.';

                    trigger OnAction()
                    var
                        BankRecMatching: Codeunit "Bank Rec. Matching";
                    begin
                        if Confirm('Are you sure you want to post this bank reconciliation?') then begin
                            if BankRecMatching.PostReconciliation(Rec) then
                                CurrPage.Close();
                        end;
                    end;
                }

                action(CarryForward)
                {
                    ApplicationArea = All;
                    Image = CopyLedgerToBudget;
                    Promoted = true;
                    PromotedCategory = Process;
                    Caption = 'Carry Forward Unreconciled';
                    ToolTip = 'Bring forward unreconciled entries from previous statements.';

                    trigger OnAction()
                    var
                        BankRecMatching: Codeunit "Bank Rec. Matching";
                    begin
                        if Confirm('Carry forward all unreconciled entries from previous statements?') then begin
                            if BankRecMatching.CarryForwardUnreconciledEntries(Rec) then
                                CurrPage.Update(false);
                        end;
                    end;
                }
            }
        }
        area(Processing)
        {
            group("Bank Statement")
            {
                Caption = 'Bank Statement';
                Image = Bank;

                action(ImportStatement)
                {
                    ApplicationArea = All;
                    Caption = 'Import Statement';
                    Image = ImportExcel;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Import bank statement lines from Excel';

                    trigger OnAction()
                    var
                        BankRecImport: Codeunit "Bank Rec. Import";
                    begin
                        BankRecImport.ImportExcelStatement(Rec);  // Now passing the header record
                    end;
                }

                action(ReconciliationReport)
                {
                    ApplicationArea = All;
                    Caption = 'Reconciliation Report';
                    Image = Report;
                    Promoted = true;

                    PromotedCategory = Report;
                    PromotedIsBig = true;
                    ToolTip = 'View the bank reconciliation report';

                    trigger OnAction()
                    begin
                        // Add report logic here
                    end;
                }
            }

            group(Matching)
            {
                Caption = 'Matching';
                Image = MailAttachment;

                action(MatchManually)
                {
                    ApplicationArea = All;
                    Caption = 'Match Manually';
                    Image = LinkAccount;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Manually match statement lines with bank entries';

                    trigger OnAction()
                    var
                        TempBankRecLine: Record "Bank Reconciliation Line" temporary;
                        TempBankLedgerEntry: Record "Bank Account Ledger Entry" temporary;
                        BankRecMatching: Codeunit "Bank Rec. Matching";
                        CashBookBalance: Decimal;
                        StatementBalance: Decimal;
                    begin
                        // Get selected records from both subpages
                        CurrPage.Lines.Page.GetSelectedRecords(TempBankRecLine);
                        CurrPage.BankEntries.Page.GetSelectedRecords(TempBankLedgerEntry);

                        // Calculate totals and validate
                        CashBookBalance := 0;
                        StatementBalance := 0;

                        // Get total of selected bank entries
                        if TempBankLedgerEntry.FindSet() then begin
                            repeat
                                CashBookBalance += TempBankLedgerEntry.Amount;
                            until TempBankLedgerEntry.Next() = 0;
                        end;

                        // Get total of selected statement lines
                        if TempBankRecLine.FindSet() then begin
                            repeat
                                StatementBalance += TempBankRecLine."Statement Amount";
                            until TempBankRecLine.Next() = 0;
                        end;

                        // Validate amounts match
                        if CashBookBalance <> StatementBalance then
                            Error('Amounts do not match.\Cash Book Balance: %1\Statement Balance: %2',
                                  CashBookBalance, StatementBalance);

                        if CashBookBalance = 0 then
                            Error('No bank entries selected');

                        if StatementBalance = 0 then
                            Error('No statement lines selected');

                        // Process the matching
                        if BankRecMatching.MatchManually(Rec, TempBankRecLine, TempBankLedgerEntry) then
                            Message('Entries matched successfully');
                    end;
                }

                action(MatchAutomatically)
                {
                    ApplicationArea = All;
                    Caption = 'Match Automatically';
                    Image = AutofillQtyToHandle;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Automatically match statement lines with bank entries';

                    trigger OnAction()
                    var
                        BankRecMatching: Codeunit "Bank Rec. Matching";
                    begin
                        if BankRecMatching.MatchAutomatically(Rec) then
                            CurrPage.Update(false);
                    end;
                }

                action(RemoveMatches)
                {
                    ApplicationArea = All;
                    Caption = 'Remove Matches';
                    Image = RemoveFilterLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Remove matching for selected statement lines';

                    trigger OnAction()
                    var
                        TempBankRecLine: Record "Bank Reconciliation Line" temporary;
                        BankRecMatching: Codeunit "Bank Rec. Matching";
                    begin
                        // Get selected statement lines
                        CurrPage.Lines.Page.GetSelectedRecords(TempBankRecLine);

                        if TempBankRecLine.IsEmpty then begin
                            Error('Please select one or more statement lines to unmatch');
                            exit;
                        end;

                        if Confirm('Are you sure you want to remove the matches for the selected lines?') then begin
                            if BankRecMatching.RemoveMatches(Rec, TempBankRecLine) then begin
                                Message('Matches removed successfully');
                                CurrPage.Update(false);
                            end;
                        end;
                    end;
                }
            }
        }
    }

    var
        CurrentBankRecLine: Record "Bank Reconciliation Line";
        CurrentBankEntry: Record "Bank Account Ledger Entry";

    trigger OnInit()
    begin
    end;

    trigger OnOpenPage()
    begin
    end;


    local procedure UpdateSelectedLine(BankRecLine: Record "Bank Reconciliation Line")
    begin
        CurrentBankRecLine := BankRecLine;
    end;

    local procedure UpdateSelectedEntry(BankEntry: Record "Bank Account Ledger Entry")
    begin
        CurrentBankEntry := BankEntry;
    end;

    local procedure UpdateBankAccountLedgerEntrySubpage(StatementDate: Date)
    var
        BankLedgerEntry: Record "Bank Account Ledger Entry";
        FilterDate: Date;
    begin
        // Set filters for bank ledger entries
        BankLedgerEntry.SetRange("Bank Account No.", Rec."Bank Account No.");
        BankLedgerEntry.SetRange(Open, true);
        BankLedgerEntry.SetRange(Reversed, false);
        BankLedgerEntry.SetFilter("Statement Status", '%1|%2|%3',
            BankLedgerEntry."Statement Status"::Open,
            BankLedgerEntry."Statement Status"::"Bank Acc. Entry Applied",
            BankLedgerEntry."Statement Status"::"Check Entry Applied");

        // Apply date filter if statement date is set
        if StatementDate <> 0D then
            BankLedgerEntry.SetFilter("Posting Date", '<=%1', StatementDate);

        // Update the page view
        CurrPage.BankEntries.Page.SetTableView(BankLedgerEntry);
        CurrPage.BankEntries.Page.Update(false);
    end;
}