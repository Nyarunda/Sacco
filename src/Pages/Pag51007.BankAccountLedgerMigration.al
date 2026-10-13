page 51007 "Bank Account Ledger Migration"
{
    ApplicationArea = All;
    Caption = 'Bank Account Ledger Migration';
    PageType = List;
    SourceTable = "Bank Account Ledger Migration";
    UsageCategory = Lists;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = All;
                }
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
                field("Amount (LCY)"; Rec."Amount (LCY)")
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
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = All;
                }
                field("Bank Acc. Posting Group"; Rec."Bank Acc. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                }
                field("Statement No."; Rec."Statement No.")
                {
                    ApplicationArea = All;
                }
                field("Transaction No."; Rec."Transaction No.")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
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
            action(MarkAllAsUnposted)
            {
                ApplicationArea = All;
                Caption = 'Mark All as Unposted';
                //Image = Reopen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    BankLedgerEntry: Record "Bank Account Ledger Migration";
                    EntriesUpdated: Integer;
                begin
                    BankLedgerEntry.SetRange(Posted, true);
                    EntriesUpdated := BankLedgerEntry.Count();

                    if EntriesUpdated = 0 then begin
                        Message('There are no posted bank account ledger entries.');
                        exit;
                    end;

                    if not Confirm('Mark all %1 posted bank account ledger entries as unposted?', false, EntriesUpdated) then
                        exit;

                    BankLedgerEntry.ModifyAll(Posted, false);
                    CurrPage.Update(false);
                    Message('%1 bank account ledger entries were marked as unposted.', EntriesUpdated);
                end;
            }
        }
    }
}
