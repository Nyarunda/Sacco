Report 51094 "HR Job Occupants"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/HR Job Occupants.rdlc';
    Caption = 'HR Job Occupants Report';

    dataset
    {
        dataitem("HR Jobs"; "HR Jobs")
        {
            RequestFilterFields = "Job ID", Status;
            column(ReportForNavId_1000000000; 1000000000)
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
            }
            column(CI_Picture; CI.Picture)
            {
            }
            column(CI_City; CI.City)
            {
                IncludeCaption = true;
            }
            column(JobID_HRJobs; "HR Jobs"."Job ID")
            {
                IncludeCaption = true;
            }
            column(JobDescription_HRJobs; "HR Jobs"."Job Description")
            {
                IncludeCaption = true;
            }
            dataitem(Employee; Employee)
            {
                //DataItemLink = Position = field("Job ID");
                DataItemTableView = sorting("No.") order(ascending);
                column(ReportForNavId_1000000001; 1000000001)
                {
                }
                column(No_HREmployee; Employee."No.")
                {
                }
                column(FirstName_HREmployee; Employee."First Name")
                {
                }
                column(JobID_HREmployee; Employee."Job Title")
                {
                }
                column(MiddleName_HREmployee; Employee."Middle Name")
                {
                }
                column(LastName_HREmployee; Employee."Last Name")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    HRJob.Reset;
                    HRJob.SetRange(HRJob."Job ID", "Job Title");
                    if HRJob.Find('-') then;
                    //CurrReport.SHOWOUTPUT := true;
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
        CI.Reset;
        CI.Get();
        CI.CalcFields(CI.Picture);
    end;

    var
        CI: Record "Company Information";
        HR_Job_OccupationsCaptionLbl: label 'HR Job Occupations';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Job_OccupantsCaptionLbl: label 'HR Job Occupants';
        P_O__BoxCaptionLbl: label 'P.O. Box';
        NoCaptionLbl: label 'No';
        NameCaptionLbl: label 'Name';
        Company_E_MailCaptionLbl: label 'Company E-Mail';
        Postal_AddressCaptionLbl: label 'Postal Address';
        CityCaptionLbl: label 'City';
        HRJob: Record "HR Jobs";
}

