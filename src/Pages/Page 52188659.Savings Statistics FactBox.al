
/// <summary>
/// Page Savings Statistics FactBox (ID 50322).
/// </summary>
Page 50322 "Savings Statistics FactBox"
{
    Caption = 'Savings Statistics';
    PageType = CardPart;
    SourceTable = "Savings Accounts";

    layout
    {
        area(content)
        {
            group(BalanceDetails)
            {
                Caption = 'Balance Details';
            }
            field(AccountNo; Rec."No.")
            {
                ApplicationArea = Basic;
                Caption = 'Account No.';
            }

            group(AB)
            {
                Caption = 'Account Balances';

                field("Old Balance"; Rec."Old Balance")
                {
                    Caption = 'Old Balance';
                    ApplicationArea = Basic;
                    HideValue = Hiders;
                }

                field(Balance; Rec.Balance)
                {
                    Caption = 'Book Balance';
                    ApplicationArea = Basic;
                    HideValue = Hiders;
                }
                field(AvailBalance; AvailBalance)
                {
                    ApplicationArea = Basic;
                    Caption = 'Available Balance';
                    HideValue = Hiders;
                }
                field("Total Loan Arrears"; Rec."Total Loan Arrears")
                {
                    ApplicationArea = Basic;
                    HideValue = Hiders;
                }
            }
            group(OD)
            {
                Caption = 'Overdraft';
                Visible = false;
                field(AuthorisedOverDraft; Rec."Authorised Over Draft")
                {
                    ApplicationArea = Basic;
                    //HideValue = HIDERS;
                }
                field("Virtual Approved Fuuza"; Rec."Virtual Approved Fuuza")
                {
                    ApplicationArea = Basic;
                    //HideValue = HIDERS;
                }
                field("Virtual Account Interest"; Rec."Virtual Account Interest")
                {
                    ApplicationArea = Basic;
                    //HideValue = HIDERS;
                }
            }
            group(UE)
            {
                Caption = 'Uncleared Effects';
                field(UnclearedCheques; Rec."Uncleared Cheques")
                {
                    ApplicationArea = Basic;
                    HideValue = Hiders;
                }
                field("ATM Balance"; Rec."ATM Balance")
                {
                    ApplicationArea = Basic;
                    HideValue = Hiders;
                }
                field(MobileWithdrawals; Rec."Mobile Withdrawals")
                {
                    ApplicationArea = Basic;
                    HideValue = Hiders;
                }
                field("Loan Lien"; Rec."Loan Lien")
                {
                    ApplicationArea = Basic;
                    HideValue = Hiders;
                }
                field(LienPlaced; Rec."Lien Placed")
                {
                    ApplicationArea = Basic;
                    HideValue = Hiders;
                }
                field("Old Uncleared Cheques"; Rec."Old Uncleared Cheques")
                {
                    ApplicationArea = Basic;
                    HideValue = Hiders;
                }
                field("OLD ATM Balance"; Rec."OLD ATM Balance")
                {
                    ApplicationArea = Basic;
                    HideValue = Hiders;
                }
                field(MinBalance; MinBalance)
                {
                    ApplicationArea = Basic;
                    Caption = 'Minimum Balance';
                    HideValue = Hiders;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        MemberAccounts: Record "Savings Accounts";
    begin

        MinBalance := 0;
        if ProdType.Get(Rec."Product Type") then begin
            MinBalance := ProdType."Minimum Account Balance";
        end;

        AvailBalance := PeriodicActivities.GetAccountBalance(Rec."No.");

        MemberAccounts.Get(Rec."No.");
        GetFreeShares(MemberAccounts);

        Hiders := false;

        if UserSetup.Get(UserId) then begin
            if Main.Get(Rec."Member No.") then begin
                if Main."Member Category" = Main."Member Category"::"Board Members" then begin
                    if UserSetup."View Board Accounts" = false then begin
                        Hiders := true;
                    end;
                end else
                    if Main."Member Category" = Main."Member Category"::"Staff Members" then begin
                        if Main."Payroll/Staff No." <> UserSetup."Staff No" then begin
                            if UserSetup."View Staff Accounts" = false then begin
                                Hiders := true;
                            end;
                        end;
                    end;
            end;
        end else
            Hiders := true;
    end;

    trigger OnOpenPage()
    begin
        Hiders := false;
    end;

    var
        Text000: label 'Overdue Amounts (LCY) as of %1';
        ProdType: Record "Product Setup";
        MinBalance: Decimal;
        PeriodicActivities: Codeunit "Member Activities";
        AvailBalance: Decimal;
        FreeShares: Decimal;
        UserSetup: Record "User Setup";
        Main: Record Members;
        Hiders: Boolean;

    local procedure GetFreeShares(MemberAccounts: Record "Savings Accounts")
    var
        LoanSecurity: Record "Loan Security";
        DepAmt: Decimal;
        GuaranteedInApplication: Decimal;
        Committed: Decimal;
        Available: Decimal;
    begin
        FreeShares := 0;

        LoanSecurity.CalculateAvailableShares(MemberAccounts, DepAmt, GuaranteedInApplication, Committed, Available, false);
        FreeShares := Available;
    end;
}

