page 50795 "Portal TopUp Subpage"
{
    PageType = ListPart;
    SourceTable = "Portal Top Up";
    ApplicationArea = All;
    Caption = 'Loan Top-Up Details';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan Top Up"; Rec."Loan Top Up")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the loan number being topped up.';
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the member number.';
                }
                field("Total Top Up"; Rec."Total Top Up")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total top-up amount.';
                    StyleExpr = 'Strong';
                }
                field("Product Code"; Rec."Product Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the loan product being topped up.';
                }
                field("Product Name"; Rec."Product Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the loan product name.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ViewLoan)
            {
                Caption = 'View Original Loan';
                ApplicationArea = All;
                Image = View;
                ToolTip = 'View the original loan details.';
                RunObject = page "Loan Posted Card";
                RunPageLink = "Loan No." = field("Loan Top Up");
            }
            action(ViewSchedule)
            {
                Caption = 'View Loan Schedule';
                ApplicationArea = All;
                Image = Timeline;
                ToolTip = 'View the loan repayment schedule.';

                trigger OnAction()
                var
                    Loans: Record Loans;
                begin
                    if Loans.Get(Rec."Loan Top Up") then begin
                        // Open loan schedule page or report
                        Message('Loan schedule for %1', Rec."Loan Top Up");
                    end;
                end;
            }
        }
    }
}