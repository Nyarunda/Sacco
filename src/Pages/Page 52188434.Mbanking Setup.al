
Page 50077 "Mbanking Setup"
{
    PageType = List;
    SourceTable = "MBanking Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(TransactionType; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field(VendorCommissionAccount; Rec."Vendor Commission Account")
                {
                    ApplicationArea = Basic;
                }
                field(VendorCommission; Rec."Vendor Commission")
                {
                    ApplicationArea = Basic;
                }
                field(SaccoFeeAccount; Rec."Sacco Fee Account")
                {
                    ApplicationArea = Basic;
                }
                field(SaccoFee; Rec."Sacco Fee")
                {
                    ApplicationArea = Basic;
                }
                field(SafaricomAccount; Rec."Safaricom Account")
                {
                    ApplicationArea = Basic;
                }
                field(SafaricomFee; Rec."Safaricom Fee")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(BankAccount; Rec."Bank Account")
                {
                    ApplicationArea = Basic;
                }
                field(PrePaymentAccount; Rec."Pre-Payment Account")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(SMSCharge; Rec."SMS Charge")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(SMSAccount; Rec."SMS Account")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(TransactionLimit; Rec."Transaction Limit")
                {
                    ApplicationArea = Basic;
                }
                field(NonMemberDebitAccount; Rec."Non-Member Debit Account")
                {
                    ApplicationArea = Basic;
                }
                field(DailyLimit; Rec."Daily Limit")
                {
                    ApplicationArea = Basic;
                }
                field(WeeklyLimit; Rec."Weekly Limit")
                {
                    ApplicationArea = Basic;
                }
                field(MonthlyLimit; Rec."Monthly Limit")
                {
                    ApplicationArea = Basic;
                }
                field(ChargeType; Rec."Charge Type")
                {
                    ApplicationArea = Basic;
                }
                field(StaggeredChargeCode; Rec."Staggered Charge Code")
                {
                    ApplicationArea = Basic;
                }
                field(RestricttoEmployer; Rec."Restrict to Employer")
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

