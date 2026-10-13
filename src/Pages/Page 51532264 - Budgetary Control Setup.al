/// <summary>
/// Page Budgetary Control Setup (ID 50621).
/// </summary>
page 50621 "Budgetary Control Setup"
{
    PageType = Card;
    SourceTable = "Budgetary Control Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Mandatory; Rec.Mandatory)
                {
                    ApplicationArea = All;
                }
                field("Allow OverExpenditure"; Rec."Allow OverExpenditure")
                {
                    ApplicationArea = All;
                }
                field("Budget Check Criteria"; Rec."Budget Check Criteria")
                {
                    ApplicationArea = All;
                }
                field("Partial Budgetary Check"; Rec."Partial Budgetary Check")
                {
                    ApplicationArea = All;
                }
                field("Use Totaling Account"; Rec."Use Totaling Account")
                {
                    ApplicationArea = All;
                }
            }
            group(Budget)
            {
                Caption = 'Budget';
                field("Current Budget Code"; Rec."Current Budget Code")
                {
                    ApplicationArea = All;
                }
                field("Current Budget Start Date"; Rec."Current Budget Start Date")
                {
                    ApplicationArea = All;
                }
                field("Current Budget End Date"; Rec."Current Budget End Date")
                {
                    ApplicationArea = All;
                }
                field("Current Item Budget"; Rec."Current Item Budget")
                {
                    ApplicationArea = All;
                }
            }
            group(Actuals)
            {
                Caption = 'Actuals';
                Visible = false;
                field("Analysis View Code"; Rec."Analysis View Code")
                {
                    ApplicationArea = All;
                }
                field("Dimension 1 Code"; Rec."Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Dimension 2 Code"; Rec."Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Dimension 3 Code"; Rec."Dimension 3 Code")
                {
                    ApplicationArea = All;
                }
                field("Dimension 4 Code"; Rec."Dimension 4 Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

