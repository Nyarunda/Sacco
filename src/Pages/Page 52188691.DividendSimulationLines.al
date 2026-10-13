Page 50354 "Dividend Simulation Lines"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    Editable = false;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "Dividend Simulation Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(GLAccount; Rec."G/L Account")
                {
                    ApplicationArea = Basic;
                }
                field(ProductType; Rec."Product Type")
                {
                    ApplicationArea = Basic;
                }
                field(StartDate; Rec."Start Date")
                {
                    ApplicationArea = Basic;
                }
                field(EndDate; Rec."End Date")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(WeightedAmount; Rec."Weighted Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Rate; Rec.Rate)
                {
                    ApplicationArea = Basic;
                }
                field(PayOut; Rec."Pay Out")
                {
                    ApplicationArea = Basic;
                }
                field(WTax; Rec."W/Tax")
                {
                    ApplicationArea = Basic;
                }
                field(NetPay; Rec."Net Pay")
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

