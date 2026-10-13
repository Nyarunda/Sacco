Report 51138 "HR Training Appl list"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/HR Training Appl list.rdlc';

    dataset
    {
        dataitem("HR Training App Header"; "HR Training App Header")
        {
            DataItemTableView = sorting("Application No");
            RequestFilterFields = "Application No";
            column(ReportForNavId_6373; 6373)
            {
            }
            column(CourseTitle_HRTrainingApplications; "HR Training App Header"."Created by")
            {
                IncludeCaption = true;
            }
            column(FromDate_HRTrainingApplications; "HR Training App Header"."No. Series")
            {
                IncludeCaption = true;
            }
            column(ToDate_HRTrainingApplications; "HR Training App Header"."Application Date")
            {
                IncludeCaption = true;
            }
            column(DurationUnits_HRTrainingApplications; "HR Training App Header"."Course Title")
            {
                IncludeCaption = true;
            }
            column(Duration_HRTrainingApplications; "HR Training App Header"."Course Description")
            {
                IncludeCaption = true;
            }
            column(CostOfTraining_HRTrainingApplications; "HR Training App Header"."No. of Participants")
            {
                IncludeCaption = true;
            }
            column(Location_HRTrainingApplications; "HR Training App Header"."Start Date")
            {
                IncludeCaption = true;
            }
            column(ApplicationNo_HRTrainingApplications; "HR Training App Header"."Application No")
            {
                IncludeCaption = true;
            }
            column(ApplicationDate_HRTrainingApplications; "HR Training App Header"."Application Date")
            {
                IncludeCaption = true;
            }
            column(EmployeeDepartment_HRTrainingApplications; "HR Training App Header"."Global Dimension 2 Code")
            {
                IncludeCaption = true;
            }
            column(Description_HRTrainingApplications; "HR Training App Header".Status)
            {
            }
            column(PurposeofTraining_HRTrainingApplications; "HR Training App Header".Justification)
            {
            }
            column(ApplicationNo_HRTrainingAppHeader; "HR Training App Header"."Application No")
            {
            }
            column(Createdby_HRTrainingAppHeader; "HR Training App Header"."Created by")
            {
            }
            column(NoSeries_HRTrainingAppHeader; "HR Training App Header"."No. Series")
            {
            }
            column(ApplicationDate_HRTrainingAppHeader; "HR Training App Header"."Application Date")
            {
            }
            column(CourseTitle_HRTrainingAppHeader; "HR Training App Header"."Course Title")
            {
            }
            column(CourseDescription_HRTrainingAppHeader; "HR Training App Header"."Course Description")
            {
            }
            column(NoofParticipants_HRTrainingAppHeader; "HR Training App Header"."No. of Participants")
            {
            }
            column(StartDate_HRTrainingAppHeader; "HR Training App Header"."Start Date")
            {
            }
            column(EndDate_HRTrainingAppHeader; "HR Training App Header"."End Date")
            {
            }
            column(Duration_HRTrainingAppHeader; "HR Training App Header".Duration)
            {
            }
            column(ResponsibilityCenter_HRTrainingAppHeader; "HR Training App Header"."Responsibility Center")
            {
            }
            column(Status_HRTrainingAppHeader; "HR Training App Header".Status)
            {
            }
            column(TrainingInstitution_HRTrainingAppHeader; "HR Training App Header"."Training Institution")
            {
            }
            column(TrainingVenue_HRTrainingAppHeader; "HR Training App Header"."Training Venue")
            {
            }
            column(TrainingCostCstimated_HRTrainingAppHeader; "HR Training App Header"."Training Cost Cstimated")
            {
            }
            column(BondedTraining_HRTrainingAppHeader; "HR Training App Header"."Bonded Training?")
            {
            }
            column(GlobalDimension1Code_HRTrainingAppHeader; "HR Training App Header"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_HRTrainingAppHeader; "HR Training App Header"."Global Dimension 2 Code")
            {
            }
            column(TrainingStatus_HRTrainingAppHeader; "HR Training App Header"."Training Status")
            {
            }
            column(ActualStartDate_HRTrainingAppHeader; "HR Training App Header"."Actual Start Date")
            {
            }
            column(ActualDuration_HRTrainingAppHeader; "HR Training App Header"."Actual Duration")
            {
            }
            column(ActualEndDate_HRTrainingAppHeader; "HR Training App Header"."Actual End Date")
            {
            }
            column(Courseapplying_HRTrainingAppHeader; "HR Training App Header"."Course applying")
            {
            }
            column(Justification_HRTrainingAppHeader; "HR Training App Header".Justification)
            {
            }
            column(CI_Name; CI.Name)
            {
                IncludeCaption = true;
            }
            column(CI_Address; CI.Address)
            {
                IncludeCaption = true;
            }
            column(CI_Address2; CI."Address 2")
            {
                IncludeCaption = true;
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
                IncludeCaption = true;
            }
            column(CI_Picture; CI.Picture)
            {
                IncludeCaption = true;
            }
            column(CI_City; CI.City)
            {
                IncludeCaption = true;
            }
            dataitem("Approval Comment Line"; "Approval Comment Line")
            {
                DataItemLink = "Document No." = field("Application No");
                DataItemLinkReference = "HR Training App Header";
                DataItemTableView = sorting("Table ID", "Document Type", "Document No.");
                column(ReportForNavId_8731; 8731)
                {
                }
                column(UserID_ApprovalCommentLine; "Approval Comment Line"."User ID")
                {
                    IncludeCaption = true;
                }
                column(Comment_ApprovalCommentLine; "Approval Comment Line".Comment)
                {
                    IncludeCaption = true;
                }
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = field("Application No");
                DataItemLinkReference = "HR Training App Header";
                DataItemTableView = sorting("Table ID", "Document Type", "Document No.", "Sequence No.");
                column(ReportForNavId_1171; 1171)
                {
                }
                column(SenderID_ApprovalEntry; "Approval Entry"."Sender ID")
                {
                    IncludeCaption = true;
                }
                column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
                {
                    IncludeCaption = true;
                }
                column(DateTimeSentforApproval_ApprovalEntry; "Approval Entry"."Date-Time Sent for Approval")
                {
                    IncludeCaption = true;
                }
                dataitem("User Setup"; "User Setup")
                {
                    //DataItemLink = "User ID" = field(Field8);
                    DataItemTableView = sorting("User ID");
                    column(ReportForNavId_7968; 7968)
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    HREmp.Reset;
                    HREmp.SetRange(HREmp."User ID", "Approval Entry"."Approver ID");
                    if HREmp.Find('-') then
                        ApproverName := HREmp.FullName
                    else
                        ApproverName := '';
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CI.Get();
        CI.CalcFields(CI.Picture);
    end;

    var
        CI: Record "Company Information";
        HREmp: Record Employee;
        ApproverName: Text[30];
        HR_Training_ApplicationsCaptionLbl: label 'HR Training Applications';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        P_O__BoxCaptionLbl: label 'P.O. Box';
        Training_Application_FormCaptionLbl: label 'Training Application Form';
        Name_of_Training_CourseCaptionLbl: label 'Name of Training Course';
        From__Date_CaptionLbl: label 'From (Date)';
        Duration_CaptionLbl: label 'Duration ';
        To__Date_CaptionLbl: label 'To (Date)';
        Cost_of_TrainingCaptionLbl: label 'Cost of Training';
        How_the_Training_Course_Will_Complement_Enhance_my_Skills_in_Relation_to_the_Job_RequirementsCaptionLbl: label 'How the Training Course Will Complement/Enhance my Skills in Relation to the Job Requirements';
        Brief_Description_of_Training_CourseCaptionLbl: label 'Brief Description of Training Course';
        CommentsCaptionLbl: label 'Comments';
        Comments_By_CaptionLbl: label 'Comments By:';
        End_of_CommentsCaptionLbl: label 'End of Comments';
        Approved_ByCaptionLbl: label 'Approved By';
        ApprovalsCaptionLbl: label 'Approvals';
        SignatureCaptionLbl: label 'Signature';
}

