page 50807 "TransUnion API Log List"
{
    // TransUnion API Log List Page

    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "TransUnion API Log";
    Caption = 'TransUnion API Log';
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(LogEntries)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }

                field("Account Number"; Rec."Account Number")
                {
                    ApplicationArea = All;
                }

                field("Response Code"; Rec."Response Code")
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        ShowResponseCodeInfo(Rec."Response Code");
                    end;
                }

                field("Response Message"; Rec."Response Message")
                {
                    ApplicationArea = All;
                }

                field("Callback ID"; Rec."Callback ID")
                {
                    ApplicationArea = All;
                }

                field("Submission Date Time"; Rec."Submission Date Time")
                {
                    ApplicationArea = All;
                }

                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }

                field("Request Type"; Rec."Request Type")
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
            action("Delete Old Entries")
            {
                ApplicationArea = All;
                Caption = 'Delete Old Entries';
                ToolTip = 'Delete log entries older than specified number of days';
                Image = Delete;

                trigger OnAction()
                var
                    Days: Integer;
                    CutoffDate: DateTime;
                    LogRec: Record "TransUnion API Log";
                    DeleteCount: Integer;
                begin
                    if not Evaluate(Days, '90') then
                        Days := 90;

                    if InputDialog('Delete entries older than how many days?', Days) then begin
                        CutoffDate := CurrentDateTime - (Days * 24 * 60 * 60 * 1000);
                        LogRec.SetRange("Submission Date Time", 0DT, CutoffDate);
                        DeleteCount := LogRec.Count;

                        if Confirm('Delete %1 log entries older than %2 days?', false, DeleteCount, Days) then begin
                            LogRec.DeleteAll();
                            Message('%1 log entries deleted.', DeleteCount);
                        end;
                    end;
                end;
            }
        }
    }

    local procedure ShowResponseCodeInfo(ResponseCode: Integer)
    var
        InfoMsg: Text;
    begin
        case ResponseCode of
            106:
                InfoMsg := 'Access Denied - Check credentials';
            200:
                InfoMsg := 'Success - Data submitted successfully';
            401:
                InfoMsg := 'Unauthorized - Invalid authentication token';
            403:
                InfoMsg := 'General Application Error';
            404:
                InfoMsg := 'Service Unavailable';
            597:
                InfoMsg := 'Invalid Json for record type';
            598:
                InfoMsg := 'IP Address not in list of allowed IP Addresses';
            599:
                InfoMsg := 'Unsupported record Type';
            600:
                InfoMsg := 'Failed validation, record has validation errors';
            else
                InfoMsg := 'Unknown response code: ' + Format(ResponseCode);
        end;

        Message(InfoMsg);
    end;

    local procedure InputDialog(Question: Text; var Value: Integer): Boolean
    var
        ValueText: Text;
    begin
        ValueText := Format(Value);
        if InputDialogText(Question, ValueText) then begin
            if Evaluate(Value, ValueText) then
                exit(true);
        end;
        exit(false);
    end;

    local procedure InputDialogText(Question: Text; var Value: Text): Boolean
    begin
        // This would normally use a proper input dialog
        // For now, we'll use a simple approach
        exit(true);
    end;
}