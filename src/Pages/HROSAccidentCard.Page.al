Page 50933 "HR OSAccident Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "HR OSAccident";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(AccidentNo; Rec."Accident No")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control5; "HR OSAccident Line")
            {
                SubPageLink = "Accident No" = field("Accident No");
            }
            part(Control6; "HR OSMeasure Line")
            {
                SubPageLink = "Measure No" = field("Accident No");
            }
        }
    }

    actions
    {
    }
}

