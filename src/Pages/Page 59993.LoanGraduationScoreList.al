page 59993 "Loan Graduation Score List"
{
    PageType = List;
    SourceTable = "Loan Graduation Score";
    UsageCategory = Lists;
    ApplicationArea = Basic;
    Caption = 'Loan Graduation Score';
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = All;
                }
                field("Evaluation Date"; Rec."Evaluation Date")
                {
                    ApplicationArea = All;
                }
                field("Final Score"; Rec."Final Score")
                {
                    ApplicationArea = All;
                }
                field("Score Percentage"; Rec."Score Percentage")
                {
                    ApplicationArea = All;
                }
                field("Qualification Tier"; Rec."Qualification Tier")
                {
                    ApplicationArea = All;
                }
                field("Risk Category"; Rec."Risk Category")
                {
                    ApplicationArea = All;
                }
                field("Eligible Hela Amount"; Rec."Eligible Hela Amount")
                {
                    ApplicationArea = All;
                }
                field("Is Qualified"; Rec."Is Qualified")
                {
                    ApplicationArea = All;
                }
                field("Computed At"; Rec."Computed At")
                {
                    ApplicationArea = All;
                }
                field("Computed By"; Rec."Computed By")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
