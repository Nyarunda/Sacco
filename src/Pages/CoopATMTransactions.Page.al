Page 50406 "Coop ATM Transactions"
{
    ApplicationArea = All;
    Editable = false;
    PageType = List;
    SourceTable = "Coop ATM Transaction";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Skipped; Rec.Skipped)
                {
                    ApplicationArea = Basic;
                }
                field(TransactionID; Rec."Transaction ID")
                {
                    ApplicationArea = Basic;
                }
                field(DocumentNo; Rec."Document No.")
                {
                    ApplicationArea = Basic;
                }
                field(ServiceName; Rec."Service Name")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionDate; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionTime; Rec."Transaction Time")
                {
                    ApplicationArea = Basic;
                }
                field(MemberAccount; Rec."Member Account")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(ATMNo; Rec."ATM No.")
                {
                    ApplicationArea = Basic;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = Basic;
                }
                field(Description1; Rec."Description 1")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionType; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionName; Rec."Transaction Name")
                {
                    ApplicationArea = Basic;
                }
                field(Activity; Rec.Activity)
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(DatePosted; Rec."Date Posted")
                {
                    ApplicationArea = Basic;
                }
                field(TimePosted; Rec."Time Posted")
                {
                    ApplicationArea = Basic;
                }
                field(PostedBy; Rec."Posted By")
                {
                    ApplicationArea = Basic;
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = Basic;
                }
                field(DateReversed; Rec."Date Reversed")
                {
                    ApplicationArea = Basic;
                }
                field(TimeReversed; Rec."Time Reversed")
                {
                    ApplicationArea = Basic;
                }
                field(ReversedBy; Rec."Reversed By")
                {
                    ApplicationArea = Basic;
                }
                field(ReversalID; Rec."Reversal ID")
                {
                    ApplicationArea = Basic;
                }
                field(Description2; Rec."Description 2")
                {
                    ApplicationArea = Basic;
                }
                field(OriginalTransactionID; Rec."Original Transaction ID")
                {
                    ApplicationArea = Basic;
                }
                field(ChannelCode; Rec."Channel Code")
                {
                    ApplicationArea = Basic;
                }
                field(TerminalCode; Rec."Terminal Code")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account"; Rec."Bank Account")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account Name"; Rec."Bank Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(TotalAccountDebit; Rec."Total Account Debit")
                {
                    ApplicationArea = Basic;
                }
                field(TotalCharges; Rec."Total Charges")
                {
                    ApplicationArea = Basic;
                }
                field(CoopFee; Rec."Coop Fee")
                {
                    ApplicationArea = Basic;
                }
                field(SaccoFee; Rec."Sacco Fee")
                {
                    ApplicationArea = Basic;
                }
                field(SaccoExciseDuty; Rec."Sacco Excise Duty")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                }
                field("Account Balance"; MobileBanking.GetAccountBalance(Rec."Member Account"))
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(UpdateBanks)
            {
                trigger OnAction()
                var
                    myInt: Integer;
                    ATM: Record "Coop ATM Transaction";
                    ATM2: Record "Coop ATM Transaction";
                    Bank: Record "Bank Account";
                    Coop: Codeunit "Coop Processing";
                    BankCode: Code[20];
                begin
                    ATM.Reset();
                    //ATM.SetRange("Bank Account", '');
                    ATM.SetFilter("Transaction Type", '<>%1', '1420');
                    if ATM.FindFirst() then begin
                        repeat
                            BankCode := Coop.GetCoopBankAccount(ATM."Transaction Type", ATM."Terminal Code", ATM."Channel Code");
                            if ATM."Bank Account" <> BankCode then begin
                                if Bank.get(BankCode) then begin
                                    ATM."Bank Account" := Bank."No.";
                                    ATM."Bank Account Name" := Bank.Name;
                                    ATM.Modify();
                                end;
                            end;
                            if ATM."Reversal ID" <> '' then begin

                                ATM2.Reset();
                                ATM2.SetRange("Document No.", ATM."Document No.");
                                ATM2.SetRange("Transaction Type", '%1', '1420');
                                if ATM2.FindFirst() then begin
                                    repeat
                                        BankCode := ATM."Bank Account";
                                        if ATM2."Bank Account" <> BankCode then begin
                                            if Bank.get(BankCode) then begin
                                                ATM2."Bank Account" := Bank."No.";
                                                ATM2."Bank Account Name" := Bank.Name;
                                                ATM2.Modify();
                                            end;
                                        end;
                                    until ATM2.Next() = 0;
                                end;

                            end;
                        until ATM.Next() = 0;
                    end;
                    Message('Updated');
                end;
            }


            action(TransferLedgers)
            {
                trigger OnAction()
                var
                    myInt: Integer;
                    ATM: Record "Coop ATM Transaction";
                    Bank: Record "Bank Account";
                    Coop: Codeunit "Coop Processing";
                    BankCode: Code[20];
                    PGroup: Record "Bank Account Posting Group";
                    GLEntry: Record "G/L Entry";
                    BLedger: Record "Bank Account Ledger Entry";
                begin
                    ATM.Reset();
                    //ATM.SetRange(Transfered, false);
                    ATM.SetFilter("Transaction Type", '<>%1', '1420');
                    ATM.SetFilter("Bank Account", '<>%1', '');
                    if ATM.FindFirst() then begin
                        repeat
                            if Bank.get(ATM."Bank Account") then begin
                                PGroup.Get(Bank."Bank Acc. Posting Group");
                                PGroup.TestField("G/L Account No.");
                                BLedger.Reset();
                                BLedger.SetRange("Document No.", ATM."Document No.");
                                BLedger.SetFilter("Bank Account No.", '<>%1', ATM."Bank Account");
                                if BLedger.FindFirst() then begin
                                    repeat
                                        GLEntry.Reset();
                                        GLEntry.SetRange("Entry No.", BLedger."Entry No.");
                                        GLEntry.SetRange("Document No.", BLedger."Document No.");
                                        GLEntry.SetRange(Amount, BLedger."Amount (LCY)");
                                        if GLEntry.FindFirst() then begin
                                            GLEntry."Old No." := GLEntry."G/L Account No.";
                                            GLEntry."G/L Account No." := PGroup."G/L Account No.";
                                            GLEntry.Modify();
                                            BLedger."Old No." := BLedger."Bank Account No.";
                                            BLedger."Bank Account No." := ATM."Bank Account";
                                            BLedger.Modify();
                                            ATM.Transfered := true;
                                            ATM.Modify();
                                            Commit();
                                        end;
                                    until BLedger.Next() = 0;
                                end;

                            end;
                        until ATM.Next() = 0;
                    end;
                    Message('Updated');
                end;
            }



            action(CompleteReversal)
            {
                Promoted = true;
                PromotedIsBig = true;


                trigger OnAction()
                var
                    myInt: Integer;
                    ATM: Record "Coop ATM Transaction";
                    Bank: Record "Bank Account";
                    Coop: Codeunit "Coop Processing";
                    BankCode: Code[20];
                    PGroup: Record "Bank Account Posting Group";
                    GLEntry: Record "G/L Entry";
                    BLedger: Record "Bank Account Ledger Entry";
                begin
                    if Confirm('Are you  sure you want to Complete this Reversal') then begin
                        //Rec.TestField("Transaction Type", '1420');
                        //Rec.TestField(Skipped);
                        Coop.PostATM(Rec."Transaction ID");
                    end;
                end;
            }

        }

    }

    var
        CoopProcessing: Codeunit "Coop Processing";
        MobileBanking: Codeunit "Sky Mbanking";
}

