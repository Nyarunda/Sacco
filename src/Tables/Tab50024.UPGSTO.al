table 50024 UPG_STO
{
    Caption = 'UPG_STO';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[200])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Source Account No."; Code[200])
        {
            Caption = 'Source Account No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Standing Order Type"; Text[30])
        {
            Caption = 'Standing Order Type';
            DataClassification = ToBeClassified;
        }
        field(4; "Destination Account No."; Code[200])
        {
            Caption = 'Destination Account No.';
            DataClassification = ToBeClassified;
        }
        field(5; "Effective/Start Date"; Date)
        {
            Caption = 'Effective/Start Date';
            DataClassification = ToBeClassified;
        }
        field(6; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = ToBeClassified;
        }
        field(7; "Duration"; Text[200])
        {
            Caption = 'Duration';
            DataClassification = ToBeClassified;
        }
        field(8; Frequency; Text[200])
        {
            Caption = 'Frequency';
            DataClassification = ToBeClassified;
        }
        field(9; Status; Text[200])
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
        }
        field(10; Description; Text[200])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(11; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
        field(12; "Bank Code"; Code[200])
        {
            Caption = 'Bank Code';
            DataClassification = ToBeClassified;
        }
        field(13; "None Salary"; Boolean)
        {
            Caption = 'None Salary';
            DataClassification = ToBeClassified;
        }
        field(14; "Responsibility Center"; Code[200])
        {
            Caption = 'Responsibility Center';
            DataClassification = ToBeClassified;
        }
        field(15; "Bank Name"; Code[200])
        {
            Caption = 'Bank Name';
            DataClassification = ToBeClassified;
        }
        field(16; "Bank Branch"; Code[200])
        {
            Caption = 'Bank Branch';
            DataClassification = ToBeClassified;
        }
        field(17; "Destination Account"; Code[200])
        {
            Caption = 'Destination Account';
            DataClassification = ToBeClassified;
        }
        field(18; Priority; Integer)
        {
            Caption = 'Priority';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
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
        STO: Record UPG_STO;
    begin
        //FileName := FileMgt.OpenFileDialog(OpenExcelFile,FileName,ExcelFileFilter);

        TempExcelBuffer.ReadSheet;
        TempExcelBuffer.SetFilter("Row No.", '>%1', 1);
        Total := TempExcelBuffer.Count;
        Counter := 0;
        Window.Open(
          ReadingFile + ' @1@@@@@@@@@@@@@@@@@@@@@@@@\' +
          CurrentLine + ' #2#######\' +
          NoOfLines + '#3#######');
        Window.Update(3, Total);
        WindowLastUpdated := CurrentDatetime;

        if TempExcelBuffer.Find('-') then
            repeat
                Counter += 1;
                case TempExcelBuffer."Column No." of
                    1:
                        begin
                            STO.Init;
                            Evaluate(STO."No.", TempExcelBuffer."Cell Value as Text");
                        end;
                    2:
                        begin
                            Evaluate(STO."Source Account No.", TempExcelBuffer."Cell Value as Text");
                        end;
                    3:
                        begin
                            Evaluate(STO."Standing Order Type", TempExcelBuffer."Cell Value as Text");
                        end;
                    4:
                        begin
                            Evaluate(STO."Destination Account No.", TempExcelBuffer."Cell Value as Text");
                        end;
                    5:
                        begin
                            Evaluate(STO."Effective/Start Date", TempExcelBuffer."Cell Value as Text");
                        end;
                    6:
                        begin
                            Evaluate(STO."End Date", TempExcelBuffer."Cell Value as Text");
                        end;
                    7:
                        begin
                            Evaluate(STO.Duration, TempExcelBuffer."Cell Value as Text");
                        end;
                    8:
                        begin
                            Evaluate(STO.Frequency, TempExcelBuffer."Cell Value as Text");
                        end;
                    9:
                        begin
                            Evaluate(STO.Status, TempExcelBuffer."Cell Value as Text");
                        end;
                    10:
                        begin
                            Evaluate(STO.Description, TempExcelBuffer."Cell Value as Text");
                        end;
                    11:
                        begin
                            Evaluate(STO.Amount, TempExcelBuffer."Cell Value as Text");
                        end;
                    12:
                        begin
                            Evaluate(STO."Bank Code", TempExcelBuffer."Cell Value as Text");
                        end;
                    13:
                        begin
                            Evaluate(STO."None Salary", TempExcelBuffer."Cell Value as Text");
                        end;
                    14:
                        begin
                            Evaluate(STO."Responsibility Center", TempExcelBuffer."Cell Value as Text");
                        end;
                    15:
                        begin
                            Evaluate(STO."Bank Name", TempExcelBuffer."Cell Value as Text");
                        end;
                    16:
                        begin
                            Evaluate(STO."Bank Branch", TempExcelBuffer."Cell Value as Text");
                        end;
                    17:
                        begin
                            Evaluate(STO."Destination Account No.", TempExcelBuffer."Cell Value as Text");
                        end;
                    18:
                        begin
                            Evaluate(STO.Priority, TempExcelBuffer."Cell Value as Text");

                            STO.Insert;
                        end;
                end;
                if CurrentDatetime - WindowLastUpdated > 100 then begin
                    Window.Update(1, ROUND(Counter / Total * 10000, 1));
                    Window.Update(2, Counter);
                    WindowLastUpdated := CurrentDatetime;
                end;
            until TempExcelBuffer.Next = 0;
        Window.Close;
    end;
}
