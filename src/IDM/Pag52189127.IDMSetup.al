page 50886 "IDM Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "IDM Setup";
    Caption = 'IDM Setup';
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Connection Settings';

                field(Enabled; Rec.Enabled)
                {
                    ApplicationArea = All;
                    ToolTip = 'Enable or disable the Calwide IDM API integration.';
                }
                field("Auto Verify ID No."; Rec."Auto Verify ID No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Automatically verify the National ID / Alien ID when it is entered on a Member Registration.';
                }
                field("Auto Verify KRA PIN"; Rec."Auto Verify KRA PIN")
                {
                    ApplicationArea = All;
                    ToolTip = 'Automatically verify the KRA PIN when it is entered on a Member Registration.';
                }
                field("Auto Verify Phone"; Rec."Auto Verify Phone")
                {
                    ApplicationArea = All;
                    ToolTip = 'Automatically verify the Mobile Phone Number when it is entered on a Member Registration.';
                }
                field("API Key"; Rec."API Key")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the X-API-Key provided by Calwide IDM.';
                    ShowMandatory = true;
                }
                field("Client ID"; Rec."Client ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter your Client UUID provided during onboarding (e.g. d77bf154-72bb-4bfe-982a-d8d76f3efdb3).';
                    ShowMandatory = true;
                }
                field("Base URL"; Rec."Base URL")
                {
                    ApplicationArea = All;
                    ToolTip = 'Calwide IDM API base URL. Default: https://idm.calwide.app/api/v1';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(TestConnection)
            {
                ApplicationArea = All;
                Caption = 'Test Connection';
                ToolTip = 'Test connectivity to the Calwide IDM API health endpoint.';
                Image = TestDatabase;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    HttpClient: HttpClient;
                    HttpResponseMessage: HttpResponseMessage;
                    ResponseText: Text;
                    ResponseJson: JsonObject;
                    JsonToken: JsonToken;
                    ApiStatus: Text;
                begin
                    if Rec."Base URL" = '' then
                        Error('Please enter the Base URL before testing the connection.');

                    if HttpClient.Get('https://idm.calwide.app/health', HttpResponseMessage) then begin
                        HttpResponseMessage.Content().ReadAs(ResponseText);
                        if ResponseJson.ReadFrom(ResponseText) then begin
                            if ResponseJson.Get('status', JsonToken) then
                                ApiStatus := JsonToken.AsValue().AsText();
                        end;
                        if ApiStatus = 'healthy' then
                            Message('✓ Connection successful. Calwide IDM API is healthy.')
                        else
                            Message('Connected but unexpected status: %1\Response: %2', ApiStatus, ResponseText);
                    end else
                        Error('Unable to connect to the IDM API. Please verify the Base URL and your network connectivity.');
                end;
            }
            action(VerificationLog)
            {
                ApplicationArea = All;
                Caption = 'View Verification Log';
                ToolTip = 'View all IDM verification log entries.';
                Image = Log;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "IDM Verification Log List";
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.Get('') then begin
            Rec.Init();
            Rec."Primary Key" := '';
            Rec."Base URL" := 'https://idm.calwide.app/api/v1';
            Rec.Insert();
        end;
    end;
}
