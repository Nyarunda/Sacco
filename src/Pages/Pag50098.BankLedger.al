page 50098 "Bank Ledger"
{
    Caption = 'Bank Ledger';
    PageType = List;
    SourceTable = "Bank Account Ledger Entry";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the entry, as assigned from the specified number series when the entry was created.';
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the bank account used for the entry.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the posting date for the entry.';
                    trigger OnValidate()
                    var
                        GLentry: Record "G/L Entry";
                        CLedger: Record "Credit Ledger Entry";
                        DetCLedger: Record "Credit Ledger Entry";
                        VLedger: Record "Savings Ledger Entry";
                        DetVLedger: Record "Savings Ledger Entry";
                        BLedger: Record "Bank Account Ledger Entry";
                    begin

                        BLedger.Reset();
                        BLedger.SetRange("Transaction No.", Rec."Transaction No.");
                        BLedger.SetFilter("Bank Account No.", '<>%1', Rec."Bank Account No.");
                        if BLedger.FindFirst() then begin
                            repeat
                                BLedger."Posting Date" := Rec."Posting Date";
                                BLedger.Modify();
                            until BLedger.Next() = 0;
                        end;


                        GLentry.Reset();
                        GLentry.SetRange("Transaction No.", Rec."Transaction No.");
                        if GLentry.FindFirst() then begin
                            repeat
                                GLentry."Posting Date" := Rec."Posting Date";
                                GLentry.Modify();
                            until GLentry.Next() = 0;
                        end;


                        CLedger.Reset();
                        CLedger.SetRange("Transaction No.", Rec."Transaction No.");
                        if CLedger.FindFirst() then begin
                            repeat
                                CLedger."Posting Date" := Rec."Posting Date";
                                CLedger.Modify();
                            until CLedger.Next() = 0;
                        end;


                        DetCLedger.Reset();
                        DetCLedger.SetRange("Transaction No.", Rec."Transaction No.");
                        if DetCLedger.FindFirst() then begin
                            repeat
                                DetCLedger."Posting Date" := Rec."Posting Date";
                                DetCLedger.Modify();
                            until DetCLedger.Next() = 0;
                        end;


                        VLedger.Reset();
                        VLedger.SetRange("Transaction No.", Rec."Transaction No.");
                        if VLedger.FindFirst() then begin
                            repeat
                                VLedger."Posting Date" := Rec."Posting Date";
                                VLedger.Modify();
                            until VLedger.Next() = 0;
                        end;


                        DetVLedger.Reset();
                        DetVLedger.SetRange("Transaction No.", Rec."Transaction No.");
                        if DetVLedger.FindFirst() then begin
                            repeat
                                DetVLedger."Posting Date" := Rec."Posting Date";
                                DetVLedger.Modify();
                            until DetVLedger.Next() = 0;
                        end;






                    end;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the document number on the bank account entry.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the bank account entry.';
                }
                field("Statement Difference"; Rec."Statement Difference")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the amount of the entry denominated in the applicable foreign currency.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the amount of the entry denominated in the applicable foreign currency.';
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the amount of the entry in LCY.';
                }
                field(Open; Rec.Open)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the amount on the bank account entry has been fully applied to, or if there is a remaining amount that must be applied to.';
                }
                field(Positive; Rec.Positive)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the bank ledger entry is positive.';
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of account that a balancing entry is posted to, such as BANK for a cash account.';
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the general ledger, customer, vendor, or bank account that the balancing entry is posted to, such as a cash account for cash purchases.';
                }
                field("Transaction No."; Rec."Transaction No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction No. field.';
                }
                field("Debit Amount"; Rec."Debit Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total of the ledger entries that represent debits.';
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total of the ledger entries that represent credits.';
                }
                field("Debit Amount (LCY)"; Rec."Debit Amount (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total of the ledger entries that represent debits, expressed in LCY.';
                }
                field("Credit Amount (LCY)"; Rec."Credit Amount (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total of the ledger entries that represent credits, expressed in LCY.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a document number that refers to the customer''s or vendor''s numbering system.';
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the entry has been part of a reverse transaction.';
                }
            }
        }
    }
}
