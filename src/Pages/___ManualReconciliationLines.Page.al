page 50391 "Manual Reconciliation Lines"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "Bank Acc. Reconciliation Line";
    SourceTableView = WHERE("Statement Type" = CONST("Bank Reconciliation"));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    StyleExpr = StyleTxt;
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    StyleExpr = StyleTxt;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    StyleExpr = StyleTxt;
                    ToolTip = 'Specifies the posting date of the bank account or check ledger entry on the reconciliation line when the Suggest Lines function is used.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a number of your choice that will appear on the reconciliation line.';
                    Visible = true;
                }
                field("Ext. Document No."; Rec."Ext. Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a number of your choice that will appear on the reconciliation line.';
                    Visible = true;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleTxt;
                    ToolTip = 'Specifies a description for the transaction on the reconciliation line.';
                }
                field(Reconciled; Rec.Reconciled)
                {
                    trigger OnValidate()
                    var
                        BankAccSetStmtNo: Codeunit "Bank Acc. Entry Set Recon.-No.";
                        BankAccReconLine: Record "Bank Acc. Reconciliation Line";
                        BankAccLedgEntry: Record "Bank Account Ledger ENtry";

                    begin


                        if Rec.Reconciled then begin
                            commit;
                            BankAccReconLine := Rec;
                            BankAccLedgEntry.Get(Rec."Entry No.");
#pragma warning disable AL0432
                            //BankAccReconLine.Type := BankAccReconLine.Type::"Bank Account Ledger Entry";
                            BankAccReconLine."Applied Amount" := BankAccReconLine."Statement Amount";
                            BankAccReconLine."Applied Entries" := 1;
                            //BankAccSetStmtNo.SetReconNo(BLedger, BankAccReconLine);


                            BankAccLedgEntry.TestField(Open, true);
                            BankAccLedgEntry.TestField("Statement No.", '');
                            BankAccLedgEntry.TestField("Statement Line No.", 0);
                            BankAccLedgEntry.TestField("Bank Account No.", BankAccReconLine."Bank Account No.");
                            if BankAccLedgEntry."Statement Status" = BankAccLedgEntry."Statement Status"::Closed then
                                Error('Statement STatus CLosed');
                            // this confirm is introduced because there can be ledger entries whose statement status is corrupt because of a bug with undo bank account statement
                            if BankAccLedgEntry."Statement Status" <> BankAccLedgEntry."Statement Status"::Open then begin
                                if not GuiAllowed then
                                    Error('GUI not ALlowed');
                            end;
                            BankAccLedgEntry."Statement Status" :=
                            BankAccLedgEntry."Statement Status"::"Bank Acc. Entry Applied";
                            BankAccLedgEntry."Statement No." := BankAccReconLine."Statement No.";
                            BankAccLedgEntry."Statement Line No." := BankAccReconLine."Statement Line No.";

                            BankAccLedgEntry."Statement Difference" := 0;
                            BankAccLedgEntry.Modify();


                            Rec."Applied Amount" += BankAccLedgEntry."Remaining Amount";
                            Rec."Applied Entries" := 1;
                            Rec.VALIDATE("Statement Amount");
                            Rec.MODIFY;




                        end
                        else begin
                            commit;
                            BankAccReconLine := Rec;
                            BankAccLedgEntry.Get(Rec."Entry No.");
                            //BankAccReconLine.Type := BankAccReconLine.Type::"Bank Account Ledger Entry";
                            BankAccReconLine."Applied Amount" := 0;
                            BankAccReconLine."Applied Entries" := 0;
                            //BankAccSetStmtNo.RemoveReconNo(BankAccLedgEntry, BankAccReconLine, false);

                            BankAccLedgEntry.TestField(Open, true);
                            //if Test then begin
                            BankAccLedgEntry.TestField(
                            "Statement Status", BankAccLedgEntry."Statement Status"::"Bank Acc. Entry Applied");
                            BankAccLedgEntry.TestField("Statement No.", BankAccReconLine."Statement No.");
                            BankAccLedgEntry.TestField("Statement Line No.", BankAccReconLine."Statement Line No.");
                            //end;
                            BankAccLedgEntry.TestField("Bank Account No.", BankAccReconLine."Bank Account No.");

                            BankAccLedgEntry."Statement Status" := BankAccLedgEntry."Statement Status"::Open;
                            BankAccLedgEntry."Statement No." := '';
                            BankAccLedgEntry."Statement Line No." := 0;
                            BankAccLedgEntry."Statement Difference" := BankAccLedgEntry."Remaining Amount";
                            BankAccLedgEntry.Modify();

                            Rec."Applied Amount" -= BankAccLedgEntry."Remaining Amount";
                            Rec."Applied Entries" := 0;
                            Rec.VALIDATE("Statement Amount");
                            Rec.MODIFY;

                        end;
                    end;

                }
                field("Statement Amount"; Rec."Statement Amount")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleTxt;
                    ToolTip = 'Specifies the amount of the transaction on the bank''s statement shown on this reconciliation line.';
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Applied Amount"; Rec."Applied Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the amount of the transaction on the reconciliation line that has been applied to a bank account or check ledger entry.';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Rec.DisplayApplication;
                    end;
                }
                field(Difference; Rec.Difference)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the difference between the amount in the Statement Amount field and the amount in the Applied Amount field.';
                    Editable = false;
                }
                field("Applied Entries"; Rec."Applied Entries")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies whether the transaction on the bank''s statement has been applied to one or more bank account or check ledger entries.';
                    Visible = false;
                }
                field("Related-Party Name"; Rec."Related-Party Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the customer or vendor who made the payment that is represented by the journal line.';
                    Visible = false;
                }
                field("Additional Transaction Info"; Rec."Additional Transaction Info")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies additional information on the bank statement line for the payment.';
                    Visible = false;
                }
            }
            group(Control16)
            {
                ShowCaption = false;
                label(Control13)
                {
                    ApplicationArea = Basic, Suite;
                    ShowCaption = false;
                    Caption = ' ';
                }
                field(Balance;/* Rec.Balance + */ Rec."Statement Amount")
                {
                    ApplicationArea = Basic, Suite;
                    AutoFormatExpression = Rec.GetCurrencyCode();
                    AutoFormatType = 1;
                    Caption = 'Balance';
                    Editable = false;
                    Enabled = BalanceEnable;
                    ToolTip = 'Specifies a balance, consisting of the Balance Last Statement field, plus the balance that has accumulated in the Statement Amount field.';
                }
                field(TotalBalance;/* Rec.TotalBalance + */ Rec."Statement Amount")
                {
                    ApplicationArea = Basic, Suite;
                    AutoFormatExpression = Rec.GetCurrencyCode();
                    AutoFormatType = 1;
                    Caption = 'Total Balance';
                    Editable = false;
                    Enabled = TotalBalanceEnable;
                    ToolTip = 'Specifies the accumulated balance of the bank reconciliation, which consists of the Balance Last Statement field, plus the balance in the Statement Amount field.';
                }
                field(TotalDiff;/* Rec.TotalDiff + */ Rec.Difference)
                {
                    ApplicationArea = Basic, Suite;
                    AutoFormatExpression = Rec.GetCurrencyCode();
                    AutoFormatType = 1;
                    Caption = 'Total Difference';
                    Editable = false;
                    Enabled = TotalDiffEnable;
                    ToolTip = 'Specifies the total amount of the Difference field for all the lines on the bank reconciliation.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ShowStatementLineDetails)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Details';
                //RunObject = Page "Bank Statement Line Details";
                //RunPageLink = "Data Exch. No." = FIELD("Data Exch. Entry No."),"Line No." = FIELD("Data Exch. Line No.");
                ToolTip = 'View additional information about the document on the selected line and link to the related card.';
            }
            action(ApplyEntries)
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Apply Entries...';
                Enabled = ApplyEntriesAllowed;
                Image = ApplyEntries;
                ToolTip = 'Select one or more ledger entries that you want to apply this record to so that the related posted documents are closed as paid or refunded.';

                trigger OnAction()
                begin
                    ApplyBankReconEntries;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        if Rec."Statement Line No." <> 0 then CalcBalance(Rec."Statement Line No.");
        SetUserInteractions;
    end;

    trigger OnAfterGetRecord()
    begin
        SetUserInteractions;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        SetUserInteractions;
    end;

    trigger OnInit()
    begin
        BalanceEnable := true;
        TotalBalanceEnable := true;
        TotalDiffEnable := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if BelowxRec then
            CalcBalance(xRec."Statement Line No.")
        else
            CalcBalance(xRec."Statement Line No." - 1);
    end;

    var
        BankAccRecon: Record "Bank Acc. Reconciliation";
        StyleTxt: Text;
        TotalDiff: Decimal;
        Balance: Decimal;
        TotalBalance: Decimal;

        TotalDiffEnable: Boolean;

        TotalBalanceEnable: Boolean;

        BalanceEnable: Boolean;
        ApplyEntriesAllowed: Boolean;

    local procedure CalcBalance(BankAccReconLineNo: Integer)
    var
        TempBankAccReconLine: Record "Bank Acc. Reconciliation Line";
    begin
        if BankAccRecon.Get(Rec."Statement Type", Rec."Bank Account No.", Rec."Statement No.") then;

        TempBankAccReconLine.Copy(Rec);

        TotalDiff := -Rec.Difference;
        if TempBankAccReconLine.CalcSums(Difference) then begin
            TotalDiff := TotalDiff + TempBankAccReconLine.Difference;
            TotalDiffEnable := true;
        end else
            TotalDiffEnable := false;

        TotalBalance := BankAccRecon."Balance Last Statement" - Rec."Statement Amount";
        if TempBankAccReconLine.CalcSums("Statement Amount") then begin
            TotalBalance := TotalBalance + TempBankAccReconLine."Statement Amount";
            TotalBalanceEnable := true;
        end else
            TotalBalanceEnable := false;

        Balance := BankAccRecon."Balance Last Statement" - Rec."Statement Amount";
        TempBankAccReconLine.SetRange("Statement Line No.", 0, BankAccReconLineNo);
        if TempBankAccReconLine.CalcSums("Statement Amount") then begin
            Balance := Balance + TempBankAccReconLine."Statement Amount";
            BalanceEnable := true;
        end else
            BalanceEnable := false;
    end;

    local procedure ApplyBankReconEntries()
    var
    //BankAccReconApplyEntries: Codeunit "Bank Acc. Recon. Apply Entries";
    begin
        Rec."Ready for Application" := true;
        CurrPage.SaveRecord;
        Commit();
        //BankAccReconApplyEntries.ApplyEntries(Rec);
    end;

    procedure GetSelectedRecords(var TempBankAccReconciliationLine: Record "Bank Acc. Reconciliation Line" temporary)
    var
        BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
    begin
        CurrPage.SetSelectionFilter(BankAccReconciliationLine);
        if BankAccReconciliationLine.FindSet() then
            repeat
                TempBankAccReconciliationLine := BankAccReconciliationLine;
                TempBankAccReconciliationLine.Insert();
            until BankAccReconciliationLine.Next() = 0;
    end;

    local procedure SetUserInteractions()
    begin
        StyleTxt := Rec.GetStyle;
        //ApplyEntriesAllowed := Type = Type::"Check Ledger Entry";
    end;

    procedure ToggleMatchedFilter(SetFilterOn: Boolean)
    begin
        if SetFilterOn then
            Rec.SetFilter(Difference, '<>%1', 0)
        else
            Rec.Reset;
        CurrPage.Update();
    end;
}

