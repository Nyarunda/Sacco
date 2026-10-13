
Page 50238 "Account Transfer Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Account Transfers";
    PromotedActionCategories = 'New,Process,Report,Approval Requests';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(TransactionType; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                    Editable = HeaderA;
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field("Document Attached"; Rec."Document Attached")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                    Editable = HeaderA;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        AControl;
                    end;
                }
                field(SendSMS; Rec."Send SMS")
                {
                    ApplicationArea = Basic;
                }
                field(CreatedBy; Rec."Created By")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionDate; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(TransactionTime; Rec."Transaction Time")
                {
                    ApplicationArea = Basic;
                }
                field(TotalDebits; Rec."Total Debits")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TotalCredits; Rec."Total Credits")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }

            part(Control2; "Account Transfer Source")
            {
                ApplicationArea = Basic;
                Caption = 'Account Transfers-Source [ Debit ]';
                Editable = SourceA;
                SubPageLink = "No." = field(No);
            }

            part(Control1; "Account Transfer Destination")
            {
                ApplicationArea = Basic;
                Caption = 'Account Transfers-Destination [ Credit ]';
                Editable = DestinationA;
                SubPageLink = "No." = field(No);
            }
        }
    }

    actions
    {
        area(navigation)
        {

            group(Posting)
            {
                Caption = 'Posting';
                action(Post)
                {
                    ApplicationArea = Basic;
                    Caption = 'Post';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        Destination: Record "Destination Account Transfers";
                        Source: Record "Source Account Transfer";
                        AccountTransfer: Record "Account Transfers";
                    begin


                        if Rec.Status <> Rec.Status::Approved then
                            Error(DocMustbeApproved);

                        Destination.Reset();
                        Destination.SetRange("No.", Rec.No);
                        Destination.SetFilter(Description, '%1', '');
                        if Destination.FindFirst() then
                            Error('Destination Description/s is needed!!');

                        Source.Reset();
                        Source.SetRange("No.", Rec.No);
                        Source.SetFilter(Description, '%1', '');
                        if Source.FindFirst() then
                            Error('Source Description/s is needed!!');

                        Rec.TestField(Posted, false);

                        BankingActivities.PostTransfers(Rec);

                        CurrPage.Close();
                    end;
                }
                action(Print)
                {
                    ApplicationArea = Basic;
                    Caption = 'Print';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin

                        BTRANS.RESET;
                        BTRANS.SETRANGE(BTRANS.No, Rec.No);
                        IF BTRANS.FIND('-') THEN BEGIN
                            REPORT.RUN(Report::"Account Transfer", TRUE, TRUE, BTRANS);
                        END;


                    end;
                }

                action("Import Transfer Source")
                {
                    ApplicationArea = Basic;
                    Caption = 'Import A/C Transfer Source';
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = xmlport "Account Transfer Source";

                }

                action("Import Transfer Destination")
                {
                    ApplicationArea = Basic;
                    Caption = 'Import A/C Transfer Destination';
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = xmlport "Account Transfer Destination";

                }
            }
        }
        area(processing)
        {
            group(RequestApproval)
            {

                Caption = 'Request Approval';
                action("Attachment")
                {
                    ApplicationArea = Basic;
                    Image = Link;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        DMSint: Record "DMS Endpoints";
                    begin

                        DMSint.RESET;
                        DMSint.SETRANGE(DMSint."Link Type", DMSint."Link Type"::Transfers);
                        IF DMSint.FIND('-') THEN BEGIN
                            HYPERLINK(DMSint."Path" + Rec."No");
                        END;
                    end;
                }
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        NextofKinError: label 'You must specify next of Kin for this application.';
                        NextofKIN: Record "Service Item";
                        ProductFactory: Record "Service Item";
                        SavingsAccountRegistration: Record "Service Item";
                        DocumentType: Enum "Custom Document Type";
                        VarVariant: Variant;
                        CalwideApprovals: Codeunit "Calwide Approvals";
                    begin


                        //TestField("Document Attached");
                        CheckControls;

                        VarVariant := Rec;

                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec.No, 0, Documenttype::"Account Transfer", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", 0);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
                    begin
                        Rec.TestField(Status, Rec.Status::"Pending Approval");

                        VarVariant := Rec;
                        CalwideApprovals.CancelTracker(VarVariant, Rec.No);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = category4;

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
                        DocumentType := Documenttype::"Account Transfer";

                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", Rec.No);
                        ApprovalTracker.SetRange("Custom Document Type", DocumentType);
                        if ApprovalTracker.FindFirst then
                            approvalsMgmt.OpenApprovalEntriesPage(ApprovalTracker.RecordId);
                    end;
                }
                action("Reopen Document")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
                    begin

                        if Rec.Status = Rec.Status::"Pending Approval" then begin
                            VarVariant := Rec;
                            CalwideApprovals.CancelTracker(VarVariant, Rec.No);
                        end
                        else begin

                            if not Confirm('Are you sure you want to re-open this document?') then
                                exit;

                            Rec.Status := Rec.Status::Open;
                            Rec.Modify;
                        end;
                    end;
                }
                action("Reset Date")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()

                    begin


                        if not Confirm('Are you sure you want to re-set dates this document?') then
                            exit;

                        Rec."Transaction Date" := Today;
                        rec."Transaction Time" := Time;
                        Rec.Modify;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        AControl;
    end;

    trigger OnOpenPage()
    begin
        AControl;
    end;

    var
        users: Record User;
        Source: Record "Source Account Transfer";
        BTRANS: Record "Account Transfers";
        DActivity: Code[20];
        DBranch: Code[20];
        UsersID: Record User;
        Destination: Record "Destination Account Transfers";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        MemberActivities: Codeunit "Member Activities";
        SaccoActivities: Codeunit "Sacco Activities";
        HeaderA: Boolean;
        SourceA: Boolean;
        DestinationA: Boolean;
        DocMustbeOpen: label 'This application request must be open';
        DocMustbePending: label 'This application request must be Pending';
        DocMustbeApproved: label 'This document must be approved before posting';
        AmountErrorTxt: label 'Check compliance to contra Entry.';
        BankingActivities: Codeunit "Banking Activities";

    local procedure CheckControls()
    var
        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
        usersetup: Record "User Setup";
    begin

        Rec.CalcFields("Total Credits", "Total Debits");
        if Rec."Total Credits" <> Rec."Total Debits" then
            Error(AmountErrorTxt);

        usersetup.Get(UserId);
        if not usersetup.Backdate then
            if Rec."Transaction Date" <> Today then
                Error('Transaction date must be today');

        Source.Reset;
        Source.SetRange("No.", Rec.No);
        Source.SetRange("Source Account Type", Source."source account type"::Credit);
        Source.SetFilter("Source Amount", '<>%1', 0);
        if Source.Find('-') then begin
            repeat
                Source.TestField("Source Loan No.");

                if Source."Source Transaction Type" = Source."source transaction type"::" " then
                    Error('Kindly specify transaction type under the Source Section');
            until Source.Next = 0;
        end;



        Destination.Reset;
        Destination.SetRange("No.", Rec.No);
        Destination.SetRange("Destination Account Type", Destination."destination account type"::Credit);
        Destination.SetFilter("Destination Amount", '<>%1', 0);
        if Destination.Find('-') then begin
            repeat
                Destination.TestField("Destination Loan No.");

                if Destination."Destination Transaction Type" = Destination."destination transaction type"::" " then
                    Error('Kindly specify transaction type under the Destination Section');
            until Destination.Next = 0;
        end;
    end;


    procedure AControl()
    begin
        case Rec.Status of
            Rec.Status::Open:
                begin
                    SourceA := true;
                    DestinationA := true;
                    HeaderA := true;
                end;

            Rec.Status::"Pending Approval", Rec.Status::Approved, Rec.Status::Rejected:
                begin
                    SourceA := false;
                    DestinationA := false;
                    HeaderA := false;
                end;
        end;
    end;
}

