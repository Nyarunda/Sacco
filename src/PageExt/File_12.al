
PageExtension 50067 pageextension50067 extends "Countries/Regions"
{
    layout
    {
        addafter(Name)
        {
            field("Phone Code Format"; Rec."Phone Code Format")
            {
                ApplicationArea = Basic;
            }
            field("Phone No. Length"; Rec."Phone No. Length")
            {
                ApplicationArea = Basic;
            }
            field("Mobile Phone. No. Length"; Rec."Mobile Phone. No. Length")
            {
                ApplicationArea = Basic;
            }
        }
    }
}

