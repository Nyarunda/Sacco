
Page 50228 "Micro Transactions Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Micro Credit Transactions";
    PromotedActionCategories = 'New,Process,Report,Posting,Send Approval Request';
    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TransactionDate; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionTime; Rec."Transaction Time")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(PaymentType; Rec."Payment Type")
                {
                    ApplicationArea = Basic;
                    ValuesAllowed = " ", Normal;
                }
                field(GroupCode; Rec."Group Code")
                {
                    ApplicationArea = Basic;
                }
                field(GroupName; Rec."Group Name")
                {
                    ApplicationArea = Basic;
                }
                field(AccountType; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field(AccountName; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(TotalAmountReceived; Rec."Total Amount Received")
                {
                    ApplicationArea = Basic;
                }
                field(DateBanked; Rec."Date Banked")
                {
                    ApplicationArea = Basic;
                }
                field(DepositedBy; Rec."Deposited By")
                {
                    ApplicationArea = Basic;
                }
                field(SigningInstructions; Rec."Signing Instructions")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Signing Instruction Narration"; Rec."Signing Instruction Narration")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(PostedBy; Rec."Posted By")
                {
                    ApplicationArea = Basic;
                }
                field(TransactingBranch; Rec."Transacting Branch")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
            }

            part(Control1; "Micro Transaction Lines")
            {
                SubPageLink = "No." = field("No.");
            }
        }
        area(FactBoxes)
        {
            part(Control3; "Picture & Signature")
            {
                SubPageLink = "Member No." = field("Group Code");
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(ActionGroup29)
            {
                action(Post)
                {
                    ApplicationArea = Basic;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        DimID: Integer;
                    begin
                        if Rec.Posted then
                            Error('The transaction %1 is already posted', Rec."No.");

                        if Rec."Account Type" = Rec."account type"::"G/L Account" then
                            Error('You cant post from a G/L Account ');

                        if Rec."Total Amount Received" <> Rec.Amount then
                            Error('The schedule amounts is not correct');


                        BankLed.Reset;
                        BankLed.SetRange("Document No.", Rec."No.");
                        if BankLed.Find('-') then begin
                            Rec.Posted := true;
                            Rec."Posted By" := UserId;
                            Rec.Modify;
                            Message('Transaction Posted succesfully');
                            exit;
                        end;

                        if Rec.Amount = 0 then
                            Error('Amount must not be 0');

                        //Rec.TestField(Status, Rec.Status::Approved);

                        //Prevent Double Posting
                        GlEnty.Reset;
                        GlEnty.SetRange(GlEnty."Document No.", Rec."No.");
                        if GlEnty.Find('-') then begin
                            Rec.Posted := true;
                            Rec."Posted By" := UserId;
                            Rec.Modify;
                            Message('The Document Posted.');
                            exit;
                        end;
                        Rec."Date Banked" := Rec."Transaction Date";

                        Rec.TestField("Transacting Branch");
                        Rec.TestField("Date Banked");
                        Rec.TestField("Deposited By");

                        JTemplate := '';
                        JBatch := '';

                        SaccoActivities.GetReceiptJournalTemplate(JTemplate, JBatch);


                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", JTemplate);
                        GenJournalLine.SetRange("Journal Batch Name", JBatch);
                        GenJournalLine.DeleteAll;
                        //end of deletion

                        DefaultBatch.Reset;
                        DefaultBatch.SetRange(DefaultBatch."Journal Template Name", JTemplate);
                        DefaultBatch.SetRange(DefaultBatch.Name, JBatch);
                        if DefaultBatch.Find('-') = false then begin
                            DefaultBatch.Init;
                            DefaultBatch."Journal Template Name" := JTemplate;
                            DefaultBatch.Name := JBatch;
                            DefaultBatch.Description := 'MICRO Repayment Journal';
                            DefaultBatch.Validate(DefaultBatch."Journal Template Name");
                            DefaultBatch.Validate(DefaultBatch.Name);
                            DefaultBatch.Insert;
                        end;


                        Rec.TestField("Account No");

                        if Rec."Payment Type" = Rec."payment type"::"Pass Book" then
                            Desc := 'Pass Book Charge'
                        else
                            if Rec."Payment Type" = Rec."payment type"::Normal then
                                Desc := 'Micro Cash Receipt';

                        SaccoActivities.JournalInsert(JTemplate, JBatch, Rec."No.", Rec."Date Banked", Rec."Account Type", Rec."Account No", Desc, Balaccttype::"G/L Account", '',
                              Rec.Amount, ExtDocNo, LoanNo, Transtype::" ", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", true, TChannel::" ", DimID);


                        Transact.Reset;
                        Transact.SetRange(Transact."No.", Rec."No.");
                        if Transact.Find('-') then begin
                            repeat

                                RunBal := Transact.Amount;

                                /*
                                IF "Payment Type"="Payment Type"::"Pass Book" THEN BEGIN
                                    ExtDocNo:=Transact."Account Number";
                                    GenSetup.GET;
                                    GenSetup.TESTFIELD("Pass Book Charge GL");
                                    GenSetup.TESTFIELD("Micro Entrance Charge GL");
                                    SaccoActivities.JournalInsert(JTemplate,JBatch,"No.","Date Banked",AcctType::"G/L Account",GenSetup."Pass Book Charge GL",'Pass Book Charge',BalAcctType::"G/L Account",'',
                                          -Transact."Pass Book Charge",ExtDocNo,LoanNo,TransType::" ","Global Dimension 1 Code","Global Dimension 2 Code",TRUE);
                        
                                    SaccoActivities.JournalInsert(JTemplate,JBatch,"No.","Date Banked",AcctType::"G/L Account",GenSetup."Micro Entrance Charge GL",'Entrance Fee Charge',BalAcctType::"G/L Account",'',
                                    -Transact."Entrance Fee Charge",ExtDocNo,LoanNo,TransType::" ","Global Dimension 1 Code","Global Dimension 2 Code",TRUE);
                        
                                END;
                                */

                                if Rec."Payment Type" = Rec."payment type"::Normal then begin


                                    /*
                                    IF Transact."Entrance Fee Charge" > 0 THEN BEGIN
                                        ExtDocNo:=Transact."Account Number";
                                        GenSetup.GET;
                                        GenSetup.TESTFIELD("Micro Entrance Charge GL");
                        
                        
                                        SaccoActivities.JournalInsert(JTemplate,JBatch,"No.","Date Banked",AcctType::"G/L Account",GenSetup."Micro Entrance Charge GL",'Entrance Fee Charge',BalAcctType::"G/L Account",'',
                                        -Transact."Entrance Fee Charge",ExtDocNo,LoanNo,TransType::" ","Global Dimension 1 Code","Global Dimension 2 Code",TRUE);
                        
                        
                                        RunBal-=Transact."Entrance Fee Charge";
                                    END;
                                    */




                                    IF Transact."FOSA Savings" > 0 THEN BEGIN
                                        SavAcc.Reset();
                                        SavAcc.SetRange("Member No.", Transact."Member No.");
                                        SavAcc.SetRange("Product Category", SavAcc."Product Category"::"Ordinary Savings");
                                        if SavAcc.FindFirst() then begin
                                            ExtDocNo := Transact."Account Number";

                                            SaccoActivities.JournalInsert(JTemplate, JBatch, Rec."No.", Rec."Date Banked", Accttype::Savings, SavAcc."No.", 'Member FOSA Savings', Balaccttype::"G/L Account", '',
                                           -Transact."FOSA Savings", ExtDocNo, LoanNo, Transtype::" ", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", true, TChannel::" ", DimID);


                                            RunBal -= Transact."FOSA Savings";

                                        end;
                                    end;



                                    if Transact."Deposit Paid" < 0 then
                                        Transact."Deposit Paid" := 0;


                                    SaccoActivities.JournalInsert(JTemplate, JBatch, Rec."No.", Rec."Date Banked", Accttype::Savings, Transact."Account Number", 'Micro Deposits', Balaccttype::"G/L Account", '',
                                          -Transact."Deposit Paid", ExtDocNo, LoanNo, Transtype::" ", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", true, TChannel::" ", DimID);

                                    RunBal -= Transact."Deposit Paid";
                                    //For Loans //Mwende
                                    RunBal := Transact."Loan Amount Paid";
                                    if RunBal > 0 then begin



                                        Loans.Reset;
                                        Loans.SetRange("Member No.", Transact."Member No.");
                                        //Loans.SETRANGE(Loans."Group Code",Transact."Group Code");
                                        Loans.SetFilter(Loans."Total Outstanding Balance", '>0');
                                        Loans.SetRange(Source, Loans.Source::MICRO);
                                        Loans.SetAutoCalcFields("Outstanding Interest", "Outstanding Principal");
                                        if Loans.Find('-') then begin
                                            repeat
                                                LoanNo := Loans."Loan No.";
                                                InterestDue := 0;
                                                PrincipleDue := 0;


                                                if RunBal > 0 then begin
                                                    PenaltyDue := Transact."Penalty Paid";
                                                    if PenaltyDue > RunBal then
                                                        PenaltyDue := RunBal;

                                                    SaccoActivities.JournalInsert(JTemplate, JBatch, Rec."No.", Rec."Date Banked", Accttype::Credit, Loans."Loan Account", 'Micro Penalty Paid', Balaccttype::"G/L Account", '',
                                                        -PenaltyDue, ExtDocNo, LoanNo, Transtype::"Penalty Paid", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", true, TChannel::" ", DimID);
                                                    RunBal -= PenaltyDue;

                                                end;


                                                if RunBal > 0 then begin

                                                    InterestDue := Loans."Outstanding Interest";//Transact."Interest Amount Paid";
                                                    if InterestDue > Loans."Outstanding Interest" then
                                                        InterestDue := Loans."Outstanding Interest";

                                                    if InterestDue < 0 then
                                                        InterestDue := 0;


                                                    if InterestDue > RunBal then
                                                        InterestDue := RunBal;

                                                    SaccoActivities.JournalInsert(JTemplate, JBatch, Rec."No.", Rec."Date Banked", Accttype::Credit, Loans."Loan Account", 'Micro Interest Paid', Balaccttype::"G/L Account", '',
                                                        -InterestDue, ExtDocNo, LoanNo, Transtype::"Interest Paid", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", true, TChannel::" ", DimID);
                                                    RunBal -= InterestDue;

                                                end;

                                                if RunBal > 0 then begin
                                                    PrincipleDue := Loans."Outstanding Principal";//Transact."Principle Amount Paid";

                                                    if PrincipleDue > Loans."Outstanding Principal" then
                                                        PrincipleDue := Loans."Total Outstanding Balance";

                                                    if PrincipleDue < 0 then
                                                        PrincipleDue := 0;


                                                    if PrincipleDue > RunBal then
                                                        PrincipleDue := RunBal;

                                                    SaccoActivities.JournalInsert(JTemplate, JBatch, Rec."No.", Rec."Date Banked", Accttype::Credit, Loans."Loan Account", 'Micro Loan Principal Paid', Balaccttype::"G/L Account", '',
                                                        -PrincipleDue, ExtDocNo, LoanNo, Transtype::"Principal Repayment", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", true, TChannel::" ", DimID);

                                                    RunBal -= PrincipleDue;


                                                end;

                                            until Loans.Next = 0;
                                        end;
                                    end;

                                    if RunBal > 0 then begin

                                        SaccoActivities.JournalInsert(JTemplate, JBatch, Rec."No.", Rec."Date Banked", Accttype::Savings, Transact."Account Number", 'Micro Excess Deposits', Balaccttype::"G/L Account", '',
                                              -RunBal, ExtDocNo, LoanNo, Transtype::" ", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", true, TChannel::" ", DimID);

                                    end;
                                end;
                            until Transact.Next = 0;

                        end;

                        //ERROR('Contact ICT');

                        //post
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange(GenJournalLine."Journal Template Name", JTemplate);
                        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", JBatch);
                        if GenJournalLine.FindFirst then
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);



                        //Prevent Double Posting
                        MTrans.Reset;
                        MTrans.SetRange("No.", Rec."No.");
                        if MTrans.FindFirst then begin
                            GlEnty.Reset;
                            GlEnty.SetRange(GlEnty."Document No.", MTrans."No.");
                            if GlEnty.Find('-') then begin
                                MTrans.Posted := true;
                                MTrans."Posted By" := UserId;
                                MTrans.Modify;
                                //MESSAGE('The Document Posted.');
                            end;
                        end;

                        Commit;

                        MTrans.Reset;
                        MTrans.SetRange("No.", Rec."No.");
                        //Report.Run(50333, true, true, MTrans);
                        CurrPage.Close();
                    end;
                }
                action("Print Receipt")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        if Rec.Posted = false then Error('Post the receipt before printing.');
                        Transact.Reset;
                        Transact.SetRange(Transact."No.", Rec."No.");
                        Report.Run(Report::"Micro_Fin_Sched Report", true, true, Transact);
                    end;
                }
                action("Print Receipt-Summary")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        if Rec.Posted = false then Error('Post the receipt before printing.');
                        MTrans.Reset;
                        MTrans.SetRange("No.", Rec."No.");
                        Report.Run(Report::"Micro_Fin_Sched Report - Summa", true, true, MTrans);
                    end;
                }
                action("Print Schedule")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        // IF Posted=FALSE THEN ERROR('Post the receipt before printing.');
                        Transact.Reset;
                        Transact.SetRange(Transact."No.", Rec."No.");
                        Report.Run(Report::"Micro Schedule", true, false, Transact);
                    end;
                }
                action("Account Signatories")
                {
                    ApplicationArea = Basic;
                    Image = NewSparkle;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Account Signatories";
                    RunPageLink = Code = field("Group Code");
                }
            }
            action(SendApprovalRequest)
            {
                ApplicationArea = Basic;
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category5;
                Enabled = Rec.Status = rec.Status::Open;
                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    NextofKinError: label 'You must specify next of Kin for this application.';
                    NextofKIN: Record "Service Item";
                    ProductFactory: Record "Service Item";
                    SavingsAccountRegistration: Record "Service Item";
                    DocumentType: Enum "Custom Document Type";
                    CalwideApprovals: Codeunit "Calwide Approvals";
                    VarVariant: Variant;
                begin

                    VarVariant := Rec;
                    CalwideApprovals.CreateCustomTracker(VarVariant, Rec."No.", 0, Documenttype::"Micro Teller Transaciton", '', '', 0);
                    CurrPage.Close();
                end;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = Basic;
                Caption = 'Cancel Approval Re&quest';
                Image = Cancel;
                Promoted = true;
                Enabled = Rec.Status = rec.Status::Pending;
                PromotedCategory = Category5;
                //Visible = CancelBool;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    CalwideApprovals: Codeunit "Calwide Approvals";
                    VarVariant: Variant;
                begin
                    Rec.TestField(Status, Rec.Status::Pending);

                    VarVariant := Rec;
                    CalwideApprovals.CancelTracker(VarVariant, Rec."No.");
                    CurrPage.Close();
                end;
            }
            action(Approvals)
            {
                ApplicationArea = Basic;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category5;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    RecRef: RecordRef;
                    DocumentType: Enum "Custom Document Type";
                    VarVariant: Variant;
                    ApprovalTracker: Record "Approval Tracker";
                begin
                    VarVariant := Rec;
                    RecRef.GetTable(VarVariant);


                    ApprovalTracker.Reset;
                    ApprovalTracker.SetRange("Table ID", RecRef.Number);
                    ApprovalTracker.SetRange("Document No.", Rec."No.");
                    ApprovalTracker.SetRange("Custom Document Type", DocumentType::"Partial Loans");
                    if ApprovalTracker.FindFirst then
                        approvalsMgmt.OpenApprovalEntriesPage(RecRef.RecordId);
                end;
            }
            action(Approve)
            {
                ApplicationArea = Basic;
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                Visible = Rec.Status = Rec.Status::Pending;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                begin
                    Rec.TestField(status, Rec.Status::Pending);
                    ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    CurrPage.Close();
                end;
            }
            action("Reopen Document")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                Enabled = Rec.Status = rec.Status::Approved;
                trigger OnAction()
                begin

                    if (Rec.Status <> Rec.Status::Open) and (Rec.Status <> Rec.Status::Pending) then begin

                        if not Confirm('Are you sure you want to re-open document?') then exit;

                        Rec.Status := Rec.Status::Open;
                        Rec.Modify;

                        CurrPage.Close();

                    end;
                end;
            }

        }
    }


    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        if Rec.Posted then
            CurrPage.Editable := false;
    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        if Rec.Posted then
            CurrPage.Editable := false;
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        if Rec.Posted then
            CurrPage.Editable := false;
    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        Transact: Record "Micro Credit Transaction Lines";
        LineNo: Integer;
        DefaultBatch: Record "Gen. Journal Batch";
        BranchCode: Code[30];
        Bank: Record "Bank Account";
        Group: Code[30];
        MTrans: Record "Micro Credit Transactions";
        Bcode: Code[30];
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,"HRTransport Request",HRTraining,"HREmp Requsition",MicroTrans;
        grouptrans: Record "Micro Credit Transactions";
        UserSetup: Record "Banking User Setup";
        GlEnty: Record "G/L Entry";
        Post: Boolean;
        Micro_Fin_Schedules: Record "Micro Credit Transactions";
        Members: Record Members;
        SavAcc: Record "Savings Accounts";
        RunAmount: Decimal;
        ProdF: Record "Product Setup";
        Loans: Record Loans;
        BankLed: Record "Bank Account Ledger Entry";
        RunBal: Decimal;
        JTemplate: Code[10];
        JBatch: Code[10];
        AcctType: Enum "Gen. Journal Account Type";
        BalAcctType: Enum "Gen. Journal Account Type";
        ExtDocNo: Code[20];
        LoanNo: Code[20];
        AppraisalDue: Decimal;
        PenaltyDue: Decimal;
        InterestDue: Decimal;
        PrincipleDue: Decimal;
        Desc: Text;
        GenSetup: Record "Sacco Setup";
        ExcessPrinciple: Decimal;
        TransType: Enum "Transaction Type Enum";
        MSGConfirm: label 'Are you sure you want to suugest member deductions?';
        SaccoActivities: Codeunit "Sacco Activities";
        MemberActivities: Codeunit "Member Activities";
        BankingUser: Record "Banking User Setup";
        TChannel: Enum "Transaction Channel";
}

