/*
Page 51129 "HR Intern Requisition Card"
{
    PageType = Card;
    SourceTable = UnknownTable39004005;

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'General';
                field(RequisitionNo; "Requisition No.")
                {
                    ApplicationArea = Basic;
                }
                field(RequisitionDate; "Requisition Date")
                {
                    ApplicationArea = Basic;
                }
                field(UserID; "User ID")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension1Code; "Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension2Code; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(ResponsibilityCenter; "Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field(Quarter; Quarter)
                {
                    ApplicationArea = Basic;
                }
                field(RequisitionFor; "Requisition For")
                {
                    ApplicationArea = Basic;
                }
                field(ReasonForRequest; "Reason For Request")
                {
                    ApplicationArea = Basic;
                }
                field(AvailableInterns; "Available Interns")
                {
                    ApplicationArea = Basic;
                }
                field(NoofInternsRequired; "No. of Interns Required")
                {
                    ApplicationArea = Basic;
                }
                field(Priority; Priority)
                {
                    ApplicationArea = Basic;
                }
                field(DueDate; "Due Date")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleText;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control16; Outlook)
            {
            }
            systempart(Control17; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                    ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                    ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                    ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        //ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Basic;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Approval Comments";
                    Visible = OpenApprovalEntriesExistForCurrUser;
                }
            }
            group(RequestApproval)
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = not OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                    ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        //TESTFIELD("No of Posts");
                        TESTFIELD("Document No.");
                        TESTFIELD(Description);
                        TESTFIELD("Interest Due Date");
                        VarVariant := Rec;
                        //if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        //CustomApprovals.OnSendDocForApproval(VarVariant);

                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                    ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        VarVariant := Rec;
                        //CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
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
                    begin

                        approvalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //Get the available interns
        if Rec.Status = Rec.Status::"0" then begin
            HRInterns.Reset;
            HRInterns.SetRange(HRInterns."Posting Status", HRInterns."posting status"::"0");
            "Available Interns" := HRInterns.Count;
            "No. of Interns Required" := 0;
        end;


        OpenApprovalEntriesExistCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;

    var
        HRCodeunit: Codeunit "HR Codeunit.";
        StyleText: Text;
        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
        OpenApprovalEntriesExistCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        HRInterns: Record UnknownRecord39004004;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        VarVariant: Variant;
        //CustomApprovals: Codeunit UnknownCodeunit39004245;
}

*/