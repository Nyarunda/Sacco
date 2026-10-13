Page 50167 "Sky Staggered Charges"
{
    PageType = ListPart;
    SourceTable = "Sky Staggered Charges";

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
                field(Charge; Rec.Charge)
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

