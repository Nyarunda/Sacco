page 59997 "Loan Graduation Bands"
{
    PageType = ListPart;
    SourceTable = "Loan Graduation Band";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Min Score"; Rec."Min Score")
                {
                    ApplicationArea = All;
                }
                field("Max Score"; Rec."Max Score")
                {
                    ApplicationArea = All;
                }
                field("Tier"; Rec."Tier")
                {
                    ApplicationArea = All;
                }
                field("Risk Category"; Rec."Risk Category")
                {
                    ApplicationArea = All;
                }
                field("Eligible Amount"; Rec."Eligible Amount")
                {
                    ApplicationArea = All;
                }
                field(Qualified; Rec.Qualified)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
