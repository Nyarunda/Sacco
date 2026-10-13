Page 51136 "HR Training Feedback"
{
    PageType = Card;
    SourceTable = "HR Training Feedback Form";
    PromotedActionCategories = 'New,Process,Report,Approval Request,Comments,Print';

    layout
    {
        area(content)
        {
            group(General)
            {
                field(DocumentNo; Rec."Document No")
                {
                    ApplicationArea = Basic;
                }
                field(CourseTitle; Rec."Course Title")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(FromDate; Rec."From Date")
                {
                    ApplicationArea = Basic;
                }
                field(ToDate; Rec."To Date")
                {
                    ApplicationArea = Basic;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = Basic;
                }
                field(Provider; Rec.Provider)
                {
                    ApplicationArea = Basic;
                }
                field(ProviderName; Rec."Provider Name")
                {
                    ApplicationArea = Basic;
                }
                field(PurposeofTraining; Rec."Purpose of Training")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeNo; Rec."Employee No.")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeName; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = Basic;
                }
                field(DepartmentName; Rec."Department Name")
                {
                    ApplicationArea = Basic;
                }
                field(Branch; Rec.Branch)
                {
                    ApplicationArea = Basic;
                }
                field(BranchName; Rec."Branch Name")
                {
                    ApplicationArea = Basic;
                }
                field("1Pleasestatehowthecoursehasbenefitedyouandtheorgan"; Rec."Text 1")
                {
                    ApplicationArea = Basic;
                    Caption = '1.Please state how the course has benefited you and the organization';
                    MultiLine = true;
                }
                field("2Whichspecificareasdoyouthinkneedimprovementinyour"; Rec."Text 2")
                {
                    ApplicationArea = Basic;
                    Caption = '2.Which specific areas do you think need improvement in your area of operation?';
                    MultiLine = true;
                }
                field("3Howwillyouusetheskillsacquiredtoaddresstheproblem"; Rec."Text 3")
                {
                    ApplicationArea = Basic;
                    Caption = '3.How will you use the skills acquired to address the problem?';
                    MultiLine = true;
                }
                field("4Providetimelinewithinwhichyouwillcascadetheskills"; Rec."Text 4")
                {
                    ApplicationArea = Basic;
                    Caption = '4.Provide timeline within which you will cascade the skills learned to others in your Department/organization';
                    MultiLine = true;
                }
                field("5Whatskillsdidyouacquirefromthetrainingattended"; Rec."Text 5")
                {
                    ApplicationArea = Basic;
                    Caption = '5.What skills did you acquire from the training attended.';
                    MultiLine = true;
                }
                field("6TargetGroupthatcanbenefitfromtheskillsacquired"; Rec."Text 6")
                {
                    ApplicationArea = Basic;
                    Caption = '6.Target Group that can benefit from the skills acquired';
                    MultiLine = true;
                }
                field(ResponsibilityCenter; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                label(Control1)
                {
                    ApplicationArea = Basic;
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
                action(Comments)
                {
                    ApplicationArea = Basic;
                    Caption = 'Comments';
                    Image = Comment;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Application","Transport Requisition";
                    begin
                        /*
                        DocumentType:=DocumentType::"Training Application";
                        
                        ApprovalComments.Setfilters(DATABASE::"HR Training Applications",DocumentType,"Application No");
                        ApprovalComments.SetUpLine(DATABASE::"HR Training Applications",DocumentType,"Application No");
                        ApprovalComments.RUN;
                        */

                    end;
                }
            }
            group(Functions)
            {
                Caption = 'F&unctions';
                action(Approve)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approve';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //Rec.Status := Rec.Status::"2";
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

                    trigger OnAction()
                    begin
                        // Rec.Status := Rec.Status::"3";
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = '&Approvals';
                    Enabled = false;
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    var
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Store Requisition","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval","Induction Approval","Disciplinary Approvals","Activity Approval","Exit Approval","Medical Claim Approval",Jv,BackToOffice;
                    //ApprovalEntries: Page "Approval Entries";
                    begin
                        /*
                        DocumentType:=DocumentType::BackToOffice;
                        ApprovalEntries.Setfilters(DATABASE::"HRBack To Office Form",DocumentType,"Document No");
                        ApprovalEntries.RUN;
                        */

                    end;
                }
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = '&Send Approval &Request';
                    Enabled = true;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = true;

                    trigger OnAction()
                    begin

                        if Confirm('Send this Application for Approval?', true) = false then exit;
                        //ApprovalMgt.SendBackOfficeAppApprovalRequest(Rec);
                    end;
                }
                action(CancelApprovalrequest)
                {
                    ApplicationArea = Basic;
                    Caption = '&Cancel Approval request';
                    Enabled = false;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin

                        if Confirm('Are you sure you want to cancel the approval request', true) = false then exit;
                        //ApprovalMgt.CancelBackOfficeAppApprovalReq(Rec,TRUE,TRUE);
                    end;
                }
                action(Print)
                {
                    ApplicationArea = Basic;
                    Caption = '&Print';
                    Image = PrintForm;
                    Promoted = true;
                    PromotedCategory = Category4;
                    //RunObject = Report UnknownReport39005550;

                    trigger OnAction()
                    begin
                        /*
                       HRTrainingApplications.SETRANGE(HRTrainingApplications."Application No","Application No");
                       IF HRTrainingApplications.FIND('-') THEN
                       REPORT.RUN(39005484,TRUE,TRUE,HRTrainingApplications);
                        */

                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        //if Rec.Status = Rec.Status::"2" then
        //  CurrPage.Editable := false;
    end;

    var
        ApprovalMgt: Codeunit System.Automation."Approvals Mgmt.";
}

