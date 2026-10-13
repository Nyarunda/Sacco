page 50806 "TransUnion Setup"
{
    // TransUnion Kenya API Configuration Page

    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "TransUnion Setup";
    Caption = 'TransUnion Setup';
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General Settings';

                field("Infinity Code"; Rec."Infinity Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the Infinity Code provided by TransUnion Kenya';
                    ShowMandatory = true;
                }

                field(Username; Rec.Username)
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter your TransUnion username';
                    ShowMandatory = true;
                }

                field(Password; Rec.Password)
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter your TransUnion password';
                    ShowMandatory = true;
                }

                field("Base URL"; Rec."Base URL")
                {
                    ApplicationArea = All;
                    ToolTip = 'TransUnion API base URL';
                }

                field("Test Mode"; Rec."Test Mode")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enable this for testing environment';
                }
            }

            group("Token Information")
            {
                Caption = 'Authentication Token Information';

                field("Last Token Generated"; Rec."Last Token Generated")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date and time when authentication token was last generated';
                }

                field("Token Expiry"; Rec."Token Expiry")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date and time when current token expires';
                }
            }

            group("Auto Submission")
            {
                Caption = 'Automatic Submission Settings';

                field("Auto Submit"; Rec."Auto Submit")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enable automatic daily submission of payment information';
                }

                field("Submit Time"; Rec."Submit Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Time of day to automatically submit data';
                    Enabled = Rec."Auto Submit";
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Test Connection")
            {
                ApplicationArea = All;
                Caption = 'Test Connection';
                ToolTip = 'Test the connection to TransUnion API';
                Image = TestDatabase;

                trigger OnAction()
                var
                    TransUnionAPI: Codeunit "TransUnion API Integration";
                begin
                    if TransUnionAPI.TestConnection() then
                        Message('Connection to TransUnion API successful!')
                    else
                        Message('Failed to connect to TransUnion API. Please check your settings.');
                end;
            }

            action("Generate Token")
            {
                ApplicationArea = All;
                Caption = 'Generate New Token';
                ToolTip = 'Generate a new authentication token';
                Image = Certificate;

                trigger OnAction()
                var
                    TransUnionAPI: Codeunit "TransUnion API Integration";
                begin
                    if TransUnionAPI.GenerateNewToken() then begin
                        CurrPage.Update();
                        Message('New authentication token generated successfully.');
                    end else
                        Error('Failed to generate authentication token.');
                end;
            }

            action("View API Log")
            {
                ApplicationArea = All;
                Caption = 'View API Log';
                ToolTip = 'View TransUnion API submission log';
                Image = Log;
                RunObject = page "TransUnion API Log List";
            }

            action("View Error Log")
            {
                ApplicationArea = All;
                Caption = 'View Error Log';
                ToolTip = 'View TransUnion API error log';
                Image = ErrorLog;
                RunObject = page "TransUnion Error Log List";
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec."Primary Key" := '';
            Rec.Insert();
        end;
    end;
}