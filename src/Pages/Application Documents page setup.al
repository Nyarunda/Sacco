page 50757 "Application Document Setup"
{
    ApplicationArea = All;
    CardPageID = "Application Doc. Setup Card";
    Editable = false;
    PageType = List;
    SourceTable = "Application Document Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1; Notes)
            {
            }
            systempart(Control2; MyNotes)
            {
            }
            systempart(Control3; Links)
            {
            }
        }
    }

    actions
    {
    }
}

