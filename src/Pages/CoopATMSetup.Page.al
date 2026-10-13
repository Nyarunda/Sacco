Page 50399 "Coop ATM Setup"
{
    PageType = Card;
    SourceTable = "Coop ATM  Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(CoopCommissionAccount; Rec."Coop Commission Account")
                {
                    ApplicationArea = Basic;
                }
                field(CoopFeeAccount; Rec."Coop Fee Account")
                {
                    ApplicationArea = Basic;
                }
                field(CoopBankAccount; Rec."Coop Bank Account")
                {
                    ApplicationArea = Basic;
                }
                field(DailyWithdrawalLimit; Rec."Daily Withdrawal Limit")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionalWithdrawalLimit; Rec."Transactional Withdrawal Limit")
                {
                    ApplicationArea = Basic;
                }
                field(InstitutionCode; Rec."Institution Code")
                {
                    ApplicationArea = Basic;
                }
                field(InstitutioName; Rec."Institutio Name")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

