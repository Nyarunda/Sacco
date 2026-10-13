
/// <summary>
/// Page Receipt Card (ID 50255).
/// </summary>
Page 50255 "Receipt Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Receipt Header";
    PromotedActionCategories = 'New,Process,Report,Post Receipt,Suggest,Send Notification,Print,Request Approval';


    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = ReceiptEditable;

                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                }

                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(PostingDate; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                    //Editable = false;
                }
                field("Process Type"; Rec."Process Type")
                {
                    ApplicationArea = Basic;
                }
                field("Customer Type"; Rec."Customer Type")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; Rec."Customer No.")
                {
                    Caption = 'Member No.';
                    ApplicationArea = Basic;
                    LookupPageId = "Member Listing";
                }

                field(CustomerName; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field(Narration; Rec.Narration)
                {
                    ApplicationArea = Basic;
                }
                field("Received From"; Rec."Received From")
                {
                    ApplicationArea = Basic;
                }

                field("External Document No"; Rec."External Document No")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    Enabled = Rec."Process Type" = Rec."Process Type"::Single;
                }

                field(AmountRecieved; Rec."Amount Recieved")
                {
                    ApplicationArea = Basic;
                }
                field(TotalAmount; Rec."Total Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Total Receipt Buffer Amount"; Rec."Total Receipt Buffer Amount")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Total amount from receipt lines in buffer(imported distribution). This amount is included in the Total Amount field.';
                }
                field("Total Document Line Amount"; Rec."Total Document Line Amount")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Total amount generated on receipt document lines.';
                }
                field("Buffer Amount by Ext. Doc."; Rec."Buffer Amount by Ext. Doc.")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Imported receipt buffer amount for the selected external document/transaction number.';
                }
                field("Doc. Line Amount by Ext. Doc."; Rec."Doc. Line Amount by Ext. Doc.")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Generated document line amount for the selected external document/transaction number.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field(BankCode; Rec."Bank Code")
                {
                    ApplicationArea = Basic;
                }
                field(BankName; Rec."Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field(PayMode; Rec."Pay Mode")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                    trigger OnValidate()
                    begin
                        SlipMandatory := false;
                        if Rec."Pay Mode" <> Rec."Pay Mode"::Cash then SlipMandatory := true
                    end;
                }
                field(ChequeNo; Rec."Cheque No.")
                {
                    Caption = 'Cheque No.';
                    ApplicationArea = Basic;
                    Enabled = Rec."Process Type" = Rec."Process Type"::Single;
                    //Enabled = false;

                }
                field("Deposit Slip No"; Rec."Cheque/Deposit Slip No")
                {
                    ApplicationArea = Basic;
                    Caption = 'EFT/Deposit Slip No.';
                    ShowMandatory = SlipMandatory;
                    Visible = false;

                    //From the table, cheque No is also the deposit/slip no.
                }
                field("ChequeDate"; Rec."Cheque/Deposit Slip Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cheque Date';
                    Visible = false;
                }
                field("Dont Send SMS"; Rec."Dont Send SMS")
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
                field(CreatedBy; Rec."Created By")
                {
                    ApplicationArea = Basic;
                }
                field(CreatedDateTime; Rec."Created Date Time")
                {
                    ApplicationArea = Basic;
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(DatePosted; Rec."Date Posted")
                {
                    ApplicationArea = Basic;
                }
                field(TimePosted; Rec."Time Posted")
                {
                    ApplicationArea = Basic;
                }
                field(payrollandstaffNo; Rec.payrollandstaffNo)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Caption = 'Payroll/Staff No.';
                }
                field(PostedBy; Rec."Posted By")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control18; "Receipt Line")
            {
                ApplicationArea = all;
                Editable = ReceiptEditable;
                SubPageLink = "Header No." = field("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {

            action("Suggest Receipt Lines")
            {
                ApplicationArea = Basic;
                Image = Suggest;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                Enabled = ReceiptEditable and (Rec."Process Type" = Rec."Process Type"::Single);

                trigger OnAction()
                var
                    RecType: Record "Payment & Receipt Types";
                    SavingsType: Record "Payment & Receipt Types";
                    Loans: Record Loans;
                    Savings: Record "Savings Accounts";
                    SaccoActivities: Codeunit "Sacco Activities";
                    ExpAmt: Decimal;
                    AmtPaid: Decimal;
                    AmtInterestPaid: Decimal;
                    DefAmt: Decimal;
                    DaysDef: Integer;
                    ArrearsDate: Date;
                    RLine: Record "Document Line";
                    RLine1: Record "Document Line";
                    RunBal: Decimal;
                    ProductSetup: Record "Product Setup";
                    DedAmt: Decimal;
                    Cust: Record Customer;
                    ArrearsAmt: Decimal;
                    Paid: boolean;
                    SaccoSetup: Record "Sacco Setup";
                    i: Integer;
                    Instructions: Record "Dividend Instructions";
                    MinimumContrib: Decimal;
                    Member: Record Members;
                    ExpectedBal: Decimal;
                    CurrentBal: Decimal;
                    IntArrears: Decimal;
                    CurrIntArrears: Decimal;
                    CurrPrinciArrears: Decimal;
                    PrincipleDue: Decimal;
                    InterestDue: Decimal;
                    InterestAmtPaid: Decimal;
                begin

                    if Confirm('Are you sure you want to Suggest Receipt Lines?') then begin

                        Rec.TestField("Customer No.");
                        Rec.TestField("Amount Recieved");
                        RunBal := Rec."Amount Recieved";

                        RLine.Reset();
                        RLine.SetRange("Header No.", Rec."No.");
                        if RLine.FindFirst() then begin
                            if Confirm('Any Existing Lines will be cleared. Do you want to proceed?') then begin
                                RLine.DeleteAll();
                            end;
                        end;

                        SaccoActivities.SuggestReceiptLines(Rec);
                    end;
                end;
            }

            action("Post Receipt")
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                enabled = Rec."Customer Type" <> Rec."Customer Type"::"G/L Account";

                trigger OnAction()
                begin
                    // Rec.TestField(Status, Rec.Status::Approved);
                    CheckControls();
                    if Rec."Process Type" = Rec."Process Type"::Single then
                        Rec.TestField("External Document No");
                    CheckReceiptLinesHaveExternalDoc();
                    if Confirm('Are you sure you want to Post this Receipt?') then begin
                        SaccoActivities.PostReceipt(Rec."No.", false);

                        /* ReceiptHeader.Reset;
                        ReceiptHeader.SetRange("No.", "No.");
                        if ReceiptHeader.FindFirst then
                            Report.Run (Report::Receipt, true, false, ReceiptHeader);*/
                    end;
                end;
            }
            action("Mark As Posted")
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    // Rec.TestField(Status, Rec.Status::Approved);
                    CheckControls();
                    if Confirm('Are you sure you want to Mark as posted on this Receipt?') then begin
                        SaccoActivities.MarkReceiptAsPosted(Rec."No.")
                    end;
                end;
            }
            action("Preview Posting")
            {
                ApplicationArea = Basic;
                Caption = 'Preview Posting';
                Image = ViewPostedOrder;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.TestField(Posted, false);

                    if Confirm('Are you sure you want to preview posting for this receipt?') then
                        SaccoActivities.PreviewReceipt(Rec."No.", true);
                end;
            }
            action("Revised Member Statement")
            {
                ApplicationArea = Basic;
                Image = Customer;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Members: Record Members;
                begin
                    Members.Reset;
                    Members.SetRange("No.", Rec."Customer No.");
                    if Members.FindFirst then begin
                        if Rec."Customer Type" = Rec."Customer Type"::Member then
                            Report.Run(Report::"Revised Member Statement", true, false, Members);

                    end;
                end;
            }
            action("Member Statement")
            {
                ApplicationArea = Basic;
                Image = StyleSheet;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Members: Record Members;
                begin
                    Members.Reset;
                    Members.SetRange("No.", Rec."Customer No.");
                    if Members.FindFirst then
                        Report.Run(Report::"Detailed Member Statement", true, false, Members);
                end;
            }
            action("Receipt")
            {
                ApplicationArea = Basic;
                Image = Receipt;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Members: Record Members;
                    TempBlob: CodeUnit "Temp Blob";
                begin

                    ReceiptHeader.Reset;
                    ReceiptHeader.SetRange("No.", Rec."No.");
                    if ReceiptHeader.FindFirst then
                        Report.Run(Report::Receipt, true, false, ReceiptHeader);
                end;
            }

            action(Print)
            {
                ApplicationArea = Basic;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.TestField(Posted, true);

                    ReceiptHeader.Reset;
                    ReceiptHeader.SetRange("No.", Rec."No.");
                    if ReceiptHeader.FindFirst then begin

                        ReceiptHeader.Reset;
                        ReceiptHeader.SetRange("No.", Rec."No.");
                        if ReceiptHeader.FindFirst then
                            Report.Run(Report::Receipt, true, false, ReceiptHeader);

                    end;
                end;
            }
            action("Send Notification")
            {
                ApplicationArea = Basic;
                Image = Email;
                Promoted = true;
                PromotedCategory = category6;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Category4;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to Send Notification to this member?') then begin
                        Rec.TestField(Posted, true);
                        SaccoActivities.SendReceiptNotifications(Rec."No.");
                    end;
                end;
            }

            action(ImportReceiptLines)
            {
                Caption = 'Import Receipt Lines';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = Basic;
                Enabled = Rec."Process Type" = Rec."Process Type"::Bulk;

                trigger OnAction()
                var
                    ConfirmImportQst: Label 'Import lines for Receipt %1? \ \ Member format: Line No, Member No, Amount, Transaction No, Batch No. \GL format: Line No, Type, G/L Account No, Amount, Transaction No, Batch No.', Comment = '%1 = Receipt No';
                begin
                    // Error Handling: Ensure we have a Header No before importing lines
                    Rec.TestField(Posted, false);
                    if Rec."No." = '' then
                        Error('You must save the Receipt Header before importing lines.');

                    if Confirm(StrSubstNo(ConfirmImportQst, Rec."No."), true) then
                        Rec.ImportReceiptLinesFromExcel();
                end;
            }
            action(ValidateReceiptLines)
            {
                Caption = 'Validate Receipt Lines';
                Image = Confirm;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = Basic;

                trigger OnAction()
                begin
                    Rec.TestField(Posted, false);

                    Rec.ValidateReceiptLines();
                end;
            }
            action(ReceiptBufferLines)
            {
                Caption = 'View Receipt Buffer Lines';
                Image = View;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = Basic;
                RunObject = Page "Receipt Buffer Lines";
                RunPageLink = "Batch No" = field("No.");


            }
            action(PostGLReceiptBufferLines)
            {
                Caption = 'Post G/L Receipt Buffer Lines';
                Image = Post;
                Promoted = true;
                PromotedCategory = Category4;
                ApplicationArea = Basic;
                Enabled = Rec."Customer Type" = Rec."Customer Type"::"G/L Account";

                trigger OnAction()
                var
                    SaccoActivities: Codeunit "Sacco Activities";
                begin
                    Rec.TestField(Posted, false);
                    if Confirm('Post G/L receipt buffer lines for receipt %1?', false, Rec."No.") then
                        SaccoActivities.PostGLReceiptBufferLines(Rec."No.", false);
                end;
            }
            action(SuggestLinesFromBuffer)
            {
                Caption = 'Suggest Distribution Lines';
                Image = SuggestLines;
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                Enabled = Rec."Customer Type" = Rec."Customer Type"::Member;
                trigger OnAction()
                begin
                    CurrPage.SaveRecord();
                    Rec.TestField("Amount Recieved");
                    Rec.TestField("posting Date");
                    Rec.TestField(Posted, false);
                    SaccoActivities.SuggestReceiptLinesFromBuffer(Rec);
                end;
            }
            action(SuggestNonMemberLinesFromBuffer)
            {
                Caption = 'Suggest Non-Member Lines';
                Image = SuggestLines;
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                Enabled = Rec."Customer Type" = Rec."Customer Type"::"G/L Account";

                trigger OnAction()
                begin
                    CurrPage.SaveRecord();
                    Rec.TestField("Amount Recieved");
                    Rec.TestField("Posting Date");
                    Rec.TestField(Posted, false);
                    SaccoActivities.SuggestNonMemberReceiptLinesFromBuffer(Rec);
                end;
            }

        }
        area(Navigation)
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
                        rec.TestField("External Document No");
                        VarVariant := Rec;
                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec."No.", 0, Documenttype::Receipt, Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", 0);
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
                        CalwideApprovals.CancelTracker(VarVariant, Rec."No.");
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
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Member Application","Loan Application","Savings Application",FDR,"Def. Recovery","Loan Changes","Guarantor Sub.","Member Exit","Member Exit Notice","Member Changes",STO,"Cheque Book App","Account Transfer","Teller Transaction","Micro Transaction",PV,"Petty Cash","Collateral Register","Collateral Return",CheckOff,"Bankers Cheque",Salary,Receipt;
                        VarVariant: Variant;
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocumentType := Documenttype::Salary;

                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", Rec."No.");
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
                            CalwideApprovals.CancelTracker(VarVariant, Rec."No.");
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
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        UpdateControls
    end;

    trigger OnAfterGetRecord()
    begin
        UpdateControls
    end;

    trigger OnOpenPage()
    begin
        if (not Rec.Posted) and (Rec."Pay Mode" = Rec."Pay Mode"::" ") And (Rec."No." <> '') then begin

            Rec."Pay Mode" := Rec."Pay Mode"::Cash;
            Rec.Modify()
        end;

        if (not Rec.Posted) and (Rec."Received From" = '') And (Rec."No." <> '') then begin
            Rec."Received From" := Rec."Member Name";
            Rec.Modify();
        end;
        UpdateControls;
    end;

    local procedure UpdateControls()
    var
        myInt: Integer;
    begin
        ReceiptEditable := (Rec.Status = Rec.Status::Open) and (not Rec.Posted);
        CurrPage.Editable := ReceiptEditable;
    end;

    local procedure CheckControls()
    var
        DocLines: Record "Document Line";
    begin
        DocLines.Reset();
        DocLines.SetRange("Header No.", Rec."No.");
        DocLines.SetRange("Account Type", DocLines."Account Type"::Savings);
        if DocLines.FindSet() then begin
            repeat
                if Savings.Get(DocLines."Account No.") then begin
                    if Savings.Status in
                        [
                            Savings.Status::Frozen,
                            Savings.Status::Closed,
                            Savings.Status::"Withdrawal Application",
                            Savings.Status::Withdrawn
                        ]
                    then
                        Error(
                            'Savings account %1 is %2. You cannot post a receipt to a frozen, closed, withdrawal application, or withdrawn savings account.',
                            Savings."No.",
                            Format(Savings.Status)
                        );
                end else
                    Error(
                        'Savings account %1 does not exist.',
                        DocLines."Account No."
                    );
            until DocLines.Next() = 0;
        end;

    end;

    local procedure CheckReceiptLinesHaveExternalDoc()
    var
        DocLines: Record "Document Line";
    begin
        DocLines.Reset();
        DocLines.SetRange("Header No.", Rec."No.");
        DocLines.SetFilter("External Doc.", '%1', '');
        if DocLines.FindSet() then
            repeat
                Error(
                    'External Document No. is missing on receipt line %1 for account %2. Please update all receipt lines before posting.',
                    DocLines."Line No.",
                    DocLines."Account No.");
            until DocLines.Next() = 0;
    end;

    local procedure ConvertInStreamToByteArray(InStr: InStream): List of [Byte]
    var
        ByteArray: List of [Byte];
        Byte: Integer;
    begin
        while not InStr.EOS() do begin
            InStr.Read(Byte);
            ByteArray.Add(Byte);
        end;
        exit(ByteArray);
    end;

    var
        SaccoActivities: Codeunit "Sacco Activities";
        ReceiptHeader: Record "Receipt Header";
        SlipMandatory: Boolean;
        AmtPaid: Decimal;
        DefAmount: Decimal;
        DaysInArrear: Integer;
        ArrearsDate: Date;
        ExpectedAmt: Decimal;
        AsAt: Date;
        Savings: Record "Savings Accounts";
        ReceiptEditable: Boolean;
}
