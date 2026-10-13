//namespace CentralDB.CentralDB;

page 50736 "FOSA interest Card - Annually"
{
    ApplicationArea = All;
    Caption = 'FOSA interest Card - Annually';
    PageType = Card;
    SourceTable = "FOSA Interest Header";
    PromotedActionCategories = 'Process';

    layout
    {
        area(content)
        {

            group(General)
            {
                Editable = EditablBool;
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No field.';
                    Editable = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("EndDate"; Rec."EndDate")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Period Name"; Rec."Period Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Period Name field.';

                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Created field.';
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.';
                    Editable = false;
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Posted field.';
                    Editable = false;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted By field.';
                    Editable = false;
                }
                field("All Savings Products"; Rec."All Savings Products")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Savings Product field.';
                    trigger OnValidate()
                    begin
                        if Rec."All Savings Products" = true then begin
                            SavingProductBool := false;
                            Rec."Savings Product" := '';
                            Rec."Savings Product Description" := '';
                        end
                        else
                            SavingProductBool := true

                    end;
                }
                field("Savings Product"; Rec."Savings Product")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Savings Product field.';
                    LookupPageId = "Product Setup List";
                    Editable = SavingProductBool;
                    trigger OnValidate()
                    begin
                        Rec."All Savings Products" := false;
                    end;
                }
                field("Savings Product Description"; Rec."Savings Product Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Savings Product Description field.';
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'FOSA Posting Status';
                    Editable = false;

                }
                field("Total Interest"; Rec."Total Interest")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total Interest';
                    Editable = false;

                }
                field("No Of Lines"; Rec."No Of Lines")
                {
                    ApplicationArea = All;
                    ToolTip = 'No Of Lines';
                    Editable = false;

                }
                field("Batch Entries"; Rec."Batch Entries")
                {
                    ApplicationArea = All;
                    ToolTip = 'Batch Entries';
                }
                field("No Of Batches"; Rec."No Of Batches")
                {
                    ApplicationArea = All;
                    ToolTip = 'No Of Batches';
                    Editable = False;
                }


            }
            part(Control20; "FOSA Interest Lines")
            {
                SubPageLink = "Header No" = field(No);
            }
            part(Control21; "FOSA Interest Buffer List")
            {
                SubPageLink = "Header No." = field(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Generate Interest")
            {
                ApplicationArea = Basic;
                Image = GetLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    AccountList: Record "Savings Accounts";
                    MemberAccounts: Record "Savings Accounts";
                    FOSALines: Record "FOSA Interest Lines";
                    ProductList: Record "Product Setup";
                    SmallestBalance: Decimal;
                    DayCount: integer;
                    AsAt: Date;
                    Skip: Boolean;
                    TotalInterestAmount: Decimal;
                    dWindow: Dialog;
                    CurrentRecordNo: Integer;
                    NoOfRecords: Integer;
                    MemberLedgerEntires: Record "Member Ledger Entry";
                begin
                    if not confirm('Are you sure you want to generate interest?') then
                        exit;

                    if Rec."All Savings Products" <> true then
                        Rec.TestField("Savings Product");

                    Rec.TestField("Start Date");
                    Rec.TestField(EndDate);
                    Rec.TestField("Posting Date");


                    TotalInterestAmount := 0;

                    FOSALines.RESET;
                    FOSALines.SetRange("Header No", Rec.No);
                    FOSALines.DeleteAll();


                    ProductList.RESET;
                    ProductList.Setrange("Earns Interest", true);
                    ProductList.SetFilter("Product Category", '<>%1&<>%2&<>%3&<>%4', ProductList."Product Category"::"Registration Fee", ProductList."Product Category"::"Share Capital", ProductList."Product Category"::"Deposit Contribution", ProductList."Product Category"::"FOSA Shares");
                    ProductList.Setrange("Product Class", ProductList."Product Class"::Savings);
                    if Rec."All Savings Products" = false then
                        ProductList.Setrange("Product ID", Rec."Savings Product");
                    If ProductList.Findfirst then begin
                        repeat
                            AccountList.RESET;
                            AccountList.SetRange("Product Type", ProductList."Product ID");
                            IF AccountList.Findfirst then begin
                                dWindow.Open('Generating FOSA Interest Lines:        #1#########\'
                                        + 'Accounts:             #2#########\'
                                        + 'Counter:              #3#########\'
                                        + 'Progress:             @4@@@@@@@@@\'
                                        + 'Press Esc to abort');



                                CurrentRecordNo := 0;
                                NoOfRecords := AccountList.Count;
                                dWindow.Update(2, NoOfRecords);
                                repeat
                                    CurrentRecordNo += 1;
                                    dWindow.Update(3, CurrentRecordNo);
                                    dWindow.Update(4, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));

                                    SmallestBalance := 0;
                                    DayCount := 1;
                                    Skip := False;


                                    //BEGINING OF THE MONTH
                                    MemberAccounts.RESET;
                                    MemberAccounts.SETRANGE(MemberAccounts."No.", AccountList."No.");
                                    MemberAccounts.SETFILTER(MemberAccounts."Date Filter", '..%1', Rec."Start Date");
                                    IF MemberAccounts.FIND('-') THEN begin
                                        if Rec."Start Date" < DMY2Date(01, 12, 2022) then begin
                                            MemberAccounts.CALCFIELDS(MemberAccounts."Old Balance");
                                            if MemberAccounts."Old Balance" <= 0 then
                                                Skip := True;
                                        end
                                        else begin
                                            MemberAccounts.CALCFIELDS(MemberAccounts."Net Change (LCY)");
                                            if MemberAccounts."Net Change (LCY)" <= 0 then
                                                Skip := True;
                                        end;
                                    end;

                                    if not Skip then begin
                                        //MID MONTH
                                        MemberAccounts.RESET;
                                        MemberAccounts.SETRANGE(MemberAccounts."No.", AccountList."No.");
                                        MemberAccounts.SETFILTER(MemberAccounts."Date Filter", '..%1', DMY2DATE(15, DATE2DMY(Rec."Start Date", 2), DATE2DMY(Rec."Start Date", 3)));
                                        IF MemberAccounts.FIND('-') THEN begin
                                            if Rec."Start Date" < DMY2Date(01, 12, 2022) then begin
                                                MemberAccounts.CALCFIELDS(MemberAccounts."Old Balance");
                                                if MemberAccounts."Old Balance" <= 0 then
                                                    Skip := True;
                                            end
                                            else begin
                                                MemberAccounts.CALCFIELDS(MemberAccounts."Net Change (LCY)");
                                                if MemberAccounts."Net Change (LCY)" <= 0 then
                                                    Skip := True;
                                            end;
                                        end;
                                    end;
                                    if not Skip then begin

                                        //END MONTH
                                        MemberAccounts.RESET;
                                        MemberAccounts.SETRANGE(MemberAccounts."No.", AccountList."No.");
                                        MemberAccounts.SETFILTER(MemberAccounts."Date Filter", '..%1', Rec.EndDate);
                                        IF MemberAccounts.FIND('-') THEN begin
                                            if Rec."Start Date" < DMY2Date(01, 12, 2022) then begin
                                                MemberAccounts.CALCFIELDS(MemberAccounts."Old Balance");
                                                if MemberAccounts."Old Balance" <= 0 then
                                                    Skip := True;
                                            end
                                            else begin
                                                MemberAccounts.CALCFIELDS(MemberAccounts."Net Change (LCY)");
                                                if MemberAccounts."Net Change (LCY)" <= 0 then
                                                    Skip := True;
                                            end;
                                        end;
                                    end;


                                    //DAILY TRANSACTIONS
                                    AsAt := Rec."Start Date";

                                    if not Skip then
                                        Repeat
                                            MemberAccounts.RESET;
                                            MemberAccounts.SETRANGE(MemberAccounts."No.", AccountList."No.");
                                            MemberAccounts.SETFILTER(MemberAccounts."Date Filter", '..%1', AsAt);
                                            IF MemberAccounts.FIND('-') THEN begin
                                                if Rec."Start Date" < DMY2Date(01, 12, 2022) then begin
                                                    MemberAccounts.CALCFIELDS(MemberAccounts."Old Balance");
                                                    if DayCount = 1 then
                                                        SmallestBalance := MemberAccounts."Old Balance"
                                                    else begin
                                                        if MemberAccounts."Old Balance" <= 0 then
                                                            Skip := True;
                                                        if SmallestBalance > MemberAccounts."Old Balance" then
                                                            SmallestBalance := MemberAccounts."Old Balance";
                                                    end;
                                                end
                                                else begin
                                                    MemberAccounts.CALCFIELDS(MemberAccounts."Net Change (LCY)");
                                                    if DayCount = 1 then
                                                        SmallestBalance := MemberAccounts."Net Change (LCY)"
                                                    else begin
                                                        if MemberAccounts."Net Change (LCY)" <= 0 then
                                                            Skip := True;
                                                        if SmallestBalance > MemberAccounts."Net Change (LCY)" then
                                                            SmallestBalance := MemberAccounts."Net Change (LCY)";
                                                    end;
                                                end;
                                            end;
                                            DayCount += 1;
                                            AsAt := CALCDATE('1D', AsAt);

                                        Until (AsAt > Rec.EndDate) OR (Skip);

                                    if SmallestBalance > ProductList."Interest Calc Min Balance" then
                                        if not Skip then begin
                                            FOSALines.Init();
                                            FOSALines."Header No" := Rec.No;
                                            FOSALines."A/C No" := AccountList."No.";
                                            FOSALines."A/C Name" := AccountList.Name;
                                            FOSALines.EndDate := Rec.EndDate;
                                            FOSALines."Product Name" := ProductList.Description;
                                            FOSALines."Saving Product" := ProductList."Product ID";
                                            FOSALines."Least Balance" := SmallestBalance;
                                            FOSALines.Amount := Round((SmallestBalance * ProductList."Interest Rate (Max.)" / 100) * (1 / 12));
                                            FOSALines."Interest Rate" := ProductList."Interest Rate (Max.)";
                                            FOSALines.Insert;
                                        end;


                                until AccountList.Next = 0;
                                dWindow.Close;
                            end;
                        until ProductList.Next() = 0;
                    end;
                    FOSALines.Reset;
                    FOSALines.Setrange("Header No", Rec.No);
                    if FOSALines.FindSet then begin
                        FOSALines.CalcSums(Amount);
                        TotalInterestAmount := FOSALines.Amount;
                    end;
                    Message('Successfully Generated \ \ Total Interest Amount:' + format(TotalInterestAmount))

                end;
            }
            action("Batch Lines")
            {
                ApplicationArea = Basic;
                Image = GetLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    dWindow: Dialog;
                    CurrentRecordNo: Integer;
                    NoOfRecords: Integer;
                    FOSALines: Record "FOSA Interest Lines";
                    BatchNo: Code[10];
                    BatchCounter: Integer;
                begin
                    FOSALines.Reset;
                    FOSALines.SetRange("Header No", Rec.No);
                    if FOSALines.Find('-') then begin
                        BatchNo := '001';
                        BatchCounter := 1;

                        dWindow.Open('Batching FOSA Interest Lines:         #1#########\'
                                                + 'Accounts:             #2#########\'
                                                + 'Counter:              #3#########\'
                                                + 'Progress:             @4@@@@@@@@@\'
                                                + 'Press Esc to abort');

                        CurrentRecordNo := 0;
                        NoOfRecords := FOSALines.Count;
                        dWindow.Update(2, NoOfRecords);

                        repeat


                            CurrentRecordNo += 1;

                            FOSALines."Batch No" := BatchNo;
                            FOSALines.Modify();

                            if BatchCounter = Rec."Batch Entries" then begin
                                BatchCounter := 0;
                                BatchNo := IncStr(BatchNo);
                            end;
                            BatchCounter += 1;

                        until FOSALines.Next = 0;
                        dWindow.Close;
                        Rec."No Of Batches" := BatchNo;
                    end;
                end;
            }
            action("Summary Report")
            {
                ApplicationArea = Basic;
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    dWindow: Dialog;
                    CurrentRecordNo: Integer;
                    NoOfRecords: Integer;
                    FOSALines: Record "FOSA Interest Header";
                    SummaryReport: Report "FOSA Inteerest Summary";
                    BatchNo: Code[10];
                    BatchCounter: Integer;
                begin
                    FOSALines.Reset;
                    FOSALines.SetRange("No", Rec.No);
                    if FOSALines.Find('-') then begin
                        Report.Run(Report::"FOSA Inteerest Summary", true, false, FOSALines);
                    end;
                end;
            }
            action("Generate Buffer")
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    FOSAInterestBuffer: Record "FOSA Interest Buffer";
                    ProductList: Record "Product Setup";
                    FOSALines: Record "FOSA Interest Lines";
                    AccountList: Record "Savings Accounts";
                    FosaList: Record "Savings Accounts";
                    dWindow: Dialog;
                    CurrentRecordNo: Integer;
                    NoOfRecords: Integer;
                    EntryNo: Integer;
                    UserSetup: Record "User Setup";
                begin
                    if not Confirm('Are you sure you want to generate FOSA Interest buffer?') then
                        exit;

                    Rec.TestField(Posted, false);
                    FOSAInterestBuffer.Reset;
                    If FOSAInterestBuffer.FindFirst() then begin
                        if not Confirm('Existing buffer lines will be deleted.Are you sure you want to generate FOSA Interest buffer?') then
                            exit;
                        FOSAInterestBuffer.DeleteAll();
                    end;


                    UserSetup.Get(UserId);
                    UserSetup.TestField("Global Dimension 1 Code");
                    UserSetup.TestField("Global Dimension 2 Code");

                    EntryNo := 1;
                    FOSALines.Reset;
                    FOSALines.SetRange("Header No", Rec.No);
                    if FOSALines.FindFirst() then begin
                        dWindow.Open('Generating FOSA Interest Buffer:        #1#########\'
                                    + 'Accounts:             #2#########\'
                                    + 'Counter:              #3#########\'
                                    + 'Progress:             @4@@@@@@@@@\'
                                    + 'Press Esc to abort');



                        CurrentRecordNo := 0;
                        NoOfRecords := AccountList.Count;
                        dWindow.Update(2, NoOfRecords);

                        repeat
                            CurrentRecordNo += 1;
                            dWindow.Update(3, CurrentRecordNo);
                            dWindow.Update(4, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));

                            ProductList.GET(FOSALines."Saving Product");
                            AccountList.GET(FOSALines."A/C No");
                            FOSALines.Blocked := AccountList.Blocked;
                            FOSALines.Modify();

                            //debit expense - payable
                            /*    FOSAInterestBuffer.INIT();
                                FOSAInterestBuffer."Entry No." := EntryNo;
                                FOSAInterestBuffer."Posting Date" := Rec."Posting Date";
                                FOSAInterestBuffer."Document No." := Rec.No;
                                FOSAInterestBuffer."Account Type" := FOSAInterestBuffer."Account Type"::"G/L Account";
                                FOSAInterestBuffer."Account No." := ProductList."Interest Expense Account";
                                FOSAInterestBuffer.Description := "Period Name" + ' Savings Interest';
                                FOSAInterestBuffer."Member No." := AccountList."Member No.";
                                FOSAInterestBuffer.Validate(Amount, FOSALines.Amount);
                                FOSAInterestBuffer."Header No." := Rec.No;
                                FOSAInterestBuffer."Shortcut Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
                                FOSAInterestBuffer."Shortcut Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                                FOSAInterestBuffer."Product Type" := FOSALines."Saving Product";
                                FOSAInterestBuffer."Product Type Name" := FOSALines."Product Name";
                                FOSAInterestBuffer."Batch No" := FOSALines."Batch No";
                                FOSAInterestBuffer."Bal. Account Type" := FOSAInterestBuffer."Account Type"::"G/L Account";
                                FOSAInterestBuffer."Bal. Account No." := ProductList."Interest Payable Account";
                                FOSAInterestBuffer."Is GL Expense" := true;
                                if FOSAInterestBuffer.Amount <> 0 then
                                    FOSAInterestBuffer.Insert();
                                EntryNo += 1;*/


                            //credit savings account - Payable
                            FOSAInterestBuffer.INIT();
                            FOSAInterestBuffer."Entry No." := EntryNo;
                            FOSAInterestBuffer."Posting Date" := Rec."Posting Date";
                            FOSAInterestBuffer."Document No." := Rec.No;
                            FOSAInterestBuffer."Account Type" := FOSAInterestBuffer."Account Type"::Savings;
                            FOSAInterestBuffer."Account No." := FOSALines."A/C No";
                            FOSAInterestBuffer.Description := Rec."Period Name" + ' Savings Interest';
                            FOSAInterestBuffer."Member No." := AccountList."Member No.";
                            FOSAInterestBuffer.Validate(Amount, FOSALines.Amount * -1);
                            FOSAInterestBuffer."Header No." := Rec.No;
                            FOSAInterestBuffer."Shortcut Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
                            FOSAInterestBuffer."Shortcut Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                            FOSAInterestBuffer."Product Type" := FOSALines."Saving Product";
                            FOSAInterestBuffer."Product Type Name" := FOSALines."Product Name";
                            FOSAInterestBuffer."Batch No" := FOSALines."Batch No";
                            FOSAInterestBuffer.Blocked := AccountList.Blocked;
                            FOSAInterestBuffer."Bal. Account Type" := FOSAInterestBuffer."Account Type"::"G/L Account";
                            FOSAInterestBuffer."Bal. Account No." := ProductList."Interest Payable Account";
                            FOSAInterestBuffer.Insert();
                            EntryNo += 1;

                            //Debit Tax savings account
                            FOSAInterestBuffer.INIT();
                            FOSAInterestBuffer."Entry No." := EntryNo;
                            FOSAInterestBuffer."Posting Date" := Rec."Posting Date";
                            FOSAInterestBuffer."Document No." := Rec.No;
                            FOSAInterestBuffer."Account Type" := FOSAInterestBuffer."Account Type"::Savings;
                            FOSAInterestBuffer."Account No." := FOSALines."A/C No";
                            FOSAInterestBuffer.Description := 'Withholding Tax on Savings Interest';
                            FOSAInterestBuffer."Member No." := AccountList."Member No.";
                            FOSAInterestBuffer.Validate(Amount, Round((FOSALines.Amount * (ProductList."WithHolding Tax" / 100))));
                            FOSAInterestBuffer."Header No." := Rec.No;
                            FOSAInterestBuffer."Shortcut Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
                            FOSAInterestBuffer."Shortcut Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                            FOSAInterestBuffer."Product Type" := FOSALines."Saving Product";
                            FOSAInterestBuffer."Product Type Name" := FOSALines."Product Name";
                            FOSAInterestBuffer."Batch No" := FOSALines."Batch No";
                            FOSAInterestBuffer.Blocked := AccountList.Blocked;
                            FOSAInterestBuffer."Bal. Account Type" := FOSAInterestBuffer."Account Type"::"G/L Account";
                            FOSAInterestBuffer."Bal. Account No." := ProductList."Withholding Tax Account";
                            if FOSAInterestBuffer.Amount <> 0 then
                                FOSAInterestBuffer.Insert();
                            EntryNo += 1;


                            if ProductList."Disbursement Product" <> '' then begin
                                FosaList.Reset();
                                FosaList.SetRange("Member No.", AccountList."Member No.");
                                FosaList.SetRange("Product Type", ProductList."Disbursement Product");
                                if FosaList.FindFirst() then begin
                                    //Credi net fosa savings account
                                    FOSAInterestBuffer.INIT();
                                    FOSAInterestBuffer."Entry No." := EntryNo;
                                    FOSAInterestBuffer."Posting Date" := Rec."Posting Date";
                                    FOSAInterestBuffer."Document No." := Rec.No;
                                    FOSAInterestBuffer."Account Type" := FOSAInterestBuffer."Account Type"::Savings;
                                    FOSAInterestBuffer."Account No." := FOSALines."A/C No";
                                    FOSAInterestBuffer.Description := CopyStr('Net Interest transfer from ' + AccountList."No." + ' to ' + FosaList."No.", 1, 50);
                                    FOSAInterestBuffer."Member No." := AccountList."Member No.";
                                    FOSAInterestBuffer.Amount := FOSALines.Amount - Round((FOSALines.Amount * (ProductList."WithHolding Tax" / 100)));
                                    FOSAInterestBuffer.Validate(Amount);
                                    FOSAInterestBuffer."Header No." := Rec.No;
                                    FOSAInterestBuffer."Shortcut Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
                                    FOSAInterestBuffer."Shortcut Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                                    FOSAInterestBuffer."Product Type" := FOSALines."Saving Product";
                                    FOSAInterestBuffer."Product Type Name" := FOSALines."Product Name";
                                    FOSAInterestBuffer."Batch No" := FOSALines."Batch No";
                                    FOSAInterestBuffer.Blocked := AccountList.Blocked;
                                    FOSAInterestBuffer."Bal. Account Type" := FOSAInterestBuffer."Account Type"::Savings;
                                    FOSAInterestBuffer."Bal. Account No." := FosaList."No.";
                                    if FOSAInterestBuffer.Amount <> 0 then
                                        FOSAInterestBuffer.Insert();
                                    EntryNo += 1;
                                end;
                            end;

                        until FOSALines.Next = 0;
                        dWindow.Close;
                    end;

                    Message('Buffer Generated');

                end;
            }
            action("Generate Accrual Buffer")
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    FOSAInterestBuffer: Record "FOSA Interest Buffer";
                    ProductList: Record "Product Setup";
                    FOSALines: Record "FOSA Interest Lines";
                    AccountList: Record "Savings Accounts";
                    FosaList: Record "Savings Accounts";
                    dWindow: Dialog;
                    CurrentRecordNo: Integer;
                    NoOfRecords: Integer;
                    EntryNo: Integer;
                    UserSetup: Record "User Setup";
                begin
                    if not Confirm('Are you sure you want to generate FOSA Interest buffer?') then
                        exit;

                    Rec.TestField(Posted, false);
                    FOSAInterestBuffer.Reset;
                    If FOSAInterestBuffer.FindFirst() then begin
                        if not Confirm('Existing buffer lines will be deleted.Are you sure you want to generate FOSA Interest Accrual buffer?') then
                            exit;
                        FOSAInterestBuffer.DeleteAll();
                    end;


                    UserSetup.Get(UserId);
                    UserSetup.TestField("Global Dimension 1 Code");
                    UserSetup.TestField("Global Dimension 2 Code");

                    EntryNo := 1;
                    FOSALines.Reset;
                    FOSALines.SetRange("Header No", Rec.No);
                    if FOSALines.FindFirst() then begin
                        dWindow.Open('Generating FOSA Interest Buffer:        #1#########\'
                                    + 'Accounts:             #2#########\'
                                    + 'Counter:              #3#########\'
                                    + 'Progress:             @4@@@@@@@@@\'
                                    + 'Press Esc to abort');



                        CurrentRecordNo := 0;
                        NoOfRecords := AccountList.Count;
                        dWindow.Update(2, NoOfRecords);

                        repeat
                            CurrentRecordNo += 1;
                            dWindow.Update(3, CurrentRecordNo);
                            dWindow.Update(4, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));

                            ProductList.GET(FOSALines."Saving Product");
                            AccountList.GET(FOSALines."A/C No");
                            FOSALines.Blocked := AccountList.Blocked;
                            FOSALines.Modify();

                            //debit expense - payable
                            FOSAInterestBuffer.INIT();
                            FOSAInterestBuffer."Entry No." := EntryNo;
                            FOSAInterestBuffer."Posting Date" := Rec."Posting Date";
                            FOSAInterestBuffer."Document No." := Rec.No;
                            FOSAInterestBuffer."Account Type" := FOSAInterestBuffer."Account Type"::"G/L Account";
                            FOSAInterestBuffer."Account No." := ProductList."Interest Expense Account";
                            FOSAInterestBuffer.Description := Rec."Period Name" + ' Savings Interest';
                            FOSAInterestBuffer."Member No." := AccountList."Member No.";
                            FOSAInterestBuffer.Validate(Amount, FOSALines.Amount);
                            FOSAInterestBuffer."Header No." := Rec.No;
                            FOSAInterestBuffer."Shortcut Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
                            FOSAInterestBuffer."Shortcut Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                            FOSAInterestBuffer."Product Type" := FOSALines."Saving Product";
                            FOSAInterestBuffer."Product Type Name" := FOSALines."Product Name";
                            FOSAInterestBuffer."Batch No" := FOSALines."Batch No";
                            FOSAInterestBuffer."Bal. Account Type" := FOSAInterestBuffer."Account Type"::"G/L Account";
                            FOSAInterestBuffer."Bal. Account No." := ProductList."Interest Payable Account";
                            FOSAInterestBuffer."Is GL Expense" := true;
                            if FOSAInterestBuffer.Amount <> 0 then
                                FOSAInterestBuffer.Insert();
                            EntryNo += 1;

                        until FOSALines.Next = 0;
                        dWindow.Close;
                    end;

                    Message('Buffer Generated');

                end;


            }
            action("Post Accrued Exp.FOSA Interest")
            {
                ApplicationArea = Basic;
                Caption = 'Post Accrued Exp. Interest G/L';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    FOSAInterestHeader: Record "FOSA Interest Header";
                    SaccoActivities: Codeunit "Sacco Activities";
                    FOSABuffer: Record "FOSA Interest Buffer";
                    FOSAGetBatch: Record "FOSA Interest Buffer";
                    UserSetup: Record "User Setup";
                    JTemplate: Code[10];
                    JBatch: Code[10];
                    dWindow: Dialog;
                    CurrentRecordNo: Integer;
                    NoOfRecords: Integer;
                    LastBatchNo: code[10];
                    CurrentBatchNo: code[10];
                    FosaAcc: Record "Savings Accounts";
                    TChannel: Enum "Transaction Channel";
                    PSetup: Record "Product Setup";

                begin
                    if not Confirm('Are you sure you want to post these FOSA  GL Expense Interest') then
                        exit;

                    CurrentBatchNo := '001';
                    UserSetup.Get(UserId);
                    UserSetup.TestField("Payment Journal Template");
                    UserSetup.TestField("Payment Journal Batch");
                    UserSetup.TestField("Dimension Set ID");

                    JBatch := UserSetup."Payment Journal Batch";
                    JTemplate := UserSetup."Payment Journal Template";

                    FOSAGetBatch.Reset;
                    FOSABuffer.SetRange("Is GL Expense", true);
                    FOSAGetBatch.SetRange("Header No.", Rec.No);
                    If FOSAGetBatch.FindLast then
                        LastBatchNo := FOSAGetBatch."Batch No";

                    PSetup.Get(Rec."Savings Product");
                    if PSetup."Check Posting Date" then begin
                        //PSetup.TestField("Posting Date");
                        //if Today < PSetup."Posting Date" then
                        // Error('Posting Date has not reached. Contact your administrator!!')
                    end;

                    repeat
                        FOSABuffer.RESET;
                        FOSABuffer.Setrange(Posted, false);
                        FOSABuffer.SetRange("Is GL Expense", true);
                        FOSABuffer.SetRange("Header No.", Rec.No);
                        FOSABuffer.SetRange("Batch No", CurrentBatchNo);
                        iF FOSABuffer.FindFirst then begin
                            dWindow.Open(
                                        'Post Accrued Exp. FOSA Interest :        #1#########\'
                                        + 'Accounts:             #2#########\'
                                        + 'Counter:              #3#########\'
                                        + 'Progress:             @4@@@@@@@@@\'
                                        + 'Batch No:              #5#########\'

                                        + 'Press Esc to abort');



                            CurrentRecordNo := 0;
                            NoOfRecords := FOSABuffer.Count;
                            dWindow.Update(2, NoOfRecords);

                            SaccoActivities.JournalInit(JTemplate, JBatch);
                            repeat
                                CurrentRecordNo += 1;
                                dWindow.Update(3, CurrentRecordNo);
                                dWindow.Update(4, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));
                                dWindow.Update(5, CurrentBatchNo);
                                if FOSABuffer.Blocked <> FOSABuffer.Blocked::" " then begin
                                    if FosaAcc.get(FOSABuffer."Account No.") then begin
                                        if FosaAcc.Blocked <> FosaAcc.Blocked::" " then begin
                                            FosaAcc.Blocked := FosaAcc.Blocked::" ";
                                            FosaAcc.Modify();
                                        end;
                                    end;
                                end;

                                SaccoActivities.JournalInsert(JTemplate,
                                        JBatch,
                                        FOSABuffer."Document No.",
                                        FOSABuffer."Posting Date",
                                        FOSABuffer."Account Type",
                                        FOSABuffer."Account No.",
                                        FOSABuffer.Description + ' for :' + FOSABuffer."Member No.",
                                        FOSABuffer."Bal. Account Type",
                                        FOSABuffer."Bal. Account No.",
                                        FOSABuffer.Amount,
                                        FOSABuffer."External Document No.",
                                        FOSABuffer."Loan No",
                                        FOSABuffer."Transaction Type",
                                        FOSABuffer."Shortcut Dimension 1 Code",
                                        FOSABuffer."Shortcut Dimension 2 Code",
                                        true,
                                        TChannel::"Fixed Deposit",
                                        UserSetup."Dimension Set ID"
                                        );
                                /* FOSAInterestHeader.Reset;
                                 FOSAInterestHeader.Setrange(No, FOSABuffer."Header No.");
                                 if FOSAInterestHeader.Findfirst then begin
                                     FOSAInterestHeader.Validate(Posted, True);
                                     FOSAInterestHeader.Modify;
                                 end;*/
                                FOSABuffer.Posted := true;
                                FOSABuffer.Modify;

                            until FOSABuffer.Next = 0;
                            SaccoActivities.JournalPost(JTemplate, JBatch);

                            FOSABuffer.RESET;
                            FOSABuffer.Setrange(Posted, false);
                            FOSABuffer.SetRange("Is GL Expense", false);
                            FOSABuffer.SetRange("Header No.", Rec.No);
                            FOSABuffer.SetRange("Batch No", CurrentBatchNo);
                            FOSABuffer.SetFilter(Blocked, '<>%1', FOSABuffer.Blocked::" ");
                            iF FOSABuffer.FindFirst then begin
                                repeat
                                    if FOSABuffer.Blocked <> FOSABuffer.Blocked::" " then begin
                                        if FosaAcc.get(FOSABuffer."Account No.") then begin
                                            if FosaAcc.Blocked = FosaAcc.Blocked::" " then begin
                                                FosaAcc.Blocked := FOSABuffer.Blocked;
                                                FosaAcc.Modify();
                                            end;
                                        end;
                                    end;
                                until FOSABuffer.Next() = 0;
                            end;
                            dWindow.Close;
                        end;
                        CurrentBatchNo := IncStr(CurrentBatchNo);
                    until CurrentBatchNo > LastBatchNo;



                    FOSABuffer.RESET;
                    FOSABuffer.SetRange("Header No.", Rec.No);
                    FOSABuffer.SetRange("Is GL Expense", false);
                    FOSABuffer.SetFilter(Amount, '<>0');
                    if FOSABuffer.FindFirst() then begin

                        FOSABuffer.RESET;
                        FOSABuffer.Setrange(Posted, true);
                        FOSABuffer.SetRange("Header No.", Rec.No);
                        if FOSABuffer.FindFirst() then begin

                            FOSABuffer.RESET;
                            FOSABuffer.Setrange(Posted, false);
                            FOSABuffer.SetRange("Is GL Expense", false);
                            FOSABuffer.SetRange("Header No.", Rec.No);
                            if not FOSABuffer.FindFirst() then begin
                                Rec.Posted := true;
                                Rec."Posted By" := UserId;
                                Rec."Date Posted" := Today;
                                Rec.Modify();
                                CurrPage.Close();
                            end;
                        end;
                    end;


                end;

            }
            action("Post FOSA Interest")
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    FOSAInterestHeader: Record "FOSA Interest Header";
                    SaccoActivities: Codeunit "Sacco Activities";
                    FOSABuffer: Record "FOSA Interest Buffer";
                    FOSAGetBatch: Record "FOSA Interest Buffer";
                    UserSetup: Record "User Setup";
                    JTemplate: Code[10];
                    JBatch: Code[10];
                    dWindow: Dialog;
                    CurrentRecordNo: Integer;
                    NoOfRecords: Integer;
                    LastBatchNo: code[10];
                    CurrentBatchNo: code[10];
                    FosaAcc: Record "Savings Accounts";
                    TChannel: Enum "Transaction Channel";
                    PSetup: Record "Product Setup";

                begin
                    if not Confirm('Are you sure you want to post these FOSA Interest') then
                        exit;

                    CurrentBatchNo := '001';
                    UserSetup.Get(UserId);
                    UserSetup.TestField("Payment Journal Template");
                    UserSetup.TestField("Payment Journal Batch");
                    UserSetup.TestField("Dimension Set ID");

                    JBatch := UserSetup."Payment Journal Batch";
                    JTemplate := UserSetup."Payment Journal Template";

                    FOSAGetBatch.Reset;
                    FOSAGetBatch.SetRange("Header No.", Rec.No);
                    If FOSAGetBatch.FindLast then
                        LastBatchNo := FOSAGetBatch."Batch No";

                    PSetup.Get(Rec."Savings Product");
                    if PSetup."Check Posting Date" then begin
                        PSetup.TestField("Posting Date");
                        if Today < PSetup."Posting Date" then
                            Error('Posting Date has not reached. Contact your administrator!!')
                    end;

                    repeat
                        FOSABuffer.RESET;
                        FOSABuffer.Setrange(Posted, false);
                        FOSABuffer.SetRange("Is GL Expense", false);
                        FOSABuffer.SetRange("Header No.", Rec.No);
                        FOSABuffer.SetRange("Batch No", CurrentBatchNo);
                        iF FOSABuffer.FindFirst then begin
                            dWindow.Open('Post FOSA Interest :        #1#########\'
                                        + 'Accounts:             #2#########\'
                                        + 'Counter:              #3#########\'
                                        + 'Progress:             @4@@@@@@@@@\'
                                        + 'Batch No:              #5#########\'

                                        + 'Press Esc to abort');



                            CurrentRecordNo := 0;
                            NoOfRecords := FOSABuffer.Count;
                            dWindow.Update(2, NoOfRecords);

                            SaccoActivities.JournalInit(JTemplate, JBatch);
                            repeat
                                CurrentRecordNo += 1;
                                dWindow.Update(3, CurrentRecordNo);
                                dWindow.Update(4, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));
                                dWindow.Update(5, CurrentBatchNo);
                                if FOSABuffer.Blocked <> FOSABuffer.Blocked::" " then begin
                                    if FosaAcc.get(FOSABuffer."Account No.") then begin
                                        if FosaAcc.Blocked <> FosaAcc.Blocked::" " then begin
                                            FosaAcc.Blocked := FosaAcc.Blocked::" ";
                                            FosaAcc.Modify();
                                        end;
                                    end;
                                end;
                                SaccoActivities.JournalInsert(JTemplate,
                                        JBatch,
                                        FOSABuffer."Document No.",
                                        FOSABuffer."Posting Date",
                                        FOSABuffer."Account Type",
                                        FOSABuffer."Account No.",
                                        FOSABuffer.Description + ' for :' + FOSABuffer."Member No.",
                                        FOSABuffer."Bal. Account Type",
                                        FOSABuffer."Bal. Account No.",
                                        FOSABuffer.Amount,
                                        FOSABuffer."External Document No.",
                                        FOSABuffer."Loan No",
                                        FOSABuffer."Transaction Type",
                                        FOSABuffer."Shortcut Dimension 1 Code",
                                        FOSABuffer."Shortcut Dimension 2 Code",
                                        true,
                                        TChannel::"Fixed Deposit",
                                        UserSetup."Dimension Set ID"
                                        );
                                FOSAInterestHeader.Reset;
                                FOSAInterestHeader.Setrange(No, FOSABuffer."Header No.");
                                if FOSAInterestHeader.Findfirst then begin
                                    FOSAInterestHeader.Validate(Posted, True);
                                    FOSAInterestHeader.Modify;
                                end;
                                FOSABuffer.Posted := true;
                                FOSABuffer.Modify;

                            until FOSABuffer.Next = 0;
                            SaccoActivities.JournalPost(JTemplate, JBatch);

                            FOSABuffer.RESET;
                            FOSABuffer.Setrange(Posted, false);
                            FOSABuffer.SetRange("Header No.", Rec.No);
                            FOSABuffer.SetRange("Batch No", CurrentBatchNo);
                            FOSABuffer.SetFilter(Blocked, '<>%1', FOSABuffer.Blocked::" ");
                            iF FOSABuffer.FindFirst then begin
                                repeat
                                    if FOSABuffer.Blocked <> FOSABuffer.Blocked::" " then begin
                                        if FosaAcc.get(FOSABuffer."Account No.") then begin
                                            if FosaAcc.Blocked = FosaAcc.Blocked::" " then begin
                                                FosaAcc.Blocked := FOSABuffer.Blocked;
                                                FosaAcc.Modify();
                                            end;
                                        end;
                                    end;
                                until FOSABuffer.Next() = 0;
                            end;
                            dWindow.Close;
                        end;
                        CurrentBatchNo := IncStr(CurrentBatchNo);
                    until CurrentBatchNo > LastBatchNo;



                    FOSABuffer.RESET;
                    FOSABuffer.SetRange("Is GL Expense", false);
                    FOSABuffer.SetRange("Header No.", Rec.No);
                    FOSABuffer.SetFilter(Amount, '<>0');
                    if FOSABuffer.FindFirst() then begin

                        FOSABuffer.RESET;
                        FOSABuffer.Setrange(Posted, true);
                        FOSABuffer.SetRange("Header No.", Rec.No);
                        if FOSABuffer.FindFirst() then begin

                            FOSABuffer.RESET;
                            FOSABuffer.Setrange(Posted, false);
                            FOSABuffer.SetRange("Header No.", Rec.No);
                            if not FOSABuffer.FindFirst() then begin
                                Rec.Posted := true;
                                Rec."Posted By" := UserId;
                                Rec."Date Posted" := Today;
                                Rec.Modify();
                                CurrPage.Close();
                            end;
                        end;
                    end;


                end;

            }

        }

    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Disbursement Period" := Rec."Disbursement Period"::Annually;
    end;

    trigger OnOpenPage()
    begin
        SavingProductBool := True;
        EditablBool := True;
        if Rec.Posted = True then
            EditablBool := False;
    end;

    var
        SavingProductBool: Boolean;
        EditablBool: Boolean;
}
