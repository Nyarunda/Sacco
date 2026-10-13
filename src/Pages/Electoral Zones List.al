page 50760 "Electoral Zones List"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Electoral Zones";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                }
                field(Code; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Contral; Notes)
            {
            }
            systempart(Control1; MyNotes)
            {
            }
            systempart(Control2; Links)
            {
            }
        }
    }

    actions
    {
    }
}

