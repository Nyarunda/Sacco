Page 50913 "Human Resource Unit of Measure"
{
    PageType = List;
    SourceTable = "Human Resource Unit of Measure";

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
                field(QtyperUnitofMeasure; Rec."Qty. per Unit of Measure")
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

