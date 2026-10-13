
Table 50115 "Monthly Checkoff Header"
{
    LookupPageId = "CheckOff List";
    DrillDownPageId = "CheckOff List";

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    NoSetup.Get();
                    NoSeries.TestManual(NoSetup."Checkoff No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Date Entered"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Time Entered"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Entered By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                GenerateDocument()
            end;
        }
        field(7; "Account Type"; Enum "Gen. Journal Account Type")
        {
            DataClassification = ToBeClassified;
            ValuesAllowed = Customer, "G/L Account";
        }
        field(8; "Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Account Type" = filter(Customer)) Customer."No." where("Account Type" = const("Employer"), Type = const(Checkoff))
            else
            if ("Account Type" = filter("Bank Account")) "Bank Account"."No."
            else
            if ("Account Type" = filter("G/L Account")) "G/L Account"."No.";

            trigger OnValidate()
            var
                GLAcc: Record "G/L Account";
                BankAcc: Record "Bank Account";
            begin
                "Employer Code" := '';
                "Employer Name" := '';

                if Customer.Get("Account No.") then begin
                    "Account Name" := Customer.Name;
                    validate("Employer Code", "Account No.");
                end else
                    if GLAcc.Get("Account No.") then begin
                        "Account Name" := GLAcc.Name;
                    end else
                        if BankAcc.Get("Account No.") then begin
                            "Account Name" := BankAcc.Name;
                        end else
                            "Account Name" := '';
            end;
        }
        field(9; "Account Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "CHK Line Amount"; Decimal)
        {
            Editable = false;
            CalcFormula = sum("Monthly Checkoff Lines".Amount where("Checkoff Header" = field("No.")));
            FieldClass = FlowField;
        }
        field(13; "Employer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer where("Account Type" = const(Employer), Type = const(Checkoff));

            trigger OnValidate()
            begin
                if Customer.Get("Employer Code") then begin
                    "Employer Name" := Customer.Name;
                end else
                    "Employer Name" := '';
            end;
        }
        field(14; "Employer Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; "Total Count"; Integer)
        {
            Editable = false;
            CalcFormula = count("Monthly Checkoff Lines" where("Checkoff Header" = field("No.")));
            FieldClass = FlowField;
        }
        field(16; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(17; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(18; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(19; "Posted Records"; Integer)
        {
            Editable = false;
            CalcFormula = count("Monthly Checkoff Lines" where("Checkoff Header" = field("No."),
                                                                Posted = filter(true)));
            FieldClass = FlowField;
        }
        field(20; "Vendor No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No." where("Creditor Type" = filter(<> Fosa));
        }
        field(21; "CHK Buffer Amount"; Decimal)
        {
            Editable = false;
            CalcFormula = sum("Monthly Checkoff Buffer".Amount where("Checkoff No" = field("No.")));
            DecimalPlaces = 2 : 2;
            FieldClass = FlowField;
        }
        field(34; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(35; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(36; "Receipt No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Receipt Header"."No." where(Posted = const(true), "Account No." = field("Account No."));
            trigger OnValidate()
            var
                CLedger: Record "Cust. Ledger Entry";
                RecAmt: Decimal;
                RecHeader: Record "Receipt Header";
            begin
                "Amount Already Posted" := 0;
                "Amount Pending" := 0;

                if "Receipt No." <> '' then begin

                    CLedger.Reset();
                    CLedger.SetRange("Customer No.", "Account No.");
                    CLedger.SetRange("External Document No.", "Receipt No.");
                    CLedger.SetRange(Reversed, false);
                    if CLedger.FindFirst() then begin
                        repeat
                            CLedger.CalcFields("Amount (LCY)");
                            "Amount Already Posted" += CLedger."Amount (LCY)";
                        until CLedger.Next() = 0;
                    end;
                    RecHeader.Get("Receipt No.");
                    "Amount Pending" := RecHeader."Amount Recieved" - "Amount Already Posted";
                    if "Amount Pending" = 0 then
                        Error('CheckOff has got zero balance pending');
                end;

            end;
        }

        field(37; "Receipt Amount"; Decimal)
        {
            Editable = false;
            CalcFormula = sum("Receipt Header"."Amount Recieved" where(Posted = const(true), "No." = field("Receipt No.")));
            FieldClass = FlowField;
        }

        field(38; "Amount Already Posted"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(39; "Amount Pending"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(40; "Batch Entries"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(41; "No. Of Batches"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(42; Reversed; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(80; "Total Principal"; Decimal)
        {
            Editable = false;
            CalcFormula = sum("Monthly Checkoff Lines".Amount where("Checkoff Header" = field("No."), Type = const(Principal)));
            FieldClass = FlowField;
        }

        field(81; "Total Interest"; Decimal)
        {
            Editable = false;
            CalcFormula = sum("Monthly Checkoff Lines".Amount where("Checkoff Header" = field("No."), Type = const(Interest)));
            FieldClass = FlowField;
        }

        field(82; "Captured By"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }

        field(83; "Total Loan"; Decimal)
        {
            Editable = false;
            CalcFormula = sum("Monthly Checkoff Buffer"."Loan Amount" where("Checkoff No" = field("No.")));
            // CalcFormula = sum("Monthly Checkoff Lines".Amount where("Checkoff Header" = field("No."), Type = const(Interest), Type = const(Principal)));
            FieldClass = FlowField;
        }

        field(84; "Total Savings"; Decimal)
        {
            Editable = false;
            CalcFormula = sum("Monthly Checkoff Buffer"."Savings Amount" where("Checkoff No" = field("No.")));
            //CalcFormula = sum("Monthly Checkoff Lines".Amount where("Checkoff Header" = field("No."), "Savings Account" = const(true)));
            FieldClass = FlowField;
        }

        field(85; Loan; Decimal)
        {
            Editable = false;
            trigger OnValidate()
            var
                TLoan: Decimal;
            begin
                Loan := "Total Principal" + "Total Interest";
            end;
        }
        field(86; "Advice No"; Code[20])
        {
            TableRelation = "Monthly Advice Header" where("Employer Code" = field("Employer Code") /*, "Variance Advice" = const(true)*/);
            trigger OnValidate()
            var
                myInt: Integer;
                MAdvice: Record "Monthly Advice Header";
            begin
                MAdvice.Get("Advice No");
                "Loan Cut-Off Date" := MAdvice."End Date";
            end;
        }

        field(87; "Checkoff-Period"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = January,February,March,April,May,June,July,August,September,October,November,December;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                TestField("Reporting Period");
                GenerateDocument();
            end;
        }
        field(88; "Checkoff Loan Posting"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Current Day","End Previous Month";

            trigger OnValidate()
            begin
                /* if "Checkoff Loan Posting" = "Checkoff Loan Posting"::"Current Day" then
                    "Posting Date" := Today
                else
                    "Posting Date" := CalcDate('-CM-1D', Today); */


                GenerateDocument();
            end;

        }
        field(89; "Loan Cut-Off Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

            end;
        }
        field(51200; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = true;
            TableRelation = "Dimension Set Entry";
            trigger OnLookup()
            var
                OldDimSetID: Integer;
                IsHandled: Boolean;
                DimMgt: Codeunit DimensionManagement;
            begin

                OldDimSetID := "Dimension Set ID";
                "Dimension Set ID" :=
                  DimMgt.EditDimensionSet(
                    Rec, "Dimension Set ID", "No.", "Global Dimension 1 Code", "Global Dimension 2 Code");

                //IsChanged := OldDimSetID <> "Dimension Set ID";
            end;

            trigger OnValidate()
            var
                DimMgt: Codeunit DimensionManagement;
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Global Dimension 1 Code", "Global Dimension 2 Code");
            end;
        }

        field(51201; "Checkoff Type"; Option)
        {
            OptionMembers = "Single Checkoff","Block Checkoff";
        }
        field(51202; "Reporting Period"; Date)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."Checkoff No.");
            "No." := NoSeries.GetNextNo(NoSetup."Checkoff No.", WorkDate(), true);
        end;

        "Date Entered" := Today;
        "Time Entered" := Time;
        "Entered By" := UserId;
        UserSetup.Get(UserId);
        "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
        "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
        "Account Type" := "Account Type"::Customer;
        "Checkoff Type" := "Checkoff Type"::"Block Checkoff";
        "Batch Entries" := 6000;

        UserSetup.Get(UserId);
        UserSetup.TestField("Global Dimension 2 Code");
        "Captured By" := UserId;
        //"Posting Date" := Today;

    end;


    var
        NoSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";
        Customer: Record Customer;
        UserSetup: Record "User Setup";


    local procedure GenerateDocument()

    begin
        IF ("Account No." <> '') AND ("Posting Date" <> 0D) THEN BEGIN
            Customer.GET("Account No.");
            Customer.TESTFIELD(Initials);
            //"Document No." := UPPERCASE(PADSTR(COPYSTR(FORMAT("Posting Date", 0, '<Month Text>'), 1, 3) + FORMAT(DATE2DMY("Posting Date", 3)) + Customer.Initials + 'PAYROLL', 20));
            "Document No." := UPPERCASE(PADSTR(COPYSTR(FORMAT("Checkoff-Period"), 1, 3) + FORMAT(DATE2DMY("Posting Date", 3)) + Customer.Initials + 'PAYROLL', 20));
            Description := "Document No."; //UPPERCASE(PADSTR(COPYSTR(FORMAT("Posting Date", 0, '<Month Text>'), 1, 3) + FORMAT(DATE2DMY("Posting Date", 3)) + Customer.Initials + 'PAYROLL', 50));
        END;
    end;

    procedure ImportCheckOffLinesFromExcel()

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
        Buffer: Record "Monthly Checkoff Buffer";
        InStream: InStream;
    begin
        //FileName := FileMgt.OpenFileDialog(OpenExcelFile,FileName,ExcelFileFilter);

        //File.Upload(OpenExcelFile, FromFolder, ExcelFileFilter, FileName, ServerFileName);

        //if not File.Exists(ServerFileName) then exit;

        //ServerFileName := FileMgt.UploadFileSilent(FileName);
        if not UploadIntoStream(OpenExcelFile, '', ExcelFileFilter, FileName, InStream) then
            exit;

        // Import from stream instead of file path
        SheetName := TempExcelBuffer.SelectSheetsNameStream(InStream);
        TempExcelBuffer.OpenBookStream(InStream, SheetName);
        TempExcelBuffer.ReadSheet;
        TempExcelBuffer.SetFilter("Row No.", '>%1', 1);
        Total := TempExcelBuffer.Count;

        Buffer.Init();
        Buffer.SetRange("Checkoff No", "No.");
        if Buffer.FindFirst() then
            Buffer.DeleteAll();

        //SheetName := TempExcelBuffer.SelectSheetsName(ServerFileName);
        //TempExcelBuffer.OpenBook(ServerFileName, SheetName);
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

                            Buffer.Init;
                            Buffer."Checkoff No" := "No.";
                            Evaluate(Buffer.Payroll, TempExcelBuffer."Cell Value as Text");
                        end;
                    2:
                        begin
                            Evaluate(Buffer.Amount, TempExcelBuffer."Cell Value as Text");
                        end;
                    /* 3:
                         begin
                             Evaluate(Buffer."Loan Amount", TempExcelBuffer."Cell Value as Text");
                         end;
                     4:
                         Begin
                             Evaluate(Buffer."Search Code", TempExcelBuffer."Cell Value as Text");
                         end;*/
                    3:
                        Begin
                            Evaluate(Buffer.No, TempExcelBuffer."Cell Value as Text");
                            Buffer.Insert;
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



    procedure ImportSingleCheckOffLinesFromExcel()

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
        Buffer: Record "Monthly Checkoff Buffer";
        InStream: InStream;
    begin
        //FileName := FileMgt.OpenFileDialog(OpenExcelFile,FileName,ExcelFileFilter);

        //File.Upload(OpenExcelFile, FromFolder, ExcelFileFilter, FileName, ServerFileName);

        //if not File.Exists(ServerFileName) then exit;

        //ServerFileName := FileMgt.UploadFileSilent(FileName);

        Buffer.Init();
        Buffer.SetRange("Checkoff No", "No.");
        if Buffer.FindFirst() then
            Buffer.DeleteAll();

        if not UploadIntoStream(OpenExcelFile, '', ExcelFileFilter, FileName, InStream) then
            exit;

        // Import from stream instead of file path
        SheetName := TempExcelBuffer.SelectSheetsNameStream(InStream);
        TempExcelBuffer.OpenBookStream(InStream, SheetName);
        TempExcelBuffer.ReadSheet;
        TempExcelBuffer.SetFilter("Row No.", '>%1', 1);
        Total := TempExcelBuffer.Count;

        //SheetName := TempExcelBuffer.SelectSheetsName(ServerFileName);
        // TempExcelBuffer.OpenBook(ServerFileName, SheetName);
        // TempExcelBuffer.ReadSheet;
        // TempExcelBuffer.SetFilter("Row No.", '>%1', 1);
        // Total := TempExcelBuffer.Count;
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
                            Buffer."Checkoff No" := "No.";
                            Evaluate(Buffer.Payroll, TempExcelBuffer."Cell Value as Text");
                        end;
                    2:
                        begin
                            Evaluate(Buffer.Amount, TempExcelBuffer."Cell Value as Text");
                        end;
                    3:
                        begin
                            Evaluate(Buffer."Reporting Name", TempExcelBuffer."Cell Value as Text");
                        end;
                    /*
                    4:
                       Begin
                           Evaluate(Buffer."Search Code", TempExcelBuffer."Cell Value as Text");
                       end;
                    */
                    4:
                        Begin
                            Evaluate(Buffer.No, TempExcelBuffer."Cell Value as Text");
                            Buffer.Insert;
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

    procedure ImportShareCapitalCheckOffLinesFromExcel()

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
        Buffer: Record "Monthly Checkoff Buffer";
        InStream: InStream;
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

        Buffer.Init();
        Buffer.SetRange("Checkoff No", "No.");
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
                            Buffer."Checkoff No" := "No.";
                            Evaluate(Buffer.Payroll, TempExcelBuffer."Cell Value as Text");
                        end;
                    2:
                        begin
                            Evaluate(Buffer."Share Capital", TempExcelBuffer."Cell Value as Text");
                        end;
                    3:
                        begin
                            Evaluate(Buffer.No, TempExcelBuffer."Cell Value as Text");

                            Buffer.Insert;
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

