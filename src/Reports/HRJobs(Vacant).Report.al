Report 51095 "HR Jobs (Vacant)"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/HR Jobs (Vacant).rdlc';
    Caption = 'HR Jobs (Vacant)';

    dataset
    {
        dataitem("HR Jobs"; "HR Jobs")
        {
            DataItemTableView = order(ascending) where("Vacant Positions" = filter(> 0));
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Job ID";
            column(ReportForNavId_9002; 9002)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; '')
            {
            }
            column(HR_Jobs_UserID; "User ID")
            {
            }
            column(CI_Picture; CI.Picture)
            {
            }
            column(CI_City; CI.City)
            {
            }
            column(CI__Address_2______CI__Post_Code_; CI."Address 2")
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
            column(HR_Jobs__No_of_Posts_; "No of Posts")
            {
            }
            column(HR_Jobs__Position_Reporting_to_; "Position Reporting to")
            {
            }
            column(HR_Jobs__Occupied_Positions_; "Occupied Positions")
            {
            }
            column(HR_Jobs__Vacant_Positions_; "Vacant Positions")
            {
            }
            column(HR_JobsCaption; HR_JobsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Jobs_with_Vacant_PositionsCaption; Jobs_with_Vacant_PositionsCaptionLbl)
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
            column(HR_Jobs__No_of_Posts_Caption; FieldCaption("No of Posts"))
            {
            }
            column(HR_Jobs__Position_Reporting_to_Caption; FieldCaption("Position Reporting to"))
            {
            }
            column(HR_Jobs__Occupied_Positions_Caption; FieldCaption("Occupied Positions"))
            {
            }
            column(HR_Jobs__Vacant_Positions_Caption; FieldCaption("Vacant Positions"))
            {
            }

            trigger OnAfterGetRecord()
            begin
                Validate("Vacant Positions");
            end;
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
        //ERROR('');

        CI.Reset;
        CI.Get();
        CI.CalcFields(CI.Picture);
    end;

    var
        CI: Record "Company Information";
        HR_JobsCaptionLbl: label 'HR Jobs';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Jobs_with_Vacant_PositionsCaptionLbl: label 'Jobs with Vacant Positions';
        P_O__BoxCaptionLbl: label 'P.O. Box';
        Userid: label 'USERID';
        HRJobs: Record "HR Jobs";
        JobIDDesc: Text;
}

