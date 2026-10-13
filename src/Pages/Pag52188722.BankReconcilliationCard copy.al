
page 50755 "Bank Rec Card - NEW"
{



    Caption = 'Bank Rec Card';
    PageType = ListPlus;
    SaveValues = false;
    SourceTable = "Bank Acc. Reconciliation";
    SourceTableView = where("Statement Type" = const("Bank Reconciliation"));
    RefreshOnActivate = true;
    Permissions = tabledata "Bank Account Ledger Entry" = rm;
    PromotedActionCategories = 'New,Process,Report,Importing,Matching,Post';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(BankAccountNo; Rec."Bank Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Account No.';
                    ToolTip = 'Specifies the number of the bank account that you want to reconcile with the bank''s statement.';
                    Editable = BankAccountNoIsEditable;

                    trigger OnValidate()
                    var
                        BankAccReconciliationLine: record "Bank Acc. Reconciliation Line";
                    begin
                        if BankAccReconciliationLine.BankStatementLinesListIsEmpty(Rec."Statement No.", Rec."Statement Type".AsInteger(), Rec."Bank Account No.") then
                            CreateEmptyListNotification();

                        if not WarnIfOngoingBankReconciliations(Rec."Bank Account No.") then
                            Error('');
                        CurrPage.ApplyBankLedgerEntries.Page.AssignBankAccReconciliation(Rec);
                        BankAccountNoIsEditable := false;
                        CheckBankAccLedgerEntriesAlreadyMatched();
                        CurrPage.Update(false);
                    end;
                }
                field(StatementNo; Rec."Statement No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Statement No.';
                    ToolTip = 'Specifies the number of the bank account statement.';
                }
                field(StatementDate; Rec."Statement Date")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Statement Date';
                    ToolTip = 'Specifies the date on the bank account statement.';
                    trigger OnValidate()
                    begin
                        // Update bank entries when statement date changes
                        //UpdateBankAccountLedgerEntrySubpage(Rec."Statement Date");

                        CurrPage.ApplyBankLedgerEntries.Page.SetBankRecDateFilter(Rec.MatchCandidateFilterDate());
                    end;
                }

                field(Type; Rec.Type)
                {
                    Editable = false;
                    ApplicationArea = Basic;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin

                        if Rec.Type = Rec.Type::Manual then begin
                            ManualBool := true;
                            AutoBool := false;
                        end
                        else begin

                            ManualBool := false;
                            AutoBool := true;
                        end;
                    end;
                }
                field(BalanceLastStatement; Rec."Balance Last Statement")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Balance Last Statement';
                    ToolTip = 'Specifies the ending balance shown on the last bank statement, which was used in the last posted bank reconciliation for this bank account.';
                }
                field(StatementEndingBalance; Rec."Statement Ending Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Statement Ending Balance';
                    ToolTip = 'Specifies the ending balance shown on the bank''s statement that you want to reconcile with the bank account.';
                }


                field("Notes Line 1"; Rec."Notes Line 1")
                {
                    ApplicationArea = Basic;
                }
                field("Notes Line 2"; Rec."Notes Line 2")
                {
                    ApplicationArea = Basic;
                }
                field("Notes Line 3"; Rec."Notes Line 3")
                {
                    ApplicationArea = Basic;
                }
                field("Notes Line 4"; Rec."Notes Line 4")
                {
                    ApplicationArea = Basic;
                }
                field("Notes Line 5"; Rec."Notes Line 5")
                {
                    ApplicationArea = Basic;
                }
                field("Notes Line 6"; Rec."Notes Line 6")
                {
                    ApplicationArea = Basic;
                }


            }
            group(Control8)
            {
                Visible = AutoBool;
                ShowCaption = false;
                part(StmtLine; "Bank Acc. Reconciliation Lines")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Statement Lines';
                    SubPageLink = "Bank Account No." = field("Bank Account No."),
                                  "Statement No." = field("Statement No.");
                }
                part(ApplyBankLedgerEntries; "Apply Bank Acc. Ledger Entries")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Account Ledger Entries';
                    SubPageLink = "Bank Account No." = FIELD("Bank Account No."),
                                  Open = CONST(true),
                                  "Statement Status" = FILTER(Open | "Bank Acc. Entry Applied" | "Check Entry Applied"),
                                  Reversed = FILTER(false);
                }
            }
            group(Control9)
            {
                Visible = ManualBool;
                part(Control27; "Manual Reconciliation Lines")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Statement Lines';
                    SubPageLink = "Bank Account No." = FIELD("Bank Account No."),
                                  "Statement No." = FIELD("Statement No.");
                }
                /*
                part(ManualApplyBankLedgerEntries; "Apply Bank Acc. Ledger Entries")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Account Ledger Entries';
                    SubPageLink = "Bank Account No." = FIELD("Bank Account No."),
                                  Open = CONST(true),
                                  "Statement Status" = FILTER(Open | "Bank Acc. Entry Applied" | "Check Entry Applied"),
                                  Reversed = FILTER(false);
                }
                */
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Recon.")
            {
                Caption = '&Recon.';
                Image = BankAccountRec;
                action("&Card")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Card';
                    Image = EditLines;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Bank Account Card";
                    RunPageLink = "No." = FIELD("Bank Account No.");
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'View or change detailed information about the record that is being processed on the journal line.';
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action(SuggestLines)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Suggest Lines';
                    Ellipsis = true;
                    Image = SuggestLines;
                    ToolTip = 'Create bank account ledger entries suggestions and enter them automatically.';

                    trigger OnAction()
                    begin
                        RecallEmptyListNotification();
                        SuggestBankAccStatement.SetStmt(Rec);
                        SuggestBankAccStatement.RunModal();
                        Clear(SuggestBankAccStatement);
                    end;
                }
                action(LoadDifference)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Load Difference';
                    Ellipsis = true;
                    Image = SuggestLines;
                    Promoted = true;
                    Visible = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Create bank account ledger entries suggestions and enter them automatically.';

                    trigger OnAction()
                    var
                        BankAccount: Record "Bank Account";
                        PostedBankAccReconLine: Record "Bank Account Statement Line";
                        TempBankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
                        BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
                        LineNo: Integer;

                    begin

                        //TESTFIELD(Status, Status::Pending);
                        BankAccount.GET(Rec."Bank Account No.");

                        BankAccReconciliationLine.RESET;
                        BankAccReconciliationLine.SETRANGE(BankAccReconciliationLine."Bank Account No.", Rec."Bank Account No.");
                        BankAccReconciliationLine.SETRANGE(BankAccReconciliationLine."Statement No.", BankAccount."Last Statement No.");
                        IF BankAccReconciliationLine.FINDSET THEN
                            LineNo := BankAccReconciliationLine."Statement Line No.";

                        BankAccount.testfield("Previous Statement No.");
                        PostedBankAccReconLine.RESET;
                        PostedBankAccReconLine.SETRANGE(PostedBankAccReconLine."Bank Account No.", Rec."Bank Account No.");
                        PostedBankAccReconLine.SETRANGE(PostedBankAccReconLine."Statement No.", BankAccount."Previous Statement No.");
                        PostedBankAccReconLine.SETFILTER(Difference, '<>%1', 0);
                        IF PostedBankAccReconLine.FINDSET THEN
                            REPEAT
                                LineNo += 10;
                                BankAccReconciliationLine.Init();
                                BankAccReconciliationLine.TRANSFERFIELDS(PostedBankAccReconLine);
                                BankAccReconciliationLine."Statement No." := Rec."Statement No.";
                                BankAccReconciliationLine."Statement Line No." := LineNo;
                                BankAccReconciliationLine."Statement Amount" := PostedBankAccReconLine.Difference;
                                BankAccReconciliationLine."Applied Amount" := 0;
                                BankAccReconciliationLine.Difference := BankAccReconciliationLine."Statement Amount";
                                //BankAccReconciliationLine.Type := BankAccReconciliationLine.Type::Difference;
                                BankAccReconciliationLine."Applied Entries" := 0;
                                BankAccReconciliationLine."Ready for Application" := TRUE;
                                //BankAccReconciliationLine.Imported := FALSE;
                                BankAccReconciliationLine.INSERT(TRUE);
                            UNTIL PostedBankAccReconLine.NEXT = 0;

                    end;
                }

                action("Transfer to General Journal")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Transfer to General Journal';
                    Ellipsis = true;
                    Image = TransferToGeneralJournal;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Transfer the lines from the current window to the general journal.';

                    trigger OnAction()
                    var
                        TempBankAccReconciliationLine: Record "Bank Acc. Reconciliation Line" temporary;
                    begin
                        CurrPage.StmtLine.PAGE.GetSelectedRecords(TempBankAccReconciliationLine);
                        TempBankAccReconciliationLine.Setrange(Difference, 0);
                        TempBankAccReconciliationLine.DeleteAll();
                        TempBankAccReconciliationLine.Setrange(Difference);
                        if TempBankAccReconciliationLine.IsEmpty then
                            error(NoBankAccReconcilliationLineWithDiffSellectedErr);
                        TransferToGLJnl.SetBankAccReconLine(TempBankAccReconciliationLine);
                        TransferToGLJnl.SetBankAccRecon(Rec);
                        TransferToGLJnl.Run();
                    end;
                }


                action(ChangeStatementNo)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Change Statement No.';
                    Ellipsis = true;
                    Image = ChangeTo;
                    ToolTip = 'Change the statement number of the bank account reconciliation. Typically, this is used when you have created a new reconciliation to correct a mistake, and you want to use the same statement number.';

                    trigger OnAction()
                    var
                        BankAccReconciliation: Record "Bank Acc. Reconciliation";
                        BankAccReconciliationCard: Page "Bank Acc. Reconciliation";
                    begin
                        BankAccReconciliation := Rec;
                        Codeunit.Run(Codeunit::"Change Bank Rec. Statement No.", BankAccReconciliation);
                        if Rec."Statement No." <> BankAccReconciliation."Statement No." then begin
                            BankAccReconciliationCard.SetRecord(BankAccReconciliation);
                            BankAccReconciliationCard.Run();
                            CurrPage.Close();
                        end;
                    end;
                }
            }
            group("Ba&nk")
            {
                Caption = 'Ba&nk';

                action(ImportStatementLinesFromExcel)
                {
                    ApplicationArea = Basic, Suite;
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Import electronic bank statements from your bank to populate with data about actual bank transactions.';

                    trigger OnAction()
                    begin
                        CurrPage.Update;
                        Rec.ImportBankStatementLinesFromExcel;
                    end;
                }

            }
            group("M&atching")
            {
                Caption = 'M&atching';
                action(DeleteLines)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Delete Lines';
                    Image = MapAccounts;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to Delete Statement Lines?') then begin

                            Rec.SetRange("Statement Type", Rec."Statement Type");
                            Rec.SetRange("Bank Account No.", Rec."Bank Account No.");
                            Rec.SetRange("Statement No.", Rec."Statement No.");
                            REPORT.Run(REPORT::"Bank Acc. Recon. Clear Lines", true, true, Rec);
                        end;
                    end;
                }
                action(MatchAutomatically)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Match Automatically';
                    Image = MapAccounts;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ToolTip = 'Automatically search for and match bank statement lines.';

                    trigger OnAction()
                    begin
                        Rec.SetRange("Statement Type", Rec."Statement Type");
                        Rec.SetRange("Bank Account No.", Rec."Bank Account No.");
                        Rec.SetRange("Statement No.", Rec."Statement No.");
                        REPORT.Run(REPORT::"Match Auto", true, true, Rec);
                    end;
                }
                action(MatchAutomaticallyManyToOne)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Match Automatically - Many to One';
                    Image = MapAccounts;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ToolTip = 'Automatically search for and match bank statement lines.';

                    trigger OnAction()
                    begin
                        Rec.SetRange("Statement Type", Rec."Statement Type");
                        Rec.SetRange("Bank Account No.", Rec."Bank Account No.");
                        Rec.SetRange("Statement No.", Rec."Statement No.");
                        REPORT.Run(REPORT::"Match Auto - Many to One", true, true, Rec);
                    end;
                }
                action(MatchAutomaticallyManyToMany)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Match Automatically - Many to Many';
                    Image = MapAccounts;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ToolTip = 'Automatically matches grouped bank statement lines to grouped bank ledger entries where document totals agree.';

                    trigger OnAction()
                    begin
                        Rec.SetRange("Statement Type", Rec."Statement Type");
                        Rec.SetRange("Bank Account No.", Rec."Bank Account No.");
                        Rec.SetRange("Statement No.", Rec."Statement No.");
                        REPORT.Run(REPORT::"Match Auto - Many to Many", true, true, Rec);
                    end;
                }
                action(MatchManually)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Match Manually';
                    Image = CheckRulesSyntax;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ToolTip = 'Manually match selected lines in both panes to link each bank statement line to one or more related bank account ledger entries.';

                    trigger OnAction()
                    var
                        TempBankAccReconciliationLine: Record "Bank Acc. Reconciliation Line" temporary;
                        TempBankAccountLedgerEntry: Record "Bank Account Ledger Entry" temporary;
                        MatchBankRecLines: Codeunit "Match Bank Rec. Lines";
                        CashBoolBalance: Decimal;
                        StatementBalance: Decimal;
                        BankAccountLedgerEntry2: Record "Bank Account Ledger Entry";
                    begin
                        CurrPage.StmtLine.PAGE.GetSelectedRecords(TempBankAccReconciliationLine);
                        CurrPage.ApplyBankLedgerEntries.PAGE.GetSelectedRecords(TempBankAccountLedgerEntry);

                        CashBoolBalance := 0;
                        StatementBalance := 0;
                        if TempBankAccountLedgerEntry.FindSet() then begin
                            repeat
                                CashBoolBalance += TempBankAccountLedgerEntry.Amount;
                            until TempBankAccountLedgerEntry.Next() = 0;
                        end;
                        if TempBankAccReconciliationLine.FindSet() then begin
                            repeat
                                StatementBalance += TempBankAccReconciliationLine."Statement Amount";
                            until TempBankAccReconciliationLine.Next() = 0;
                        end;

                        if CashBoolBalance <> StatementBalance then
                            Error('Amounts do not match');

                        if CashBoolBalance = 0 then
                            Error('No Cashbook Lines Selected');

                        if StatementBalance = 0 then
                            Error('No Statement Lines Selected');

                        MatchBankRecLines.MatchManually(TempBankAccReconciliationLine, TempBankAccountLedgerEntry);


                        BankAccountLedgerEntry2.Reset;
                        BankAccountLedgerEntry2.SetRange("Bank Account No.", Rec."Bank Account No.");
                        BankAccountLedgerEntry2.SetRange(Open, true);
                        BankAccountLedgerEntry2.SetRange(Reversed, false);
                        BankAccountLedgerEntry2.SetFilter("Posting Date", '<=%1', Rec."Statement Date");
                        BankAccountLedgerEntry2.SetFilter("Amount (LCY)", '<>%1', 0);
                        BankAccountLedgerEntry2.SetFilter("Statement Difference", '<>%1', 0);
                        BankAccountLedgerEntry2.SetRange(BankAccountLedgerEntry2."Statement Status", BankAccountLedgerEntry2."Statement Status"::"Bank Acc. Entry Applied");
                        if BankAccountLedgerEntry2.Find('-') then begin
                            repeat
                                BankAccountLedgerEntry2."Statement Difference" := 0;
                                BankAccountLedgerEntry2.Modify();
                            until BankAccountLedgerEntry2.Next() = 0;
                        end;

                        BankAccountLedgerEntry2.Reset;
                        BankAccountLedgerEntry2.SetRange("Bank Account No.", Rec."Bank Account No.");
                        BankAccountLedgerEntry2.SetRange(Open, true);
                        BankAccountLedgerEntry2.SetRange(Reversed, false);
                        BankAccountLedgerEntry2.SetFilter("Posting Date", '<=%1', Rec."Statement Date");
                        BankAccountLedgerEntry2.SetFilter("Amount (LCY)", '<>%1', 0);
                        BankAccountLedgerEntry2.SetFilter("Statement Difference", '%1', 0);
                        BankAccountLedgerEntry2.SetFilter(BankAccountLedgerEntry2."Statement Status", '<>%1', BankAccountLedgerEntry2."Statement Status"::"Bank Acc. Entry Applied");
                        if BankAccountLedgerEntry2.Find('-') then begin
                            repeat
                                BankAccountLedgerEntry2."Statement Difference" := BankAccountLedgerEntry2."Amount (LCY)";
                                BankAccountLedgerEntry2.Modify();
                            until BankAccountLedgerEntry2.Next() = 0;
                        end;

                    end;
                }
                action(MatchManyManually)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Match Many to Many Manually';
                    Image = CheckRulesSyntax;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ToolTip = 'Manually match selected lines in both panes to link each bank statement line to one or more related bank account ledger entries.';

                    trigger OnAction()
                    var
                        TempBankAccReconciliationLine: Record "Bank Acc. Reconciliation Line" temporary;
                        TempBankAccountLedgerEntry: Record "Bank Account Ledger Entry" temporary;
                        MatchBankRecLines: Codeunit "Match Bank Rec. Lines";
                        CashBoolBalance: Decimal;
                        StatementBalance: Decimal;
                        BankAccountLedgerEntry2: Record "Bank Account Ledger Entry";
                        StatementLines: Record "Bank Acc. Reconciliation Line";
                        LedgerEntry: Record "Bank Account Ledger Entry";
                        RecEnum: enum "Bank Acc. Rec. Stmt. Type";
                        GuiId: Guid;
                    begin
                        CurrPage.StmtLine.PAGE.GetSelectedRecords(TempBankAccReconciliationLine);
                        CurrPage.ApplyBankLedgerEntries.PAGE.GetSelectedRecords(TempBankAccountLedgerEntry);

                        Rec."Statement Guid No." := CreateGuid();
                        Rec.Modify();

                        CashBoolBalance := 0;
                        StatementBalance := 0;
                        if TempBankAccountLedgerEntry.FindSet() then begin
                            repeat
                                CashBoolBalance += TempBankAccountLedgerEntry.Amount;
                            until TempBankAccountLedgerEntry.Next() = 0;
                        end;
                        if TempBankAccReconciliationLine.FindSet() then begin
                            repeat
                                StatementBalance += TempBankAccReconciliationLine."Statement Amount";
                            until TempBankAccReconciliationLine.Next() = 0;
                        end;

                        if CashBoolBalance <> StatementBalance then
                            Error('Amounts do not match');

                        if CashBoolBalance = 0 then
                            Error('No Cashbook Lines Selected');

                        if StatementBalance = 0 then
                            Error('No Statement Lines Selected');



                        if TempBankAccReconciliationLine.FindSet() then begin
                            repeat


                                StatementLines.Get(
                                  TempBankAccReconciliationLine."Statement Type",
                                  TempBankAccReconciliationLine."Bank Account No.",
                                  TempBankAccReconciliationLine."Statement No.",
                                  TempBankAccReconciliationLine."Statement Line No."
                                );
                                //StatementLines.Type := StatementLines.Type::"Bank Account Ledger Entry";
                                StatementLines."Applied Amount" := StatementLines."Statement Amount";
                                StatementLines."Applied Entries" := 1;
                                //BankAccSetStmtNo.SetReconNo(BLedger, StatementLines);

                                //StatementLines."Applied Amount" += LedgerEntry."Remaining Amount";
                                StatementLines."Statement Guid No." := Rec."Statement Guid No.";
                                StatementLines."Applied Entries" := 1;
                                StatementLines.VALIDATE("Statement Amount");
                                StatementLines.Reconciled := true;
                                StatementLines.MODIFY;

                            until TempBankAccReconciliationLine.Next() = 0;
                        end;


                        if TempBankAccountLedgerEntry.FindSet() then begin
                            repeat

                                LedgerEntry.Get(TempBankAccountLedgerEntry."Entry No.");

                                LedgerEntry.TestField(Open, true);
                                if LedgerEntry."Posting Date" > DMY2Date(31, 10, 2022) then begin

                                    LedgerEntry.TestField("Statement No.", '');
                                    LedgerEntry.TestField("Statement Line No.", 0);
                                    if LedgerEntry."Statement Status" = LedgerEntry."Statement Status"::Closed then
                                        Error('Statement Status CLosed');
                                end;


                                LedgerEntry.TestField("Bank Account No.", Rec."Bank Account No.");
                                LedgerEntry."Statement Status" :=
                                LedgerEntry."Statement Status"::"Bank Acc. Entry Applied";
                                LedgerEntry."Statement No." := Rec."Statement No.";
                                LedgerEntry."Statement Line No." := StatementLines."Statement Line No.";
                                LedgerEntry."Statement Difference" := 0;
                                LedgerEntry.Modify();


                            until TempBankAccountLedgerEntry.Next() = 0;
                        end;




                        BankAccountLedgerEntry2.Reset;
                        BankAccountLedgerEntry2.SetRange("Bank Account No.", Rec."Bank Account No.");
                        BankAccountLedgerEntry2.SetRange(Open, true);
                        BankAccountLedgerEntry2.SetRange(Reversed, false);
                        BankAccountLedgerEntry2.SetFilter("Posting Date", '<=%1', Rec."Statement Date");
                        BankAccountLedgerEntry2.SetFilter("Amount (LCY)", '<>%1', 0);
                        BankAccountLedgerEntry2.SetFilter("Statement Difference", '<>%1', 0);
                        BankAccountLedgerEntry2.SetRange(BankAccountLedgerEntry2."Statement Status", BankAccountLedgerEntry2."Statement Status"::"Bank Acc. Entry Applied");
                        if BankAccountLedgerEntry2.Find('-') then begin
                            repeat
                                BankAccountLedgerEntry2."Statement Difference" := 0;
                                BankAccountLedgerEntry2.Modify();
                            until BankAccountLedgerEntry2.Next() = 0;
                        end;

                        BankAccountLedgerEntry2.Reset;
                        BankAccountLedgerEntry2.SetRange("Bank Account No.", Rec."Bank Account No.");
                        BankAccountLedgerEntry2.SetRange(Open, true);
                        BankAccountLedgerEntry2.SetRange(Reversed, false);
                        BankAccountLedgerEntry2.SetFilter("Posting Date", '<=%1', Rec."Statement Date");
                        BankAccountLedgerEntry2.SetFilter("Amount (LCY)", '<>%1', 0);
                        BankAccountLedgerEntry2.SetFilter("Statement Difference", '%1', 0);
                        BankAccountLedgerEntry2.SetFilter(BankAccountLedgerEntry2."Statement Status", '<>%1', BankAccountLedgerEntry2."Statement Status"::"Bank Acc. Entry Applied");
                        if BankAccountLedgerEntry2.Find('-') then begin
                            repeat
                                BankAccountLedgerEntry2."Statement Difference" := BankAccountLedgerEntry2."Amount (LCY)";
                                BankAccountLedgerEntry2.Modify();
                            until BankAccountLedgerEntry2.Next() = 0;
                        end;

                    end;
                }
                action(RemoveMatch)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Remove Match';
                    Image = RemoveContacts;
                    ToolTip = 'Remove selection of matched bank statement lines.';

                    trigger OnAction()
                    var
                        TempBankAccReconciliationLine: Record "Bank Acc. Reconciliation Line" temporary;
                        TempBankAccountLedgerEntry: Record "Bank Account Ledger Entry" temporary;
                        MatchBankRecLines: Codeunit "Match Bank Rec. Lines";
                        BankAccountLedgerEntry2: Record "Bank Account Ledger Entry";
                        StatementLines: Record "Bank Acc. Reconciliation Line";
                    begin
                        CurrPage.StmtLine.PAGE.GetSelectedRecords(TempBankAccReconciliationLine);
                        CurrPage.ApplyBankLedgerEntries.PAGE.GetSelectedRecords(TempBankAccountLedgerEntry);
                        MatchBankRecLines.RemoveMatch(TempBankAccReconciliationLine, TempBankAccountLedgerEntry);


                        BankAccountLedgerEntry2.Reset;
                        BankAccountLedgerEntry2.SetRange("Bank Account No.", Rec."Bank Account No.");
                        BankAccountLedgerEntry2.SetRange(Open, true);
                        BankAccountLedgerEntry2.SetRange(Reversed, false);
                        BankAccountLedgerEntry2.SetFilter("Posting Date", '<=%1', Rec."Statement Date");
                        BankAccountLedgerEntry2.SetFilter("Amount (LCY)", '<>%1', 0);
                        BankAccountLedgerEntry2.SetFilter("Statement Difference", '<>%1', 0);
                        BankAccountLedgerEntry2.SetRange(BankAccountLedgerEntry2."Statement Status", BankAccountLedgerEntry2."Statement Status"::"Bank Acc. Entry Applied");
                        if BankAccountLedgerEntry2.Find('-') then begin
                            repeat
                                BankAccountLedgerEntry2."Statement Difference" := 0;
                                BankAccountLedgerEntry2.Modify();
                            until BankAccountLedgerEntry2.Next() = 0;
                        end;

                        BankAccountLedgerEntry2.Reset;
                        BankAccountLedgerEntry2.SetRange("Bank Account No.", Rec."Bank Account No.");
                        BankAccountLedgerEntry2.SetRange(Open, true);
                        BankAccountLedgerEntry2.SetRange(Reversed, false);
                        BankAccountLedgerEntry2.SetFilter("Posting Date", '<=%1', Rec."Statement Date");
                        BankAccountLedgerEntry2.SetFilter("Amount (LCY)", '<>%1', 0);
                        BankAccountLedgerEntry2.SetFilter("Statement Difference", '%1', 0);
                        BankAccountLedgerEntry2.SetFilter(BankAccountLedgerEntry2."Statement Status", '<>%1', BankAccountLedgerEntry2."Statement Status"::"Bank Acc. Entry Applied");
                        if BankAccountLedgerEntry2.Find('-') then begin
                            repeat
                                BankAccountLedgerEntry2."Statement Difference" := BankAccountLedgerEntry2."Amount (LCY)";
                                BankAccountLedgerEntry2.Modify();
                            until BankAccountLedgerEntry2.Next() = 0;
                        end;

                        StatementLines.Reset();
                        StatementLines.SetRange("Statement Guid No.", Rec."Statement Guid No.");
                        if StatementLines.FindSet() then begin
                            repeat
                                StatementLines."Applied Amount" := 0;
                                StatementLines.Validate("Statement Amount");
                                StatementLines.Modify();
                            until StatementLines.Next() = 0;
                        end;

                    end;
                }
                action(MatchDetails)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Match Details';
                    Image = ViewDetails;
                    ToolTip = 'Show matching details about the selected bank statement line.';

                    trigger OnAction()
                    var
                        TempBankAccReconciliationLine: Record "Bank Acc. Reconciliation Line" temporary;
                    begin
                        CurrPage.StmtLine.PAGE.GetSelectedRecords(TempBankAccReconciliationLine);
                        if TempBankAccReconciliationLine."Applied Entries" > 0 then
                            Page.Run(Page::"Bank Rec. Line Match Details", TempBankAccReconciliationLine);
                    end;
                }
                action(All)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Show All';
                    Image = AddWatch;
                    ToolTip = 'Show all bank statement lines.';

                    trigger OnAction()
                    begin
                        CurrPage.StmtLine.PAGE.ToggleMatchedFilter(false);
                        CurrPage.ApplyBankLedgerEntries.Page.ShowAll();
                    end;
                }
                action(NotMatched)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Show Nonmatched';
                    Image = AddWatch;
                    ToolTip = 'Show all bank statement lines that have not yet been matched.';

                    trigger OnAction()
                    begin
                        CurrPage.StmtLine.PAGE.ToggleMatchedFilter(true);
                        CurrPage.ApplyBankLedgerEntries.Page.ShowNonMatched();
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                /*
                action("&Test Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    ToolTip = 'Preview the resulting bank account reconciliations to see the consequences before you perform the actual posting.';

                    trigger OnAction()
                    begin
                        ReportPrint.PrintBankAccRecon(Rec);
                    end;
                }
                */

                action(ReconReport)
                {
                    ApplicationArea = Basic, Suite;
                    Image = Report2;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        Recon: Record "Bank Acc. Reconciliation";
                    begin
                        CurrPage.Update;
                        Recon.Reset();
                        Recon.SetRange("Bank Account No.", Rec."Bank Account No.");
                        Recon.SetRange("Statement No.", Rec."Statement No.");
                        if Recon.FindFirst() then begin
                            Report.Run(REPORT::"Bank Acc. Recon. Custom", true, false, recon);
                            //Report.Run(50182, true, false, recon);

                        end;
                    end;
                }
                action(Post)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    //RunObject = Codeunit "Bank Acc. Recon. Post (Yes/No)";
                    RunObject = Codeunit BankAccountReconPostYesNo;
                    ShortCutKey = 'F9';
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';
                }
                action(PostAndPrint)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    RunObject = Codeunit "Bank Acc. Recon. Post+Print";
                    ShortCutKey = 'Shift+F9';
                    ToolTip = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.';
                }
            }
        }
    }


    trigger OnAfterGetRecord()
    begin
        if Rec.Type = Rec.Type::Manual then begin
            ManualBool := true;
            AutoBool := false;
        end
        else begin

            ManualBool := false;
            AutoBool := true;
        end;
    end;

    trigger OnOpenPage()
    var
        Usersetup: Record "User Setup";
        FeatureTelemetry: Codeunit "Feature Telemetry";
    begin
        CreateEmptyListNotification();
        if Rec.Type = Rec.Type::Manual then begin
            ManualBool := true;
            AutoBool := false;
        end
        else begin

            ManualBool := false;
            AutoBool := true;
        end;

        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId);
        UserSetup.SetRange(Reconciliation, true);
        if not UserSetup.findfirst then
            error('You do not have the permission to Open and Process Bank Reconciliation!');


        if (Rec."Bank Account No." <> '') then begin
            BankAccountNoIsEditable := false;
            CheckBankAccLedgerEntriesAlreadyMatched();
            CurrPage.ApplyBankLedgerEntries.Page.AssignBankAccReconciliation(Rec);
            CurrPage.ApplyBankLedgerEntries.Page.SetBankRecDateFilter(Rec.MatchCandidateFilterDate());
        end
        else
            BankAccountNoIsEditable := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        BankAccount: Record "Bank Account";
        BankAccReconciliation: Record "Bank Acc. Reconciliation";
        BankAccountNumber: Code[20];
    begin
        if (Rec."Bank Account No." <> '') then
            exit;
        if BankAccount.FindSet() then begin
            BankAccountNumber := BankAccount."No.";
            if BankAccount.Next() = 0 then begin
                Rec."Statement Type" := BankAccReconciliation."Statement Type"::"Bank Reconciliation";
                Rec.Validate("Bank Account No.", BankAccountNumber);
                BankAccountNoIsEditable := false;
            end;
        end;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        RecallEmptyListNotification();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        if UpdatedBankAccountLESystemId <> Rec.SystemId then begin
            UpdatedBankAccountLESystemId := Rec.SystemId;
            CurrPage.ApplyBankLedgerEntries.Page.SetBankRecDateFilter(Rec.MatchCandidateFilterDate());
        end;

        if Rec.Type = Rec.Type::Manual then begin
            ManualBool := true;
            AutoBool := false;
        end
        else begin

            ManualBool := false;
            AutoBool := true;
        end;

        CurrPage.ApplyBankLedgerEntries.Page.AssignBankAccReconciliation(Rec);
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
        CurrPage.ApplyBankLedgerEntries.Page.SetTableView(BankLedgerEntry);
        CurrPage.ApplyBankLedgerEntries.Page.Update(false);
    end;

    local procedure GetImportBankStatementNotificatoinId(): Guid
    begin
        exit('aa54bf06-b8b9-420d-a4a8-1f55a3da3e2a');
    end;

    local procedure CreateEmptyListNotification()
    var
        BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
        ImportBankStatementNotification: Notification;
    begin
        ImportBankStatementNotification.Id := GetImportBankStatementNotificatoinId();
        if ImportBankStatementNotification.Recall() then;
        if not BankAccReconciliationLine.BankStatementLinesListIsEmpty(Rec."Statement No.", Rec."Statement Type".AsInteger(), Rec."Bank Account No.") then
            exit;

        ImportBankStatementNotification.Message := ListEmptyMsg;
        ImportBankStatementNotification.Scope := NotificationScope::LocalScope;
        ImportBankStatementNotification.Send();
    end;

    local procedure RecallEmptyListNotification()
    var
        ImportBankStatementNotification: Notification;
    begin
        ImportBankStatementNotification.Id := GetImportBankStatementNotificatoinId();
        if ImportBankStatementNotification.Recall() then;
    end;

    local procedure CheckStatementDate()
    var
        BankAccReconciliation: Record "Bank Acc. Reconciliation";
        BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
    begin
        BankAccReconciliationLine.SetFilter("Bank Account No.", Rec."Bank Account No.");
        BankAccReconciliationLine.SetFilter("Statement No.", Rec."Statement No.");
        BankAccReconciliationLine.SetCurrentKey("Transaction Date");
        BankAccReconciliationLine.Ascending := false;
        if BankAccReconciliationLine.FindFirst() then begin
            BankAccReconciliation.GetBySystemId(Rec.SystemId);
            if BankAccReconciliation."Statement Date" = 0D then begin
                if Confirm(StrSubstNo(StatementDateEmptyMsg, Format(BankAccReconciliationLine."Transaction Date"))) then begin
                    Rec."Statement Date" := BankAccReconciliationLine."Transaction Date";
                    Rec.Modify();
                end;
            end else
                if BankAccReconciliation."Statement Date" < BankAccReconciliationLine."Transaction Date" then
                    Message(ImportedLinesAfterStatementDateMsg);
            CurrPage.ApplyBankLedgerEntries.Page.SetBankRecDateFilter(BankAccReconciliation.MatchCandidateFilterDate());
        end;
    end;

    local procedure WarnIfOngoingBankReconciliations(BankAccountNoCode: Code[20]): Boolean
    var
        BankAccReconciliation: Record "Bank Acc. Reconciliation";
    begin
        BankAccReconciliation.SetRange("Bank Account No.", BankAccountNoCode);
        BankAccReconciliation.SetRange("Statement Type", BankAccReconciliation."Statement Type"::"Bank Reconciliation");
        if not BankAccReconciliation.FindSet() then
            exit(true);
        repeat
            if BankAccReconciliation."Statement No." <> Rec."Statement No." then
                exit(Dialog.Confirm(StrSubstNo(IgnoreExistingBankAccReconciliationAndContinueQst)));
        until BankAccReconciliation.Next() = 0;
        exit(true);
    end;

    local procedure ConfirmSelectedEntriesWithExternalMatchForModification(var TempBankAccountLedgerEntry: Record "Bank Account Ledger Entry" temporary): Boolean
    var
        ReturnValue: Boolean;
    begin
        TempBankAccountLedgerEntry.SetFilter("Statement No.", '<> %1 & <> ''''', Rec."Statement No.");
        if TempBankAccountLedgerEntry.IsEmpty() then
            ReturnValue := true
        else begin
            ReturnValue := Confirm(ModifyBankAccLedgerEntriesForModificationQst, false);
            //Azizif ReturnValue then
            //AzizSession.LogMessage('0000JLM', '', Verbosity::Warning, DataClassification::SystemMetadata, TelemetryScope::ExtensionPublisher, 'Category', Rec.GetBankReconciliationTelemetryFeatureName());
        end;

        TempBankAccountLedgerEntry.SetRange("Statement No.");
        TempBankAccountLedgerEntry.FindSet();
        exit(ReturnValue);
    end;

    local procedure CheckBankAccLedgerEntriesAlreadyMatched()
    var
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
    begin
        BankAccountLedgerEntry.SetRange("Bank Account No.", Rec."Bank Account No.");
        BankAccountLedgerEntry.SetRange(Open, true);
        BankAccountLedgerEntry.SetFilter("Statement No.", '<> %1 & <> ''''', Rec."Statement No.");
        BankAccountLedgerEntry.SetFilter("Statement Status", '<> Closed');
        if (Rec."Statement Date" <> 0D) then
            BankAccountLedgerEntry.SetFilter("Posting Date", '<= %1', Rec."Statement Date");

        if not BankAccountLedgerEntry.IsEmpty() then
            Message(ExistingBankAccReconciliationAndContinueMsg);
    end;

    var
        SuggestBankAccStatement: Report "Suggest Manual Bank Recon";
        TransferToGLJnl: Report "Trans. Bank Rec. to Gen. Jnl.";
        ReportPrint: Codeunit Microsoft.Foundation.Reporting."Test Report-Print";
        ListEmptyMsg: Label 'No bank statement lines exist. Choose the Import Bank Statement action to fill in the lines from a file, or enter lines manually.';
        ImportedLinesAfterStatementDateMsg: Label 'There are lines on the imported bank statement with dates that are after the statement date.';
        StatementDateEmptyMsg: Label 'The bank account reconciliation does not have a statement date. %1 is the latest date on a line. Do you want to use that date for the statement?', Comment = '%1 - statement date';
        NoBankAccReconcilliationLineWithDiffSellectedErr: Label 'Select the bank statement lines that have differences to transfer to the general journal.';
        UpdatedBankAccountLESystemId: Guid;
        ManualBool: Boolean;
        AutoBool: Boolean;

        BankAccountNoIsEditable: Boolean;
        UpdatedBankAccountLESubpageStementDate: Date;
        IgnoreExistingBankAccReconciliationAndContinueQst: Label 'There are ongoing reconciliations for this bank account. \\Do you want to continue?';
        ExistingBankAccReconciliationAndContinueMsg: Label 'There are ongoing reconciliations for this bank account in which entries are matched.';
        ModifyBankAccLedgerEntriesForModificationQst: Label 'One or more of the selected entries have been matched on another bank account reconciliation.\\Do you want to continue?';

    [IntegrationEvent(false, false)]
    local procedure OnActionSuggestLinesOnBeforeSuggestBankAccReconLines(var BankAccReconciliation: Record "Bank Acc. Reconciliation"; var IsHandled: Boolean)
    begin
    end;
}
