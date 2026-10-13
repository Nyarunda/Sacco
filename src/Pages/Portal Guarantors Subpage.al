page 50793 "Portal Guarantors Subpage"
{
    PageType = ListPart;
    SourceTable = "Mobile Loan Guarantors";
    ApplicationArea = All;
    Caption = 'Loan Guarantors';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Guarantor Member No."; Rec."Guarantor Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the guarantor member number.';
                }
                field("Guarantor Name"; Rec."Guarantor Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the guarantor name.';
                }
                field("Guarantor Mobile No."; Rec."Guarantor Mobile No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the guarantor mobile number.';
                }
                field("Amount Guaranteed"; Rec."Amount Guaranteed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the amount guaranteed.';
                    StyleExpr = 'Strong';
                }
                field("Guarantor Accepted"; Rec."Guarantor Accepted")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the guarantor has accepted.';
                    StyleExpr = AcceptanceStyle;
                }
                field("Guarantor Response Date"; Rec."Guarantor Response Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the guarantor responded.';
                }
                field("Loan Status"; Rec."Loan Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the current loan status.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(SendRequest)
            {
                Caption = 'Send Guarantor Request';
                ApplicationArea = All;
                Image = SendMail;
                ToolTip = 'Send guarantor request to the member.';

                trigger OnAction()
                begin
                    if Rec."Guarantor Mobile No." <> '' then begin
                        // Send SMS or notification logic here
                        Message('Guarantor request sent to %1', Rec."Guarantor Name");
                    end else
                        Error('No mobile number available for guarantor');
                end;
            }
            action(ViewGuarantor)
            {
                Caption = 'View Guarantor Details';
                ApplicationArea = All;
                Image = Customer;
                ToolTip = 'View guarantor member details.';
                RunObject = page "Member Card";
                RunPageLink = "No." = field("Guarantor Member No.");
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetAcceptanceStyle();
    end;

    local procedure SetAcceptanceStyle()
    begin
        case Rec."Guarantor Accepted" of
            Rec."Guarantor Accepted"::Yes:
                AcceptanceStyle := 'Favorable';
            Rec."Guarantor Accepted"::No:
                AcceptanceStyle := 'Unfavorable';
            Rec."Guarantor Accepted"::Pending:
                AcceptanceStyle := 'StandardAccent';
        end;
    end;

    var
        AcceptanceStyle: Text;
}