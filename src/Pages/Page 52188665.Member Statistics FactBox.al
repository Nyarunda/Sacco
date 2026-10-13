
Page 50328 "Member Statistics FactBox"
{
    Caption = 'Member Statistics';
    PageType = CardPart;
    SourceTable = Members;

    layout
    {
        area(content)
        {
            group(BalanceDetails)
            {
                Caption = 'Balance Details';
            }
            field(MemberNo; Rec."No.")
            {
                ApplicationArea = Basic;
                Caption = 'Member No.';
            }
            field(Name; Rec.Name)
            {
                ApplicationArea = Basic;
            }
            group(ShareAnalysis)
            {
                Caption = 'Share Analysis';
                field("Share Capital"; ShareCap)
                {
                    ApplicationArea = Basic;
                }
                field(Deposits; Deposits)
                {
                    ApplicationArea = Basic;
                }
                field(Dividend; Dividend)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Interest on Deposits"; Dividend)
                {
                    ApplicationArea = Basic;
                }
                field("Available Guarantorship"; FreeShares)
                {
                    Caption = 'Available Guarantorship';
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        ValidatePage;
    end;

    trigger OnOpenPage()
    begin

        ValidatePage;
    end;

    var
        Text000: label 'Overdue Amounts (LCY) as of %1';
        ProdType: Record "Product Setup";
        MinBalance: Decimal;
        Reg: Record "Member Images";
        MemberActivities: Codeunit "Member Activities";
        AvailBalance: Decimal;
        Deposits: Decimal;
        ShareCap: Decimal;
        FreeShares: Decimal;
        LoanSecurity: Record "Loan Security";
        MemberAccounts: Record "Savings Accounts";
        SaccoActivities: Codeunit "Sacco Activities";
        DepAmt: Decimal;
        GuaranteedInApplication: Decimal;
        Dividend: Decimal;
        Committed: Decimal;
        Available: Decimal;
        CommittedShares: Decimal;
        Legacy: Codeunit Legacy;

    procedure ValidatePage()
    begin
        Deposits := 0;
        MemberAccounts.Reset;
        MemberAccounts.SetRange("Member No.", Rec."No.");
        if MemberAccounts.FindFirst then begin
            repeat
                if (MemberAccounts."Product Category" = MemberAccounts."product category"::"Deposit Contribution") or (MemberAccounts."Product Category" = MemberAccounts."product category"::"Micro Member Deposit") then begin
                    Deposits += MemberActivities.GetAccountBalance(MemberAccounts."No.");

                    Available := (MemberActivities.GetAccountBalance(Legacy.GetDepositAccounts(Rec."No."))) - (MemberActivities.GetMemberCommittedDeposits(Legacy.GetDepositAccounts(Rec."No."), true) + MemberActivities.GetSelfGuaranteeCommitment(Legacy.GetDepositAccounts(Rec."No."), true));
                    if Available < 0 then
                        Available := 0;

                    FreeShares := Available;
                end;
                if MemberAccounts."Product Category" = MemberAccounts."product category"::"Share Capital" then
                    ShareCap := MemberActivities.GetAccountBalance(MemberAccounts."No.");

                if MemberAccounts."Product Category" = MemberAccounts."product category"::"Dividend Account" then
                    Dividend := MemberActivities.GetAccountBalance(MemberAccounts."No.");

            until MemberAccounts.Next = 0;

        end;
    end;
}

