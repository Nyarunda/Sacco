page 50758 "Application Documents"
{
    ApplicationArea = All;
    LinksAllowed = false;
    PageType = List;
    SourceTable = "Application Documents";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                }
                field("Document Type"; Rec."Document Type")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Provided; Rec.Provided)
                {
                }
            }
        }
    }

    actions
    {
    }
}

