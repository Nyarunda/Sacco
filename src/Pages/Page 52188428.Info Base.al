
Page 50063 "Info Base"
{
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = ListPart;
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
                field("Action Date"; Rec."Action Date")
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

