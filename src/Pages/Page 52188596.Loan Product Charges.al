
Page 50259 "Loan Product Charges"
{
    PageType = List;
    SourceTable = "Loan Product Charges.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ChargeCode; Rec."Charge Code")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(ChargeAmount; Rec."Charge Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Percentage; Rec.Percentage)
                {
                    ApplicationArea = Basic;
                }
                field(ChargeType; Rec."Charge Type")
                {
                    ApplicationArea = Basic;
                }
                field(ChargingOption; Rec."Charging Option")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Minimum; Rec.Minimum)
                {
                    ApplicationArea = Basic;
                }
                field(Maximum; Rec.Maximum)
                {
                    ApplicationArea = Basic;
                }
                field(EffectExciseDuty; Rec."Effect Excise Duty")
                {
                    ApplicationArea = Basic;
                }
                field(Prorate; Rec.Prorate)
                {
                    ApplicationArea = Basic;
                }
                field(ChargeMethod; Rec."Charge Method")
                {
                    ApplicationArea = Basic;
                }
                field(StaggeredChargeCode; Rec."Staggered Charge Code")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Type"; Rec."Posting Type")
                {
                    ApplicationArea = Basic;
                }
                field("Excise Duty %"; Rec."Excise Duty %")
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

