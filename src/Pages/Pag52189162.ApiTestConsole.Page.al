page 50864 "API Test Console"
{
    PageType = Card;
    Caption = 'API Test Console';
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = Integer;
    SourceTableTemporary = true;

    layout
    {
        area(Content)
        {
            group(Setup)
            {
                Caption = 'Setup';

                field(ApiTarget; ApiTarget)
                {
                    ApplicationArea = All;
                    Caption = 'Target API';
                }

                field(LastRunAt; LastRunAt)
                {
                    ApplicationArea = All;
                    Caption = 'Last Run At';
                    Editable = false;
                }

                field(IsValidJson; IsValidJson)
                {
                    ApplicationArea = All;
                    Caption = 'Valid JSON';
                    Editable = false;
                }
            }

            group(Request)
            {
                Caption = 'Request';

                field(RequestJson; RequestJson)
                {
                    ApplicationArea = All;
                    Caption = 'Request JSON';
                    MultiLine = true;
                    ShowCaption = true;

                    trigger OnValidate()
                    begin
                        ValidateRequestJson();
                    end;
                }
            }

            group(Response)
            {
                Caption = 'Response';

                field(ResponseJson; ResponseJson)
                {
                    ApplicationArea = All;
                    Caption = 'Response JSON';
                    Editable = false;
                    MultiLine = true;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(RunRequest)
            {
                ApplicationArea = All;
                Caption = 'Run Request';
                Image = ExecuteBatch;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    ExecuteRequest();
                end;
            }

            action(ValidateJson)
            {
                ApplicationArea = All;
                Caption = 'Validate JSON';
                Image = CheckList;

                trigger OnAction()
                begin
                    ValidateRequestJson(true);
                end;
            }

            action(LoadMobileSample)
            {
                ApplicationArea = All;
                Caption = 'Load Mobile Sample';
                Image = Import;

                trigger OnAction()
                begin
                    LoadSample(ApiTarget::"Sky Mobile Banking Integration");
                end;
            }

            action(LoadPortalSample)
            {
                ApplicationArea = All;
                Caption = 'Load Portal Sample';
                Image = Import;

                trigger OnAction()
                begin
                    LoadSample(ApiTarget::"Sky Portal API");
                end;
            }

            action(ClearOutput)
            {
                ApplicationArea = All;
                Caption = 'Clear Response';
                Image = ClearLog;

                trigger OnAction()
                begin
                    ResponseJson := '';
                    CurrPage.Update(false);
                end;
            }

            action(ClearAll)
            {
                ApplicationArea = All;
                Caption = 'Clear All';
                Image = Delete;

                trigger OnAction()
                begin
                    RequestJson := '';
                    ResponseJson := '';
                    LastRunAt := 0DT;
                    IsValidJson := false;
                    CurrPage.Update(false);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.FindFirst() then begin
            Rec.Number := 1;
            Rec.Insert();
        end;

        if RequestJson = '' then
            LoadSample(ApiTarget::"Sky Mobile Banking Integration");
    end;

    var
        ApiTarget: Enum "API Test Target";
        RequestJson: Text;
        ResponseJson: Text;
        LastRunAt: DateTime;
        IsValidJson: Boolean;

        SkyMobileBanking: Codeunit "Sky Mobile Banking Integration";
        SkyPortal: Codeunit "Sky Portal";

    local procedure ExecuteRequest()
    begin
        if RequestJson = '' then
            Error('Request JSON cannot be empty.');

        ValidateRequestJson(true);

        ResponseJson := RunRequestSafe();
        LastRunAt := CurrentDateTime;
        CurrPage.Update(false);
    end;

    local procedure RunRequestSafe(): Text
    var
        ResultText: Text;
    begin
        ClearLastError();

        if not TryRunRequest(ResultText) then
            exit(GetExecutionErrorResponse());

        exit(ResultText);
    end;

    [TryFunction]
    local procedure TryRunRequest(var ResultText: Text)
    begin
        case ApiTarget of
            ApiTarget::"Sky Mobile Banking Integration":
                ResultText := SkyMobileBanking.HandleRequest(RequestJson);

            ApiTarget::"Sky Portal API":
                ResultText := SkyPortal.HandleRequest(RequestJson);

            else
                Error('Unsupported API target.');
        end;
    end;

    local procedure ValidateRequestJson()
    begin
        ValidateRequestJson(false);
    end;

    local procedure ValidateRequestJson(ShowMessage: Boolean)
    var
        RequestObject: JsonObject;
    begin
        IsValidJson := RequestObject.ReadFrom(RequestJson);

        if not IsValidJson then begin
            if ShowMessage then
                Error('The request is not valid JSON.');
        end else begin
            if ShowMessage then
                Message('JSON is valid.');
        end;
    end;

    local procedure LoadSample(Target: Enum "API Test Target")
    begin
        ApiTarget := Target;

        case Target of
            Target::"Sky Mobile Banking Integration":
                RequestJson := GetSkyMobileSample();

            Target::"Sky Portal API":
                RequestJson := GetSkyPortalSample();
        end;

        ResponseJson := '';
        LastRunAt := 0DT;
        ValidateRequestJson();
        CurrPage.Update(false);
    end;

    local procedure GetExecutionErrorResponse(): Text
    var
        ResponseObject: JsonObject;
        PayloadObject: JsonObject;
        ResponseText: Text;
    begin
        ResponseObject.Add('request_status', 'ERROR');
        ResponseObject.Add('request_status_description', 'Execution failed');

        PayloadObject.Add('error_message', GetLastErrorText());
        ResponseObject.Add('response_payload', PayloadObject);
        ResponseObject.Add('response_date_time', Format(CurrentDateTime, 0, 9));

        ResponseObject.WriteTo(ResponseText);
        exit(ResponseText);
    end;

    local procedure GetSkyMobileSample(): Text
    begin
        exit(
          '{"action":"ACCOUNT_FULL_STATEMENT",' +
          '"api_request_id":"df3e7cf5-1e4b-41ef-a22f-e755be665432",' +
          '"payload":{' +
          '"identifier_type":"CUSTOMER_NO",' +
          '"identifier":"009932",' +
          '"account_number":"S06-009932",' +
          '"start_date":"2025-01-01",' +
          '"end_date":"2026-04-22"' +
          '}}');
    end;

    local procedure GetSkyPortalSample(): Text
    begin
        exit(
          '{"action":"ACCOUNT_FULL_STATEMENT_PORTAL",' +
          '"api_request_id":"df3e7cf5-1e4b-41ef-a22f-e755be665432",' +
          '"payload":{' +
          '"identifier_type":"CUSTOMER_NO",' +
          '"identifier":"009932",' +
          '"account_number":"S06-009932",' +
          '"start_date":"2025-01-01",' +
          '"end_date":"2026-04-22"' +
          '}}');
    end;
}