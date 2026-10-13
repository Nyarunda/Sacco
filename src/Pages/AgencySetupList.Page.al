Page 50529 "Agency Setup List"
{
    CardPageID = "Agency Setup Page";
    Editable = true;
    PageType = List;
    SourceTable = "Sky Agency Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                }
                field(VendorCommissionAccount; Rec."Vendor Commission Account")
                {
                    ApplicationArea = Basic;
                }
                field(SaccoFeeAccount; Rec."Sacco Fee Account")
                {
                    ApplicationArea = Basic;
                }
                field(BankAccount; Rec."Bank Account")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionType; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field(VendorCommission; Rec."Vendor Commission")
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
                }
                field(PrePaymentAccount; Rec."Pre-Payment Account")
                {
                    ApplicationArea = Basic;
                }
                field(SMSCharge; Rec."SMS Charge")
                {
                    ApplicationArea = Basic;
                }
                field(SMSAccount; Rec."SMS Account")
                {
                    ApplicationArea = Basic;
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
                field(StaggeredChargeCode; Rec."Staggered Charge Code")
                {
                    ApplicationArea = Basic;
                }
                field(ChargeType; Rec."Charge Type")
                {
                    ApplicationArea = Basic;
                }
                field(RestricttoEmployer; Rec."Restrict to Employer")
                {
                    ApplicationArea = Basic;
                }
                field(AgentCommision; Rec."Agent Commision %")
                {
                    ApplicationArea = Basic;
                }
                field(Control24; Rec."Agent Commision")
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

