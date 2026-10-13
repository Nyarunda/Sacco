page 50810 "TransUnion Error Details"
{
    // TransUnion Error Details Page - Shows detailed JSON error information

    PageType = Card;
    ApplicationArea = All;
    SourceTable = "TransUnion Error Log";
    Caption = 'TransUnion Error Details';
    Editable = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Error Information';

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
            }

            group("ErrorDetails")
            {
                Caption = 'Error Details';

                field("Error Details"; Rec."Error Details")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    Editable = false;
                    ToolTip = 'Raw JSON error details from TransUnion API';
                }
            }

            group("Parsed Errors")
            {
                Caption = 'Parsed Error Information';

                part("Error List"; "TransUnion Parsed Errors")
                {
                    ApplicationArea = All;
                    SubPageLink = "Parent Entry No." = field("Entry No.");
                }
            }

            group(Resolution)
            {
                Caption = 'Resolution';

                field(Resolved; Rec.Resolved)
                {
                    ApplicationArea = All;
                }

                field("Resolution Notes"; Rec."Resolution Notes")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Parse Errors")
            {
                ApplicationArea = All;
                Caption = 'Parse Error Details';
                ToolTip = 'Parse JSON error details into structured format';
                Image = Import;

                trigger OnAction()
                begin
                    ParseErrorDetails();
                    CurrPage.Update(true);
                end;
            }

            action("Copy Error Text")
            {
                ApplicationArea = All;
                Caption = 'Copy Error Text';
                ToolTip = 'Copy error details to clipboard';
                Image = Copy;

                trigger OnAction()
                begin
                    // In a real implementation, you would copy to clipboard
                    Message('Error details:\%1', Rec."Error Details");
                end;
            }

            action("Mark Resolved")
            {
                ApplicationArea = All;
                Caption = 'Mark as Resolved';
                ToolTip = 'Mark this error as resolved';
                Image = Approve;

                trigger OnAction()
                begin
                    Rec.Resolved := true;
                    if Rec."Resolution Notes" = '' then
                        Rec."Resolution Notes" := 'Manually marked as resolved on ' + Format(CurrentDateTime);
                    Rec.Modify();
                    CurrPage.Update();
                end;
            }
        }
    }

    /// <summary>
    /// Sets the error record to display
    /// </summary>
    /// <param name="ErrorRecord">Error log record to display</param>
    procedure SetErrorRecord(ErrorRecord: Record "TransUnion Error Log")
    begin
        Rec := ErrorRecord;
        CurrPage.Update(false);
    end;

    local procedure ParseErrorDetails()
    var
        JsonObject: JsonObject;
        JsonArray: JsonArray;
        JsonToken: JsonToken;
        ErrorToken: JsonToken;
        ParsedError: Record "TransUnion Parsed Error";
        i: Integer;
        AccountNumber: Text;
        ErrorMessage: Text;
        FieldName: Text;
        FieldValue: Text;
        ErrorCode: Text;
    begin
        // Clear existing parsed errors
        ParsedError.SetRange("Parent Entry No.", Rec."Entry No.");
        ParsedError.DeleteAll();

        // Try to parse the JSON error details
        if not JsonObject.ReadFrom(Rec."Error Details") then
            exit;

        // Look for recordErrors array
        if not JsonObject.Get('recordErrors', JsonToken) then
            exit;

        if not JsonToken.IsValue or JsonToken.AsValue().IsNull then
            exit;

        JsonArray := JsonToken.AsArray();

        for i := 0 to JsonArray.Count - 1 do begin
            JsonArray.Get(i, ErrorToken);
            if ErrorToken.IsObject then begin
                JsonObject := ErrorToken.AsObject();

                // Extract error fields
                AccountNumber := GetJsonText(JsonObject, 'accountNumber');
                ErrorMessage := GetJsonText(JsonObject, 'errorMessage');
                FieldName := GetJsonText(JsonObject, 'fieldName');
                FieldValue := GetJsonText(JsonObject, 'fieldValue');
                ErrorCode := GetJsonText(JsonObject, 'errorCode');

                // Create parsed error record
                ParsedError.Init();
                ParsedError."Parent Entry No." := Rec."Entry No.";
                ParsedError."Line No." := i + 1;
                ParsedError."Account Number" := CopyStr(AccountNumber, 1, MaxStrLen(ParsedError."Account Number"));
                ParsedError."Field Name" := CopyStr(FieldName, 1, MaxStrLen(ParsedError."Field Name"));
                ParsedError."Field Value" := CopyStr(FieldValue, 1, MaxStrLen(ParsedError."Field Value"));
                ParsedError."Error Message" := CopyStr(ErrorMessage, 1, MaxStrLen(ParsedError."Error Message"));
                ParsedError."Error Code" := CopyStr(ErrorCode, 1, MaxStrLen(ParsedError."Error Code"));
                ParsedError.Insert();
            end;
        end;

        Message('Parsed %1 error details', JsonArray.Count);
    end;

    local procedure GetJsonText(JsonObj: JsonObject; PropertyName: Text): Text
    var
        JsonToken: JsonToken;
    begin
        if JsonObj.Get(PropertyName, JsonToken) then
            if not JsonToken.AsValue().IsNull then
                exit(JsonToken.AsValue().AsText());
        exit('');
    end;
}