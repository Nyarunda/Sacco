page 52006 "Bank Acc. Ledger Entries"
{
    PageType = ListPart;
    SourceTable = "Bank Account Ledger Entry";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Entries)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    ApplicationArea = All;
                }
                field(Open; Rec.Open)
                {
                    ApplicationArea = All;
                }
                field("Statement Status"; Rec."Statement Status")
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
            action(Match)
            {
                ApplicationArea = All;
                Image = Apply;
                Caption = 'Match with Statement Line';

                trigger OnAction()
                begin
                    MatchWithStatementLine();
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        OnAfterEntrySelection(Rec);
    end;

    local procedure MatchWithStatementLine()
    var
        BankRecLine: Record "Bank Reconciliation Line";
    begin
        // Add matching logic here
        // This would match the selected ledger entry with a statement line
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterEntrySelection(BankEntry: Record "Bank Account Ledger Entry")
    begin
    end;

    procedure GetSelectedRecords(var TempBankLedgerEntry: Record "Bank Account Ledger Entry" temporary)
    var
        BankLedgerEntry: Record "Bank Account Ledger Entry";
    begin
        CurrPage.SetSelectionFilter(BankLedgerEntry);
        if BankLedgerEntry.FindSet() then
            repeat
                TempBankLedgerEntry := BankLedgerEntry;
                TempBankLedgerEntry.Insert();
            until BankLedgerEntry.Next() = 0;
    end;
}