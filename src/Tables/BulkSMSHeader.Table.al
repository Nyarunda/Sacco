Table 50060 "Bulk SMS Header"
{

    fields
    {
        field(1; No; Code[20])
        {
            NotBlank = false;
        }
        field(2; "Date Entered"; Date)
        {
        }
        field(3; "Time Entered"; Time)
        {
        }
        field(4; "Entered By"; Code[40])
        {
        }
        field(5; "SMS Type"; Option)
        {
            OptionCaption = 'Everyone,Branch,Product,Branch & Product,Employer,Gender,Religion,Status';
            OptionMembers = Everyone,Branch,Product,"Branch & Product",Employer,Gender,Religion,Status;
        }
        field(6; "SMS Status"; Option)
        {
            OptionMembers = Pending,Sent,Cancelled;
        }
        field(7; "Status Date"; Date)
        {
        }
        field(8; "Status Time"; Time)
        {
        }
        field(9; "Status By"; Code[40])
        {
        }
        field(10; Message_; Text[2000])
        {
        }
        field(11; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(12; "Message to Use"; Option)
        {
            OptionCaption = ' ,Header Message,Line Message';
            OptionMembers = " ","Header Message","Line Message";
        }
        field(13; Status; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(14; "Approval Status"; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(15; "Filter Type"; enum "Bulk Sms Filter Type")
        {
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
        }
        field(5701; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Branch Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Last Date Modified");
            end;
        }
        field(5702; Product; Code[20])
        {
            TableRelation = "Product Setup" where("Product Class" = const(Savings));
        }
        field(5703; "Charge SMS Fee"; Boolean)
        {
        }
        field(5704; "Active Members Only"; Boolean)
        {
        }
        field(5705; "Product Balance Filter"; Text[30])
        {
            DataClassification = ToBeClassified;
        }

        field(50117; "Member Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Member,"Staff Members","Board Members",Delegates,"Non-Member"," ";
        }

        field(50118; "Entries"; Integer)
        {
            CalcFormula = count("Bulk SMS Lines" where("No" = field("No")));
            FieldClass = FlowField;
        }
        field(50119; "Employer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(50200; Gender; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "  ",Male,Female;
        }
        field(50201; Religion; Option)
        {
            OptionMembers = " ",Christian,Muslim;
        }
        field(50202; "Member Status"; Enum "Member Status Enum")
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin


        if No = '' then begin
            NoSetup.Get;
            NoSetup.TestField(NoSetup."BULK SMS Nos");
            No := NoSeriesMgt.GetNextNo(NoSetup."BULK SMS Nos");
        end;

        "Date Entered" := Today;
        "Time Entered" := Time;
        "Entered By" := UserId;
        "Member Category" := "Member Category"::" ";
    end;

    var
        NoSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit "No. Series";

    procedure ImportTelephoneFromExcel()
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
        BulkSMSLines: Record "Bulk SMS Lines";
        FromFolder: Text;
        Buffer: Record "Bulk SMS Lines";
        InStream: InStream;
    begin


        // Use UploadIntoStream for cloud compatibility
        if not UploadIntoStream(OpenExcelFile, '', ExcelFileFilter, FileName, InStream) then
            exit;

        // Import from stream instead of file path
        SheetName := TempExcelBuffer.SelectSheetsNameStream(InStream);
        TempExcelBuffer.OpenBookStream(InStream, SheetName);
        TempExcelBuffer.ReadSheet;
        TempExcelBuffer.SetFilter("Row No.", '>%1', 1);
        Total := TempExcelBuffer.Count;



        /*ONPREMUPGRADE
        File.Upload(OpenExcelFile, FromFolder, ExcelFileFilter, FileName, ServerFileName);

        if not File.Exists(ServerFileName) then exit;

        //ServerFileName := FileMgt.UploadFileSilent(FileName);


        SheetName := TempExcelBuffer.SelectSheetsName(ServerFileName);
        TempExcelBuffer.OpenBook(ServerFileName, SheetName);
        TempExcelBuffer.ReadSheet;
        TempExcelBuffer.SetFilter("Row No.", '>%1', 1);
        Total := TempExcelBuffer.Count;
        */



        Buffer.Reset();
        Buffer.SetRange("No", "No");
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

                BulkSMSLines.Init;
                BulkSMSLines.No := Rec.No;
                case TempExcelBuffer."Column No." of
                    1:
                        begin
                            Evaluate(BulkSMSLines."Phone No.", TempExcelBuffer."Cell Value as Text");
                            BulkSMSLines.Insert;
                        end;
                    2:
                        begin
                            Evaluate(BulkSMSLines."Sms Message", TempExcelBuffer."Cell Value as Text");
                            BulkSMSLines.Modify;
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

