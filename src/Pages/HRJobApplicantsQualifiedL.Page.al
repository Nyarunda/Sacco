Page 50842 "HR Job Applicants Qualified L"
{
    CardPageID = "Job Applicants Qualified Card";
    Editable = false;
    PageType = List;
    SourceTable = "HR Job Applications";
    SourceTableView = where(Qualified = const(true),
                            Uploaded = const(false),
                            "Approval Status" = filter(<> Approved));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(JobApplicationNo; Rec."Job Application No.")
                {
                    ApplicationArea = Basic;
                }
                field(FullName; Rec."Full Name")
                {
                    ApplicationArea = Basic;
                }
                field(DateApplied; Rec."Date Applied")
                {
                    ApplicationArea = Basic;
                    StyleExpr = true;
                }
                field(ApplicationRefNo; Rec."Employee Requisition No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Application Ref. No.';
                }
                field(JobID; Rec."Job Applied For")
                {
                    ApplicationArea = Basic;
                    Caption = 'Job ID';
                }
                field(JobDescription; Rec."Job Applied for Description")
                {
                    ApplicationArea = Basic;
                    Caption = 'Job Description';
                }
                field(FromTime; Rec."From Time")
                {
                    ApplicationArea = Basic;
                }
                field(ToTime; Rec."To Time")
                {
                    ApplicationArea = Basic;
                }
                field(Venue; Rec.Venue)
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                    StyleExpr = true;
                }
                field(InterviewInvitationSent; Rec."Interview Invitation Sent")
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
            group(Applicant)
            {
                Caption = 'Applicant';
                action("Send Interview Invitation")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Interview Invitation';
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        FN: Text;
                        SaccoActivities: Codeunit "Sacco Activities";
                        WelcomeInterviewText: Text;
                    begin

                        //TestField(Qualified, Qualified::"1");
                        Rec.TESTFIELD("Date of Interview");
                        Rec.TESTFIELD("From Time");
                        Rec.TESTFIELD("To Time");
                        Rec.TESTFIELD(Venue);
                        Rec.TestField("E-Mail");

                        WelcomeInterviewText := 'Following your job application for ' + Rec."Job Applied for Description" + '. We are happy to inform ' +
                        'you that you have been invited for an interview at ' + Rec.Venue + ' ' +
                        'on ' + Format(Rec."Date of Interview") + ' from' + Format(Rec."From Time") + ' to ' + Format(Rec."To Time");
                        FN := Rec."First Name" + ' ' + Rec."Middle Name" + ' ' + Rec."Last Name";
                        if not Confirm(Text002, false, FN) then exit;


                        if Rec."Interview Invitation Sent" = true then Error('Applicant has already been notified');

                        HRJobApplications.SetRange(HRJobApplications."Job Application No.", Rec."Job Application No.");
                        CurrPage.SetSelectionFilter(HRJobApplications);

                        if HRJobApplications.Find('-') then
                        //GET E-MAIL PARAMETERS FOR JOB APPLICATIONS
                        //    HREmailParameters.Reset;
                        //HREmailParameters.SetRange(HREmailParameters."Associate With", HREmailParameters."associate with"::"Interview Invitations");
                        //if not HREmailParameters.Find('-') then Error('Please setup Email Parameters');
                        begin
                            repeat
                                SaccoActivities.SendEmail(Rec."E-Mail", '', '', 'Interview Invitation', 'Dear ' + Rec."First Name", WelcomeInterviewText);
                            //  SaccoActivities.SendLoanDisbursementNotifications();
                            /*
                                                            HRJobApplications.TestField(HRJobApplications."E-Mail");
                                SMTP.CreateMessage(HREmailParameters."Sender Name", HREmailParameters."Sender Address", HRJobApplications."E-Mail",
                                HREmailParameters.Subject, 'Dear' + ' ' + HRJobApplications."First Name" + '<BR><br>' + HREmailParameters.Body + ' '
                                + HRJobApplications."Job Applied for Description" + ' ' + 'applied on ' + Format("Date Applied") + ' ' + HREmailParameters."Body 2" + '<br>'
                                + HREmailParameters."Body 3" + ' ' + Format(HRJobApplications."Date of Interview") + ' '
                                + 'Starting at ' + Format(HRJobApplications."From Time") + ' to ' + Format(HRJobApplications."To Time") + ' Venue ' + HRJobApplications.Venue
                                + '<br><br>Best Regards' + '<br>' + COMPANYNAME, true);

                                SMTP.Send();
                                */
                            until HRJobApplications.Next = 0;

                            Rec."Interview Invitation Sent" := true;
                            Rec.Modify;
                            Message('%1 has been invited for the Interview Invitation via E-Mail ', FN)
                        end;
                    end;
                }
                action(JobInterviewdetails)
                {
                    ApplicationArea = Basic;
                    Caption = 'Job Interview details';
                    Image = ApplicationWorksheet;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "HR Job Interview";
                    RunPageLink = "Applicant No" = field("Job Application No.");
                }
                action(JobApplicantCard)
                {
                    ApplicationArea = Basic;
                    Caption = 'Job Applicant Card';
                    Image = Card;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HR Job Applications Card";
                    RunPageLink = "Job Application No." = field("Job Application No.");
                }
                action(ApplicantQualifications)
                {
                    ApplicationArea = Basic;
                    Caption = 'Applicant Qualifications';
                    Image = QualificationOverview;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Page "HR Applicant Qualifications";
                    RunPageLink = "Application No" = field("Job Application No.");
                }
                action(ApplicantReferees)
                {
                    ApplicationArea = Basic;
                    Caption = 'Applicant Referees';
                    Image = ContactReference;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Page "HR Applicant Referees";
                    RunPageLink = "Job Application No" = field("Job Application No.");
                }
                action(ApplicantHobbies)
                {
                    ApplicationArea = Basic;
                    Caption = 'Applicant Hobbies';
                    Image = Holiday;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Page "HR Applicant Hobbies";
                    RunPageLink = "Job Application No" = field("Job Application No.");
                }
                action("Upload to Employees")
                {
                    ApplicationArea = Basic;
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Report "HR Applicant to Employee";
                    Visible = false;
                }
            }
        }
    }

    var
        Text001: label 'Are you sure you want to upload "%1" to the Employee List?';
        Text002: label 'Are you sure you want to Send this Interview invitation to\%1?';
        HRJobApplications: Record "HR Job Applications";
        //SMTP: Codeunit UnknownCodeunit400;
        CTEXTURL: Text[30];
        //HREmailParameters: Record UnknownRecord39003942;
        ////Interview: Record UnknownRecord52018685;
        fn: Text;
}

