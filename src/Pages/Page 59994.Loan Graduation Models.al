page 59994 "Loan Graduation Models"
{
    PageType = List;
    SourceTable = "Loan Graduation Model";
    CardPageId = "Loan Graduation Model Card";
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
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
            }
        }
    }
}
