tableextension 50329 "Bank Reconcilliation " extends "Bank Acc. Reconciliation"
{

    fields
    {


        field(50101; "Notes Line 1"; Text[2000])
        {
        }
        field(50102; "Notes Line 2"; Text[2000])
        {
        }
        field(50103; "Notes Line 3"; Text[2000])
        {
        }
        field(50104; "Notes Line 4"; Text[2000])
        {
        }
        field(50105; "Notes Line 5"; Text[2000])
        {
        }
        field(50106; "Notes Line 6"; Text[2000])
        {
        }
        field(50107; "Type"; Option)
        {
            OptionMembers = Auto,Manual;
        }

        field(50108; "Entry No."; Integer)
        {
        }
        field(50109; "Statement Guid No."; Guid)
        {
        }
    }

    procedure ImportBankStatementLinesFromExcel()
    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        FileName: Text;
        ServerFileName: Text;
        SheetName: Text;
        FileMgt: Codeunit "File Management";
        OpenObjectFile: label 'Open Object Text File';
        SaveObjectFile: label 'Save Object Text File';
        OpenExcelFile: label 'Open Excel File';
        TextFileFilter: label 'Text Files (*.txt)|*.txt|All Files (*.*)|*.*';
        ExcelFileFilter: label 'Excel Files (*.xls*)|*.xls*|All Files (*.*)|*.*';
        MenuSuiteProcess: label 'Updating MenuSuite';
        ReplacingProcess: label 'Replacing';
        ReadingFile: label 'Reading File';
        WritingFile: label 'Writing File';
        ReadingLines: label 'Reading Lines';
        TypeNotFoundError: label 'Type %1 not found';
        RenumberLines: label 'Renumbering Lines';
        NoOfLines: label 'No. of Lines';
        CurrentLine: label 'Current Line No.';
        OpeningExcel: label 'Opening Excel';
        AvailableObject: label 'Available Object';
        FindAvailableObjects: label 'Finding Available Objects';
        CreatingSuggestion: label 'Creating Suggestion';
        UploadingFile: label 'Uploading File to the Server temporary storage';
        UseInMemoryObjects: label 'Object are in memory, use them ?';
        Window: Dialog;
        WindowLastUpdated: DateTime;
        Counter: Integer;
        Total: Integer;
        FromFolder: Text;
        LineNo: Integer;
        InStream: InStream;
        BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
    begin
        //FileName := FileMgt.OpenFileDialog(OpenExcelFile,FileName,ExcelFileFilter);

        //File.Upload(OpenExcelFile, FromFolder, ExcelFileFilter, FileName, ServerFileName);

        //if not File.Exists(ServerFileName) then exit;

        //ServerFileName := FileMgt.UploadFileSilent(FileName);

        //SheetName := TempExcelBuffer.SelectSheetsName(ServerFileName);
        //TempExcelBuffer.OpenBook(ServerFileName, SheetName);
        if not UploadIntoStream(OpenExcelFile, '', ExcelFileFilter, FileName, InStream) then
            exit;

        // Import from stream instead of file path
        SheetName := TempExcelBuffer.SelectSheetsNameStream(InStream);
        TempExcelBuffer.OpenBookStream(InStream, SheetName);
        TempExcelBuffer.ReadSheet;
        TempExcelBuffer.SetFilter("Row No.", '>%1', 1);
        Total := TempExcelBuffer.Count;

        /*   TempExcelBuffer.ReadSheet;
          TempExcelBuffer.SetFilter("Row No.", '>%1', 1);
          Total := TempExcelBuffer.Count; */
        Counter := 0;
        Window.Open(
          ReadingFile + ' @1@@@@@@@@@@@@@@@@@@@@@@@@\' +
          CurrentLine + ' #2#######\' +
          NoOfLines + '#3#######');
        Window.Update(3, Total);
        WindowLastUpdated := CurrentDatetime;

        LineNo := 0;
        BankAccReconciliationLine.Reset();
        BankAccReconciliationLine.setrange("Bank Account No.", "Bank Account No.");
        BankAccReconciliationLine.setrange("Statement No.", "Statement No.");
        if BankAccReconciliationLine.FindLast() then
            LineNo := BankAccReconciliationLine."Statement Line No.";

        if TempExcelBuffer.Find('-') then
            repeat
                Counter += 1;
                LineNo += 1;
                case TempExcelBuffer."Column No." of
                    1:
                        begin
                            BankAccReconciliationLine.Init;
                            BankAccReconciliationLine."Statement Type" := "Statement Type";
                            BankAccReconciliationLine."Bank Account No." := "Bank Account No.";
                            BankAccReconciliationLine."Statement No." := "Statement No.";
                            BankAccReconciliationLine."Statement Line No." := LineNo;
                            Evaluate(BankAccReconciliationLine."Transaction Date", TempExcelBuffer."Cell Value as Text");
                        end;
                    2:
                        begin
                            Evaluate(BankAccReconciliationLine."Document No.", TempExcelBuffer."Cell Value as Text");
                        end;
                    3:
                        begin
                            Evaluate(BankAccReconciliationLine.Description, CopyStr(TempExcelBuffer."Cell Value as Text", 1, 100));
                        end;
                    4:
                        begin
                            Evaluate(BankAccReconciliationLine."Statement Amount", TempExcelBuffer."Cell Value as Text");
                            BankAccReconciliationLine.Validate("Statement Amount");
                            BankAccReconciliationLine.Insert;
                        end;
                end;
                if CurrentDatetime - WindowLastUpdated > 1000 then begin
                    Window.Update(1, ROUND(Counter / Total * 10000, 1));
                    Window.Update(2, Counter);
                    WindowLastUpdated := CurrentDatetime;
                end;
            until TempExcelBuffer.Next = 0;
        Window.Close;
    end;
}



