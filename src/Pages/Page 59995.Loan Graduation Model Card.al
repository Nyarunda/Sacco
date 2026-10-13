page 59995 "Loan Graduation Model Card"
{
    PageType = Card;
    SourceTable = "Loan Graduation Model";
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Version No."; Rec."Version No.")
                {
                    ApplicationArea = All;
                }
                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                }
                field("Evaluation Period Months"; Rec."Evaluation Period Months")
                {
                    ApplicationArea = All;
                }
                field("Minimum Qualifying Score"; Rec."Minimum Qualifying Score")
                {
                    ApplicationArea = All;
                }
                field("Grace Days Before Due"; Rec."Grace Days Before Due")
                {
                    ApplicationArea = All;
                }
                field("Grace Days After Due"; Rec."Grace Days After Due")
                {
                    ApplicationArea = All;
                }
                field("On Time Grace Days"; Rec."On Time Grace Days")
                {
                    ApplicationArea = All;
                }
            }

            part(Products; "Loan Graduation Products")
            {
                ApplicationArea = All;
                SubPageLink = "Model Code" = field("Code");
            }

            part(Bands; "Loan Graduation Bands")
            {
                ApplicationArea = All;
                SubPageLink = "Model Code" = field("Code");
            }

            part(Weights; "Loan Graduation Score Weights")
            {
                ApplicationArea = All;
                SubPageLink = "Model Code" = field("Code");
            }
        }
    }
}
