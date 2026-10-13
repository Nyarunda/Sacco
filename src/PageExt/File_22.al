
PageExtension 50076 pageextension50076 extends "G/L Account List"
{
    layout
    {
        addafter("Default Deferral Template Code")
        {
            field("Can Pay Staff"; Rec."Can Pay Staff")
            {
                ApplicationArea = Basic;
            }
            field("Can Pay Board"; Rec."Can Pay Board")
            {
                ApplicationArea = Basic;
            }
            field("Can Pay Member"; Rec."Can Pay Member")
            {
                ApplicationArea = Basic;
            }
        }
    }
}

