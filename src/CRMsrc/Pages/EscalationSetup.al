
// Escalation Setup Page
page 50524 "Escalation Setup"
{
    ApplicationArea = All;
    Caption = 'Escalation Setup';
    PageType = Card;
    SourceTable = "Escalation Setup";
    UsageCategory = Administration;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Enable Escalations"; Rec."Enable Escalations")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether escalations are enabled.';
                }
                field("Default Email Template"; Rec."Default Email Template")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the default email template for escalations.';
                }
                field("Log All Escalations"; Rec."Log All Escalations")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether all escalations should be logged.';
                }
            }
            group("Business Hours")
            {
                Caption = 'Business Hours';
                field("Business Hours Start"; Rec."Business Hours Start")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when business hours start.';
                }
                field("Business Hours End"; Rec."Business Hours End")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when business hours end.';
                }
            }
            group(Limits)
            {
                Caption = 'Limits';
                field("Max Escalations Per Hour"; Rec."Max Escalations Per Hour")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the maximum number of escalations allowed per hour.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.Get() then begin
            Rec.Init();
            Rec."Primary Key" := '';
            Rec.Insert();
        end;
    end;
}