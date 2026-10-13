report 50536 "Generate TransUnion Batch Data"
{
    // Generate TransUnion Batch Data Report

    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'Generate TransUnion Batch Data';
    ProcessingOnly = true;

    dataset
    {
        dataitem(Header; "TransUnion Submission Header")
        {
            RequestFilterFields = "Entry No.";

            trigger OnPreDataItem()
            begin
                if not GuiAllowed then
                    ProgressDialog.Open('Generating TransUnion batch data...\Processing: #1#########');
            end;

            trigger OnAfterGetRecord()
            var
                TransUnionDaily: Record "TransUnion Daily Payment";
                TransUnionLine: Record "TransUnion Submission Line";
                LineNo: Integer;
                RecordCount: Integer;
            begin
                if not GuiAllowed then
                    ProgressDialog.Update(1, StrSubstNo('Header: %1', Header."Entry No."));

                // Clear existing lines if specified
                if Header."Clear Existing Records" then begin
                    TransUnionLine.Reset();
                    TransUnionLine.SetRange("Header Entry No.", Header."Entry No.");
                    TransUnionLine.DeleteAll();
                end;

                // Set filters on TransUnion Daily Payment based on header filters
                TransUnionDaily.Reset();

                if Header."Date Filter From" <> 0D then
                    TransUnionDaily.SetRange("Payment Date", Header."Date Filter From", Header."Date Filter To");

                if Header."Loan No. Filter" <> '' then
                    TransUnionDaily.SetFilter("Loan No.", Header."Loan No. Filter");

                if Header."Member No. Filter" <> '' then
                    TransUnionDaily.SetFilter("Customer No.", Header."Member No. Filter");

                if Header."Account Category Filter" <> Header."Account Category Filter"::" " then
                    TransUnionDaily.SetFilter("Account Number", Format(Header."Account Category Filter"));

                // Additional filter for snapshot date
                if Header."Snapshot Date" <> 0D then
                    TransUnionDaily.SetRange("Snapshot Date", Header."Snapshot Date");

                // Filter out closed loans if not included
                if not Header."Include Closed Loans" then
                    TransUnionDaily.SetFilter("Current Balance", '>%1', 0);

                // Get the last line number
                TransUnionLine.Reset();
                TransUnionLine.SetRange("Header Entry No.", Header."Entry No.");
                if TransUnionLine.FindLast() then
                    LineNo := TransUnionLine."Line No."
                else
                    LineNo := 0;

                if TransUnionDaily.FindSet() then begin
                    repeat
                        RecordCount += 1;
                        LineNo += 10000;

                        CreateSubmissionLine(Header, TransUnionDaily, LineNo);

                        if (RecordCount mod 100 = 0) and not GuiAllowed then
                            ProgressDialog.Update(1, StrSubstNo('Processed %1 records', RecordCount));

                    until TransUnionDaily.Next() = 0;
                end;

                // Update header totals
                Header.CalcFields("Total Records");
                Header."Last Generation Date Time" := CurrentDateTime;
                Header.Modify();

                TotalRecordsGenerated += RecordCount;
            end;

            trigger OnPostDataItem()
            begin
                if not GuiAllowed then
                    ProgressDialog.Close();

                if GuiAllowed then
                    Message('Generation completed.\Total records generated: %1', TotalRecordsGenerated);
            end;
        }
    }

    var
        ProgressDialog: Dialog;
        TotalRecordsGenerated: Integer;

    local procedure CreateSubmissionLine(SubmissionHeader: Record "TransUnion Submission Header"; TransUnionDaily: Record "TransUnion Daily Payment"; LineNo: Integer)
    var
        TransUnionLine: Record "TransUnion Submission Line";
    begin
        TransUnionLine.Init();
        TransUnionLine."Header Entry No." := SubmissionHeader."Entry No.";
        TransUnionLine."Line No." := LineNo;

        // Copy all fields from daily payment
        TransUnionLine."Account Number" := TransUnionDaily."Account Number";
        TransUnionLine."Snapshot Date" := TransUnionDaily."Snapshot Date";
        TransUnionLine."Client Type" := TransUnionDaily."Client Type";
        TransUnionLine.Surname := TransUnionDaily.Surname;
        TransUnionLine."Forename 1" := TransUnionDaily."Forename 1";
        TransUnionLine."Forename 2" := TransUnionDaily."Forename 2";
        TransUnionLine."Forename 3" := TransUnionDaily."Forename 3";
        TransUnionLine."Company Name" := TransUnionDaily."Company Name";
        TransUnionLine."Primary ID Doc Type" := TransUnionDaily."Primary ID Doc Type";
        TransUnionLine."Primary ID Doc Number" := TransUnionDaily."Primary ID Doc Number";
        TransUnionLine."Currency Code" := TransUnionDaily."Currency Code";
        TransUnionLine."Original Amount" := TransUnionDaily."Original Amount";
        TransUnionLine."Payment Amount" := TransUnionDaily."Payment Amount";
        TransUnionLine."Payment Date" := TransUnionDaily."Payment Date";
        TransUnionLine."Current Balance" := TransUnionDaily."Current Balance";
        TransUnionLine."Installments in Arrears" := TransUnionDaily."Installments in Arrears";
        TransUnionLine."Days in Arrears" := TransUnionDaily."Days in Arrears";
        TransUnionLine."Account Status" := TransUnionDaily."Account Status";
        TransUnionLine."Customer No." := TransUnionDaily."Customer No.";
        TransUnionLine."Loan No." := TransUnionDaily."Loan No.";

        // Set initial status
        TransUnionLine."Submission Status" := TransUnionLine."Submission Status"::"Not Submitted";
        TransUnionLine."Creation Date Time" := CurrentDateTime;

        TransUnionLine.Insert();
    end;
}