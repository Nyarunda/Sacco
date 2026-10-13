Page 50919 "HR Applicants UnQualified L"
{
    CardPageID = "HR Applicants UnQualified Card";
    PageType = List;
    SourceTable = "HR Job Applications";
    SourceTableView = where(Qualified = filter(false));

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
                action("Send Regret Alert")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Regret Alert';
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        /*

                        //IF CONFIRM('Send this Requisition for Approval?',TRUE)=FALSE THEN EXIT;
                        if not Confirm(Text003, false) then exit;

                        TestField(Qualified, Qualified::"0");
                        HRJobApplications.SetRange(HRJobApplications."Job Application No.", "Job Application No.");
                        CurrPage.SetSelectionFilter(HRJobApplications);
                        if HRJobApplications.Find('-') then
                            //GET E-MAIL PARAMETERS FOR JOB APPLICATIONS
                            HREmailParameters.Reset;
                        HREmailParameters.SetRange(HREmailParameters."Associate With", HREmailParameters."associate with"::"Regret Notification");
                        if HREmailParameters.Find('-') then begin
                            repeat
                                HRJobApplications.TestField(HRJobApplications."E-Mail");
                                SMTP.CreateMessage(HREmailParameters."Sender Name", HREmailParameters."Sender Address", HRJobApplications."E-Mail",
                                HREmailParameters.Subject, 'Dear' + ' ' + HRJobApplications."First Name" + ' ' + HREmailParameters.Body + ' ' + HRJobApplications."Job Applied for Description" + ' ' + 'applied on' + ' ' + Format("Date Applied") + ' ' + HREmailParameters."Body 2", true);
                                //HREmailParameters."Body 2"+' '+ FORMAT("Date Applied")+'. '+
                                // HREmailParameters.Body,TRUE);
                                SMTP.Send();
                            until HRJobApplications.Next = 0;

                            Message('All Unqualified  candidates have been sent regret alerts');
                        end;
                        */
                    end;
                }
            }
        }
    }

    var
        Text001: label 'Are you sure you want to Upload Applicants Details to the Employee Card?';
        Text002: label 'Are you sure you want to Send this Interview invitation?';
        HRJobApplications: Record "HR Job Applications";
        ////SMTP: Codeunit UnknownCodeunit400;
        CTEXTURL: Text[30];
        //HREmailParameters: Record UnknownRecord39003942;
        Text003: label 'Are you sure you want to Send Regret Notification?';
}

