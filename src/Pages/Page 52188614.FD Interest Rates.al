
Page 50277 "FD Interest Rates"
{
    PageType = ListPart;
    SourceTable = "FD Interest Rates";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Minimum; Rec.Minimum)
                {
                    ApplicationArea = Basic;
                }
                field(Maximum; Rec.Maximum)
                {
                    ApplicationArea = Basic;
                }
                field(IntRate; Rec."Int Rate")
                {
                    ApplicationArea = Basic;
                }
                field(Margin; Rec.Margin)
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

