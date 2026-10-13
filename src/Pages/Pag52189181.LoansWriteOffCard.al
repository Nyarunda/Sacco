page 50883 "Loans Write Off Card"
{
    Caption = 'Loans Write-Off Card';
    PageType = Card;
    SourceTable = "Write offs";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Write Off No"; Rec."Write Off No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan Balance field.';
                    Editable = False;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("FIle Comments"; Rec."FIle Comments")
                {
                    ApplicationArea = All;
                    Editable = EditableBoolean;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Printed By"; Rec."Printed By")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Submitted By"; Rec."Submitted By")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                group(AmountsStats)
                {
                    Caption = 'Documnent Amounts Statistics';

                    field("Interest Balance"; Rec."Interest Balance")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Interest Balance field.';
                        Editable = False;
                    }
                    field("Loan Balance"; Rec."Loan Balance")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Loan Balance field.';
                        Editable = False;
                    }
                    field("Loan + Interest Amount"; Rec."Loan + Interest Amount")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Loan Balance field.';
                        Editable = False;
                    }
                    field("Total Write Off Amount"; Rec."Total Write Off Amount")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Share Capital field.';
                        Editable = False;
                    }
                }
            }
            part(WriteOff; "Loan WriteOff Lines")
            {
                Caption = 'Write-Off Lines';
                Editable = CardEdit;
                ApplicationArea = All;
                SubPageLink = "Write Off No" = field("Write Off No");
            }
        }
    }
    actions
    {
        area(navigation)
        {

            group(RequestApproval)
            {
                Caption = 'Request Approval';
                Visible = false;
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category8;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";


                        DocumentType: Enum "Custom Document Type";
                        VarVariant: Variant;
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        ApprovalEntry: Record "Approval Entry";
                    begin
                        //CheckControls;

                        VarVariant := Rec;
                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec."Write Off No", 0, Documenttype::"Loan Write Off", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", 0);
                        CurrPage.Close();
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category8;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
                    begin
                        Rec.TestField(Status, Rec.Status::Pending);

                        VarVariant := Rec;
                        CalwideApprovals.CancelTracker(VarVariant, Rec."Write Off No");
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category8;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        RecRef: RecordRef;
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Member Application","Loan Application","Savings Application",FDR,"Def. Recovery","Loan Changes","Guarantor Sub.","Member Exit","Member Exit Notice","Member Changes",STO,"Cheque Book App","Account Transfer","Teller Transaction","Micro Transaction",PV,"Petty Cash","Collateral Register","Collateral Return",CheckOff,"Bankers Cheque",Salary,Receipt,"Loan Write Off";
                        VarVariant: Variant;
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocumentType := Documenttype::Salary;

                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", Rec."Write Off No");
                        ApprovalTracker.SetRange("Document Type", DocumentType);
                        if ApprovalTracker.FindFirst then
                            approvalsMgmt.OpenApprovalEntriesPage(ApprovalTracker.RecordId);
                    end;
                }
                action("Reopen Document")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Category8;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
                    begin

                        if Rec.Status = Rec.Status::Pending then begin
                            VarVariant := Rec;
                            CalwideApprovals.CancelTracker(VarVariant, Rec."Write Off No");
                        end
                        else begin

                            if not Confirm('Are you sure you want to re-open this document?') then
                                exit;

                            Rec.Status := Rec.Status::Open;
                            Rec.Modify;
                            CurrPage.Close();
                        end;
                    end;
                }
            }


            action("Print Write-off")
            {
                ApplicationArea = Basic;
                Image = Print;
                Promoted = true;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    WriteOffList.Reset;
                    WriteOffList.setrange("Write Off No", Rec."Write Off No");
                    if WriteOffList.FindFirst() then
                        Report.Run(Report::"Write-off Report", true, false, WriteOffList);

                    if Rec.Status = Rec.Status::Open then begin
                        Rec."Printed By" := UserId;
                        Rec.Modify();
                    end;

                end;
            }

            action("Import Loan Write-Offsf")
            {
                ApplicationArea = Basic;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //RunObject = XMLport "Writeoff Buffer";
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    Message('Ensure the document is as follows: \1. Member No.\2. Loan No.\\ - Document Format should be Excel and Should include the Headers');

                    if Confirm('Are you sure you want to Import WriteOff??') then begin

                        ImportWriteOffOffLinesFromExcel();
                    end;
                end;
            }

            action("Validate Buffer")
            {
                ApplicationArea = Basic;
                Image = Accounts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    MsgValidate: label 'Validation Successful';
                begin
                    WriteoffHeader.Reset;
                    WriteoffHeader.SetRange("Write Off No", Rec."Write Off No");
                    if WriteoffHeader.FindFirst then begin
                        n := 0;
                        f := 0;
                        Buffer.Reset;
                        Buffer.SetRange("Write Off No", Rec."Write Off No");
                        if Buffer.Find('-') then begin
                            dWindow.Open('Validating Buffer:     #1#########\'
                                        + 'Accounts:              #2#########\'
                                        + 'Counter:               #3#########\'
                                        + 'Progress:              @4@@@@@@@@@\'
                                        + 'Press Esc to abort');

                            CurrentRecordNo := 0;
                            NoOfRecords := Buffer.Count;
                            dWindow.Update(2, NoOfRecords);
                            repeat
                                dWindow.Update(1, Buffer."Member No");
                                dWindow.Update(3, CurrentRecordNo);
                                dWindow.Update(4, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));


                                Members.Reset;
                                //Members.SetRange("Employer Code", Buffer."Employer Code");
                                Members.SetRange("No.", Buffer."Member No");
                                if Members.FindFirst then begin
                                    //Buffer."Old Member No" := Members."No.";
                                    Buffer.Validate("Member No");
                                    Buffer.Modify;
                                    f += 1;
                                    if Buffer."Loan No" <> '' then begin

                                        Loans.Reset;
                                        Loans.SetRange("Loan No.", Buffer."Loan No");
                                        Loans.SetRange("Member No.", Members."No.");
                                        //Loans.SetFilter("Outstanding Principal", '>0');
                                        if Loans.FindFirst() then begin
                                            Buffer.Validate("Loan No");
                                            Buffer."Loan Not Found" := false;
                                            Buffer.Modify();
                                            j += 1;
                                        end;
                                    end;
                                end
                                else begin
                                    Buffer."Member Not Found" := true;
                                    Buffer.Modify;
                                    n += 1;
                                end;
                                Buffer.Modify();
                            until Buffer.Next = 0;
                            dWindow.Close;
                        end;
                        Message('Total Accounts %1\Found %2\Not Found %3', Buffer.Count, f, n);

                    end;


                end;
            }
            action("Post Provision Write-off")
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    JTemplate: Text;
                    JBatch: Text;
                    AcctType: Enum "Gen. Journal Account Type";
                    TransType: Enum "Transaction Type Enum";
                    BalAcctType: Enum "Gen. Journal Account Type";
                    WriteOffLines: Record "Write Off Lines";
                    SavAcc: Record Vendor;
                    LoanPrincRunBal: Decimal;
                    PrincBal: Decimal;
                    LoanRunBal: Decimal;
                    LoanIntRunBal: Decimal;
                    IntBal: decimal;
                    Bal: Decimal;
                    SavBal: Decimal;
                    RunSavBal: Decimal;
                    AmountToApply: Decimal;
                    AvailableSavBal: Decimal;
                    LoansList: Record Loans;
                    GenJournalLine: Record "Gen. Journal Line";
                    Product: Record "Product Setup";
                    SActivity: Codeunit "Sacco Activities";
                    DedAmt: Decimal;

                begin
                    if confirm('Are you sure you want to post?') then begin
                        Rec.TestField("FIle Comments");


                        UserSetup.Reset;
                        UserSetup.Setrange("Post Writeoff", true);
                        UserSetup.Setrange("User ID", UserId);
                        if not UserSetup.FindFirst() then
                            error('You do not have the rights to post writeoff');

                        SaccoSetup.get;
                        SaccoSetup.TestField("Writeoff Provision GL");


                        JTemplate := 'GENERAL';
                        JBatch := 'WRITEOFF';

                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                        GenJournalLine.SetRange("Journal Batch Name", JBatch);

                        IntBal := 0;
                        PrincBal := 0;
                        AvailableSavBal := 0;
                        RunSavBal := 0;
                        AmountToApply := 0;




                        WriteOffLines.Reset();
                        WriteOffLines.SetRange("Write Off No", Rec."Write Off No");
                        WriteOffLines.SetRange(Processed, false);
                        if WriteOffLines.findfirst then begin
                            repeat

                                SaccoActivities.JournalInit(JTemplate, JBatch);

                                Loans.Reset;
                                Loans.SetRange("Loan No.", WriteOffLines."Loan No");
                                Loans.SetRange("Member No.", WriteOffLines."Member No");
                                if Loans.FindFirst then begin


                                    LoanRunBal := WriteOffLines."Loan + Interest Amount";
                                    Loans.CalcFields("Outstanding Principal", "Outstanding Interest", "Total Outstanding Balance");
                                    IntBal := Loans."Outstanding Interest";
                                    PrincBal := Loans."Outstanding Principal";



                                    Product.Reset();
                                    Product.SetRange("Can Offset Loan", false);
                                    Product.Setfilter("Product Category", '%1', Product."Product Category"::"Deposit Contribution");
                                    IF Product.FindFirst() THEN begin
                                        Error('Update Deposit Product to Allow Loan Offset in Product Setup');
                                    end;

                                    Product.Reset();
                                    Product.SetRange("Can Offset Loan", true);
                                    Product.Setfilter("Product Category", '<>%1&<>%2', Product."Product Category"::"Share Capital", Product."Product Category"::"Registration Fee");
                                    if Product.FindFirst() then begin
                                        repeat

                                            SavAcc.Reset();
                                            SavAcc.SetRange("Member No.", Loans."Member No.");
                                            SavAcc.SetRange("Product Type", Product."Product ID");
                                            if SavAcc.FindFirst() then begin
                                                repeat

                                                    SavAcc.CalcFields(Balance);
                                                    AvailableSavBal := SavAcc.Balance - SaccoActivities.GetJournalDebits(JTemplate, JBatch, AcctType::Savings, SavAcc."No.");

                                                    //INTEREST 
                                                    IF (IntBal > 0) and (AvailableSavBal > 0) then begin
                                                        DedAmt := IntBal;
                                                        if DedAmt > AvailableSavBal then
                                                            DedAmt := AvailableSavBal;

                                                        if DedAmt < 0 then
                                                            DedAmt := 0;

                                                        IntBal -= DedAmt;
                                                        AvailableSavBal -= DedAmt;


                                                        SaccoActivities.JournalInsert(
                                                                        JTemplate,
                                                                        JBatch,
                                                                        WriteOffLines."Write Off No",
                                                                        Today,
                                                                        Accttype::Credit,
                                                                        WriteOffLines."Member No",
                                                                        CopyStr('Interest Write-off: ' + SavAcc."Product Name", 1, 50),
                                                                        Balaccttype::"G/L Account",
                                                                        '',
                                                                        -DedAmt,
                                                                        WriteOffLines."Write Off No",
                                                                        WriteOffLines."Loan No",
                                                                        Transtype::"Interest Paid",
                                                                        Rec."Global Dimension 1 Code",
                                                                        Rec."Global Dimension 2 Code",
                                                                        true,
                                                                        TChannel,
                                                                        DimID
                                                                        );

                                                        SaccoActivities.JournalInsert(
                                                                    JTemplate,
                                                                    JBatch,
                                                                    WriteOffLines."Write Off No",
                                                                    Today,
                                                                    Accttype::Savings,
                                                                    SavAcc."No.",
                                                                    CopyStr('Interest Write-off: ' + WriteOffLines."Loan No", 1, 50),
                                                                    Balaccttype::"G/L Account",
                                                                    '',
                                                                    DedAmt,
                                                                    WriteOffLines."Write Off No",
                                                                    '',
                                                                    Transtype::" ",
                                                                    Rec."Global Dimension 1 Code",
                                                                    Rec."Global Dimension 2 Code",
                                                                    true,
                                                                    TChannel,
                                                                    DimID
                                                                    );
                                                    end;
                                                    //Principal 

                                                    IF (PrincBal > 0) and (AvailableSavBal > 0) then begin
                                                        DedAmt := PrincBal;
                                                        if DedAmt > AvailableSavBal then
                                                            DedAmt := AvailableSavBal;

                                                        if DedAmt < 0 then
                                                            DedAmt := 0;

                                                        PrincBal -= DedAmt;
                                                        AvailableSavBal -= DedAmt;


                                                        SaccoActivities.JournalInsert(
                                                                        JTemplate,
                                                                        JBatch,
                                                                        WriteOffLines."Write Off No",
                                                                        Today,
                                                                        Accttype::Credit,
                                                                        WriteOffLines."Member No",
                                                                        CopyStr('Principal Write-off: ' + SavAcc."Product Name", 1, 50),
                                                                        Balaccttype::"G/L Account",
                                                                        '',
                                                                        -DedAmt,
                                                                        WriteOffLines."Write Off No",
                                                                        WriteOffLines."Loan No",
                                                                        Transtype::"Principal Repayment",
                                                                        Rec."Global Dimension 1 Code",
                                                                        Rec."Global Dimension 2 Code",
                                                                        true,
                                                                        TChannel,
                                                                        DimID
                                                                        );

                                                        SaccoActivities.JournalInsert(
                                                                    JTemplate,
                                                                    JBatch,
                                                                    WriteOffLines."Write Off No",
                                                                    Today,
                                                                    Accttype::Savings,
                                                                    SavAcc."No.",
                                                                    CopyStr('Principal Write-off: ' + WriteOffLines."Loan No", 1, 50),
                                                                    Balaccttype::"G/L Account",
                                                                    '',
                                                                    DedAmt,
                                                                    WriteOffLines."Write Off No",
                                                                    '',
                                                                    Transtype::" ",
                                                                    Rec."Global Dimension 1 Code",
                                                                    Rec."Global Dimension 2 Code",
                                                                    true,
                                                                    TChannel,
                                                                    DimID
                                                                    );

                                                    end;

                                                until SavAcc.Next() = 0;
                                            end;
                                        until Product.Next() = 0;
                                    end;


                                    if IntBal > 0 then begin

                                        SaccoActivities.JournalInsert(
                                                        JTemplate,
                                                        JBatch,
                                                        WriteOffLines."Write Off No",
                                                        Today,
                                                        Accttype::Credit,
                                                        Loans."Member No.",
                                                        CopyStr('Interest Write-off: Provision' + WriteOffLines."Loan No", 1, 50),
                                                        Balaccttype::"G/L Account",
                                                        SaccoSetup."Writeoff Provision GL",
                                                        -IntBal,
                                                        WriteOffLines."Loan No",
                                                        WriteOffLines."Loan No",
                                                        Transtype::"Interest Paid",
                                                        Rec."Global Dimension 1 Code",
                                                        Rec."Global Dimension 2 Code",
                                                        true,
                                                        Tchannel,
                                                        DimID
                                                        );
                                    end;

                                    if PrincBal > 0 then begin

                                        SaccoActivities.JournalInsert(
                                                        JTemplate,
                                                        JBatch,
                                                        WriteOffLines."Write Off No",
                                                        Today,
                                                        Accttype::Credit,
                                                        Loans."Member No.",
                                                        CopyStr('Interest Write-off: Provision' + WriteOffLines."Loan No", 1, 50),
                                                        Balaccttype::"G/L Account",
                                                        SaccoSetup."Writeoff Provision GL",
                                                        -PrincBal,
                                                        WriteOffLines."Loan No",
                                                        WriteOffLines."Loan No",
                                                        Transtype::"Principal Repayment",
                                                        Rec."Global Dimension 1 Code",
                                                        Rec."Global Dimension 2 Code",
                                                        true,
                                                        TChannel,
                                                        DimID
                                                        );
                                    end;
                                end;

                                WriteOffLines.Processed := true;
                                WriteOffLines.Modify();
                                SaccoActivities.JournalPost(Jtemplate, Jbatch);
                            until WriteOffLines.Next() = 0;
                        end;
                    end;



                    Rec.Status := Rec.Status::Posted;
                    Rec."Posted By" := UserId;
                    Rec."Date Posted" := Today;
                    Rec.Modify();
                    Message('Write-off posted successfully');
                end;
            }

            action("Post Normal Write-off")
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    JTemplate: Text;
                    JBatch: Text;
                    AcctType: Enum "Gen. Journal Account Type";
                    TransType: Enum "Transaction Type Enum";
                    BalAcctType: Enum "Gen. Journal Account Type";
                    WriteOffLines: Record "Write Off Lines";
                    SavAcc: Record Vendor;
                    LoanPrincRunBal: Decimal;
                    PrincBal: Decimal;
                    LoanRunBal: Decimal;
                    LoanIntRunBal: Decimal;
                    IntBal: decimal;
                    Bal: Decimal;
                    SavBal: Decimal;
                    RunSavBal: Decimal;
                    AmountToApply: Decimal;
                    AvailableSavBal: Decimal;
                    LoansList: Record Loans;
                    GenJournalLine: Record "Gen. Journal Line";

                begin
                    if confirm('Are you sure you want to post?') then begin
                        Rec.TestField("FIle Comments");

                        /*if Rec.Status <> Status::Approved then
                            error('You cannot submit to finance, write-off status is ' + format(Rec.Status));

                        if Rec.Department <> Department::Finance then
                            error('You cannot post write-off when not submitted to finance');*/

                        UserSetup.Reset;
                        UserSetup.Setrange("Post Writeoff", true);
                        UserSetup.Setrange("User ID", UserId);
                        if not UserSetup.FindFirst() then
                            error('You do not have the rights to post writeoff');

                        SaccoSetup.get;
                        SaccoSetup.TestField("Writeoff GL");


                        JTemplate := 'General';
                        JBatch := 'WRITEOFF';

                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                        GenJournalLine.SetRange("Journal Batch Name", JBatch);

                        IntBal := 0;
                        PrincBal := 0;
                        AvailableSavBal := 0;
                        RunSavBal := 0;
                        AmountToApply := 0;

                        SaccoActivities.JournalInit(JTemplate, JBatch);
                        WriteOffLines.Reset();
                        WriteOffLines.SetRange("Write Off No", Rec."Write Off No");
                        WriteOffLines.SetRange(Processed, false);
                        if WriteOffLines.findfirst then begin
                            Loans.Reset;
                            Loans.SetRange("Loan No.", WriteOffLines."Loan No");
                            if Loans.FindFirst then begin
                                LoanRunBal := WriteOffLines."Loan + Interest Amount";
                                Loans.CalcFields("Outstanding Principal", "Outstanding Interest", "Total Outstanding Balance");
                                IntBal := Loans."Outstanding Interest";
                                PrincBal := Loans."Outstanding Principal";

                                LoansList.get(WriteOffLines."Loan No");
                                LoanPrincRunBal := WriteOffLines."Loan Balance";
                                LoanIntRunBal := WriteOffLines."Interest Balance";
                                if LoanPrincRunBal > PrincBal then
                                    LoanPrincRunBal := PrincBal;
                                if LoanIntRunBal > IntBal then
                                    LoanIntRunBal := IntBal;
                                repeat

                                    SavAcc.Reset();
                                    SavAcc.SetRange("Member No.", Loans."Member No.");
                                    SavAcc.SetRange("Member No.", WriteOffLines."Member No");
                                    SavAcc.SetRange("Product Category", SavAcc."Product Category"::"Deposit Contribution");
                                    if SavAcc.FindFirst() then begin
                                        SavAcc.CalcFields(Balance);
                                        //SavBal := SavAcc.Balance;
                                        repeat
                                            //PRINCIPAL
                                            IF WriteOffLines."Loan Balance" > 0 then begin
                                                SavAcc.Reset();
                                                SavAcc.SetRange("Member No.", Loans."Member No.");
                                                SavAcc.SetRange("Member No.", WriteOffLines."Member No");
                                                SavAcc.SetRange("Product Category", SavAcc."Product Category"::"Deposit Contribution");
                                                if SavAcc.FindFirst() then begin
                                                    SavAcc.CalcFields(Balance);
                                                    SavBal := SavAcc.Balance;
                                                end;
                                                Bal := 0;
                                                AvailableSavBal := 0;
                                                AmountToApply := 0;
                                                SaccoActivities.JournalInsert(
                                                                JTemplate,
                                                                JBatch,
                                                                WriteOffLines."Write Off No",
                                                                Today,
                                                                Accttype::Credit,
                                                                WriteOffLines."Member No",
                                                                CopyStr('Principal Write-off: ' + WriteOffLines."Loan No", 1, 50),
                                                                Balaccttype::"G/L Account",
                                                                '',
                                                                -WriteOffLines."Loan Balance",
                                                                WriteOffLines."Write Off No",
                                                                WriteOffLines."Loan No",
                                                                Transtype::"Principal Repayment",
                                                                Rec."Global Dimension 1 Code",
                                                                Rec."Global Dimension 2 Code",
                                                                true,
                                                                TChannel,
                                                                DimID
                                                                );
                                                if SavBal >= 0 then begin
                                                    if SavBal >= WriteOffLines."Loan Balance"
                                                    then
                                                        AvailableSavBal := WriteOffLines."Loan Balance"
                                                    else
                                                        if SavBal < WriteOffLines."Loan Balance" then
                                                            AvailableSavBal := SavBal;
                                                    SaccoActivities.JournalInsert(
                                                                JTemplate,
                                                                JBatch,
                                                                WriteOffLines."Write Off No",
                                                                Today,
                                                                Accttype::Savings,
                                                                SavAcc."No.",
                                                                CopyStr('Principal Write-off: ' + WriteOffLines."Loan No", 1, 50),
                                                                Balaccttype::"G/L Account",
                                                                '',
                                                                AvailableSavBal,
                                                                WriteOffLines."Write Off No",
                                                                '',
                                                                Transtype::" ",
                                                                Rec."Global Dimension 1 Code",
                                                                Rec."Global Dimension 2 Code",
                                                                true,
                                                                TChannel,
                                                                DimID                                                            
                                                                );
                                                    Bal := WriteOffLines."Loan Balance" - AvailableSavBal;

                                                    if Bal > 0 then begin

                                                        SaccoActivities.JournalInsert(
                                                                        JTemplate,
                                                                        JBatch,
                                                                        WriteOffLines."Write Off No",
                                                                        Today,
                                                                        Accttype::"G/L Account",
                                                                        SaccoSetup."Writeoff GL",
                                                                        CopyStr('Principal Write-off: ' + WriteOffLines."Loan No", 1, 50),
                                                                        Balaccttype::"G/L Account",
                                                                        '',
                                                                        Bal,
                                                                        WriteOffLines."Write Off No",
                                                                        '',
                                                                        Transtype::" ",
                                                                        Rec."Global Dimension 1 Code",
                                                                        Rec."Global Dimension 2 Code",
                                                                        true,
                                                                        TChannel,
                                                                        DimID
                                                                        );
                                                    end;
                                                end;
                                            end;

                                            //INTEREST 
                                            IF WriteOffLines."Interest Balance" > 0 then begin
                                                SavAcc.Reset();
                                                SavAcc.SetRange("Member No.", Loans."Member No.");
                                                SavAcc.SetRange("Member No.", WriteOffLines."Member No");
                                                SavAcc.SetRange("Product Category", SavAcc."Product Category"::"Deposit Contribution");
                                                if SavAcc.FindFirst() then begin
                                                    SavAcc.CalcFields(Balance);
                                                    SavBal := SavAcc.Balance;
                                                end;
                                                Bal := 0;
                                                AvailableSavBal := 0;

                                                SaccoActivities.JournalInsert(
                                                                JTemplate,
                                                                JBatch,
                                                                WriteOffLines."Write Off No",
                                                                Today,
                                                                Accttype::Credit,
                                                                WriteOffLines."Member No",
                                                                CopyStr('Interest Write-off: ' + WriteOffLines."Loan No", 1, 50),
                                                                Balaccttype::"G/L Account",
                                                                '',
                                                                -WriteOffLines."Interest Balance",
                                                                WriteOffLines."Write Off No",
                                                                WriteOffLines."Loan No",
                                                                Transtype::"Interest Paid",
                                                                Rec."Global Dimension 1 Code",
                                                                Rec."Global Dimension 2 Code",
                                                                true,
                                                                TChannel,
                                                                DimID
                                                                );
                                                if SavBal >= 0 then begin
                                                    if SavBal >= WriteOffLines."Interest Balance"
                                                    then
                                                        AvailableSavBal := WriteOffLines."Interest Balance"
                                                    else
                                                        AvailableSavBal := SavBal;
                                                    SaccoActivities.JournalInsert(
                                                                JTemplate,
                                                                JBatch,
                                                                WriteOffLines."Write Off No",
                                                                Today,
                                                                Accttype::Savings,
                                                                SavAcc."No.",
                                                                CopyStr('Interest Write-off: ' + WriteOffLines."Loan No", 1, 50),
                                                                Balaccttype::"G/L Account",
                                                                '',
                                                                AvailableSavBal,
                                                                WriteOffLines."Write Off No",
                                                                '',
                                                                Transtype::" ",
                                                                Rec."Global Dimension 1 Code",
                                                                Rec."Global Dimension 2 Code",
                                                                true,
                                                                TChannel,
                                                                DimID
                                                                );
                                                    Bal := WriteOffLines."Interest Balance" - AvailableSavBal;

                                                    if Bal > 0 then begin

                                                        SaccoActivities.JournalInsert(
                                                                        JTemplate,
                                                                        JBatch,
                                                                        WriteOffLines."Write Off No",
                                                                        Today,
                                                                        Accttype::"G/L Account",
                                                                        SaccoSetup."Writeoff GL",
                                                                        CopyStr('Interest Write-off: ' + WriteOffLines."Loan No", 1, 50),
                                                                        Balaccttype::"G/L Account",
                                                                        '',
                                                                        Bal,
                                                                        WriteOffLines."Write Off No",
                                                                        '',
                                                                        Transtype::" ",
                                                                        Rec."Global Dimension 1 Code",
                                                                        Rec."Global Dimension 2 Code",
                                                                        true,
                                                                        TChannel,
                                                                        DimID
                                                                        );
                                                    end;
                                                end;
                                            end;
                                        until Loans.Next() = 0;
                                    end;
                                    WriteOffLines.Processed := true;
                                    WriteOffLines.Modify();
                                until WriteOffLines.next = 0;

                            end;
                        end;
                        SaccoActivities.JournalPost(Jtemplate, Jbatch);



                        Rec.Status := Rec.Status::Posted;
                        Rec."Posted By" := UserId;
                        Rec."Date Posted" := Today;
                        Rec.Modify();
                        Message('Write-off posted successfully');
                    end;
                end;
            }
        }

    }
    trigger OnOpenPage()
    begin
        UpdateStatus();
    end;

    trigger OnAfterGetRecord()
    begin
        UpdateStatus();
        if Rec.Status = Rec.status::Posted then
            CardEdit := false
        else
            CardEdit := true;
    end;

    procedure UpdateStatus()
    begin
        if (Rec.Status = Rec.Status::Pending) And (Rec.Department = Rec.Department::"Assistant Credit Officer") then
            EditableBoolean := true
        else
            if (Rec.Status = Rec.Status::Open) And (Rec.Department = Rec.Department::"Assistant Credit Officer") then
                EditableBoolean := true
            else
                EditableBoolean := False;
    end;

    var
        EditableBoolean: Boolean;
        CardEdit: Boolean;
        WriteOffList: Record "Write offs";
        UserSetup: Record "User Setup";
        SaccoActivities: Codeunit "Sacco Activities";
        SaccoSetup: Record "Sacco Setup";
        WriteoffHeader: Record "Write offs";
        Buffer: Record "Write Off Lines";
        dWindow: Dialog;
        CurrentRecordNo: Integer;
        Members: Record Customer;
        Loans: Record Loans;
        NoOfRecords: Integer;
        f: Integer;
        n: Integer;
        j: Integer;
        TChannel: Enum "Transaction Channel";
        DimID: Integer;


    procedure ImportWriteOffOffLinesFromExcel()
    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        SheetName: Text;
        OpenExcelFile: Label 'Open Excel File';
        ExcelFileFilter: Label 'Excel Files (*.xls*)|*.xls*|All Files (*.*)|*.*';
        ReadingFile: Label 'Reading File';
        CurrentLine: Label 'Current Line No.';
        NoOfLines: Label 'No. of Lines';
        Window: Dialog;
        WindowLastUpdated: DateTime;
        Counter: Integer;
        Total: Integer;
        Buffer: Record "Write Off Lines";
        FileInStream: InStream;
        FileName: Text;
        Uploaded: Boolean;
    begin
        // Cloud-compatible file upload using InStream
        Uploaded := UploadIntoStream(OpenExcelFile, '', ExcelFileFilter, FileName, FileInStream);
        if not Uploaded then
            exit;

        Buffer.Init();
        Buffer.SetRange("Write Off No", Rec."Write Off No");
        if Buffer.FindFirst() then
            Buffer.DeleteAll();

        // Use OpenBookStream instead of OpenBook (no server file path on cloud)
        SheetName := TempExcelBuffer.SelectSheetsNameStream(FileInStream);
        TempExcelBuffer.OpenBookStream(FileInStream, SheetName);
        TempExcelBuffer.ReadSheet();
        TempExcelBuffer.SetFilter("Row No.", '>%1', 1);

        Total := TempExcelBuffer.Count();
        Counter := 0;

        Window.Open(
            ReadingFile + ' @1@@@@@@@@@@@@@@@@@@@@@@@@\' +
            CurrentLine + ' #2#######\' +
            NoOfLines + '#3#######');
        Window.Update(3, Total);
        WindowLastUpdated := CurrentDatetime();

        if TempExcelBuffer.Find('-') then
            repeat
                Counter += 1;

                case TempExcelBuffer."Column No." of
                    1:
                        begin
                            Buffer.Init();
                            Buffer."Write Off No" := Rec."Write Off No";
                            Evaluate(Buffer."Member No", TempExcelBuffer."Cell Value as Text");
                        end;
                    2:
                        begin
                            Evaluate(Buffer."Loan No", TempExcelBuffer."Cell Value as Text");
                            Buffer.Insert();
                        end;
                /*3:
                    begin
                        Evaluate(Buffer."Total Write Off Amount", TempExcelBuffer."Cell Value as Text");
                    end;*/
                end;

                if CurrentDatetime() - WindowLastUpdated > 100 then begin
                    Window.Update(1, Round(Counter / Total * 10000, 1));
                    Window.Update(2, Counter);
                    WindowLastUpdated := CurrentDatetime();
                end;

            until TempExcelBuffer.Next() = 0;

        Window.Close();
    end;
}
