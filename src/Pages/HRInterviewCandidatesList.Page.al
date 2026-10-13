Page 51051 "HR Interview Candidates List"
{
    ApplicationArea = All;
    CardPageID = "HR Job Applications Card";
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Applicant,Functions,Print';
    SourceTable = "HR Job Applications";
    SourceTableView = where(Qualified = filter(true));

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                Editable = false;
                field(JobApplicationNo; Rec."Job Application No.")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    StyleExpr = true;
                }
                field(DateApplied; Rec."Date Applied")
                {
                    ApplicationArea = Basic;
                    StyleExpr = true;
                }
                field(JobAppliedFor; Rec."Job Applied For")
                {
                    ApplicationArea = Basic;
                }
                field(FirstName; Rec."First Name")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(MiddleName; Rec."Middle Name")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(LastName; Rec."Last Name")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(Qualified; Rec.Qualified)
                {
                    ApplicationArea = Basic;
                }
                field(InterviewInvitationSent; Rec."Interview Invitation Sent")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755009; "HR Job Applications Factbox")
            {
                SubPageLink = "Job Application No." = field("Job Application No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Applicant)
            {
                Caption = 'Applicant';
                action(JobInterviewdetails)
                {
                    ApplicationArea = Basic;
                    Caption = 'Job Interview details';
                    Image = ApplicationWorksheet;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "HR Job Interview";
                    RunPageLink = "Applicant No" = field("Job Application No.");
                }
                action(Card)
                {
                    ApplicationArea = Basic;
                    Caption = 'Card';
                    Image = Card;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "HR Job Applications Card";
                    RunPageLink = "Job Application No." = field("Job Application No.");
                }
                action(UploadtoEmployeeCard)
                {
                    ApplicationArea = Basic;
                    Caption = '&Upload to Employee Card';
                    Image = Export;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        if not Confirm(Text001, false) then exit;
                        if Rec."Employee No" = '' then begin
                            //IF NOT CONFIRM('Are you sure you want to Upload Applications Information to the Employee Card',FALSE) THEN EXIT;
                            HRJobApplications.SetFilter(HRJobApplications."Job Application No.", Rec."Job Application No.");
                            Report.Run(51018, true, false, HRJobApplications);
                        end else begin
                            Message('This applicants information already exists in the employee card');
                        end;
                    end;
                }
                action("Send Interview Invitation")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Interview Invitation';
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        /*
                                                //IF CONFIRM('Send this Requisition for Approval?',TRUE)=FALSE THEN EXIT;
                                                if not Confirm(Text002, false) then exit;

                                                //TestField(Qualified, Qualified::"1");
                                                HRJobApplications.SetRange(HRJobApplications."Job Application No.", "Job Application No.");
                                                if HRJobApplications.Find('-') then
                                                    //GET E-MAIL PARAMETERS FOR JOB APPLICATIONS

                                                    HREmailParameters.Reset;
                                                HREmailParameters.SetRange(HREmailParameters."Associate With", HREmailParameters."associate with"::"Vacancy Advertisements");
                                                if HREmailParameters.Find('-') then begin
                                                    repeat
                                                        HRJobApplications.TestField(HRJobApplications."E-Mail");
                                                    //SMTP.CreateMessage(HREmailParameters."Sender Name", HREmailParameters."Sender Address", HRJobApplications."E-Mail",
                                                    //HREmailParameters.Subject, 'Dear' + ' ' + HRJobApplications."First Name" + ' ' + HREmailParameters.Body + HRJobApplications."Job Applied For" + 'applied on' + Format("Date Applied") + ' ' + HREmailParameters."Body 2", true);
                                                    //HREmailParameters."Body 2"+' '+ FORMAT("Date Applied")+'. '+
                                                    // HREmailParameters.Body,TRUE);
                                                    //SMTP.Send();
                                                    until HRJobApplications.Next = 0;

                                                    Message('All Qualified shortlisted candidates have been invited for the interview ');
                                                end;
                                                */

                    end;
                }
                action(Qualifications)
                {
                    ApplicationArea = Basic;
                    Caption = 'Qualifications';
                    Image = QualificationOverview;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Applicant Qualifications";
                    RunPageLink = "Application No" = field("Job Application No.");
                }
                action(Referees)
                {
                    ApplicationArea = Basic;
                    Caption = 'Referees';
                    Image = ContactReference;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Applicant Referees";
                    RunPageLink = "Job Application No" = field("Job Application No.");
                }
                action(Hobbies)
                {
                    ApplicationArea = Basic;
                    Caption = 'Hobbies';
                    Image = Holiday;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Applicant Hobbies";
                    RunPageLink = "Job Application No" = field("Job Application No.");
                }
            }
        }
    }

    var
        HRJobApplications: Record "HR Job Applications";
        Text001: label 'Are you sure you want to Upload Applicants Details to the Employee Card?';
        Text002: label 'Are you sure you want to Send this Interview invitation?';
        //SMTP: Codeunit UnknownCodeunit400;
        CTEXTURL: Text[30];
    //HREmailParameters: Record UnknownRecord39003942;
}

