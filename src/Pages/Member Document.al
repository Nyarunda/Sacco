page 50759 "Member Documents"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Member Documents";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                }
                field("Document Type"; Rec."Document Type")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Single Party/Multiple"; Rec."Single Party/Multiple")
                {
                }
                field("Reference No."; Rec."Reference No.")
                {
                }
                field("Product ID"; Rec."Product ID")
                {
                }
                field("Product Name"; Rec."Product Name")
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

