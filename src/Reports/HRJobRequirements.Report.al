Report 51099 "HR Job Requirements"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/HR Job Requirements.rdlc';

    dataset
    {
        dataitem("HR Jobs"; "HR Jobs")
        {
            RequestFilterFields = "Job ID";
            column(ReportForNavId_9002; 9002)
            {
            }
            column(PageConst_________FORMAT_CurrReport_PAGENO_; PageConst + ' ' + Format(''))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(CI_City; CI.City)
            {
            }
            column(CI__Address_2______CI__Post_Code_; CI."Address 2" + ' ' + CI."Post Code")
            {
            }
            column(CI_Address; CI.Address)
            {
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
            }
            column(HR_Jobs__Job_ID_; "Job ID")
            {
            }
            column(HR_Jobs__Job_Description_; "Job Description")
            {
            }
            column(HR_Jobs__Main_Objective_; "Main Objective")
            {
            }
            column(HR_JobsCaption; HR_JobsCaptionLbl)
            {
            }
            column(Job_RequirementsCaption; Job_RequirementsCaptionLbl)
            {
            }
            column(P_O__BoxCaption; P_O__BoxCaptionLbl)
            {
            }
            column(HR_Jobs__Job_ID_Caption; FieldCaption("Job ID"))
            {
            }
            column(HR_Jobs__Job_Description_Caption; FieldCaption("Job Description"))
            {
            }
            column(HR_Jobs__Main_Objective_Caption; FieldCaption("Main Objective"))
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(CI_Picture; CI.Picture)
            {
            }
            dataitem("HR Job Requirements"; "HR Job Requirements")
            {
                DataItemLink = "Job ID" = field("Job ID");
                DataItemTableView = sorting("Job ID", "Qualification Type", "Qualification Code");
                column(ReportForNavId_5968; 5968)
                {
                }
                column(JobId_HRJobRequirements; "HR Job Requirements"."Job ID")
                {
                    IncludeCaption = true;
                }
                column(QualificationType_HRJobRequirements; "HR Job Requirements"."Qualification Type")
                {
                    IncludeCaption = true;
                }
                column(QualificationCode_HRJobRequirements; "HR Job Requirements"."Qualification Code")
                {
                    IncludeCaption = true;
                }
                column(Priority_HRJobRequirements; "HR Job Requirements".Priority)
                {
                    IncludeCaption = true;
                }
                column(ScoreID_HRJobRequirements; "HR Job Requirements"."Score ID")
                {
                    IncludeCaption = true;
                }
                column(Needcode_HRJobRequirements; "HR Job Requirements"."Need code")
                {
                    IncludeCaption = true;
                }
                column(StageCode_HRJobRequirements; "HR Job Requirements"."Stage Code")
                {
                    IncludeCaption = true;
                }
                column(Mandatory_HRJobRequirements; "HR Job Requirements".Mandatory)
                {
                    IncludeCaption = true;
                }
                column(DesiredScore_HRJobRequirements; "HR Job Requirements"."Minimum Score")
                {
                    IncludeCaption = true;
                }
                column(TotalStageDesiredScore_HRJobRequirements; "HR Job Requirements"."Total (Stage)Desired Score")
                {
                    IncludeCaption = true;
                }
                column(QualificationDescription_HRJobRequirements; "HR Job Requirements"."Qualification Description")
                {
                    IncludeCaption = true;
                }
                column(JobDescription; JobDescription)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    JobDescription := '';
                    Jobs.Reset;
                    Jobs.SetRange(Jobs."Job ID", "HR Job Requirements"."Job ID");
                    if Jobs.Find('-') then
                        JobDescription := Jobs."Job Description";
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
        HR_JobsCaptionLbl: label 'HR Jobs';
        Job_RequirementsCaptionLbl: label 'Job Requirements';
        P_O__BoxCaptionLbl: label 'P.O. Box';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        PageConst: label 'Page';
        NameCaptionLbl: label 'Name';
        Jobs: Record "HR Jobs";
        JobDescription: Text[100];
}

