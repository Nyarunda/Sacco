
Page 50241 "Cheque Clearing"
{
    ApplicationArea = Basic;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Teller Transaction";
    SourceTableView = where(Type = filter("Cheque Deposit" | "Credit Cheque"),
                            Posted = const(true),
                            "Cheque Status" = const(Pending));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control20)
            {
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TransactionNo; Rec."Transaction No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(AccountNo; Rec."Account No.")
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
                field(ChequeLocation; Rec."Cheque Location")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ChequeStatus; Rec."Cheque Status")
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
                                    Rec."Cheque ByPassed By" := UserId;
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
                field(SelectedBy; Rec."Selected By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ClearedBy; Rec."Cleared By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(BouncingCharge; Rec."Bouncing Charge")
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
                    if Confirm('Are you sure you want to process the selected transactions?', false) = true then begin

                        //Transactions.RESET;
                        //Transactions.SETRANGE(Transactions.Select,TRUE);
                        //IF Transactions.FIND('-') THEN
                        //REPEAT

                        BankingActivities.ProcessCheque(Rec);


                        //UNTIL Transactions.NEXT = 0;

                        //SENDMAIL;
                        Message('The selected transactions have been processed.');

                    end;
                end;
            }
            action("Process Customer")
            {
                ApplicationArea = Basic;
                Image = PutAway;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SaccoActivities: Codeunit "Sacco Activities";
                begin
                    if Confirm('Are you sure you want to Process the selected Customer transactions?', false) = true then begin

                        //Transactions.RESET;
                        //Transactions.SETRANGE(Transactions.Select,TRUE);
                        //IF Transactions.FIND('-') THEN
                        //REPEAT
                        Rec.TestField("Account Type", Rec."Account Type"::Customer);
                        Rec.TestField("Cheque Status", Rec."Cheque Status"::Pending);
                        Rec.TestField(Posted, true);
                        Rec.TestField(Select, true);

                        Rec."Cheque Status" := Rec."cheque status"::Honoured;
                        Rec."Date Cleared" := Today;
                        Rec."Cleared By" := UserId;
                        Rec.Modify;


                        //UNTIL Transactions.NEXT = 0;

                        //SENDMAIL;
                        Message('The selected transactions have been processed.');

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
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if not UserSetup."Cheque mangemennt" then
            Error('You do not have any permissions for Cheque Clearing. Contact the administrator!');
    end;

    var
        Transactions: Record "Teller Transaction";
        BUser: Record "Banking User Setup";
        BankingActivities: Codeunit "Banking Activities";
        SaccoSetup: Record "Sacco Setup";
}

