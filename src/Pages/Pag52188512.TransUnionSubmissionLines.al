page 50812 "TransUnion Submission Lines"
{
    // TransUnion Submission Lines Page

    PageType = ListPart;
    SourceTable = "TransUnion Submission Line";
    Caption = 'TransUnion Submission Lines';
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Line number';
                }

                field("Submission Status"; Rec."Submission Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Status of this record submission';
                    StyleExpr = StatusStyleExpr;
                }

                field("Account Number"; Rec."Account Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Account number for this loan';
                }

                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Customer number';
                }

                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Loan number';
                }

                field("Client Type"; Rec."Client Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Client type (A=Individual, B=Corporate)';
                }

                field(Surname; Rec.Surname)
                {
                    ApplicationArea = All;
                    ToolTip = 'Surname for individual clients';
                }

                field("Forename 1"; Rec."Forename 1")
                {
                    ApplicationArea = All;
                    ToolTip = 'First forename';
                }

                field("Forename 2"; Rec."Forename 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Second forename';
                    Visible = false;
                }

                field("Forename 3"; Rec."Forename 3")
                {
                    ApplicationArea = All;
                    ToolTip = 'Third forename';
                    Visible = false;
                }

                field("Company Name"; Rec."Company Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Company name for corporate clients';
                }

                field("Primary ID Doc Type"; Rec."Primary ID Doc Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Primary identification document type';
                }

                field("Primary ID Doc Number"; Rec."Primary ID Doc Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Primary identification document number';
                }

                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Currency code for amounts';
                }

                field("Original Amount"; Rec."Original Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Original loan amount';
                }

                field("Payment Amount"; Rec."Payment Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Payment amount for this period';
                }

                field("Payment Date"; Rec."Payment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date of the payment';
                }

                field("Current Balance"; Rec."Current Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Current outstanding balance';
                }

                field("Installments in Arrears"; Rec."Installments in Arrears")
                {
                    ApplicationArea = All;
                    ToolTip = 'Number of installments in arrears';
                }

                field("Days in Arrears"; Rec."Days in Arrears")
                {
                    ApplicationArea = All;
                    ToolTip = 'Number of days in arrears';
                }

                field("Account Status"; Rec."Account Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Account status code';
                }

                field("Snapshot Date"; Rec."Snapshot Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date for which the data represents';
                }

                field("Submission Date Time"; Rec."Submission Date Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date and time when successfully submitted';
                    Editable = false;
                }

                field("Last Error Message"; Rec."Last Error Message")
                {
                    ApplicationArea = All;
                    ToolTip = 'Last error message if submission failed';
                    Editable = false;
                    Visible = ShowErrorMessages;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Submit Selected")
            {
                ApplicationArea = All;
                Caption = 'Submit Selected';
                ToolTip = 'Submit selected records to TransUnion';
                Image = SendTo;

                trigger OnAction()
                var
                    TransUnionLine: Record "TransUnion Submission Line";
                    SelectedCount: Integer;
                    SubmittedCount: Integer;
                    ErrorCount: Integer;
                begin
                    CurrPage.SetSelectionFilter(TransUnionLine);
                    SelectedCount := TransUnionLine.Count();

                    if SelectedCount = 0 then begin
                        Error('Please select records to submit.');
                    end;

                    if not Confirm('Submit %1 selected records to TransUnion?', false, SelectedCount) then
                        exit;

                    if TransUnionLine.FindSet() then
                        repeat
                            if SubmitSingleRecord(TransUnionLine) then
                                SubmittedCount += 1
                            else
                                ErrorCount += 1;
                        until TransUnionLine.Next() = 0;

                    Message('Submission completed.\Submitted: %1\Errors: %2', SubmittedCount, ErrorCount);
                    CurrPage.Update(false);
                end;
            }

            action("Validate Selected")
            {
                ApplicationArea = All;
                Caption = 'Validate Selected';
                ToolTip = 'Validate selected records';
                Image = CheckRulesSyntax;

                trigger OnAction()
                var
                    TransUnionLine: Record "TransUnion Submission Line";
                    ValidationErrors: Text;
                    ErrorCount: Integer;
                    TotalCount: Integer;
                begin
                    CurrPage.SetSelectionFilter(TransUnionLine);
                    TotalCount := TransUnionLine.Count();

                    if TotalCount = 0 then begin
                        Error('Please select records to validate.');
                    end;

                    if TransUnionLine.FindSet() then
                        repeat
                            ValidationErrors := ValidateRecord(TransUnionLine);
                            if ValidationErrors <> '' then begin
                                TransUnionLine."Last Error Message" := CopyStr(ValidationErrors, 1, MaxStrLen(TransUnionLine."Last Error Message"));
                                TransUnionLine."Submission Status" := TransUnionLine."Submission Status"::"Resubmit Required";
                                ErrorCount += 1;
                            end else begin
                                TransUnionLine."Last Error Message" := '';
                                if TransUnionLine."Submission Status" = TransUnionLine."Submission Status"::"Resubmit Required" then
                                    TransUnionLine."Submission Status" := TransUnionLine."Submission Status"::"Not Submitted";
                            end;
                            TransUnionLine.Modify();
                        until TransUnionLine.Next() = 0;

                    Message('Validation completed for %1 records.\Records with errors: %2', TotalCount, ErrorCount);
                    CurrPage.Update(false);
                end;
            }

            action("Delete Selected")
            {
                ApplicationArea = All;
                Caption = 'Delete Selected';
                ToolTip = 'Delete selected records that have not been submitted';
                Image = Delete;

                trigger OnAction()
                var
                    TransUnionLine: Record "TransUnion Submission Line";
                    SelectedCount: Integer;
                    DeletedCount: Integer;
                begin
                    CurrPage.SetSelectionFilter(TransUnionLine);
                    SelectedCount := TransUnionLine.Count();

                    if SelectedCount = 0 then begin
                        Error('Please select records to delete.');
                    end;

                    if not Confirm('Delete %1 selected records?', false, SelectedCount) then
                        exit;

                    if TransUnionLine.FindSet() then
                        repeat
                            if TransUnionLine."Submission Status" <> TransUnionLine."Submission Status"::Submitted then begin
                                TransUnionLine.Delete();
                                DeletedCount += 1;
                            end;
                        until TransUnionLine.Next() = 0;

                    Message('Deleted %1 records. Submitted records cannot be deleted.', DeletedCount);
                    CurrPage.Update(false);
                end;
            }
            action("Show Error Messages")
            {
                ApplicationArea = All;
                Caption = 'Show/Hide Error Messages';
                ToolTip = 'Toggle visibility of error message column';
                Image = ShowList;

                trigger OnAction()
                begin
                    ShowErrorMessages := not ShowErrorMessages;
                    CurrPage.Update(false);
                end;
            }

            action("View Line Errors")
            {
                ApplicationArea = All;
                Caption = 'View Detailed Errors';
                ToolTip = 'View detailed errors for selected line';
                Image = Error;

                trigger OnAction()
                var
                    ParsedErrorList: Page "TransUnion Parsed Error List";
                    ParsedError: Record "TransUnion Parsed Error";
                begin
                    ParsedError.SetRange("Account Number", Rec."Account Number");
                    ParsedErrorList.SetTableView(ParsedError);
                    ParsedErrorList.Run();
                end;
            }

        }
    }

    trigger OnAfterGetRecord()
    begin
        SetStatusStyle();
    end;

    var
        ShowErrorMessages: Boolean;
        StatusStyleExpr: Text;

    local procedure SetStatusStyle()
    begin
        case Rec."Submission Status" of
            Rec."Submission Status"::"Not Submitted":
                StatusStyleExpr := 'Standard';
            Rec."Submission Status"::Submitted:
                StatusStyleExpr := 'Favorable';
            Rec."Submission Status"::Error:
                StatusStyleExpr := 'Unfavorable';
            Rec."Submission Status"::"Resubmit Required":
                StatusStyleExpr := 'Attention';
            else
                StatusStyleExpr := 'Standard';
        end;
    end;

    local procedure SubmitSingleRecord(var TransUnionLine: Record "TransUnion Submission Line"): Boolean
    var
        TransUnionAPI: Codeunit "TransUnion API Integration";
        TempDailyPayment: Record "TransUnion Daily Payment" temporary;
    begin
        if TransUnionLine."Submission Status" = TransUnionLine."Submission Status"::Submitted then
            exit(true); // Already submitted

        // Convert line to daily payment format
        ConvertLineToDailyPayment(TransUnionLine, TempDailyPayment);

        if TransUnionAPI.SubmitDailyPaymentInformation(TransUnionLine."Header Entry No.", TempDailyPayment) then begin
            TransUnionLine."Submission Status" := TransUnionLine."Submission Status"::Submitted;
            TransUnionLine."Submission Date Time" := CurrentDateTime;
            TransUnionLine."Last Error Message" := '';
            TransUnionLine.Modify();
            exit(true);
        end else begin
            TransUnionLine."Submission Status" := TransUnionLine."Submission Status"::Error;
            TransUnionLine.Modify();
            exit(false);
        end;
        Commit();
    end;

    local procedure ConvertLineToDailyPayment(TransUnionLine: Record "TransUnion Submission Line"; var TempDailyPayment: Record "TransUnion Daily Payment" temporary)
    begin
        TempDailyPayment.Init();
        TempDailyPayment."Account Number" := TransUnionLine."Account Number";
        TempDailyPayment."Snapshot Date" := TransUnionLine."Snapshot Date";
        TempDailyPayment."Client Type" := TransUnionLine."Client Type";
        TempDailyPayment.Surname := TransUnionLine.Surname;
        TempDailyPayment."Forename 1" := TransUnionLine."Forename 1";
        TempDailyPayment."Forename 2" := TransUnionLine."Forename 2";
        TempDailyPayment."Forename 3" := TransUnionLine."Forename 3";
        TempDailyPayment."Company Name" := TransUnionLine."Company Name";
        TempDailyPayment."Primary ID Doc Type" := TransUnionLine."Primary ID Doc Type";
        TempDailyPayment."Primary ID Doc Number" := TransUnionLine."Primary ID Doc Number";
        TempDailyPayment."Currency Code" := TransUnionLine."Currency Code";
        TempDailyPayment."Original Amount" := TransUnionLine."Original Amount";
        TempDailyPayment."Payment Amount" := TransUnionLine."Payment Amount";
        TempDailyPayment."Payment Date" := TransUnionLine."Payment Date";
        TempDailyPayment."Current Balance" := TransUnionLine."Current Balance";
        TempDailyPayment."Installments in Arrears" := TransUnionLine."Installments in Arrears";
        TempDailyPayment."Days in Arrears" := TransUnionLine."Days in Arrears";
        TempDailyPayment."Account Status" := TransUnionLine."Account Status";
        TempDailyPayment."Customer No." := TransUnionLine."Customer No.";
        TempDailyPayment."Loan No." := TransUnionLine."Loan No.";
    end;

    local procedure ValidateRecord(var TransUnionLine: Record "TransUnion Submission Line"): Text
    var
        ErrorList: Text;
    begin
        if TransUnionLine."Account Number" = '' then
            ErrorList += 'Account Number is required; ';

        if TransUnionLine."Primary ID Doc Type" = TransUnionLine."Primary ID Doc Type"::" " then
            ErrorList += 'Primary ID Document Type is required; ';

        if TransUnionLine."Primary ID Doc Number" = '' then
            ErrorList += 'Primary ID Document Number is required; ';

        if TransUnionLine."Client Type" = '' then
            ErrorList += 'Client Type is required; ';

        if TransUnionLine."Client Type" = 'A' then begin // Individual
            if TransUnionLine.Surname = '' then
                ErrorList += 'Surname is required for individual clients; ';
            if TransUnionLine."Forename 1" = '' then
                ErrorList += 'First Name is required for individual clients; ';
        end else if TransUnionLine."Client Type" = 'B' then begin // Corporate
            if TransUnionLine."Company Name" = '' then
                ErrorList += 'Company Name is required for corporate clients; ';
        end;

        if TransUnionLine."Original Amount" <= 0 then
            ErrorList += 'Original Amount must be greater than zero; ';

        if TransUnionLine."Payment Amount" < 0 then
            ErrorList += 'Payment Amount cannot be negative; ';

        if TransUnionLine."Snapshot Date" = 0D then
            ErrorList += 'Snapshot Date is required; ';

        if TransUnionLine."Payment Date" = 0D then
            ErrorList += 'Payment Date is required; ';

        // Remove trailing semicolon and space
        if ErrorList <> '' then
            ErrorList := CopyStr(ErrorList, 1, StrLen(ErrorList) - 2);

        exit(ErrorList);
    end;
}