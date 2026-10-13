Page 50966 "HR Asset Transfer Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'Manage,Proces,Report,Transfer,Request Approval';
    SourceTable = "HR Asset Transfer Header";
    Caption = 'Asset Transfer Card';
    SourceTableView = where(Transfered = const(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(DocumentDate; Rec."Document Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Raisedby; Rec."Raised by")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(CurrentHolder; Rec."Current Holder")
                {
                    ApplicationArea = Basic;
                }
                field(CurrentHolderName; Rec."Current Holder Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(AssettoTransfer; Rec."Asset to Transfer")
                {
                    ApplicationArea = Basic;
                }
                field(AssetDescription; Rec."Asset Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(SerialNo; Rec."Serial No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(NewHolder; Rec."New Holder")
                {
                    ApplicationArea = Basic;
                }
                field(NewHolderName; Rec."New Holder Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Transfered; Rec.Transfered)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(DateTransfered; Rec."Date Transfered")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TransferedBy; Rec."Transfered By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TimeTransferred; Rec."Time Transferred")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control16; Links)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Transfer)
            {
                ApplicationArea = Basic;
                Image = TransferToLines;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    //TESTFIELD(Status,Status::Approved);

                    if Confirm(Txt001, false) = true then begin

                        EmployeeAssets.Reset;
                        EmployeeAssets.SetRange(EmployeeAssets."Employee No.", Rec."Current Holder");
                        EmployeeAssets.SetRange(EmployeeAssets."Misc. Article Code", Rec."Asset to Transfer");
                        if EmployeeAssets.Find('-') then begin

                            EmployeeAssets."In Use" := false;
                            EmployeeAssets."To Date" := Today;
                            EmployeeAssets.Modify;

                            EmployeeAssets.Reset;
                            EmployeeAssets.Init;
                            EmployeeAssets."Employee No." := Rec."New Holder";
                            EmployeeAssets."Misc. Article Code" := Rec."Asset to Transfer";
                            EmployeeAssets.Description := Rec."Asset Description";
                            EmployeeAssets."Serial No." := Rec."Serial No.";
                            EmployeeAssets."From Date" := Today;
                            EmployeeAssets."In Use" := true;
                            EmployeeAssets.Insert(true);

                            Rec.Transfered := true;
                            Rec."Transfered By" := UserId;
                            Rec."Date Transfered" := Today;
                            Rec."Time Transferred" := Time;

                            Message(Txt002, Rec."Asset to Transfer", Rec."New Holder");

                        end;

                    end;
                end;
            }
        }
        area(Navigation)
        {
            group(RequestApproval)
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        NextofKinError: label 'You must specify next of Kin for this application.';
                        DocumentType: Enum "Custom Document Type";
                        VarVariant: Variant;
                        CalwideApprovals: Codeunit "Calwide Approvals";
                    begin

                        //CheckControls;

                        VarVariant := Rec;
                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec."No.", 0, Documenttype::"Asset Transfer", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", 0);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;

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
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        RecRef: RecordRef;
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Member Application","Loan Application","Savings Application",FDR,"Def. Recovery","Loan Changes","Guarantor Sub.","Member Exit","Member Exit Notice";
                        VarVariant: Variant;
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocumentType := Documenttype::"Member Exit";


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
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        Updatecontrol;
    end;

    trigger OnAfterGetRecord()
    begin
        Updatecontrol;
    end;

    trigger OnInit()
    begin
        Edit := true;
        Line := true;
    end;

    var
        //RecHeader: Record UnknownRecord39003971;
        //ApprovalEntries: Page "Approval Entries";
        Edit: Boolean;
        Line: Boolean;
        EmployeeAssets: Record "Misc. Article Information";
        Txt001: label 'Do you want to effect the transfer';
        Txt002: label 'Asset %1 Successfully Transferred to Employee %2';


    procedure Updatecontrol()
    begin
        /*
        IF Status=Status::Open THEN BEGIN
        Edit:=TRUE;
        Line:=TRUE;
        END ELSE IF Status=Status::"Pending Approval" THEN BEGIN
        Edit:=FALSE;
        Line:=FALSE;
        END ELSE IF Status=Status::Approved THEN BEGIN
        Edit:=FALSE;
        Line:=FALSE;
        END
         */

    end;
}

