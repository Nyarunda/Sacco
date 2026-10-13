page 59984 "AML Suspicious Activity Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "AML Suspicious Activity";
    Caption = 'AML Suspicious Activity Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General Information';

                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Alert Type"; Rec."Alert Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
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
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Alert Date"; Rec."Alert Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Alert Time"; Rec."Alert Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Priority"; Rec."Priority")
                {
                    ApplicationArea = All;
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                }
                field("Auto Generated"; Rec."Auto Generated")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group(DescriptionInfo)
            {
                Caption = 'Description';

                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                }
                field("Detailed Description"; Rec."Detailed Description")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }

            group(TransactionDetails)
            {
                Caption = 'Related Transaction';

                field("Transaction Monitor Entry"; Rec."Transaction Monitor Entry")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Transaction Amount"; Rec."Transaction Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group(RiskAssessment)
            {
                Caption = 'Risk Assessment';

                field("Risk Score"; Rec."Risk Score")
                {
                    ApplicationArea = All;
                }
                field("Customer Risk Level"; Rec."Customer Risk Level")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group(Investigation)
            {
                Caption = 'Investigation Details';

                field("Assigned To"; Rec."Assigned To")
                {
                    ApplicationArea = All;
                }
                field("Investigation Notes"; Rec."Investigation Notes")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Resolution"; Rec."Resolution")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
            }

            group(Reporting)
            {
                Caption = 'Regulatory Reporting';

                field("Reported to FRC"; Rec."Reported to FRC")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("FRC Reference"; Rec."FRC Reference")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Report Date"; Rec."Report Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("External Reference"; Rec."External Reference")
                {
                    ApplicationArea = All;
                }
            }

            group(StatusTracking)
            {
                Caption = 'Status Tracking';

                field("Status Date"; Rec."Status Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Status Updated By"; Rec."Status Updated By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Closed Date"; Rec."Closed Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Closed By"; Rec."Closed By")
                {
                    ApplicationArea = All;
                    Editable = false;
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
            action(ViewCustomerRiskProfile)
            {
                ApplicationArea = All;
                Caption = 'Customer Risk Profile';
                Image = Customer;
                PromotedCategory = Process;
                Promoted = true;

                trigger OnAction()
                var
                    CustomerRisk: Record "AML Customer Risk Profile";
                    CustomerRiskPage: Page "AML Customer Risk Profile Card";
                begin
                    CustomerRisk.SetFilter("Customer No.", Rec."Customer No.");
                    if CustomerRisk.FindFirst() then begin
                        CustomerRiskPage.SetRecord(CustomerRisk);
                        CustomerRiskPage.RunModal();
                    end else
                        Message('No risk profile found for customer %1', Rec."Customer No.");
                end;
            }
            action(ViewTransactionMonitor)
            {
                ApplicationArea = All;
                Caption = 'View Transaction Monitor';
                Image = ViewDetails;
                PromotedCategory = Process;
                Promoted = true;

                trigger OnAction()
                var
                    TransactionMonitor: Record "AML Transaction Monitor";
                    TransactionMonitorPage: Page "AML Transaction Monitor Card";
                begin
                    if Rec."Transaction Monitor Entry" <> 0 then begin
                        if TransactionMonitor.Get(Rec."Transaction Monitor Entry") then begin
                            TransactionMonitorPage.SetRecord(TransactionMonitor);
                            TransactionMonitorPage.RunModal();
                        end;
                    end else
                        Message('No related transaction monitor entry found');
                end;
            }
            action(AssignToMe)
            {
                ApplicationArea = All;
                Caption = 'Assign to Me';
                Image = Allocate;
                PromotedCategory = Process;
                Promoted = true;

                trigger OnAction()
                begin
                    Rec.AssignToUser(UserId);
                    Message('Alert assigned to you');
                end;
            }
            action(EscalateToManagement)
            {
                ApplicationArea = All;
                Caption = 'Escalate to Management';
                Image = Hierarchy;
                PromotedCategory = Process;
                Promoted = true;

                trigger OnAction()
                begin
                    Rec.EscalateToManagement();
                    Message('Case escalated to management');
                end;
            }
            action(ReportToAuthorities)
            {
                ApplicationArea = All;
                Caption = 'Report to FRC';
                Image = SendTo;
                PromotedCategory = Process;
                Promoted = true;

                trigger OnAction()
                var
                    FRCRef: Code[50];
                begin
                    FRCRef := 'FRC' + Format(Rec."Entry No.") + Format(Today, 0, '<Day,2><Month,2><Year4>');
                    Rec.ReportToAuthorities(FRCRef);
                    Message('Case reported to FRC with reference: %1', FRCRef);
                end;
            }
            action(MarkAsFalsePositive)
            {
                ApplicationArea = All;
                Caption = 'Mark as False Positive';
                Image = Close;
                PromotedCategory = Process;
                Promoted = true;

                trigger OnAction()
                begin
                    Rec.MarkAsFalsePositive('Investigated and determined to be false positive');
                    Message('Case marked as false positive');
                end;
            }
            action(CloseCase)
            {
                ApplicationArea = All;
                Caption = 'Close Case';
                Image = Close;
                PromotedCategory = Process;
                Promoted = true;

                trigger OnAction()
                begin
                    Rec.CloseCase('Case investigation completed');
                    Message('Case has been closed');
                end;
            }
        }
    }
}
