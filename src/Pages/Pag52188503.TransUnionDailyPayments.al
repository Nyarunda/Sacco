page 50808 "TransUnion Daily Payments"
{
    // TransUnion Daily Payment Information List

    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "TransUnion Daily Payment";
    Caption = 'TransUnion Daily Payment Information';

    layout
    {
        area(Content)
        {
            repeater(PaymentData)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Account Number"; Rec."Account Number")
                {
                    ApplicationArea = All;
                }

                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }

                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = All;
                }

                field("Snapshot Date"; Rec."Snapshot Date")
                {
                    ApplicationArea = All;
                }

                field("Client Type"; Rec."Client Type")
                {
                    ApplicationArea = All;
                }

                field(Surname; Rec.Surname)
                {
                    ApplicationArea = All;
                    Visible = IsIndividualClient;
                }

                field("Forename 1"; Rec."Forename 1")
                {
                    ApplicationArea = All;
                    Visible = IsIndividualClient;
                }

                field("Company Name"; Rec."Company Name")
                {
                    ApplicationArea = All;
                    Visible = IsCorporateClient;
                }

                field("Primary ID Doc Type"; Rec."Primary ID Doc Type")
                {
                    ApplicationArea = All;
                }

                field("Primary ID Doc Number"; Rec."Primary ID Doc Number")
                {
                    ApplicationArea = All;
                }

                field("Original Amount"; Rec."Original Amount")
                {
                    ApplicationArea = All;
                }

                field("Current Balance"; Rec."Current Balance")
                {
                    ApplicationArea = All;
                }

                field("Payment Amount"; Rec."Payment Amount")
                {
                    ApplicationArea = All;
                }

                field("Payment Date"; Rec."Payment Date")
                {
                    ApplicationArea = All;
                }

                field("Days in Arrears"; Rec."Days in Arrears")
                {
                    ApplicationArea = All;
                }

                field("Account Status"; Rec."Account Status")
                {
                    ApplicationArea = All;
                }

                field("Submission Status"; Rec."Submission Status")
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        ShowSubmissionDetails();
                    end;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Submit to TransUnion")
            {
                ApplicationArea = All;
                Caption = 'Submit to TransUnion';
                ToolTip = 'Submit selected records to TransUnion';
                Image = SendTo;

                trigger OnAction()
                var
                    TransUnionAPI: Codeunit "TransUnion API Integration";
                    SelectedRecords: Record "TransUnion Daily Payment";
                    SubmittedCount: Integer;
                    ErrorCount: Integer;
                begin
                    CurrPage.SetSelectionFilter(SelectedRecords);

                    if SelectedRecords.Count = 0 then begin
                        SelectedRecords.Copy(Rec);
                        SelectedRecords.SetRecFilter();
                    end;

                    if SelectedRecords.FindSet() then
                        repeat
                            if TransUnionAPI.SubmitDailyPaymentInformation(0, SelectedRecords) then begin
                                SelectedRecords."Submission Status" := SelectedRecords."Submission Status"::Submitted;
                                SelectedRecords."Submission Date Time" := CurrentDateTime;
                                SelectedRecords."Last Error Message" := '';
                                SubmittedCount += 1;
                            end else begin
                                SelectedRecords."Submission Status" := SelectedRecords."Submission Status"::Error;
                                ErrorCount += 1;
                            end;
                            SelectedRecords.Modify();
                        until SelectedRecords.Next() = 0;

                    Message('Submission completed.\Submitted: %1\Errors: %2', SubmittedCount, ErrorCount);
                    CurrPage.Update();
                end;
            }

            action("Generate from Loans")
            {
                ApplicationArea = All;
                Caption = 'Generate from Loan Data';
                ToolTip = 'Generate TransUnion records from existing loan data';
                Image = CreateDocument;

                trigger OnAction()
                var
                    GenerateDataReport: Report "Generate TransUnion Data";
                begin
                    GenerateDataReport.Run();
                    CurrPage.Update();
                end;
            }

            action("Validate Data")
            {
                ApplicationArea = All;
                Caption = 'Validate Data';
                ToolTip = 'Validate selected records before submission';
                Image = CheckRulesSyntax;

                trigger OnAction()
                var
                    ValidationErrors: Text;
                begin
                    ValidationErrors := ValidateRecord(Rec);
                    if ValidationErrors = '' then
                        Message('Record validation successful')
                    else
                        Message('Validation errors found:\%1', ValidationErrors);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IsIndividualClient := (Rec."Client Type" = 'A');
        IsCorporateClient := (Rec."Client Type" = 'B');
    end;

    var
        IsIndividualClient: Boolean;
        IsCorporateClient: Boolean;

    local procedure ShowSubmissionDetails()
    var
        DetailsMsg: Text;
    begin
        DetailsMsg := 'Submission Status: ' + Format(Rec."Submission Status");

        if Rec."Submission Date Time" <> 0DT then
            DetailsMsg += '\Submission Date: ' + Format(Rec."Submission Date Time");

        if Rec."TransUnion Callback ID" <> '' then
            DetailsMsg += '\Callback ID: ' + Rec."TransUnion Callback ID";

        if Rec."Last Error Message" <> '' then
            DetailsMsg += '\Last Error: ' + Rec."Last Error Message";

        Message(DetailsMsg);
    end;

    local procedure ValidateRecord(PaymentRec: Record "TransUnion Daily Payment"): Text
    var
        ErrorList: Text;
    begin
        // Validate mandatory fields
        if PaymentRec."Account Number" = '' then
            ErrorList += 'Account Number is required\';

        if PaymentRec."Primary ID Doc Type" = PaymentRec."Primary ID Doc Type"::" " then
            ErrorList += 'Primary ID Document Type is required\';

        if PaymentRec."Primary ID Doc Number" = '' then
            ErrorList += 'Primary ID Document Number is required\';

        if PaymentRec."Client Type" = '' then
            ErrorList += 'Client Type is required\';

        // Validate conditional fields
        if PaymentRec."Client Type" = 'A' then begin // Individual
            if PaymentRec.Surname = '' then
                ErrorList += 'Surname is required for individual clients\';
            if PaymentRec."Forename 1" = '' then
                ErrorList += 'First Name is required for individual clients\';
        end else if PaymentRec."Client Type" = 'B' then begin // Corporate
            if PaymentRec."Company Name" = '' then
                ErrorList += 'Company Name is required for corporate clients\';
        end;

        // Validate amounts
        if PaymentRec."Original Amount" <= 0 then
            ErrorList += 'Original Amount must be greater than zero\';

        if PaymentRec."Payment Amount" < 0 then
            ErrorList += 'Payment Amount cannot be negative\';

        // Validate dates
        if PaymentRec."Snapshot Date" = 0D then
            ErrorList += 'Snapshot Date is required\';

        if PaymentRec."Payment Date" = 0D then
            ErrorList += 'Payment Date is required\';

        exit(ErrorList);
    end;
}