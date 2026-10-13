
Table 50017 "Receipt Header"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SalesSetup.Get;
                    NoSeries.TestManual(SalesSetup."Receipts Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Posting Date" > Today then Error('You can not post with a future date');
            end;
        }
        field(3; Cashier; Code[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Date Posted"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Time Posted"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Bank Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No." where(
                                                //"Responsibility Center" = field("Responsibility Center"),
                                                "Currency Code" = field("Currency Code"));

            trigger OnValidate()
            begin
                if bank.Get("Bank Code") then
                    "Bank Name" := bank.Name;
            end;
        }
        field(9; Narration; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "On Behalf Of"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Amount Recieved"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          "Dimension Value Type" = const(Standard));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");

                DimVal.Reset;
                //DimVal.SETRANGE(DimVal."Global Dimension No.",2);
                DimVal.SetRange(DimVal.Code, "Global Dimension 1 Code");
                if DimVal.Find('-') then
                    Dim1 := DimVal.Name
            end;
        }
        field(27; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          "Dimension Value Type" = const(Standard));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");

                DimVal.Reset;
                //DimVal.SETRANGE(DimVal."Global Dimension No.",2);
                DimVal.SetRange(DimVal.Code, "Global Dimension 2 Code");
                if DimVal.Find('-') then
                    Dim2 := DimVal.Name
            end;
        }
        field(29; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = ToBeClassified;
            TableRelation = Currency;
        }
        field(30; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(38; "Total Amount"; Decimal)
        {
            CalcFormula = sum("Document Line".Amount where("Header No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(39; "Posted By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(40; "Print No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(41; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(42; "Cheque No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(43; "No. Printed"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Created By"; Code[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(45; "Created Date Time"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(46; "Register No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(47; "From Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(48; "To Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Document Date" > Today then Error('You can not post with a future date');
            end;
        }
        field(50; "External Document No"; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(81; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";

            trigger OnValidate()
            begin


                TestField(Status, Status::Open);
            end;
        }
        field(83; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                DimVal.Reset;
                //DimVal.SETRANGE(DimVal."Global Dimension No.",2);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 3 Code");
                if DimVal.Find('-') then
                    Dim3 := DimVal.Name
            end;
        }
        field(84; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                DimVal.Reset;
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 4 Code");
                if DimVal.Find('-') then
                    Dim4 := DimVal.Name
            end;
        }
        field(86; Dim3; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(87; Dim4; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(88; "Bank Name"; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(89; "Receipt Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Bank,Cash';
            OptionMembers = Bank,Cash;
        }
        field(90; "Account Type"; Option)
        {
            Caption = 'Account Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Savings,Credit';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Savings,Credit;
        }
        field(91; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = ToBeClassified;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                //ShowDimensions
            end;
        }
        field(481; Dim1; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(482; Dim2; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(483; "Customer No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;

            //TableRelation = Members

            TableRelation = if ("Customer Type" = const(Member)) Members where(Type = filter(Member | Group), "Member Status" = filter(<> Withdrawn | <> Deceased))
            else
            if ("Customer Type" = const(Customer)) Customer
            else
            if ("Customer Type" = const("G/L Account")) "G/L Account" where("Direct Posting" = const(true));

            trigger OnValidate()
            Var
                GLAcc: Record "G/L Account";
                RLine: Record "Document Line";
                Savings: Record "Savings Accounts";
                Loans: Record Loans;
                Usersetup: Record "User Setup";
            begin

                "Member Name" := '';
                if Members.Get("Customer No.") then begin
                    "Member Name" := Members.Name;
                    "Received From" := Members.Name;
                    payrollandstaffNo := Members."Payroll/Staff No.";
                    "Global Dimension 2 Code" := Members."Global Dimension 2 Code";

                    RLine.Reset();
                    RLine.setrange("Header No.", "No.");
                    if RLine.Find('-') then
                        RLine.Deleteall();

                    /*
                    Savings.Reset();
                    Savings.SetRange("Member No.", "Customer No.");
                    Savings.SetFilter(Savings."Product Category", '%1|%2|%3',
                        Savings."Product Category"::"Deposit Contribution",
                        Savings."Product Category"::"Share Capital",
                        Savings."Product Category"::"Benevolent Fund"
                        );
                    if Savings.FindFirst() then
                        repeat

                            RLine.Init();
                            RLine."Header No." := "No.";
                            RLine.Grouping := Savings."Product Type";
                            RLine."Account Type" := RLine."Account Type"::Savings;
                            RLine."Member No." := Savings."Member No.";
                            RLine.Type := Savings."Product Type";
                            RLine."Account No." := Savings."No.";
                            RLine.Insert();

                        until Savings.Next() = 0;

                    Loans.Reset();
                    Loans.SetRange("Member No.", "Customer No.");
                    Loans.SetFilter("Total Outstanding Balance", '<>%1', 0);
                    if Loans.FindFirst() then
                        repeat

                            RLine.Init();
                            RLine."Header No." := "No.";
                            RLine.Type := 'LOANS';
                            RLine."Account Type" := RLine."Account Type"::Credit;
                            RLine."Member No." := Loans."Member No.";
                            //RLine.Type := Savings."Product Type";
                            RLine."Account No." := Loans."Loan Account";
                            Rline."Loan No." := Loans."Loan No.";
                            RLine.Insert();

                        until Loans.Next() = 0;
                    */
                end;

                if GLAcc.Get("Customer No.") then begin
                    "Member Name" := GLAcc.Name;
                    "Received From" := GLAcc.Name;
                    payrollandstaffNo := '';
                end;
                if Customer.Get("Customer No.") then begin
                    "Member Name" := Customer.Name;
                    "Received From" := Customer.Name;
                    payrollandstaffNo := '';
                end;

                UserSetup.Get(Cashier);
                UserSetup.TestField("Member No.");
                if "Customer No." = UserSetup."Member No." then
                    Error('You cannot do a transaction on your account. Kindly seek approvals!');
            end;

            trigger OnLookup()
            var
                Cust: Record Members;
                GLAcc: Record "G/L Account";
            begin
                if "Customer Type" = "Customer Type"::Customer then begin
                    Customer.RESET;
                    Customer.SetRange(Type, cust.Type::" ");
                    if Customer.FindFirst() then begin
                        IF PAGE.RUNMODAL(33, Customer) = ACTION::LookupOK THEN BEGIN
                            "Customer No." := Customer."No.";
                            VALIDATE("Customer No.");
                        END
                    end;
                end;
                if "Customer Type" = "Customer Type"::Member then begin
                    cust.RESET;
                    cust.SetFilter(Type, '<>%1', cust.Type::" ");
                    if cust.FindFirst() then begin
                        IF PAGE.RUNMODAL(50174, cust) = ACTION::LookupOK THEN BEGIN
                            "Customer No." := cust."No.";
                            //   "Customer No." := cust."Payroll/Staff No.";
                            VALIDATE("Customer No.");
                            //xxx

                        END
                    end;
                end;
                if "Customer Type" = "Customer Type"::"G/L Account" then begin

                    GLAcc.RESET;
                    GLAcc.SetRange("Direct Posting", true);
                    if GLAcc.FindFirst() then begin
                        IF PAGE.RUNMODAL(Page::"Chart of Accounts", GLAcc) = ACTION::LookupOK THEN BEGIN
                            "Customer No." := GLAcc."No.";
                            //   "Customer No." := cust."Payroll/Staff No.";
                            VALIDATE("Customer No.");
                            //xxx

                        END
                    end;
                end;

            end;
        }
        field(484; "Member Name"; Text[100])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50050; "Pay Mode"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Cash,Cheque,EFT,"Deposit Slip","Banker's Cheque",RTGS,"Mobile Money";
        }
        field(50051; "Cheque/Deposit Slip No"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Cheque No." := "Cheque/Deposit Slip No";
            end;
        }
        field(50052; "Cheque/Deposit Slip Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                SaccoSetup: Record "Sacco Setup";
            begin

                if "Cheque/Deposit Slip Date" > Today then
                    Error('Post dating not allowed');


                SaccoSetup.Get;

                SaccoSetup.Get;
                SaccoSetup.TestField("Cheque Reject Period");
                if "Cheque/Deposit Slip Date" < CalcDate('-' + Format(SaccoSetup."Cheque Reject Period"), Today) then
                    Error('Date not within the acceptable cheque dates');
            end;
        }
        field(50053; "Cheque/Deposit Slip Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " "," Local","Up Country";
        }
        field(50054; "Customer Type"; Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            OptionMembers = Member,Customer,"G/L Account";

            trigger OnValidate()
            begin
                "Customer No." := '';
                "Member Name" := '';
                Narration := '';
            end;
        }
        field(50055; "Received From"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        //HERE
        field(50056; payrollandstaffNo; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        //HERE
        field(50057; "Date Created"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50058; "Total Receipt Buffer Amount"; Decimal)
        {
            CalcFormula = sum("Receipt Buffer Lines".Amount where("Batch No" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50059; "Process Type"; Option)
        {
            OptionMembers = Single,Bulk;
            DataClassification = ToBeClassified;
        }
        field(50060; "Total Document Line Amount"; Decimal)
        {
            CalcFormula = sum("Document Line".Amount where("Header No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50061; "External Doc. Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(50062; "Buffer Amount by Ext. Doc."; Decimal)
        {
            CalcFormula = sum("Receipt Buffer Lines".Amount where("Batch No" = field("No."),
                                                                  "Transaction No." = field("External Doc. Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50063; "Doc. Line Amount by Ext. Doc."; Decimal)
        {
            CalcFormula = sum("Document Line".Amount where("Header No." = field("No."),
                                                           "External Doc." = field("External Doc. Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50064; "Dont Send SMS"; Boolean)
        {
            FieldClass = FlowFilter;
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
        fieldgroup(DropDown; "No.", "Member Name", "Amount Recieved")
        {
        }
    }

    trigger OnInsert()
    begin


        if "No." = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField("Receipts Nos.");
            "No." := NoSeries.GetNextNo(SalesSetup."Receipts Nos.", WorkDate(), true);
        end;

        UserTemplate.Get(UserId);


        "Created By" := UserId;
        "Created Date Time" := CurrentDatetime;
        Cashier := UserId;
        "Date Created" := Today;

        "Global Dimension 1 Code" := UserTemplate."Global Dimension 1 Code";
        "Global Dimension 2 Code" := UserTemplate."Global Dimension 2 Code";
        "Responsibility Center" := UserTemplate."Responsibility Center";
        "Bank Code" := UserTemplate."Default Receipt Bank";
        Validate("Bank Code");

        if not UserTemplate."Create Receipt" then
            Error('YOu do not have permission to create receipts. Please contact your administrator!');

    end;

    var
        NoSeries: Codeunit "No. Series";
        UserTemplate: Record "User Setup";
        RLine: Record "Document Line";
        RespCenter: Record "Responsibility Center";
        DimVal: Record "Dimension Value";
        bank: Record "Bank Account";
        DimMgt: Codeunit DimensionManagement;
        Members: Record Members;
        Customer: Record Customer;
        SalesSetup: Record "Sales & Receivables Setup";

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    procedure ImportReceiptLinesFromExcel()
    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        RcptBufLines: Record "Receipt Buffer Lines";
        InStream: InStream;
        FileName: Text;
        SheetName: Text;
        TotalRows: Integer;
        RowNo: Integer;
        Window: Dialog;
        // Labels
        ImportMsg: Label 'Ensure the Excel format is either old member format: Column 1: Line No., Column 2: Member No., Column 3: Amount, Column 4: Transaction No., Column 5 Batch; or new typed format: Column 1: Line No., Column 2: Type, Column 3: Member/G/L Account No., Column 4: Amount, Column 5: Transaction No., Column 6 Batch.';
        OpenExcelFile: Label 'Select Excel File to Import';
        ExcelFileFilter: Label 'Excel Files (*.xls*)|*.xls*|All Files (*.*)|*.*';
        ProcessMsg: Label 'Processing Row #1####### of #2#######';
        EvalError: Label 'Error evaluating value "%1" in Row %2, Column %3.';
    begin
        // Message(ImportMsg);

        if not UploadIntoStream(OpenExcelFile, '', ExcelFileFilter, FileName, InStream) then
            exit;

        SheetName := TempExcelBuffer.SelectSheetsNameStream(InStream);
        TempExcelBuffer.OpenBookStream(InStream, SheetName);
        TempExcelBuffer.ReadSheet();

        // Functional Cleanup: Clear existing lines for this header before import
        RcptBufLines.SetRange("Batch No", Rec."No.");
        if not RcptBufLines.IsEmpty() then
            RcptBufLines.DeleteAll();

        // Get unique Row count (excluding header)
        TempExcelBuffer.SetFilter("Row No.", '>%1', 1);
        if TempExcelBuffer.FindLast() then
            TotalRows := TempExcelBuffer."Row No." - 1;

        Window.Open(ProcessMsg);

        // Iterate through rows (1 to TotalRows + 1 because we skip the first row)
        for RowNo := 2 to TotalRows + 1 do begin
            Window.Update(1, RowNo - 1);
            Window.Update(2, TotalRows);

            ProcessExcelRow(TempExcelBuffer, RowNo, Rec."No.");
        end;

        Window.Close();
        Message('Import Completed. %1 rows processed.', TotalRows);
    end;

    local procedure ProcessExcelRow(var TempExcelBuffer: Record "Excel Buffer" temporary; RowNo: Integer; CurrentHeaderNo: Code[20])
    var
        RcptBufLines: Record "Receipt Buffer Lines";
        LineNo: Integer;
        BatchNoFromExcel: Code[20];
    begin
        BatchNoFromExcel := GetReceiptImportBatchNo(TempExcelBuffer, RowNo, CurrentHeaderNo);

        // Step 2: Calculate LineNo using the FINAL Batch No
        /* RcptBufLines.SetRange("Batch No", BatchNoFromExcel);
        if RcptBufLines.FindLast() then
            LineNo := RcptBufLines."Line No." + 10000
        else
            LineNo := 10000; */

        // Step 3: Init and assign PK fields together before anything else
        RcptBufLines.Init();
        RcptBufLines."Batch No" := BatchNoFromExcel;
        if TempExcelBuffer.Get(RowNo, 1) then begin
            Evaluate(RcptBufLines."Line No.", TempExcelBuffer."Cell Value as Text");
            RcptBufLines."Line No." := RcptBufLines."Line No.";
        end;

        ApplyReceiptImportAccount(RcptBufLines, TempExcelBuffer, RowNo);

        // Amount
        if TempExcelBuffer.Get(RowNo, GetReceiptImportAmountColumn(TempExcelBuffer, RowNo)) then begin
            // Check if the text is a valid decimal
            if not Evaluate(RcptBufLines.Amount, TempExcelBuffer."Cell Value as Text") then
                Error('Invalid Amount format at Row %1. Value: %2', RowNo, TempExcelBuffer."Cell Value as Text");

            // Validation: Prevent negative or zero amounts
            if RcptBufLines.Amount <= 0 then
                Error('Amount must be greater than zero at Row %1. Found: %2', RowNo, RcptBufLines.Amount);

            RcptBufLines.Validate(Amount);
        end;

        // Transaction No
        if TempExcelBuffer.Get(RowNo, GetReceiptImportTransactionColumn(TempExcelBuffer, RowNo)) then
            RcptBufLines.Validate("Transaction No.", TempExcelBuffer."Cell Value as Text");

        RcptBufLines.Insert(true);
    end;

    local procedure ApplyReceiptImportAccount(var RcptBufLines: Record "Receipt Buffer Lines"; var TempExcelBuffer: Record "Excel Buffer" temporary; RowNo: Integer)
    var
        TypeText: Text;
        AccountNo: Code[20];
    begin
        if IsTypedReceiptImportRow(TempExcelBuffer, RowNo) then begin
            TempExcelBuffer.Get(RowNo, 2);
            TypeText := TempExcelBuffer."Cell Value as Text";
            TempExcelBuffer.Get(RowNo, 3);
            AccountNo := CopyStr(TempExcelBuffer."Cell Value as Text", 1, MaxStrLen(AccountNo));

            if IsGLReceiptImportType(TypeText) then begin
                RcptBufLines.Validate(Type, RcptBufLines.Type::"G/L Account");
                RcptBufLines.Validate("G/L Account No.", AccountNo);
            end else begin
                RcptBufLines.Validate(Type, RcptBufLines.Type::Member);
                RcptBufLines.Validate("Member No", AccountNo);
            end;
        end else begin
            RcptBufLines.Validate(Type, RcptBufLines.Type::Member);
            if TempExcelBuffer.Get(RowNo, 2) then
                RcptBufLines.Validate("Member No", TempExcelBuffer."Cell Value as Text");
        end;
    end;

    local procedure GetReceiptImportBatchNo(var TempExcelBuffer: Record "Excel Buffer" temporary; RowNo: Integer; CurrentHeaderNo: Code[20]): Code[20]
    var
        BatchNoFromExcel: Code[20];
        BatchColumnNo: Integer;
    begin
        BatchColumnNo := 5;
        if IsTypedReceiptImportRow(TempExcelBuffer, RowNo) then
            BatchColumnNo := 6;

        if TempExcelBuffer.Get(RowNo, BatchColumnNo) then
            BatchNoFromExcel := CopyStr(TempExcelBuffer."Cell Value as Text", 1, MaxStrLen(BatchNoFromExcel));

        if BatchNoFromExcel = '' then
            BatchNoFromExcel := CurrentHeaderNo;

        exit(BatchNoFromExcel);
    end;

    local procedure GetReceiptImportAmountColumn(var TempExcelBuffer: Record "Excel Buffer" temporary; RowNo: Integer): Integer
    begin
        if IsTypedReceiptImportRow(TempExcelBuffer, RowNo) then
            exit(4);

        exit(3);
    end;

    local procedure GetReceiptImportTransactionColumn(var TempExcelBuffer: Record "Excel Buffer" temporary; RowNo: Integer): Integer
    begin
        if IsTypedReceiptImportRow(TempExcelBuffer, RowNo) then
            exit(5);

        exit(4);
    end;

    local procedure IsTypedReceiptImportRow(var TempExcelBuffer: Record "Excel Buffer" temporary; RowNo: Integer): Boolean
    var
        TypeText: Text;
    begin
        if not TempExcelBuffer.Get(RowNo, 2) then
            exit(false);

        TypeText := UpperCase(DelChr(TempExcelBuffer."Cell Value as Text", '=', ' '));
        exit((TypeText = 'MEMBER') or (TypeText = 'GL') or (TypeText = 'G/LACCOUNT') or (TypeText = 'G/L') or (TypeText = 'GLACCOUNT'));
    end;

    local procedure IsGLReceiptImportType(TypeText: Text): Boolean
    begin
        TypeText := UpperCase(DelChr(TypeText, '=', ' '));
        exit((TypeText = 'GL') or (TypeText = 'G/LACCOUNT') or (TypeText = 'G/L') or (TypeText = 'GLACCOUNT'));
    end;

    procedure ValidateReceiptLines()
    var
        RcptBufLines: Record "Receipt Buffer Lines";
        Memb: Record Members;
    begin
        RcptBufLines.Reset();
        RcptBufLines.SetRange("Batch No", "No.");
        if RcptBufLines.Find('-') then begin
            repeat
                Memb.Reset();
                Memb.SetRange("No.", RcptBufLines."Member No");
                Memb.SetRange("Member Status", Memb."Member Status"::Active);
                if Memb.Find('-') then begin
                    RcptBufLines.Name := Memb.Name;
                    RcptBufLines."Member Found" := true;
                    RcptBufLines.Modify();
                end;
            until RcptBufLines.Next() = 0;
        end;
        Message('Successfully Validated');
    end;
}
