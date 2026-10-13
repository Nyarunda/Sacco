page 59983 "AML Suspicious Activity List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "AML Suspicious Activity";
    Caption = 'AML Suspicious Activities';
    CardPageId = 59984;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Alert Type"; Rec."Alert Type")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                }
                field("Alert Date"; Rec."Alert Date")
                {
                    ApplicationArea = All;
                }
                field("Priority"; Rec."Priority")
                {
                    ApplicationArea = All;
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                }
                field("Transaction Amount"; Rec."Transaction Amount")
                {
                    ApplicationArea = All;
                }
                field("Risk Score"; Rec."Risk Score")
                {
                    ApplicationArea = All;
                }
                field("Assigned To"; Rec."Assigned To")
                {
                    ApplicationArea = All;
                }
                field("Auto Generated"; Rec."Auto Generated")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field("Reported to FRC"; Rec."Reported to FRC")
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
                    TransactionMonitorPage: Page "AML Transaction Monitor List";
                begin
                    if Rec."Transaction Monitor Entry" <> 0 then begin
                        TransactionMonitor.SetFilter("Entry No.", Format(Rec."Transaction Monitor Entry"));
                        TransactionMonitorPage.SetTableView(TransactionMonitor);
                        TransactionMonitorPage.RunModal();
                    end else
                        Message('No related transaction monitor entry found');
                end;
            }
            action(AssignToUser)
            {
                ApplicationArea = All;
                Caption = 'Assign to User';
                Image = Allocate;
                PromotedCategory = Process;
                Promoted = true;

                trigger OnAction()
                var
                    UserCode: Code[50];
                begin
                    UserCode := UserId;
                    if UserCode <> '' then begin
                        Rec.AssignToUser(UserCode);
                        Message('Alert assigned to %1', UserCode);
                    end;
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
}
