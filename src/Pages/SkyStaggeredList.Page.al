Page 50418 "Sky Staggered List"
{
    ApplicationArea = Basic;
    CardPageID = "Sky Staggered Header Card";
    PageType = List;
    SourceTable = "Transaction Charges";
    UsageCategory = Lists;

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
                field(Description; Rec.Description)
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

