table 50350 "Sacco Journal Header"
{
    Caption = 'Sacco Journal Header';
    DataClassification = ToBeClassified;
    LookupPageId = "Sacco Journals List";
    DrillDownPageId = "Sacco Journals List";

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Editable = false;
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Captured By"; Code[50])
        {
            Caption = 'Captured By';
            DataClassification = ToBeClassified;
        }
        field(3; "Posting Type"; Option)
        {
            Caption = 'Posting Type';
            OptionMembers = "Use Line Document No","User Header Document No.";
            trigger OnValidate()
            var
                SaccoLines: record "Sacco Journal Line";
            begin
                SaccoLines.Reset();
                SaccoLines.SetRange("Batch No.", "Document No.");
                if SaccoLines.FindFirst() then
                    SaccoLines.DeleteAll();
            end;
        }
        field(4; Posted; Boolean)
        {
            Caption = 'Posted';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Date Posted"; Date)
        {
            Caption = 'Date Posted';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "No. Series"; Code[20])
        {
        }
        field(7; "Date"; Date)
        {
            Editable = false;
        }
        field(8; "Time"; Time)
        {
        }
        field(9; "Status"; Enum "Approval Status Enum")
        {
        }
        field(10; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center";
        }
        field(11; "Posting Date"; Date)
        {
        }
        field(12; "Custom Journal Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(13; "Data Migrations"; Boolean)
        {
            //TableRelation = "Gen. Journal Template";
        }
        field(14; "Preview Done"; Boolean)
        {
            //TableRelation = "Gen. Journal Template";
        }
    }
    keys
    {
        key(PK; "Document No.")
        {
            Clustered = true;
        }
    }



    trigger OnInsert()
    var
        JBatches: Record "Gen. Journal Batch";
        UserSetup: Record "User Setup";
    begin
        if "Document No." = '' then begin
            NoSetup.Get;
            NoSetup.TestField(NoSetup."Sacco Journal Nos");
            "Document No." := NoSeries.GetNextNo(NoSetup."Sacco Journal Nos", WorkDate(), true);
        end;

        "Date" := Today;
        "Time" := Time;
        "Captured By" := UserId;

        "Custom Journal Template" := 'GENERAL';

        if "Document No." <> '' then begin

            JBatches.Reset();
            JBatches.SetRange("Journal Template Name", 'GENERAL');
            JBatches.SetFilter(Name, "Document No.");
            if not JBatches.FindFirst() then begin
                UserSetup.Get(UserId);
                UserSetup.TestField(UserSetup."Default Journal Nos. Series");

                JBatches.Init();
                JBatches."No. Series" := UserSetup."Default Journal Nos. Series";
                JBatches."Journal Template Name" := 'GENERAL';
                JBatches.Name := "Document No.";
                JBatches.Insert();
            end;
        end;

    end;


    procedure ImportJournalLinesFromExcel()

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
        InStream: InStream;
        Buffer: Record "Gen. Journal Line"; //"Sacco Journal Line";
    begin
        //FileName := FileMgt.OpenFileDialog(OpenExcelFile,FileName,ExcelFileFilter);

        // Use UploadIntoStream for cloud compatibility
        if not UploadIntoStream(OpenExcelFile, '', ExcelFileFilter, FileName, InStream) then
            exit;

        // Import from stream instead of file path
        SheetName := TempExcelBuffer.SelectSheetsNameStream(InStream);
        TempExcelBuffer.OpenBookStream(InStream, SheetName);
        TempExcelBuffer.ReadSheet;
        TempExcelBuffer.SetFilter("Row No.", '>%1', 1);
        Total := TempExcelBuffer.Count;

        Buffer.Reset();
        Buffer.SetRange("Journal Template Name", "Custom Journal Template");
        Buffer.SetRange("Journal Batch Name", "Document No.");
        if Buffer.FindFirst() then
            Buffer.DeleteAll();


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

                            Buffer.Init;
                            Evaluate(Buffer."Line No.", TempExcelBuffer."Cell Value as Text");
                            //
                        end;
                    2:
                        begin
                            Evaluate(Buffer."Posting Date", TempExcelBuffer."Cell Value as Text");
                            Buffer.Validate("Posting Date");
                        end;
                    3:
                        begin
                            Evaluate(Buffer."Document No.", TempExcelBuffer."Cell Value as Text");
                            Buffer.Validate("Document No.");
                        end;
                    4:
                        Begin

                            Evaluate(Buffer."Account Type", TempExcelBuffer."Cell Value as Text");
                            Buffer.Validate("Account Type");

                        end;
                    5:
                        Begin

                            Evaluate(Buffer."Account No.", TempExcelBuffer."Cell Value as Text");
                            Buffer.Validate("Account No.");

                        end;
                    6:
                        Begin

                            Evaluate(Buffer.Description, TempExcelBuffer."Cell Value as Text");
                            Buffer.Validate(Description);

                        end;
                    7:
                        Begin

                            Evaluate(Buffer."Debit Amount", TempExcelBuffer."Cell Value as Text");
                            Buffer.Validate("Debit Amount");

                        end;
                    8:
                        Begin

                            Evaluate(Buffer."Credit Amount", TempExcelBuffer."Cell Value as Text");
                            Buffer.Validate("Credit Amount");

                        end;
                    9:
                        Begin

                            Evaluate(Buffer."Transaction Type", TempExcelBuffer."Cell Value as Text");
                            Buffer.Validate("Transaction Type");

                        end;
                    10:
                        Begin

                            Evaluate(Buffer."Loan No.", TempExcelBuffer."Cell Value as Text");
                            Buffer.Validate("Loan No.");

                        end;
                    11:
                        Begin

                            Evaluate(Buffer."External Document No.", TempExcelBuffer."Cell Value as Text");

                        end;
                    12:
                        Begin

                            Evaluate(Buffer."Shortcut Dimension 1 Code", TempExcelBuffer."Cell Value as Text");

                            Buffer.Validate("Shortcut Dimension 1 Code");

                        end;
                    13:
                        Begin

                            Evaluate(Buffer."Shortcut Dimension 2 Code", TempExcelBuffer."Cell Value as Text");

                            Buffer.Validate("Shortcut Dimension 2 Code");
                        end;

                    14:
                        Begin
                            if TempExcelBuffer."Cell Value as Text" = '' then
                                Buffer."Journal Batch Name" := "Document No."
                            else
                                Buffer."Journal Batch Name" := TempExcelBuffer."Cell Value as Text";
                            Buffer."Journal Template Name" := "Custom Journal Template";
                            Buffer."Posting No. Series" := '';
                            Buffer.Insert();
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

    var
        NoSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";
        UserSetup: Record "User Setup";
}
