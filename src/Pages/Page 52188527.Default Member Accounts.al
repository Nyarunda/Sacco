
Page 50190 "Default Member Accounts"
{
    PageType = List;
    SourceTable = "Default Savings Products.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Product; Rec.Product)
                {
                    ApplicationArea = Basic;
                }
                field(ProductName; Rec."Product Name")
                {
                    ApplicationArea = Basic;
                }
                field(MonthlyContribution; Rec."Monthly Contribution")
                {
                    ApplicationArea = Basic;
                }
                field("Repay Mode"; Rec."Repay Mode")
                {
                    ApplicationArea = Basic;
                }
                field(ProductCategory; Rec."Product Category")
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

