page 59986 "AML Customer Risk Profile Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "AML Customer Risk Profile";
    Caption = 'AML Customer Risk Profile Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General Information';

                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group(RiskAssessment)
            {
                Caption = 'Risk Assessment';

                field("Risk Level"; Rec."Risk Level")
                {
                    ApplicationArea = All;
                }
                field("Risk Score"; Rec."Risk Score")
                {
                    ApplicationArea = All;
                }
                field("Risk Level Date"; Rec."Risk Level Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Risk Level Updated By"; Rec."Risk Level Updated By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group(RiskFactors)
            {
                Caption = 'Risk Factors';

                field("Is PEP"; Rec."Is PEP")
                {
                    ApplicationArea = All;
                }
                field("PEP Details"; Rec."PEP Details")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("High Risk Country"; Rec."High Risk Country")
                {
                    ApplicationArea = All;
                }
                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = All;
                }
            }

            group(TransactionMetrics)
            {
                Caption = 'Transaction Metrics (Last 12 Months)';

                field("Total Deposits"; Rec."Total Deposits")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total Withdrawals"; Rec."Total Withdrawals")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total Loan Amount"; Rec."Total Loan Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Average Monthly Transactions"; Rec."Average Monthly Transactions")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group(ReviewSchedule)
            {
                Caption = 'Review Schedule';

                field("Last Review Date"; Rec."Last Review Date")
                {
                    ApplicationArea = All;
                }
                field("Next Review Date"; Rec."Next Review Date")
                {
                    ApplicationArea = All;
                }
                field("Review Frequency Months"; Rec."Review Frequency Months")
                {
                    ApplicationArea = All;
                }
            }

            group(AuditTrail)
            {
                Caption = 'Audit Trail';

                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Last Modified Date"; Rec."Last Modified Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Last Modified By"; Rec."Last Modified By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
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
                    Message('Risk metrics updated successfully');
                end;
            }
            action(CalculateRiskScore)
            {
                ApplicationArea = All;
                Caption = 'Calculate Risk Score';
                Image = Calculate;
                PromotedCategory = Process;
                Promoted = true;

                trigger OnAction()
                begin
                    Rec.CalculateRiskScore();
                    Rec.Modify();
                    Message('Risk score calculated: %1', Rec."Risk Score");
                end;
            }
            action(MarkReviewed)
            {
                ApplicationArea = All;
                Caption = 'Mark as Reviewed';
                Image = Approve;
                PromotedCategory = Process;
                Promoted = true;

                trigger OnAction()
                begin
                    Rec."Last Review Date" := Today;
                    Rec.Modify();
                    Message('Customer profile marked as reviewed');
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
    }
}
