page 59985 "AML Customer Risk Profile List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "AML Customer Risk Profile";
    Caption = 'AML Customer Risk Profiles';
    CardPageId = "AML Customer Risk Profile Card";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = All;
                }
                field("Risk Level"; Rec."Risk Level")
                {
                    ApplicationArea = All;
                }
                field("Risk Score"; Rec."Risk Score")
                {
                    ApplicationArea = All;
                }
                field("Is PEP"; Rec."Is PEP")
                {
                    ApplicationArea = All;
                }
                field("High Risk Country"; Rec."High Risk Country")
                {
                    ApplicationArea = All;
                }
                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = All;
                }
                field("Last Review Date"; Rec."Last Review Date")
                {
                    ApplicationArea = All;
                }
                field("Next Review Date"; Rec."Next Review Date")
                {
                    ApplicationArea = All;
                }
                field("Total Deposits"; Rec."Total Deposits")
                {
                    ApplicationArea = All;
                }
                field("Total Withdrawals"; Rec."Total Withdrawals")
                {
                    ApplicationArea = All;
                }
                field("Total Loan Amount"; Rec."Total Loan Amount")
                {
                    ApplicationArea = All;
                }
                field("Average Monthly Transactions"; Rec."Average Monthly Transactions")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {
            part(CustomerInfo; "Customer Statistics FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("Customer No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(UpdateRiskMetrics)
            {
                ApplicationArea = All;
                Caption = 'Update Risk Metrics';
                Image = Refresh;
                PromotedCategory = Process;
                Promoted = true;

                trigger OnAction()
                begin
                    Rec.UpdateRiskMetrics();
                    Message('Risk metrics updated for customer %1', Rec."Customer No.");
                end;
            }
            action(UpdateAllRiskMetrics)
            {
                ApplicationArea = All;
                Caption = 'Update All Risk Metrics';
                Image = RefreshLines;
                PromotedCategory = Process;
                Promoted = true;

                trigger OnAction()
                var
                    CustomerRiskProfile: Record "AML Customer Risk Profile";
                    ProcessedCount: Integer;
                begin
                    CustomerRiskProfile.Copy(Rec);
                    if CustomerRiskProfile.FindSet() then
                        repeat
                            CustomerRiskProfile.UpdateRiskMetrics();
                            ProcessedCount += 1;
                        until CustomerRiskProfile.Next() = 0;

                    Message('%1 customer risk profiles updated', ProcessedCount);
                end;
            }
            action(ViewTransactionHistory)
            {
                ApplicationArea = All;
                Caption = 'View Transaction History';
                Image = History;
                PromotedCategory = Process;
                Promoted = true;

                trigger OnAction()
                var
                    TransactionMonitor: Record "AML Transaction Monitor";
                    TransactionMonitorPage: Page "AML Transaction Monitor List";
                begin
                    TransactionMonitor.SetFilter("Customer No.", Rec."Customer No.");
                    TransactionMonitorPage.SetTableView(TransactionMonitor);
                    TransactionMonitorPage.RunModal();
                end;
            }
            action(ViewSuspiciousActivities)
            {
                ApplicationArea = All;
                Caption = 'View Suspicious Activities';
                Image = Warning;
                PromotedCategory = Process;
                Promoted = true;

                trigger OnAction()
                var
                    SuspiciousActivity: Record "AML Suspicious Activity";
                    SuspiciousActivityPage: Page "AML Suspicious Activity List";
                begin
                    SuspiciousActivity.SetFilter("Customer No.", Rec."Customer No.");
                    SuspiciousActivityPage.SetTableView(SuspiciousActivity);
                    SuspiciousActivityPage.RunModal();
                end;
            }
        }
        area(Navigation)
        {
            action(AMLSetup)
            {
                ApplicationArea = All;
                Caption = 'AML Setup';
                Image = Setup;
                RunObject = Page "AML Setup";
            }
        }
    }

    trigger OnOpenPage()
    begin
        // Show customers that need review first
        Rec.SetCurrentKey("Next Review Date");
    end;
}
