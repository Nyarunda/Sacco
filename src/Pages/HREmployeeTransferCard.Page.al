Page 50962 "HR Employee Transfer Card"
{
    PageType = Card;
    PromotedActionCategories = 'Manage,Process,Report,Redeploy,Category5_caption,Category6_caption,Category7_caption,Category8_caption,Approvals';
    SourceTable = "HR Employee Transfer Header";
    SourceTableView = where("Transfer details Updated" = const(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                field(RequestNo; Rec."Request No")
                {
                    ApplicationArea = Basic;
                }
                field(DateRequested; Rec."Date Requested")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeNo; Rec."Employee No")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeName; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(JobID; Rec."Job ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(JobDescription; Rec."Job Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowCaption = false;
                }
                field(Dimension1Code; Rec."Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Dimension1Description; Rec."Dimension 1 Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowCaption = false;
                }
                field(Dimension2Code; Rec."Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Dimension2Description; Rec."Dimension 2 Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowCaption = false;
                }
                field(Dimension3Code; Rec."Dimension 3 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Dimension3Description; Rec."Dimension 3 Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowCaption = false;
                    Visible = false;
                }
                field(SalaryGrade; Rec."Salary Grade")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(SalaryNotch; Rec."Salary Notch")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(NewJobID; Rec."New Job ID")
                {
                    ApplicationArea = Basic;
                }
                field(NewJobDescription; Rec."New Job Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowCaption = false;
                }
                field(NewDimension1Code; Rec."New Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(NewDimension1Description; Rec."New Dimension 1 Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowCaption = false;
                }
                field(NewDimension2Code; Rec."New Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(NewDimension2Description; Rec."New Dimension 2 Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowCaption = false;
                }
                field(NewDimension3Code; Rec."New Dimension 3 Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(NewDimension3Description; Rec."New Dimension 3 Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowCaption = false;
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(ReasonforTransfer; Rec."Reason for Transfer")
                {
                    ApplicationArea = Basic;
                }
                field(TransferdetailsUpdated; Rec."Transfer details Updated")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("Transfer Duration")
            {
                field(EffectiveFrom; Rec."Effective From")
                {
                    ApplicationArea = Basic;
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = Basic;
                }
                field(EffectiveTo; Rec."Effective To")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Show)
            {
                Caption = '&Show';
            }
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
                    //ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        // ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
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
                    //ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        //ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
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
                        DocumentType: Enum "Custom Document Type";
                    begin
                        Rec.TestField("Employee No");
                        Rec.TestField("New Job ID");
                        Rec.TestField("New Dimension 1 Code");
                        Rec.TestField("New Dimension 2 Code");

                        VarVariant := Rec;
                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec."Request No", 0, DocumentType::"Employee Transfer", Rec."Dimension 1 Code", Rec."Dimension 2 Code", 0);
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
                    begin
                        VarVariant := Rec;
                        CalwideApprovals.CancelTracker(VarVariant, Rec."Request No");
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
                        RecRef: RecordRef;
                        DocType: Enum "Custom Document Type";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);

                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", Rec."Request No");
                        ApprovalTracker.SetRange("Custom Document Type", DocType::"Employee Transfer");
                        if ApprovalTracker.FindFirst then
                            ApprovalsMgmt.OpenApprovalEntriesPage(ApprovalTracker.RecordId);
                    end;
                }
                action(Redeploy)
                {
                    ApplicationArea = Basic;
                    Caption = 'Redeploy';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = false;

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Approved);
                        Rec.TestField("Employee No");
                        Rec.TestField("New Job ID");

                        if Rec."Transfer details Updated" then
                            Error(Text003);

                        if Confirm(Text002, false) = true then begin

                            if Employees.Get(Rec."Employee No") then begin
                                Employees.Validate("Job ID", Rec."New Job ID");
                                Employees.Validate("Job Title", Rec."New Job ID");

                                if Rec."New Dimension 1 Code" <> '' then begin
                                    Employees.Validate("Global Dimension 1 Code", Rec."New Dimension 1 Code");
                                end;

                                if Rec."New Dimension 2 Code" <> '' then
                                    Employees.Validate("Global Dimension 2 Code", Rec."New Dimension 2 Code");

                                Employees.Modify(true);
                            end else
                                Error('Employee %1 was not found.', Rec."Employee No");

                            Rec."Job ID" := Rec."New Job ID";
                            Rec."Job Description" := Rec."New Job Description";
                            Rec."Dimension 1 Code" := Rec."New Dimension 1 Code";
                            Rec."Dimension 1 Description" := Rec."New Dimension 1 Description";
                            Rec."Dimension 2 Code" := Rec."New Dimension 2 Code";
                            Rec."Dimension 2 Description" := Rec."New Dimension 2 Description";
                            Rec."Transfer details Updated" := true;
                            Rec.Modify(true);
                            CurrPage.Update(false);
                            Message(Text001, Rec."Employee No");

                        end;
                    end;
                }
            }
        }
    }

    var
        ApprovalComments: Page "Approval Comments";
        Employees: Record Employee;
        Text001: label 'Employee No. %1 has been successfully redeployed';
        Text002: label 'Do you want to effect this transfer';
        Text003: label 'This transfer has already been effected.';
        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
        CalwideApprovals: Codeunit "Calwide Approvals";
        ApprovalTracker: Record "Approval Tracker";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        VarVariant: Variant;
        ////CustomApprovals: Codeunit UnknownCodeunit39004245;
        OpenApprovalEntriesExist: Boolean;
}

