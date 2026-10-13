
Page 50295 "Transaction Charges Lines"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Transaction Charges Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(ChargeType; Rec."Charge Type")
                {
                    ApplicationArea = Basic;
                }
                field(ChargeAmount; Rec."Charge Amount")
                {
                    ApplicationArea = Basic;
                }
                field(PercentageofAmount; Rec."Percentage of Amount")
                {
                    ApplicationArea = Basic;
                }
                field(StaggeredChargeCode; Rec."Staggered Charge Code")
                {
                    ApplicationArea = Basic;
                }
                field(MinimumAmount; Rec."Minimum Amount")
                {
                    ApplicationArea = Basic;
                }
                field(MaximumAmount; Rec."Maximum Amount")
                {
                    ApplicationArea = Basic;
                }
                field(ChargeAccountType; Rec."Charge Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(ChargeAccount; Rec."Charge Account")
                {
                    ApplicationArea = Basic;
                }
                field(ChargeExciseDuty; Rec."Charge Excise Duty")
                {
                    ApplicationArea = Basic;
                }
                field("Excise Duty %"; Rec."Excise Duty %")
                {
                    ApplicationArea = Basic;
                }
                field(SharingAccountType; Rec."Sharing Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(SharingAccountNo; Rec."Sharing Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(SharingValue; Rec."Sharing Value")
                {
                    ApplicationArea = Basic;
                }
                field(SharingUsePercentage; Rec."Sharing Use Percentage")
                {
                    ApplicationArea = Basic;
                }
                field(SharingExciseDuty; Rec."Sharing Excise Duty")
                {
                    ApplicationArea = Basic;
                }
                field("Sharing Excise Duty %"; Rec."Sharing Excise Duty %")
                {
                    ApplicationArea = Basic;
                }
                field("Is Sms Charge"; Rec."Is Sms Charge")
                {
                }
            }
        }
    }

    actions
    {
    }
}

