page 50817 "TransUnion Error Log List"
{
    // TransUnion Error Log List Page

    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "TransUnion Error Log";
    Caption = 'TransUnion Error Log';

    layout
    {
        area(Content)
        {
            repeater(ErrorEntries)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Account Number"; Rec."Account Number")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Error Date Time"; Rec."Error Date Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Resolved; Rec.Resolved)
                {
                    ApplicationArea = All;
                }

                field("Resolution Notes"; Rec."Resolution Notes")
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
            action("View Error Details")
            {
                ApplicationArea = All;
                Caption = 'View Error Details';
                ToolTip = 'View detailed error information';
                Image = ViewDetails;

                trigger OnAction()
                begin
                    ShowErrorDetails();
                end;
            }

            action("Mark as Resolved")
            {
                ApplicationArea = All;
                Caption = 'Mark as Resolved';
                ToolTip = 'Mark selected errors as resolved';
                Image = Approve;

                trigger OnAction()
                var
                    ResolutionNotes: Text[250];
                begin
                    if InputDialogText('Enter resolution notes:', ResolutionNotes) then begin
                        Rec.Resolved := true;
                        Rec."Resolution Notes" := ResolutionNotes;
                        Rec.Modify();
                        CurrPage.Update();
                    end;
                end;
            }

            action("Delete Resolved Entries")
            {
                ApplicationArea = All;
                Caption = 'Delete Resolved Entries';
                ToolTip = 'Delete all resolved error entries';
                Image = Delete;

                trigger OnAction()
                var
                    ErrorLog: Record "TransUnion Error Log";
                    DeleteCount: Integer;
                begin
                    ErrorLog.SetRange(Resolved, true);
                    DeleteCount := ErrorLog.Count;

                    if Confirm('Delete %1 resolved error entries?', false, DeleteCount) then begin
                        ErrorLog.DeleteAll();
                        Message('%1 resolved error entries deleted.', DeleteCount);
                        CurrPage.Update();
                    end;
                end;
            }
        }
    }

    local procedure ShowErrorDetails()
    var
        ErrorDetailsPage: Page "TransUnion Error Details";
    begin
        ErrorDetailsPage.SetErrorRecord(Rec);
        ErrorDetailsPage.RunModal();
    end;

    local procedure InputDialogText(Question: Text; var Value: Text): Boolean
    begin
        // This would normally use a proper input dialog
        // For now, we'll use a simple approach
        exit(true);
    end;
}