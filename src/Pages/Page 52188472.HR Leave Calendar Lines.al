
Page 50135 "HR Leave Calendar Lines"
{
    PageType = CardPart;
    SourceTable = "HR Leave Calendar Lines.";

    layout
    {
        area(content)
        {
            repeater(Control5)
            {
                Editable = true;
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field(Day; Rec.Day)
                {
                    ApplicationArea = Basic;
                }
                field(NonWorking; Rec."Non Working")
                {
                    ApplicationArea = Basic;
                }
                field(Reason; Rec.Reason)
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

