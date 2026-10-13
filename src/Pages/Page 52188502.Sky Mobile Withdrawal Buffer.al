
Page 50165 "Sky Mobile Withdrawal Buffer"
{
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "Mobile Withdrawal Buffer";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(TraceID; Rec."Trace ID")
                {
                    ApplicationArea = Basic;
                }
                field("Reference No"; Rec."Reference No")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(WithdrawalType; Rec."Withdrawal Type")
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
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = Basic;
                }
                field(DateReversed; Rec."Date Reversed")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(PostingDate; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field(SessionID; Rec."Session ID")
                {
                    ApplicationArea = Basic;
                }
                field(ReversedBy; Rec."Reversed By")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Reverse Transaction")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin
                    StatusPermissions.Reset;
                    StatusPermissions.SetRange("Reverse Sky Transactions", true);
                    StatusPermissions.SetRange("User ID", UserId);
                    if not StatusPermissions.FindFirst then
                        Error('You do not have the following permission: "Reverse Sky Transactions"');

                    Rec.TestField(Posted, false);
                    Rec.TestField(Reversed, false);
                    if Confirm('Are you sure you want to reverse this transaction?') then
                        if SkyMbanking.ReverseWithdrawalRequest(Rec."Trace ID") then
                            Message('Reversed Successfully')
                        else
                            Message('Not Reversed');
                end;
            }
            action("Update Withdrawal Acount")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                var
                    Accounts: Record "Savings Accounts";
                    Sky: Record "Sky Transactions.";
                    Spot: Record "Spotcash Transactions";
                    j: Integer;
                begin

                    j := 0;
                    Withdrawals.Reset;
                    Withdrawals.SetRange(Posted, false);
                    if Withdrawals.FindFirst then begin
                        repeat
                            if Withdrawals."Account No" <> '' then begin

                                Accounts.Reset();
                                Accounts.SetRange("Old Account No.", Withdrawals."Account No");
                                if Accounts.FindFirst() then begin
                                    Withdrawals."Account No" := Accounts."No.";
                                    Withdrawals.Modify();
                                    j += 1;
                                end;
                            end;

                        until Withdrawals.Next() = 0;
                    end;
                    Message('%1 Buffer ENtries UPdated', j);

                    j := 0;
                    Sky.Reset;
                    Sky.SetRange(Posted, false);
                    if Sky.FindFirst then begin
                        repeat
                            if Sky."Member Account" <> '' then begin

                                Accounts.Reset();
                                Accounts.SetRange("Old Account No.", Sky."Member Account");
                                if Accounts.FindFirst() then begin
                                    Sky."Member Account" := Accounts."No.";
                                    Sky.Modify();
                                    j += 1;
                                end;
                            end;

                        until Sky.Next() = 0;
                    end;
                    Message('%1 Sky ENtries UPdated', j);



                    j := 0;

                    Spot.Reset;
                    Spot.SetRange(Posted, false);
                    if Spot.FindFirst then begin
                        repeat
                            if Spot.account_number <> '' then begin

                                Accounts.Reset();
                                Accounts.SetRange("Old Account No.", Spot.account_number);
                                if Accounts.FindFirst() then begin
                                    Spot.account_number := Accounts."No.";
                                    Spot.Modify();
                                    j += 1;
                                end;
                            end;

                        until Spot.Next() = 0;
                    end;
                    Message('%1 Spot ENtries UPdated', j);
                end;
            }
        }
    }

    var
        SkyMbanking: Codeunit "Sky Mbanking";
        StatusPermissions: Record "Sky Permissions";
        Withdrawals: Record "Mobile Withdrawal Buffer";
}

