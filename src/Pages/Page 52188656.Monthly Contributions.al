
/// <summary>
/// Page Monthly Contributions (ID 50319).
/// </summary>
Page 50319 "Monthly Contributions"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    Editable=false;
    PageType = List;
    SourceTable = "Savings Accounts";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(ProductType; Rec."Product Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(ProductName; Rec."Product Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ProductCategory; Rec."Product Category")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Old Amount"; Rec."Old Amount")
                {
                    Visible = false;
                    ApplicationArea = Basic;
                }
                field(MonthlyContribution; Rec."Monthly Contribution")
                {
                    ApplicationArea = Basic;
                }
                field("Repay Mode"; Rec."Repay Mode")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Change Balance"; Rec."Change Balance")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = false;
                }
                field("Current Balance"; Rec."Current Balance")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = false;
                }
                field("Cummulative Contribution"; Rec."Cummulative Contribution")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(MonthlyContributionDate; Rec."Monthly Contribution Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(ContributionUpdatedBy; Rec."Contribution Updated By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

