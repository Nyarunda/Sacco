page 50888 "IDM Verification Log Card"
{
    PageType = Card;
    SourceTable = "IDM Verification Log";
    Caption = 'IDM Verification Log Entry';
    Editable = false;

    layout
    {
        area(Content)
        {
            group(RequestDetails)
            {
                Caption = 'Request Details';

                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Unique log entry number.';
                }
                field("API Request ID"; Rec."API Request ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Unique request ID sent to the Calwide IDM API (used for idempotency).';
                }
                field("Verification Type"; Rec."Verification Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Type of verification performed.';
                }
                field(Identifier; Rec.Identifier)
                {
                    ApplicationArea = All;
                    ToolTip = 'Primary identifier verified (ID number, KRA PIN, plate number, etc.).';
                }
                field("Secondary Identifier"; Rec."Secondary Identifier")
                {
                    ApplicationArea = All;
                    ToolTip = 'Secondary value (e.g. phone number, bank code).';
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Member number linked to this verification.';
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Name of the linked member.';
                }
                field("Requested By"; Rec."Requested By")
                {
                    ApplicationArea = All;
                    ToolTip = 'User who initiated the verification.';
                }
                field("Request Date Time"; Rec."Request Date Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date and time the request was sent.';
                }
                field("Response Date Time"; Rec."Response Date Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date and time the API response was received.';
                }
                field("HTTP Status Code"; Rec."HTTP Status Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'HTTP status code returned by the API.';
                }
            }
            group(VerificationResult)
            {
                Caption = 'Verification Result';

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Overall verification outcome.';
                    StyleExpr = StatusStyle;
                }
                field("API Response Status"; Rec."API Response Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Raw status value from the API response (success / not_found / error).';
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Full name of the verified individual or entity.';
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date of birth returned from the verification.';
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                    ToolTip = 'Gender returned from the verification.';
                }
                field("Additional Info"; Rec."Additional Info")
                {
                    ApplicationArea = All;
                    ToolTip = 'Key information extracted from the verification response (e.g. citizenship, tax status, credit score).';
                }
                field("Error Code"; Rec."Error Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'API error code, if the verification failed.';
                }
                field("Error Message"; Rec."Error Message")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descriptive error message, if the verification failed.';
                    MultiLine = true;
                }
            }
            group(RawData)
            {
                Caption = 'Raw Request Data';

                field("Request JSON"; Rec."Request JSON")
                {
                    ApplicationArea = All;
                    ToolTip = 'JSON payload sent to the Calwide IDM API.';
                    MultiLine = true;
                }
                field("Response JSON"; Rec."Response JSON")
                {
                    ApplicationArea = All;
                    ToolTip = 'JSON payload received from the Calwide IDM API.';
                    MultiLine = true;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(DownloadPDF)
            {
                ApplicationArea = All;
                Caption = 'Download PDF Report';
                ToolTip = 'Download the credit report PDF returned from the API.';
                Image = Document;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = HasPDF;

                trigger OnAction()
                var
                    InStr: InStream;
                    FileName: Text;
                begin
                    Rec.CalcFields("PDF Report");
                    if not Rec."PDF Report".HasValue() then
                        Error('No PDF report available for this entry.');
                    Rec."PDF Report".CreateInStream(InStr);
                    FileName := StrSubstNo('CreditReport_%1.pdf', Rec."Entry No.");
                    DownloadFromStream(InStr, 'Download Credit Report', '', 'PDF Files (*.pdf)|*.pdf', FileName);
                end;
            }
            action(ViewResponseJSON)
            {
                ApplicationArea = All;
                Caption = 'View Response JSON';
                ToolTip = 'View the full JSON response stored for this verification entry.';
                Image = ViewDetails;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ResponseText: Text;
                begin
                    ResponseText := Rec."Response JSON";
                    if ResponseText = '' then
                        Message('No response JSON stored for this entry.')
                    else
                        Message(ResponseText);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        case Rec.Status of
            Rec.Status::Success:
                StatusStyle := 'Favorable';
            Rec.Status::Failed:
                StatusStyle := 'Unfavorable';
            Rec.Status::"Not Found":
                StatusStyle := 'Attention';
            else
                StatusStyle := 'Standard';
        end;
        Rec.CalcFields("PDF Report");
        HasPDF := Rec."PDF Report".HasValue();
    end;

    var
        StatusStyle: Text;
        HasPDF: Boolean;
}
