page 50813 "TransUnion Submission Card"
{
    // TransUnion Submission Card Page

    PageType = Card;
    SourceTable = "TransUnion Submission Header";
    Caption = 'TransUnion Submission Card';
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General Information';

                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Unique identifier for the submission batch';
                }

                field("Submission Date"; Rec."Submission Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date when the submission was created';
                }

                field("Snapshot Date"; Rec."Snapshot Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date for which the data represents';
                    NotBlank = true;
                }

                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'User who created this submission';
                }

                field("Creation Date Time"; Rec."Creation Date Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Date and time when submission was created';
                }

                field("Submission Type"; Rec."Submission Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Type of TransUnion submission';
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Description of the submission';
                }
            }

            group(Filters)
            {
                Caption = 'Generation Filters';

                field("Account Category Filter"; Rec."Account Category Filter")
                {
                    ApplicationArea = All;
                    ToolTip = 'Filter by account category when generating records';
                }

                field("Date Filter From"; Rec."Date Filter From")
                {
                    ApplicationArea = All;
                    ToolTip = 'Start date for filtering loan data';
                }

                field("Date Filter To"; Rec."Date Filter To")
                {
                    ApplicationArea = All;
                    ToolTip = 'End date for filtering loan data';
                }

                field("Loan No. Filter"; Rec."Loan No. Filter")
                {
                    ApplicationArea = All;
                    ToolTip = 'Filter by specific loan number';
                }

                field("Member No. Filter"; Rec."Member No. Filter")
                {
                    ApplicationArea = All;
                    ToolTip = 'Filter by specific member number';
                }

                field("Loan Product Filter"; Rec."Loan Product Filter")
                {
                    ApplicationArea = All;
                    ToolTip = 'Filter by loan product type';
                }

                field("Include Closed Loans"; Rec."Include Closed Loans")
                {
                    ApplicationArea = All;
                    ToolTip = 'Include loans with zero outstanding balance';
                }

                field("Clear Existing Records"; Rec."Clear Existing Records")
                {
                    ApplicationArea = All;
                    ToolTip = 'Clear existing records before generating new ones';
                }
            }

            group(Status)
            {
                Caption = 'Submission Status';

                field(StatusField; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Current status of the submission';
                }

                field("Total Records"; Rec."Total Records")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Total number of records in this submission';
                }

                field("Records Submitted"; Rec."Records Submitted")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Number of successfully submitted records';
                }

                field("Records with Errors"; Rec."Records with Errors")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Number of records with submission errors';
                }

                field("Last Submission Date Time"; Rec."Last Submission Date Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Date and time of last submission attempt';
                }

                field("TransUnion Batch ID"; Rec."TransUnion Batch ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'TransUnion batch identifier';
                }
            }

            part(Lines; "TransUnion Submission Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Header Entry No." = field("Entry No.");
                UpdatePropagation = Both;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Generate Records")
            {
                ApplicationArea = All;
                Caption = 'Generate Records';
                ToolTip = 'Generate TransUnion records from loan data';
                Image = CreateDocument;

                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::Submitted then
                        Error('Cannot generate records for already submitted batch.');

                    if not Confirm('Generate TransUnion records for this batch?') then
                        exit;

                    GenerateLoanRecords();
                    CurrPage.Update(true);
                end;
            }

            action("Submit to TransUnion")
            {
                ApplicationArea = All;
                Caption = 'Submit to TransUnion';
                ToolTip = 'Submit all records in this batch to TransUnion';
                Image = SendTo;

                trigger OnAction()
                var
                    TransUnionAPI: Codeunit "TransUnion API Integration";
                begin
                    Rec.CalcFields("Total Records");
                    if Rec."Total Records" = 0 then
                        Error('No records to submit. Generate records first.');

                    if not Confirm('Submit all records in this batch to TransUnion?') then
                        exit;

                    SubmitBatchToTransUnion();
                    CurrPage.Update(true);
                end;
            }

            action("Validate Records")
            {
                ApplicationArea = All;
                Caption = 'Validate Records';
                ToolTip = 'Validate all records in this batch';
                Image = CheckRulesSyntax;

                trigger OnAction()
                begin
                    ValidateAllRecords();
                    CurrPage.Update(true);
                end;
            }

            action("Resubmit Errors")
            {
                ApplicationArea = All;
                Caption = 'Resubmit Error Records';
                ToolTip = 'Resubmit records that had errors';
                Image = Refresh;

                trigger OnAction()
                begin
                    ResubmitErrorRecords();
                    CurrPage.Update(true);
                end;
            }
        }

        area(Navigation)
        {
            action("API Log")
            {
                ApplicationArea = All;
                Caption = 'API Log';
                ToolTip = 'View API submission log';
                Image = Log;
                RunObject = page "TransUnion API Log List";
            }

            action("Error Log")
            {
                ApplicationArea = All;
                Caption = 'Error Log';
                ToolTip = 'View detailed error information';
                Image = ErrorLog;
                RunObject = page "TransUnion Error Log List";
                RunPageLink = "Parent Entry No." = field("Entry No.");
            }

            action("Detailed Errors")
            {
                ApplicationArea = All;
                Caption = 'Detailed Errors';
                ToolTip = 'View field-level validation errors with resolution suggestions';
                Image = Error;
                RunObject = page "TransUnion Parsed Error List";
                RunPageLink = "Parent Entry No." = field("Entry No.");
            }
        }
    }

    local procedure SubmitBatchToTransUnion()
    var
        TransUnionAPI: Codeunit "TransUnion API Integration";
        TransUnionLine: Record "TransUnion Submission Line";
        SubmittedCount: Integer;
        ErrorCount: Integer;
        TotalCount: Integer;
        ProgressDialog: Dialog;
        Errorlog: Record "TransUnion Parsed Error";
        TransErrorlog: Record "TransUnion Error Log";
    begin

        Errorlog.SetRange("Parent Entry No.", Rec."Entry No.");
        if Errorlog.FindSet() then
            repeat
                Errorlog.Delete();
            until Errorlog.Next() = 0;

        TransErrorlog.SetRange("Parent Entry No.", Rec."Entry No.");
        if TransErrorlog.FindSet() then
            repeat
                TransErrorlog.Delete();
            until TransErrorlog.Next() = 0;

        TransUnionLine.SetRange("Header Entry No.", Rec."Entry No.");
        TransUnionLine.SetRange("Submission Status", TransUnionLine."Submission Status"::"Not Submitted");

        if not TransUnionLine.FindSet() then begin
            Message('No pending records to submit.');
            exit;
        end;

        TotalCount := TransUnionLine.Count;
        ProgressDialog.Open('Submitting records to TransUnion...\Progress: #1####### of #2#######');

        repeat
            ProgressDialog.Update(1, SubmittedCount + ErrorCount + 1);
            ProgressDialog.Update(2, TotalCount);

            if SubmitSingleRecord(TransUnionLine) then
                SubmittedCount += 1
            else
                ErrorCount += 1;

        until TransUnionLine.Next() = 0;

        ProgressDialog.Close();

        // Update header status
        UpdateHeaderStatus();

        Message('Batch submission completed.\Submitted: %1\Errors: %2', SubmittedCount, ErrorCount);
    end;

    local procedure SubmitSingleRecord(var TransUnionLine: Record "TransUnion Submission Line"): Boolean
    var
        TransUnionAPI: Codeunit "TransUnion API Integration";
        TempDailyPayment: Record "TransUnion Daily Payment" temporary;
    begin
        // Convert line to daily payment format
        ConvertLineToDailyPayment(TransUnionLine, TempDailyPayment);

        if TransUnionAPI.SubmitDailyPaymentInformation(Rec."Entry No.", TempDailyPayment) then begin
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

    local procedure ValidateAllRecords()
    var
        TransUnionLine: Record "TransUnion Submission Line";
        ValidationErrors: Text;
        ErrorCount: Integer;
        TotalCount: Integer;
    begin
        TransUnionLine.SetRange("Header Entry No.", Rec."Entry No.");
        if TransUnionLine.FindSet() then begin
            repeat
                ValidationErrors := ValidateLineRecord(TransUnionLine);
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
                TotalCount += 1;
            until TransUnionLine.Next() = 0;
        end;

        Message('Validation completed.\Total Records: %1\Records with Errors: %2', TotalCount, ErrorCount);
    end;

    local procedure ValidateLineRecord(TransUnionLine: Record "TransUnion Submission Line"): Text
    var
        ErrorList: Text;
    begin
        // Reuse validation logic from the daily payments page
        if TransUnionLine."Account Number" = '' then
            ErrorList += 'Account Number is required\';

        if TransUnionLine."Primary ID Doc Type" = TransUnionLine."Primary ID Doc Type"::" " then
            ErrorList += 'Primary ID Document Type is required\';

        if TransUnionLine."Primary ID Doc Number" = '' then
            ErrorList += 'Primary ID Document Number is required\';

        if TransUnionLine."Client Type" = '' then
            ErrorList += 'Client Type is required\';

        if TransUnionLine."Client Type" = 'A' then begin // Individual
            if TransUnionLine.Surname = '' then
                ErrorList += 'Surname is required for individual clients\';
            if TransUnionLine."Forename 1" = '' then
                ErrorList += 'First Name is required for individual clients\';
        end else if TransUnionLine."Client Type" = 'B' then begin // Corporate
            if TransUnionLine."Company Name" = '' then
                ErrorList += 'Company Name is required for corporate clients\';
        end;

        if TransUnionLine."Original Amount" <= 0 then
            ErrorList += 'Original Amount must be greater than zero\';

        if TransUnionLine."Payment Amount" < 0 then
            ErrorList += 'Payment Amount cannot be negative\';

        if TransUnionLine."Snapshot Date" = 0D then
            ErrorList += 'Snapshot Date is required\';

        if TransUnionLine."Payment Date" = 0D then
            ErrorList += 'Payment Date is required\';

        exit(ErrorList);
    end;

    local procedure ResubmitErrorRecords()
    var
        TransUnionLine: Record "TransUnion Submission Line";
        SubmittedCount: Integer;
        ErrorCount: Integer;
    begin
        TransUnionLine.SetRange("Header Entry No.", Rec."Entry No.");
        TransUnionLine.SetRange("Submission Status", TransUnionLine."Submission Status"::Error);

        if not TransUnionLine.FindSet() then begin
            Message('No error records to resubmit.');
            exit;
        end;

        repeat
            if SubmitSingleRecord(TransUnionLine) then
                SubmittedCount += 1
            else
                ErrorCount += 1;
        until TransUnionLine.Next() = 0;

        UpdateHeaderStatus();
        Message('Resubmission completed.\Submitted: %1\Still have errors: %2', SubmittedCount, ErrorCount);
    end;

    local procedure UpdateHeaderStatus()
    begin
        Rec.CalcFields("Total Records", "Records Submitted", "Records with Errors");

        if Rec."Records with Errors" > 0 then begin
            if Rec."Records Submitted" > 0 then
                Rec.Status := Rec.Status::"Partially Submitted"
            else
                Rec.Status := Rec.Status::Error;
        end else if Rec."Records Submitted" = Rec."Total Records" then
                Rec.Status := Rec.Status::Submitted
        else
            Rec.Status := Rec.Status::"Not Submitted";

        Rec."Last Submission Date Time" := CurrentDateTime;
        Rec.Modify();
    end;

    local procedure GenerateLoanRecords()
    var
        Loans: Record Loans;
        Members: Record Members;
        TransUnionLine: Record "TransUnion Submission Line";
        ProgressDialog: Dialog;
        Counter: Integer;
        TotalCount: Integer;
        LineNo: Integer;
    begin
        // Clear existing lines if requested
        TransUnionLine.SetRange("Header Entry No.", Rec."Entry No.");
        if not TransUnionLine.IsEmpty then
            TransUnionLine.DeleteAll();

        // Set up loan filters
        Loans.Reset();
        if Rec."Member No. Filter" <> '' then
            Loans.SetFilter("Member No.", Rec."Member No. Filter");
        if Rec."Loan No. Filter" <> '' then
            Loans.SetFilter("Loan No.", Rec."Loan No. Filter");
        if Rec."Loan Product Filter" <> '' then
            Loans.SetFilter("Loan Product Type", Rec."Loan Product Filter");
        if Rec."Date Filter From" <> 0D then
            Loans.SetFilter("Disbursement Date", '>=%1', Rec."Date Filter From");
        if Rec."Date Filter To" <> 0D then
            Loans.SetFilter("Disbursement Date", '<=%1', Rec."Date Filter To");

        // Filter for loans with outstanding balance unless including closed loans
        if not Rec."Include Closed Loans" then
            Loans.SetFilter("Outstanding Principal", '>0');

        if not Loans.FindSet() then begin
            Message('No loans found matching the specified criteria.');
            exit;
        end;

        TotalCount := Loans.Count;
        ProgressDialog.Open('Generating TransUnion records...\Progress: #1####### of #2#######');

        // Get next line number
        TransUnionLine.SetRange("Header Entry No.", Rec."Entry No.");
        if TransUnionLine.FindLast() then
            LineNo := TransUnionLine."Line No."
        else
            LineNo := 0;

        repeat
            Counter += 1;
            ProgressDialog.Update(1, Counter);
            ProgressDialog.Update(2, TotalCount);

            // Get member information
            if Members.Get(Loans."Member No.") then begin
                // Create TransUnion submission line
                LineNo += 1;
                TransUnionLine.Init();
                TransUnionLine."Line No." := LineNo;
                TransUnionLine."Header Entry No." := Rec."Entry No.";
                TransUnionLine."Snapshot Date" := Rec."Snapshot Date";
                TransUnionLine."Account Number" := Loans."Loan Account";
                TransUnionLine."Customer No." := Loans."Member No.";
                TransUnionLine."Loan No." := Loans."Loan No.";
                TransUnionLine."Client Type" := 'A'; // Individual for now

                // Member information
                TransUnionLine.Surname := Members.Surname;
                TransUnionLine."Forename 1" := Members."First Name";
                TransUnionLine."Forename 2" := Members."Middle Name";

                // ID Information
                TransUnionLine."Primary ID Doc Number" := Members."ID No.";

                // Calculate arrears using SaccoActivities
                CalculateArrearsFromSaccoActivities(Loans, Members, TransUnionLine);

                TransUnionLine."Submission Status" := TransUnionLine."Submission Status"::"Not Submitted";
                TransUnionLine.Insert();
            end;
        until Loans.Next() = 0;

        ProgressDialog.Close();

        // Update header totals
        Rec.CalcFields("Total Records");
        Rec.Status := Rec.Status::"Not Submitted";
        Rec.Modify();

        Message('Successfully generated %1 TransUnion records.', Counter);
    end;

    local procedure CalculateArrearsFromSaccoActivities(Loans: Record Loans; Members: Record Members; var TransUnionLine: Record "TransUnion Submission Line")
    var
        SaccoActivities: Codeunit "Sacco Activities";
        ExpectedAmt: Decimal;
        AmtPaid: Decimal;
        DefAmount: Decimal;
        DaysInArrear: Integer;
        ArrearsDate: Date;
        DF: DateFormula;
    begin
        // Get defaulted amount information using SaccoActivities
        SaccoActivities.GetDefaultedAmount(
            Loans."Loan No.",
            Rec."Snapshot Date",
            ExpectedAmt,
            AmtPaid,
            DefAmount,
            DaysInArrear,
            ArrearsDate,
            true,
            DF);

        // Validate arrears date
        if ArrearsDate > Rec."Snapshot Date" then begin
            ArrearsDate := 0D;
            DefAmount := 0;
            DaysInArrear := 0;
        end;

        // Cap defaulted amount at outstanding principal
        if DefAmount > Loans."Outstanding Principal" then
            DefAmount := Loans."Outstanding Principal";

        // Populate TransUnion line with calculated data (similar to CreateTransUnionRecord)
        PopulateTransUnionLineData(TransUnionLine, Loans, Members, DefAmount, DaysInArrear, ArrearsDate);
    end;

    local procedure PopulateTransUnionLineData(var TransUnionLine: Record "TransUnion Submission Line"; Loans: Record Loans; Members: Record Members; DefAmount: Decimal; DaysInArrear: Integer; ArrearsDate: Date)
    var
        RepaymentAmount: Decimal;
        RSchedule: Record "Loan Repayment Schedule";
        LastPaymentAmount: Decimal;
        CLedger: Record "Credit Ledger Entry";
        DateFilter: Text;
    begin
        // Client type and identification (from CreateTransUnionRecord logic)
        case Members."Account Category" of
            Members."Account Category"::Individual:
                TransUnionLine."Client Type" := 'A';
            Members."Account Category"::Business:
                TransUnionLine."Client Type" := 'B';
            else
                TransUnionLine."Client Type" := 'A'; // Default to individual
        end;

        // Personal information
        if TransUnionLine."Client Type" = 'A' then begin
            TransUnionLine.Surname := Members.Surname;
            TransUnionLine."Forename 1" := Members."First Name";
            TransUnionLine."Forename 2" := Members."Middle Name";
            TransUnionLine."Company Name" := '';
        end else begin
            TransUnionLine."Company Name" := Members.Name;
            TransUnionLine.Surname := '';
            TransUnionLine."Forename 1" := '';
            TransUnionLine."Forename 2" := '';
        end;

        // ID Document information
        if Members."ID No." <> '' then begin
            TransUnionLine."Primary ID Doc Type" := TransUnionLine."Primary ID Doc Type"::"001"; // National ID
            TransUnionLine."Primary ID Doc Number" := Members."ID No.";
        end else if Members."Passport" <> '' then begin
            TransUnionLine."Primary ID Doc Type" := TransUnionLine."Primary ID Doc Type"::"002"; // Passport  
            TransUnionLine."Primary ID Doc Number" := Members."Passport";
        end;

        // Financial information
        TransUnionLine."Currency Code" := 'KES';
        TransUnionLine."Original Amount" := Loans."Approved Amount";
        TransUnionLine."Current Balance" := Loans."Outstanding Principal";

        // Payment information (from CreateTransUnionRecord)
        TransUnionLine."Payment Date" := Loans."Last Principal Pay Date";
        if TransUnionLine."Payment Date" = 0D then
            TransUnionLine."Payment Date" := Rec."Snapshot Date";

        // Get last payment amount
        LastPaymentAmount := 0;
        if Loans."Last Principal Pay Date" <> 0D then begin
            DateFilter := Format(Loans."Last Principal Pay Date");
            CLedger.Reset();
            CLedger.SetRange("Loan No.", Loans."Loan No.");
            CLedger.SetFilter("Posting Date", DateFilter);
            CLedger.SetRange("Transaction Type", CLedger."Transaction Type"::"Principal Repayment");
            CLedger.SetFilter("Amount (LCY)", '<0');
            if CLedger.FindFirst() then begin
                CLedger.CalcSums("Amount (LCY)");
                LastPaymentAmount := Abs(CLedger."Amount (LCY)");
            end;
        end;

        TransUnionLine."Payment Amount" := LastPaymentAmount;

        // Arrears information (from SaccoActivities calculation)
        TransUnionLine."Days in Arrears" := DaysInArrear;
        TransUnionLine."Installments in Arrears" := Round(DaysInArrear / 30, 1, '>');

        // Account status based on performance (using enum values)
        TransUnionLine."Account Status" := TransUnionLine."Account Status"::A; // Default to Active

        if Loans."Outstanding Principal" <= 0 then
            TransUnionLine."Account Status" := TransUnionLine."Account Status"::B // Closed/Paid
        else if DaysInArrear > 90 then
            TransUnionLine."Account Status" := TransUnionLine."Account Status"::G // Delinquent 91-120 days
        else if DaysInArrear > 60 then
            TransUnionLine."Account Status" := TransUnionLine."Account Status"::F // Delinquent 61-90 days
        else if DaysInArrear > 30 then
            TransUnionLine."Account Status" := TransUnionLine."Account Status"::E // Delinquent 31-60 days  
        else if DaysInArrear > 0 then
            TransUnionLine."Account Status" := TransUnionLine."Account Status"::D; // Delinquent 1-30 days
    end;
}