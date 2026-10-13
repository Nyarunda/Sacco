
Page 50481 "Old Cheque Clearing"
{
    ApplicationArea = Basic;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Transactions- CBS";
    SourceTableView = where(Type = filter('Cheque Deposit'),
                            Posted = const(true),
                            "Cheque Processed" = const(false));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control20)
            {
                field(TransactionNo; Rec."No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(AccountNo; Rec."Account No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(AccountName; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ProductType; Rec."Product Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Transaction; Rec."Transaction Description")
                {
                    ApplicationArea = Basic;
                    Caption = 'Transaction';
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ChequeNo; Rec."Cheque No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(BankAccount; Rec."Bank Account")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field(Date; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date';
                    Editable = false;
                }
                field(Time; Rec."Transaction Time")
                {
                    ApplicationArea = Basic;
                    Caption = 'Time';
                    Editable = false;
                }
                field(ExpectedMaturityDate; Rec."Expected Maturity Date")
                {
                    ApplicationArea = Basic;
                }
                field(Select; Rec.Select)
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        SaccoSetup.Get;
                        if SaccoSetup."By Pass Cheque Clearing Days" then begin
                            if Rec."Expected Maturity Date" > Today then
                                if Confirm('Are you sure you want to Clear this cheque? Clearing Date is not today') then begin
                                    Rec."Expected Maturity Date" := Today;
                                    Rec.Modify;
                                    Message('Updated');
                                end;
                        end;
                    end;
                }
                field(DateCleared; Rec."Date Cleared")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(View)
            {
                Caption = 'View';
                action(AccountCard)
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Card';
                }
            }
        }
        area(processing)
        {
            action(Process)
            {
                ApplicationArea = Basic;
                Caption = 'Process';
                Image = PutawayLines;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SaccoActivities: Codeunit "Sacco Activities";
                begin
                    if Confirm('Are you sure you want to process the selected transaction?', false) = true then begin
                        Rec."Cheque Processed" := true;
                        Rec."Cheque Cleared By" := UserId;
                        Rec.Modify();
                        Message('The selected transaction has been processed.');

                    end;
                end;
            }
            action("Stop Cheque")
            {
                ApplicationArea = Basic;
                Image = VoidCheck;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin


                    /*
                    Transactions.Reset;
                    Transactions.SetRange(Posted, true);
                    Transactions.SetRange(Transactions.Select, true);
                    Transactions.SetRange("Selected By", UserId);
                    Transactions.SetFilter(Transactions."Cheque Status", '%1', Transactions."cheque status"::Pending);

                    if Transactions.Find('-') then begin
                        if Confirm('Are you sure you want to STOP the selected cheque(s)?') then begin
                            repeat
                                BankingActivities.StopCheque(Transactions);
                            until Transactions.Next = 0;

                        end;

                    end;
                    */
                end;
            }
        }
    }

    var
        Transactions: Record "Transactions- CBS";
        BUser: Record "Banking User Setup";
        BankingActivities: Codeunit "Banking Activities";
        SaccoSetup: Record "Sacco Setup";
}

