page 59982 "AML Transaction Monitor Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "AML Transaction Monitor";
    Caption = 'AML Transaction Monitor Card';

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
                field("Customer Risk Level"; Rec."Customer Risk Level")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group(Transaction)
            {
                Caption = 'Transaction Details';

                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Amount"; Rec."Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Counterparty"; Rec."Counterparty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Transaction Channel"; Rec."Transaction Channel")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group(Source)
            {
                Caption = 'Source Information';

                field("Source Table ID"; Rec."Source Table ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Source Entry No."; Rec."Source Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Source Document No."; Rec."Source Document No.")
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

            group(Risk)
            {
                Caption = 'Risk Assessment';

                field("Risk Score"; Rec."Risk Score")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Alert Generated"; Rec."Alert Generated")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Alert Type"; Rec."Alert Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Alert Description"; Rec."Alert Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                    MultiLine = true;
                }
            }

            group(Statistics)
            {
                Caption = 'Transaction Statistics';

                field("Daily Transaction Count"; Rec."Daily Transaction Count")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Daily Transaction Amount"; Rec."Daily Transaction Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Monthly Transaction Count"; Rec."Monthly Transaction Count")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Monthly Transaction Amount"; Rec."Monthly Transaction Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group(Tracking)
            {
                Caption = 'Creation Tracking';

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
            action(ViewSourceTransaction)
            {
                ApplicationArea = All;
                Caption = 'View Source Transaction';
                Image = ViewDetails;
                PromotedCategory = Process;
                Promoted = true;

                trigger OnAction()
                begin
                    if (Rec."Source Table ID" <> 0) and (Rec."Source Entry No." <> 0) then begin
                        Message('Source: Table ID %1, Entry No. %2, Document No. %3',
                                Rec."Source Table ID", Rec."Source Entry No.", Rec."Source Document No.");
                    end else
                        Message('No source transaction information available');
                end;
            }
        }
    }
}
