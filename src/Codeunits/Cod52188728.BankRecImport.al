codeunit 50391 "Bank Rec. Import"
{
    procedure ImportExcelStatement(BankRecHeader: Record "Bank Reconciliation")
    var
        BankRecLine: Record "Bank Reconciliation Line";
        TempExcelBuffer: Record "Excel Buffer" temporary;
        FileName: Text;
        SheetName: Text;
        ExcelFileFilter: Label 'Excel Files (*.xlsx)|*.xlsx';
        ReadingFile: Label 'Reading File...';
        CurrentLine: Label 'Processing Line:';
        NoOfLines: Label 'Total Lines:';
        Window: Dialog;
        WindowLastUpdated: DateTime;
        Counter: Integer;
        Total: Integer;
        LineNo: Integer;
        InStream: InStream;
    begin
        // Validate header record
        if BankRecHeader."No." = '' then
            Error('Bank Reconciliation header must be specified');

        // Initialize line record
        BankRecLine.Reset();
        BankRecLine.SetRange("Document No.", BankRecHeader."No.");

        // Get Excel file through upload
        if not UploadIntoStream('Select Excel File', '', ExcelFileFilter, FileName, InStream) then
            exit;

        // Read Excel file into buffer
        SheetName := TempExcelBuffer.SelectSheetsNameStream(InStream);
        TempExcelBuffer.OpenBookStream(InStream, SheetName);
        TempExcelBuffer.ReadSheet();

        // Skip header row
        TempExcelBuffer.SetFilter("Row No.", '>%1', 1);
        Total := TempExcelBuffer.Count;

        // Show progress window
        Window.Open(
            ReadingFile + '\' +
            CurrentLine + ' #1#####\' +
            NoOfLines + ' #2#####');
        Window.Update(2, Total);
        WindowLastUpdated := CurrentDateTime;

        // Get last line number
        LineNo := GetLastLineNo(BankRecLine);

        if TempExcelBuffer.FindSet() then
            repeat
                Counter += 1;
                LineNo += 10000;

                case TempExcelBuffer."Column No." of
                    1:  // Transaction Date
                        begin
                            BankRecLine.Init();
                            BankRecLine."Line No." := LineNo;
                            if Evaluate(BankRecLine."Transaction Date", TempExcelBuffer."Cell Value as Text") then;
                        end;
                    2:  // Reference No
                        begin
                            BankRecLine."Reference No." := CopyStr(TempExcelBuffer."Cell Value as Text", 1, MaxStrLen(BankRecLine."Reference No."));
                        end;
                    3:  // Description
                        begin
                            BankRecLine.Description := CopyStr(TempExcelBuffer."Cell Value as Text", 1, MaxStrLen(BankRecLine.Description));
                        end;
                    4:  // Amount
                        begin
                            if Evaluate(BankRecLine."Statement Amount", TempExcelBuffer."Cell Value as Text") then;
                            
                            // Set document type based on amount
                            if BankRecLine."Statement Amount" < 0 then
                                BankRecLine."Document Type" := BankRecLine."Document Type"::Payment
                            else
                                BankRecLine."Document Type" := BankRecLine."Document Type"::Receipt;

                            BankRecLine.Insert();
                        end;
                end;

                // Update progress window every second
                if CurrentDateTime - WindowLastUpdated > 1000 then begin
                    Window.Update(1, Counter);
                    WindowLastUpdated := CurrentDateTime;
                end;

            until TempExcelBuffer.Next() = 0;

        Window.Close();
        Message('Import completed. %1 lines imported.', Counter);
    end;

    local procedure GetLastLineNo(var BankRecLine: Record "Bank Reconciliation Line"): Integer
    begin
        BankRecLine.Reset();
        if BankRecLine.FindLast() then
            exit(BankRecLine."Line No.");
        exit(0);
    end;
}