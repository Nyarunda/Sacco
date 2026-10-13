Page 50361 "Dashboard."
{
    ApplicationArea = All;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = DashBoard;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field(TotalIncome; Rec."Total Income")
                {
                    ApplicationArea = Basic;
                }
                field(TotalExpense; Rec."Total Expense")
                {
                    ApplicationArea = Basic;
                }
                field(LoanPortfolio; Rec."Loan Portfolio")
                {
                    ApplicationArea = Basic;
                }
                field(ActiveAccounts; Rec."Active Accounts")
                {
                    ApplicationArea = Basic;
                }
                field(DormantAccounts; Rec."Dormant Accounts")
                {
                    ApplicationArea = Basic;
                }
                field(Assets; Rec.Assets)
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control12; "dashboard Lines")
            {
                SubPageLink = Date = field(Date);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(GetDashboard)
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Report.Run(50270, true, false);
                    CurrPage.Close;
                end;
            }
        }
    }
}

