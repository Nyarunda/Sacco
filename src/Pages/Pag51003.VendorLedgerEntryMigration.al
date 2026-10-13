page 51003 "Vendor Ledger Entry Migration"
{
    ApplicationArea = All;
    Caption = 'Vendor Ledger Entry Migration';
    PageType = List;
    SourceTable = "Vendor Ledger Entry Migration";
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
                field("Vendor No."; Rec."Vendor No.")
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
                field("Vendor Posting Group"; Rec."Vendor Posting Group")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
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
                    VendorLedgerEntry: Record "Vendor Ledger Entry Migration";
                    EntriesUpdated: Integer;
                begin
                    VendorLedgerEntry.SetRange(Posted, true);
                    EntriesUpdated := VendorLedgerEntry.Count();

                    if EntriesUpdated = 0 then begin
                        Message('There are no posted vendor ledger entries.');
                        exit;
                    end;

                    if not Confirm('Mark all %1 posted vendor ledger entries as unposted?', false, EntriesUpdated) then
                        exit;

                    VendorLedgerEntry.ModifyAll(Posted, false);
                    CurrPage.Update(false);
                    Message('%1 vendor ledger entries were marked as unposted.', EntriesUpdated);
                end;
            }
            action(Delete)
            {
                ApplicationArea = All;
                //Image = Reopen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    VendorLedgerEntry: Record "Vendor Ledger Entry Migration";
                    EntriesUpdated: Integer;
                begin

                    VendorLedgerEntry.Reset();
                    if VendorLedgerEntry.FindFirst() then
                        VendorLedgerEntry.DeleteAll();

                    CurrPage.Update(false);
                    Message('%1 vendor ledger entries were marked as unposted.', EntriesUpdated);
                end;
            }

        }
    }
}
