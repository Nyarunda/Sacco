page 59980 "AML Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "AML Setup";
    Caption = 'AML Setup';
    InsertAllowed = false;
    //DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General Settings';

                field("Primary Key"; Rec."Primary Key")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Enable Real Time Monitoring"; Rec."Enable Real Time Monitoring")
                {
                    ApplicationArea = All;
                }
                field("Auto Generate Alerts"; Rec."Auto Generate Alerts")
                {
                    ApplicationArea = All;
                }
                field("Send Email Notifications"; Rec."Send Email Notifications")
                {
                    ApplicationArea = All;
                }
            }

            group(Thresholds)
            {
                Caption = 'Transaction Thresholds';

                field("High Value Threshold (D)"; Rec."High Value Threshold (D)")
                {
                    ApplicationArea = All;
                }
                field("High Value Threshold (W)"; Rec."High Value Threshold (W)")
                {
                    ApplicationArea = All;
                }
                field("Cash Reporting Threshold (D)"; Rec."Cash Reporting Threshold (D)")
                {
                    ApplicationArea = All;
                }
                field("Cash Reporting Threshold (W)"; Rec."Cash Reporting Threshold (W)")
                {
                    ApplicationArea = All;
                }
                field("PEP Alert Threshold"; Rec."PEP Alert Threshold (D)")
                {
                    ApplicationArea = All;
                }
                field("PEP Alert Threshold (W)"; Rec."PEP Alert Threshold (W)")

                {
                    ApplicationArea = All;
                }
                field("Alert Risk Threshold"; Rec."Alert Risk Threshold")
                {
                    ApplicationArea = All;
                }
                field("Pattern Deviation Threshold"; Rec."Pattern Deviation Threshold")
                {
                    ApplicationArea = All;
                }
            }

            group(Limits)
            {
                Caption = 'Transaction Limits';

                field("Max Daily Transactions (D)"; Rec."Max Daily Transactions (D)")
                {
                    ApplicationArea = All;
                }
                field("Max Daily Transactions (W)"; Rec."Max Daily Transactions (W)")
                {
                    ApplicationArea = All;
                }
                field("Max Daily Amount (D)"; Rec."Max Daily Amount (D)")
                {
                    ApplicationArea = All;
                }
                field("Max Daily Amount (W)"; Rec."Max Daily Amount (W)")
                {
                    ApplicationArea = All;
                }
                field("Max Monthly Transactions (D)"; Rec."Max Monthly Transactions (D)")
                {
                    ApplicationArea = All;
                }
                field("Max Monthly Amount (D)"; Rec."Max Monthly Amount (D)")
                {
                    ApplicationArea = All;
                }
                field("Max Monthly Transactions (W)"; Rec."Max Monthly Transactions (W)")

                {
                    ApplicationArea = All;
                }
                field("Max Monthly Amount (W)"; Rec."Max Monthly Amount (W)")
                {
                    ApplicationArea = All;
                }
            }

            group(BusinessHours)
            {
                Caption = 'Business Hours';

                field("Business Hours Start"; Rec."Business Hours Start")
                {
                    ApplicationArea = All;
                }
                field("Business Hours End"; Rec."Business Hours End")
                {
                    ApplicationArea = All;
                }
            }

            group(Notifications)
            {
                Caption = 'Notification Settings';

                field("Compliance Officer Email"; Rec."Compliance Officer Email")
                {
                    ApplicationArea = All;
                }
                field("AML Manager Email"; Rec."AML Manager Email")
                {
                    ApplicationArea = All;
                }
            }

            group(Reporting)
            {
                Caption = 'Reporting Configuration';

                field("STR Report Path"; Rec."STR Report Path")
                {
                    ApplicationArea = All;
                }
                field("Archive Path"; Rec."Archive Path")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(TestNotification)
            {
                ApplicationArea = All;
                Caption = 'Test Notification';
                Image = TestFile;
                PromotedCategory = Process;
                Promoted = true;

                trigger OnAction()
                begin
                    if Rec."Compliance Officer Email" <> '' then
                        Message('Test notification would be sent to: %1', Rec."Compliance Officer Email")
                    else
                        Message('Please configure compliance officer email first');
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}
