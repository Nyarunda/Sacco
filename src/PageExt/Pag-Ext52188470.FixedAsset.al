pageextension 50133 "Fixed Asset" extends "Fixed Asset Card"
{
    layout
    {

        addafter("Responsible Employee")
        {
            field("Year of Purchase"; Rec."Year of Purchase")
            {
                ApplicationArea = Basic;
            }
            field("Acquisition Cost"; Rec."Acquisition Cost")
            {
                ApplicationArea = Basic;
            }
            field("Book Value"; Rec."Book Value")
            {
                ApplicationArea = Basic;
            }
            field("Revaluation Amount"; Rec."Revaluation Amount")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("Serial No.")
        {
            field("Asset Tag"; Rec."Asset Tag")
            {
                ApplicationArea = Basic;
            }
        }
        addafter(UseHalfYearConvention)
        {
            field("Location Code"; Rec."Location Code")
            {
                ApplicationArea = Basic;
            }
        }
    }
}
