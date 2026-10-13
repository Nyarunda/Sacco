
Page 50145 "Tiered Debt Threshold"
{
    PageType = List;
	UsageCategory=Lists;
    SourceTable = "Tiered Debt Threshold";
	ApplicationArea = All;

  layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(LineNo; Rec."Line No")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Visible = false;
                }
                field(LoanProduct; Rec."Loan Product")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field(LowerLimit; Rec."Lower Limit")
                {
                    ApplicationArea = Basic;
                }
                field(UpperLimit; Rec."Upper Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Loan Term";Rec."Maximum Loan Term")
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

