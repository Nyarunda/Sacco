report 50535 "Generate TransUnion Data"
{
    // Generate TransUnion Daily Payment Information from existing loan data

    ProcessingOnly = true;
    Caption = 'Generate TransUnion Data';

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where(Posted = filter(= true), Installments = filter(> 0), "Approved Amount" = filter(> 0));
            RequestFilterFields = "Last Principal Pay Date", "Loan No.", "Member No.", "Loan Product Type", "Disbursement Date";

            trigger OnAfterGetRecord()
            var
                TransUnionPayment: Record "TransUnion Daily Payment";
                Member: Record Members;
                LoanType: Record "Product Setup";
                SaccoActivities: Codeunit "Sacco Activities";
                ExpectedAmt: Decimal;
                AmtPaid: Decimal;
                DefAmount: Decimal;
                DaysInArrear: Integer;
                ArrearsDate: Date;
                DF: DateFormula;
            begin
                CurrentRecordNo += 1;

                // Skip certain loan types if needed
                if Loans."Loan Product Type" = 'L99' then
                    CurrReport.Skip;

                // Calculate fields
                Loans.CalcFields(Loans."Outstanding Principal", "Last Principal Pay Date");

                if Loans."Outstanding Principal" < 0 then
                    Loans."Outstanding Principal" := 0;

                // Skip closed loans unless generating closure data
                if not IncludeClosedLoans and (Loans."Outstanding Principal" < 1) then
                    CurrReport.Skip;

                // Get member information
                Member.Reset();
                Member.SetRange("No.", Loans."Member No.");
                Member.SetRange(Type, Member.Type::Member);
                if not Member.FindFirst() then
                    CurrReport.Skip;

                // Filter by account category if specified
                if (AccountCategoryFilter <> AccountCategoryFilter::" ") and
                   (Member."Account Category" <> AccountCategoryFilter) then
                    CurrReport.Skip;

                // Get defaulted amount information
                SaccoActivities.GetDefaultedAmount(
                    Loans."Loan No.",
                    SnapshotDate,
                    ExpectedAmt,
                    AmtPaid,
                    DefAmount,
                    DaysInArrear,
                    ArrearsDate,
                    true,
                    DF);

                if ArrearsDate > SnapshotDate then begin
                    ArrearsDate := 0D;
                    DefAmount := 0;
                    DaysInArrear := 0;
                end;

                if DefAmount > Loans."Outstanding Principal" then
                    DefAmount := Loans."Outstanding Principal";

                // Create TransUnion payment record
                CreateTransUnionRecord(Member, Loans, DefAmount, DaysInArrear, ArrearsDate);

                // Update progress
                if GuiAllowed then begin
                    ProgressDialog.Update(1, Round(CurrentRecordNo / TotalRecords * 10000, 1));
                    ProgressDialog.Update(2, CurrentRecordNo);
                    ProgressDialog.Update(3, TotalRecords);
                end;
            end;

            trigger OnPreDataItem()
            var

                TransUnionPayment: Record "TransUnion Daily Payment";
            begin
                // Clear existing records for this snapshot date
                if ClearExistingRecords then begin
                    TransUnionPayment.SetRange("Snapshot Date", SnapshotDate);
                    TransUnionPayment.DeleteAll();
                end;

                // Set filters
                Loans.SetFilter(Loans."Date Filter", '..%1', SnapshotDate);

                if LoanNoFilter <> '' then
                    Loans.SetRange("Loan No.", LoanNoFilter);
                if MemberNoFilter <> '' then
                    Loans.SetRange("Member No.", MemberNoFilter);
                if LoanProductFilter <> '' then
                    Loans.SetRange("Loan Product Type", LoanProductFilter);

                // Apply date filters
                if PaymentDateFrom <> 0D then
                    Loans.SetFilter("Last Principal Pay Date", '>=%1', PaymentDateFrom);
                if PaymentDateTo <> 0D then
                    Loans.SetFilter("Last Principal Pay Date", '..%1', PaymentDateTo);

                TotalRecords := Loans.Count;
                CurrentRecordNo := 0;

                if GuiAllowed and (TotalRecords > 0) then
                    ProgressDialog.Open('Generating TransUnion Records: @1@@@@@@@@@\' +
                                      'Current: #2#######\' +
                                      'Total: #3#######\' +
                                      'Press ESC to cancel');
            end;

            trigger OnPostDataItem()
            begin
                if GuiAllowed then begin
                    ProgressDialog.Close();
                    Message('Generated %1 TransUnion payment records for snapshot date %2',
                           CurrentRecordNo, SnapshotDate);
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(General)
                {
                    Caption = 'General Settings';

                    field(SnapshotDate; SnapshotDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Snapshot Date';
                        ToolTip = 'Date for which to generate TransUnion payment information';
                        NotBlank = true;
                    }

                    field(ClearExistingRecords; ClearExistingRecords)
                    {
                        ApplicationArea = All;
                        Caption = 'Clear Existing Records';
                        ToolTip = 'Clear existing TransUnion records for the snapshot date before generating new ones';
                    }

                    field(IncludeClosedLoans; IncludeClosedLoans)
                    {
                        ApplicationArea = All;
                        Caption = 'Include Closed Loans';
                        ToolTip = 'Include loans with zero outstanding balance';
                    }
                }

                group(Filters)
                {
                    Caption = 'Additional Filters';

                    field(AccountCategoryFilter; AccountCategoryFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Account Category Filter';
                        ToolTip = 'Filter by specific account category';
                    }

                    field(LoanNoFilter; LoanNoFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Loan No. Filter';
                        ToolTip = 'Filter by specific loan number';
                    }

                    field(MemberNoFilter; MemberNoFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Member No. Filter';
                        ToolTip = 'Filter by specific member number';
                    }

                    field(LoanProductFilter; LoanProductFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Loan Product Filter';
                        ToolTip = 'Filter by specific loan product type';
                    }
                }

                group("Date Range")
                {
                    Caption = 'Payment Date Range';

                    field(PaymentDateFrom; PaymentDateFrom)
                    {
                        ApplicationArea = All;
                        Caption = 'Payment Date From';
                        ToolTip = 'Include loans with last payment from this date';
                    }

                    field(PaymentDateTo; PaymentDateTo)
                    {
                        ApplicationArea = All;
                        Caption = 'Payment Date To';
                        ToolTip = 'Include loans with last payment up to this date';
                    }
                }
            }
        }
    }

    var
        SnapshotDate: Date;
        ClearExistingRecords: Boolean;
        IncludeClosedLoans: Boolean;
        AccountCategoryFilter: Option " ",Individual,Joint,Business;
        LoanNoFilter: Code[20];
        MemberNoFilter: Code[20];
        LoanProductFilter: Code[20];
        PaymentDateFrom: Date;
        PaymentDateTo: Date;
        TotalRecords: Integer;
        CurrentRecordNo: Integer;
        ProgressDialog: Dialog;

    trigger OnInitReport()
    begin
        SnapshotDate := Today;
        ClearExistingRecords := true;
        IncludeClosedLoans := false;
    end;

    local procedure CreateTransUnionRecord(Member: Record Members; LoanRec: Record Loans; DefAmount: Decimal; DaysInArrear: Integer; ArrearsDate: Date)
    var
        TransUnionPayment: Record "TransUnion Daily Payment";
        LoanType: Record "Product Setup";
        RepaymentAmount: Decimal;
        RSchedule: Record "Loan Repayment Schedule";
        LastPaymentAmount: Decimal;
        CLedger: Record "Credit Ledger Entry";
        DateFilter: Text;
    begin
        TransUnionPayment.Init();

        // Basic information
        TransUnionPayment."Account Number" := LoanRec."Loan No.";
        TransUnionPayment."Snapshot Date" := SnapshotDate;
        TransUnionPayment."Customer No." := Member."No.";
        TransUnionPayment."Loan No." := LoanRec."Loan No.";

        // Client type and identification
        case Member."Account Category" of
            Member."Account Category"::Individual:
                TransUnionPayment."Client Type" := 'A';
            Member."Account Category"::Business:
                TransUnionPayment."Client Type" := 'B';
            else
                TransUnionPayment."Client Type" := 'A'; // Default to individual
        end;

        // Personal information for individuals
        if TransUnionPayment."Client Type" = 'A' then begin
            TransUnionPayment.Surname := Member.Surname;
            TransUnionPayment."Forename 1" := Member."First Name";
            TransUnionPayment."Forename 2" := Member."Middle Name";
            TransUnionPayment."Company Name" := '';
        end else begin
            TransUnionPayment."Company Name" := Member.Name;
            TransUnionPayment.Surname := '';
            TransUnionPayment."Forename 1" := '';
            TransUnionPayment."Forename 2" := '';
        end;

        // ID Document information
        if Member."ID No." <> '' then begin
            TransUnionPayment."Primary ID Doc Type" := TransUnionPayment."Primary ID Doc Type"::"001"; // National ID
            TransUnionPayment."Primary ID Doc Number" := Member."ID No.";
        end else if Member."Passport" <> '' then begin
            TransUnionPayment."Primary ID Doc Type" := TransUnionPayment."Primary ID Doc Type"::"002"; // Passport
            TransUnionPayment."Primary ID Doc Number" := Member."Passport";
        end;

        // Financial information
        TransUnionPayment."Currency Code" := 'KES';
        TransUnionPayment."Original Amount" := LoanRec."Approved Amount";
        TransUnionPayment."Current Balance" := LoanRec."Outstanding Principal";

        // Calculate payment amount
        RepaymentAmount := LoanRec."Loan Principle Repayment";
        if RepaymentAmount = 0 then begin
            RSchedule.Reset();
            RSchedule.SetRange("Loan No.", LoanRec."Loan No.");
            RSchedule.SetFilter("Monthly Principal", '>0');
            if RSchedule.FindFirst() then
                RepaymentAmount := RSchedule."Monthly Principal";
        end;

        // Payment information
        TransUnionPayment."Payment Date" := LoanRec."Last Principal Pay Date";
        if TransUnionPayment."Payment Date" = 0D then
            TransUnionPayment."Payment Date" := SnapshotDate;

        // Get last payment amount
        LastPaymentAmount := 0;
        if LoanRec."Last Principal Pay Date" <> 0D then begin
            DateFilter := Format(LoanRec."Last Principal Pay Date");
            CLedger.Reset();
            CLedger.SetRange("Loan No.", LoanRec."Loan No.");
            CLedger.SetFilter("Posting Date", DateFilter);
            CLedger.SetRange("Transaction Type", CLedger."Transaction Type"::"Principal Repayment");
            CLedger.SetFilter("Amount (LCY)", '<0');
            if CLedger.FindFirst() then begin
                CLedger.CalcSums("Amount (LCY)");
                LastPaymentAmount := Abs(CLedger."Amount (LCY)");
            end;
        end;

        TransUnionPayment."Payment Amount" := LastPaymentAmount;

        // Arrears information
        TransUnionPayment."Days in Arrears" := DaysInArrear;
        TransUnionPayment."Installments in Arrears" := Round(DaysInArrear / 30, 1, '>');

        // Account status based on performance
        TransUnionPayment."Account Status" := TransUnionPayment."Account Status"::A; // Default to Active

        if LoanRec."Outstanding Principal" <= 0 then
            TransUnionPayment."Account Status" := TransUnionPayment."Account Status"::B // Closed/Paid
        else if DaysInArrear > 90 then
            TransUnionPayment."Account Status" := TransUnionPayment."Account Status"::G // Delinquent 91-120 days
        else if DaysInArrear > 60 then
            TransUnionPayment."Account Status" := TransUnionPayment."Account Status"::F // Delinquent 61-90 days
        else if DaysInArrear > 30 then
            TransUnionPayment."Account Status" := TransUnionPayment."Account Status"::E // Delinquent 31-60 days
        else if DaysInArrear > 0 then
            TransUnionPayment."Account Status" := TransUnionPayment."Account Status"::D; // Delinquent 1-30 days

        // Mark as not submitted
        TransUnionPayment."Submission Status" := TransUnionPayment."Submission Status"::"Not Submitted";

        TransUnionPayment.Insert(true);
    end;
}