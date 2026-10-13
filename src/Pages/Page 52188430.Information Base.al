
Page 50065 "Information Base"
{
    PageType = List;
    SourceTable = "Information Base.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Info; Rec.Info)
                {
                    ApplicationArea = Basic;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field(CapturedBy; Rec."Captured By")
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

