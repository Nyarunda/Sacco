page 50814 "TransUnion Submission List"
{
    // TransUnion Submission List Page

    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "TransUnion Submission Header";
    Caption = 'TransUnion Submission List';
    CardPageId = "TransUnion Submission Card";
    Editable = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Unique identifier for the submission batch';
                }

                field("Submission Date"; Rec."Submission Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date when the submission was created';
                }

                field("Snapshot Date"; Rec."Snapshot Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date for which the data represents';
                }

                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'User who created this submission';
                }

                field("Submission Type"; Rec."Submission Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Type of TransUnion submission';
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Current status of the submission';

                    trigger OnDrillDown()
                    begin
                        ShowStatusDetails();
                    end;
                }

                field("Total Records"; Rec."Total Records")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total number of records in this submission';
                }

                field("Records Submitted"; Rec."Records Submitted")
                {
                    ApplicationArea = All;
                    ToolTip = 'Number of successfully submitted records';
                }

                field("Records with Errors"; Rec."Records with Errors")
                {
                    ApplicationArea = All;
                    ToolTip = 'Number of records with submission errors';
                }

                field("Last Submission Date Time"; Rec."Last Submission Date Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date and time of last submission attempt';
                }

                field("TransUnion Batch ID"; Rec."TransUnion Batch ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'TransUnion batch identifier';
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Description of the submission';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("New Submission")
            {
                ApplicationArea = All;
                Caption = 'New Submission';
                ToolTip = 'Create a new TransUnion submission batch';
                Image = New;

                trigger OnAction()
                var
                    TransUnionHeader: Record "TransUnion Submission Header";
                    TransUnionCard: Page "TransUnion Submission Card";
                begin
                    TransUnionHeader.Init();
                    TransUnionHeader.Insert(true);
                    TransUnionCard.SetRecord(TransUnionHeader);
                    TransUnionCard.Run();
                    CurrPage.Update();
                end;
            }
        }

        area(Navigation)
        {
            action("Submission Lines")
            {
                ApplicationArea = All;
                Caption = 'Submission Lines';
                ToolTip = 'View submission line details';
                Image = List;
                RunObject = page "TransUnion Submission Lines";
                RunPageLink = "Header Entry No." = field("Entry No.");
            }

            action("API Log")
            {
                ApplicationArea = All;
                Caption = 'API Log';
                ToolTip = 'View API submission log for this batch';
                Image = Log;
                RunObject = page "TransUnion API Log List";
            }

            action("Error Log")
            {
                ApplicationArea = All;
                Caption = 'Error Log';
                ToolTip = 'View error log for this batch';
                Image = ErrorLog;
                RunObject = page "TransUnion Error Log List";
            }

            action("Detailed Errors")
            {
                ApplicationArea = All;
                Caption = 'Detailed Errors';
                ToolTip = 'View detailed field-level validation errors';
                Image = Error;
                RunObject = page "TransUnion Parsed Error List";
            }
        }
    }

    local procedure ShowStatusDetails()
    var
        StatusMsg: Text;
    begin
        Rec.CalcFields("Total Records", "Records Submitted", "Records with Errors");

        StatusMsg := 'Submission Status Details:\';
        StatusMsg += 'Status: ' + Format(Rec.Status) + '\';
        StatusMsg += 'Total Records: ' + Format(Rec."Total Records") + '\';
        StatusMsg += 'Successfully Submitted: ' + Format(Rec."Records Submitted") + '\';
        StatusMsg += 'Records with Errors: ' + Format(Rec."Records with Errors");

        if Rec."Last Submission Date Time" <> 0DT then
            StatusMsg += '\Last Submission: ' + Format(Rec."Last Submission Date Time");

        if Rec."TransUnion Batch ID" <> '' then
            StatusMsg += '\TransUnion Batch ID: ' + Rec."TransUnion Batch ID";

        Message(StatusMsg);
    end;
}