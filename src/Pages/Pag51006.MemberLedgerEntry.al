page 51001 "Member Ledger Entry"
{
    Caption = 'Member Ledger Entry';
    PageType = List;
    SourceTable = "Member Ledger Entry Migration";
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = False;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field(AccountNo; Rec.AccountNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account No field.';
                }
                field(MemberFound; Rec.MemberFound)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member Found field.';
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer No. field.';
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
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount (LCY) field.';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field("Transaction No."; Rec."Transaction No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction No. field.';
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reversed field.';
                }
                field("Reversed by Entry No."; Rec."Reversed by Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reversed by Entry No. field.';
                }
                field("Reversed Entry No."; Rec."Reversed Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reversed Entry No. field.';
                }
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan No field.';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction Type field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(MarkAsUnposted)
            {
                ApplicationArea = All;
                Caption = 'Mark as Unposted';
                //Image = Reopen;
                Promoted = true;
                Visible = false;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    MemberLedgerEntry: Record "Member Ledger Entry Migration";
                    EntriesUpdated: Integer;
                begin
                    MemberLedgerEntry.Reset();
                    MemberLedgerEntry.SetRange(Posted, true);
                    EntriesUpdated := MemberLedgerEntry.Count();

                    if EntriesUpdated = 0 then begin
                        Message('There are no posted member ledger entries.');
                        exit;
                    end;

                    if not Confirm('Mark all %1 posted member ledger entries as unposted?', false, EntriesUpdated) then
                        exit;

                    MemberLedgerEntry.ModifyAll(Posted, false);
                    CurrPage.Update(false);
                    Message('%1 member ledger entries were marked as unposted.', EntriesUpdated);
                end;
            }
            action(DeleteGL)
            {
                ApplicationArea = All;
                Caption = 'Delete GL Transaction';
                //Image = Reopen;
                Promoted = true;
                Visible = false;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    GLLedger: Record "G/L Entry Migration";
                    EntriesUpdated: Integer;
                begin
                    GLLedger.Reset();
                    GLLedger.SetRange(Posted, false);
                    if GLLedger.FindFirst() then
                        GLLedger.DeleteAll();

                    Message('%1 member ledger entries were marked as unposted.', EntriesUpdated);
                end;
            }
        }
    }
}
