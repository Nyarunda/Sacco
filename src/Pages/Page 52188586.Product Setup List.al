
Page 50249 "Product Setup List"
{
    ApplicationArea = Basic;
    CardPageID = "Product Setup Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Product Setup";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ProductID; Rec."Product ID")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(ProductClass; Rec."Product Class")
                {
                    ApplicationArea = Basic;
                }
                field(ProductCategory; Rec."Product Category")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(MbankingKeyWord; Rec."Mbanking Key Word")
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

