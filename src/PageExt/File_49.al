
PageExtension 50086 pageextension50086 extends "Post Codes"
{
    layout
    {
        addafter(County)
        {
            field("Phone Code"; Rec."Phone Code")
            {
                ApplicationArea = Basic;
            }
        }
    }
}

