page 59981 "AML Transaction Monitor List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "AML Transaction Monitor";
    Caption = 'AML Transaction Monitor';
    CardPageId = "AML Transaction Monitor Card";
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
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = All;
                }
                field("Amount"; Rec."Amount")
                {
                    ApplicationArea = All;
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Risk Score"; Rec."Risk Score")
                {
                    ApplicationArea = All;
                }
                field("Alert Generated"; Rec."Alert Generated")
                {
                    ApplicationArea = All;
                }
                field("Alert Type"; Rec."Alert Type")
                {
                    ApplicationArea = All;
                }
                field("Alert Description"; Rec."Alert Description")
                {
                    ApplicationArea = All;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                }
                field("Transaction Channel"; Rec."Transaction Channel")
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
            action(GenerateAlert)
            {
                ApplicationArea = All;
                Caption = 'Generate Alert';
                Image = Documents;
                PromotedCategory = Process;
                Promoted = true;

                trigger OnAction()
                begin
                    if not Rec."Alert Generated" then begin
                        Rec."Alert Generated" := true;
                        Rec."Alert Type" := Rec."Alert Type"::HighValue;
                        Rec."Alert Description" := 'Manual alert generated for transaction monitoring';
                        Rec.Modify();
                        Message('Alert generated successfully');
                    end else
                        Message('Alert already generated for this transaction');
                end;
            }
            action(ViewRelatedAlerts)
            {
                ApplicationArea = All;
                Caption = 'View Related Alerts';
                Image = ViewDetails;
                PromotedCategory = Process;
                Promoted = true;

                trigger OnAction()
                var
                    SuspiciousActivity: Record "AML Suspicious Activity";
                    SuspiciousActivityPage: Page "AML Suspicious Activity List";
                begin
                    SuspiciousActivity.SetFilter("Transaction Monitor Entry", Format(Rec."Entry No."));
                    if SuspiciousActivity.FindSet() then begin
                        SuspiciousActivityPage.SetTableView(SuspiciousActivity);
                        SuspiciousActivityPage.RunModal();
                    end else
                        Message('No related alerts found for this transaction');
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
        // Set default filter to show recent transactions
        if Rec.GetFilters = '' then
            Rec.SetFilter("Transaction Date", '>=%1', CalcDate('<-1M>', Today));
    end;
}
