Page 51071 "HR Employee Separation"
{
    ApplicationArea = All;
    SourceTable = "HR Employee Separation";

    layout
    {
        area(content)
        {
            field(SeparationNo; Rec."Separation No.")
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
            field(JobTitle; Rec."Job Title")
            {
                ApplicationArea = Basic;
            }
            field(NatureofSeparation; Rec."Nature of Separation")
            {
                ApplicationArea = Basic;
            }
            field(ReasonforSeparation; Rec."Reason for Separation")
            {
                ApplicationArea = Basic;
                MultiLine = true;
            }
            field(SeparationDate; Rec."Separation Date")
            {
                ApplicationArea = Basic;
            }
            field(ResponsibilityCenter; Rec."Responsibility Center")
            {
                ApplicationArea = Basic;
            }
            field(ReasonforRetirement; Rec."Reason for Retirement")
            {
                ApplicationArea = Basic;
                Visible = false;
            }
            field(Illness; Rec.Illness)
            {
                ApplicationArea = Basic;
            }
            field(Justification; Rec.Justification)
            {
                ApplicationArea = Basic;
                MultiLine = true;
            }
            field(Status; Rec.Status)
            {
                ApplicationArea = Basic;
            }
            field(EndofcontractDate; Rec."End of contract Date")
            {
                ApplicationArea = Basic;
            }
        }
        area(factboxes)
        {
            systempart(Control17; Outlook)
            {
            }
            systempart(Control16; Notes)
            {
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Approvals)
            {
                ApplicationArea = Basic;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher",PettyCash,Imprest,Requisition,ImpSurrender,Interbank,Receipt,StaffClaim,"Staff Adv",AdvSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Requisition","Transport Requisition",JV,"Grant Task","Concept Note",Proposal,"Job Approval","Disciplinary Approvals",GRN,Clearence,Donation,Transfer,PayChange,Budget,GL,"Cash Purchase","Leave Reimburse",Appraisal,Inspection,Closeout,"Lab Request",ProposalProjectsAreas,"Leave Carry over","IB Transfer",EmpTransfer,LeavePlanner,HrAssetTransfer,Contract,Project,MR,Inves,PB,Prom,Ind,Conf,BSC,OT,Jobsucc,SuccDetails,Disc,Separation;
                //ApprovalEntries: Page "Approval Entries";
                begin
                    DocumentType := Documenttype::Separation;
                    //ApprovalEntries.Setfilters(Database::"HR Employee Separation", DocumentType, "Separation No.");
                    // ApprovalEntries.Run;
                end;
            }
            action(SendApprovalRequest)
            {
                ApplicationArea = Basic;
                Caption = 'Send Approval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    /*TESTFIELD("No of Posts");
                    TESTFIELD("Responsibility Center");
                    
                    CALCFIELDS("No. of Requirements");
                    IF "No. of Requirements" = 0 THEN  ERROR('Please Specify the Job Requirements');
                     CALCFIELDS("No. of Responsibilities");
                    
                    IF "No. of Responsibilities" = 0 THEN ERROR('Please Specify the Job Responsibilities');
                      */
                    if Confirm('Send this Document for Approval?', true) = false then exit;
                    //   AppMgmt.SendQualifiedAplicantApprovalReq(Rec);

                end;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = Basic;
                Caption = 'Cancel Approval Request';
                Image = CancelAllLines;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    if Confirm('Cancel Approval Request?', true) = false then exit;
                    //AppMgmt.CancelEmpChangeDetailsRequest(Rec,TRUE,TRUE);
                end;
            }
        }
    }

    var
        HREmployees: Record Employee;
}

