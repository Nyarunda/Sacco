Page 50533 "Agent Tariff Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Agent Tarriff Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type"; Rec."Trans Type Agents")
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
                field(YearlyLimit; Rec."Yearly Limit")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionLimit; Rec."Transaction Limit")
                {
                    ApplicationArea = Basic;
                }
                field(ChargeExciseDuty; Rec."Charge Excise Duty")
                {
                    ApplicationArea = Basic;
                }
                field(SaccoCommAcc; Rec."Sacco Comm Acc")
                {
                    ApplicationArea = Basic;
                }
                field(VendorCommAcc; Rec."Vendor Comm Acc")
                {
                    ApplicationArea = Basic;
                }
                field(SMSAcc; Rec."SMS Acc")
                {
                    ApplicationArea = Basic;
                }
                field(ChargeAcc; Rec."Charge Acc")
                {
                    ApplicationArea = Basic;
                }
                field(Tiered; Rec.Tiered)
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control7; "Agent Tariff Details")
            {
                SubPageLink = Code = field(Code);
            }
        }
    }

    actions
    {
    }
}

