page 50809 "TransUnion Parsed Error List"
{
    // TransUnion Parsed Error List Page

    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "TransUnion Parsed Error";
    Caption = 'TransUnion Parsed Errors';
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Parent Entry No."; Rec."Parent Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Reference to the main error log entry';
                }

                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Line number within the parent error log';
                }

                field("Account Number"; Rec."Account Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Account number that had the validation error';
                }

                field("Field Name"; Rec."Field Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Name of the field that failed validation';
                }

                field("Field Value"; Rec."Field Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Value that caused the validation error';
                }

                field("Error Code"; Rec."Error Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'TransUnion error code';
                }

                field("Error Message"; Rec."Error Message")
                {
                    ApplicationArea = All;
                    ToolTip = 'Detailed error message from TransUnion';
                }

                field("Resolution Suggestion"; Rec."Resolution Suggestion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Suggested resolution for this error';
                    Style = Attention;
                }
            }
        }

        area(FactBoxes)
        {
            part("Error Details"; "TransUnionError Detail FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Parent Entry No." = field("Parent Entry No."), "Line No." = field("Line No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Group by Field")
            {
                ApplicationArea = All;
                Caption = 'Group by Field';
                ToolTip = 'Group errors by field name to see common issues';
                Image = Group;

                trigger OnAction()
                begin
                    ShowGroupedByField();
                end;
            }

            action("Group by Error Code")
            {
                ApplicationArea = All;
                Caption = 'Group by Error Code';
                ToolTip = 'Group errors by TransUnion error code';
                Image = ErrorLog;

                trigger OnAction()
                begin
                    ShowGroupedByErrorCode();
                end;
            }

        }

        area(Navigation)
        {
            action("View Parent Error")
            {
                ApplicationArea = All;
                Caption = 'View Parent Error Log';
                ToolTip = 'View the main error log entry';
                Image = Log;

                trigger OnAction()
                var
                    ErrorLog: Record "TransUnion Error Log";
                    ErrorLogPage: Page "TransUnion Error Log List";
                begin
                    if ErrorLog.Get(Rec."Parent Entry No.") then begin
                        ErrorLogPage.SetRecord(ErrorLog);
                        ErrorLogPage.Run();
                    end;
                end;
            }

            action("Find Account Records")
            {
                ApplicationArea = All;
                Caption = 'Find Account Records';
                ToolTip = 'Find all records for this account number';
                Image = Find;

                trigger OnAction()
                var
                    DailyPayment: Record "TransUnion Daily Payment";
                    DailyPaymentPage: Page "TransUnion Daily Payments";
                begin
                    DailyPayment.SetRange("Account Number", Rec."Account Number");
                    DailyPaymentPage.SetTableView(DailyPayment);
                    DailyPaymentPage.Run();
                end;
            }
        }

        area(Reporting)
        {
            action("Error Summary Report")
            {
                ApplicationArea = All;
                Caption = 'Error Summary Report';
                ToolTip = 'Generate summary report of validation errors';
                Image = Report;

                trigger OnAction()
                begin
                    Message('Error Summary Report functionality can be added based on your reporting requirements.');
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        // Set default sorting by account number and field name for better readability
        Rec.SetCurrentKey("Account Number", "Field Name");
    end;

    local procedure ShowGroupedByField()
    var
        TempParsedError: Record "TransUnion Parsed Error" temporary;
        ParsedError: Record "TransUnion Parsed Error";
        FieldSummary: Text;
        CurrentField: Text;
        ErrorCount: Integer;
    begin
        ParsedError.CopyFilters(Rec);
        ParsedError.SetCurrentKey("Field Name", "Account Number");

        if ParsedError.FindSet() then begin
            repeat
                if CurrentField <> ParsedError."Field Name" then begin
                    if CurrentField <> '' then
                        FieldSummary += StrSubstNo('%1: %2 errors\', CurrentField, ErrorCount);
                    CurrentField := ParsedError."Field Name";
                    ErrorCount := 1;
                end else
                    ErrorCount += 1;
            until ParsedError.Next() = 0;

            if CurrentField <> '' then
                FieldSummary += StrSubstNo('%1: %2 errors', CurrentField, ErrorCount);
        end;

        Message('Field Error Summary:\%1', FieldSummary);
    end;

    local procedure ShowGroupedByErrorCode()
    var
        ParsedError: Record "TransUnion Parsed Error";
        CodeSummary: Text;
        CurrentCode: Code[20];
        ErrorCount: Integer;
    begin
        ParsedError.CopyFilters(Rec);
        ParsedError.SetCurrentKey("Error Code", "Account Number");

        if ParsedError.FindSet() then begin
            repeat
                if CurrentCode <> ParsedError."Error Code" then begin
                    if CurrentCode <> '' then
                        CodeSummary += StrSubstNo('%1: %2 errors\', CurrentCode, ErrorCount);
                    CurrentCode := ParsedError."Error Code";
                    ErrorCount := 1;
                end else
                    ErrorCount += 1;
            until ParsedError.Next() = 0;

            if CurrentCode <> '' then
                CodeSummary += StrSubstNo('%1: %2 errors', CurrentCode, ErrorCount);
        end;

        Message('Error Code Summary:\%1', CodeSummary);
    end;

}