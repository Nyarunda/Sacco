page 50648 "Reversal Card"
{
    ApplicationArea = All;
    Caption = 'Reversal Card';
    PageType = Card;
    SourceTable = "Reversal Header";
    PromotedActionCategories = 'New,Process,Reports,Approvals,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';


                field("Account Type"; Rec."Account Type")
                {

                }
                field("Member No."; Rec."Member No.")
                {
                }
                field("Account No"; Rec."Account No")
                {
                }
                field("Entry No"; Rec."Entry No")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                    editable = false;
                }
                field(Description; Rec.Description)
                {
                    editable = false;
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    editable = false;
                }
                field("Posted By"; Rec."Posted By")
                {
                    editable = false;
                }
                field("Reponsibility Center"; Rec."Reponsibility Center")
                {

                }
                field(Branch; Rec.Branch)
                {

                }
                field(Status; Rec.Status)
                {

                }
                field("Time Posted"; Rec."Time Posted")
                {
                    editable = false;
                }
                field(Reversed; Rec.Reversed)
                {
                    editable = false;
                }
                field("Date Reversed"; Rec."Date Reversed")
                {
                    editable = false;
                }
                field("Time Reversed"; Rec."Time Reversed")
                {
                    editable = false;
                }
                field("Reversed By"; Rec."Reversed By")
                {
                    editable = false;

                }
                field(Reason; Rec.Reason)
                {

                }
            }
            part(ReversalLines; "Auto Reversal Lines")
            {
                SubPageLink = "Document No." = field("Document No.");
            }
        }

    }
    actions
    {
        area(Navigation)
        {
            action("Reverse Entries")
            {
                ApplicationArea = Basic;
                Image = AllLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.TestField(status, Rec.Status::Approved);
                    if Confirm('Are you sure you want to Reverse this entry/s?') then begin
                        SaccoActivities.CustomeReverseProcess(Rec);
                        Rec.Reversed := true;
                        Rec."Date Reversed" := Today;
                        Rec."Time Reversed" := time;
                        Rec."Reversed By" := UserId;
                        Rec.Modify();
                    end;

                end;
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
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
                        Rec.TestField(Status, Rec.Status::Open);
                        Rec.TestField(Reason);
                        VarVariant := Rec;
                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec."Reversal No.", 0, Documenttype::Reversal, '', '', 0);
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
                        CalwideApprovals.CancelTracker(VarVariant, Rec."Reversal No.");
                    end;
                }
            }
            group(Navigate)
            {
                Caption = 'Navigate';
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ApplicationArea = Basic;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page System.Automation."Approval Entries";
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                    end;
                }
            }
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ApplicationArea = Basic;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId)
                    end;
                }
                action(Reject)
                {
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ApplicationArea = Basic;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId)
                    end;
                }
                action(Delegate)
                {
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ApplicationArea = Basic;

                    trigger OnAction()
                    var

                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId)
                    end;
                }
            }

        }
    }
    trigger OnAfterGetRecord()
    begin
        UpdateControls;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControls;
    end;

    trigger OnOpenPage()
    begin
        UpdateControls;
    end;

    /// <summary>
    /// UpdateControls.
    /// </summary>
    procedure UpdateControls()
    begin
        if Rec.Status = Rec.Status::Open then
            CurrPage.Editable := true
        else
            CurrPage.Editable := false;
    end;

    var
        SaccoActivities: Codeunit "Sacco Activities";
        "NOT OpenApprovalEntriesExist": Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Calwide Approvals";
}
