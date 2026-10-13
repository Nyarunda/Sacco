page 59998 "Loan Graduation Score Weights"
{
    PageType = ListPart;
    SourceTable = "Loan Graduation Score Weight";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Score Area"; Rec."Score Area")
                {
                    ApplicationArea = All;
                }
                field(Weight; Rec.Weight)
                {
                    ApplicationArea = All;
                }
                field("Maximum Raw Score"; Rec."Maximum Raw Score")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
