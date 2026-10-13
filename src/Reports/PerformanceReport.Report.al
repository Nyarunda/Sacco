Report 51135 "Performance Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Performance Report.rdlc';

    dataset
    {
        dataitem("HR Individual Targets Header"; "HR Individual Targets Header")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(FinanceRating_HRIndividualTargetsHeader; "HR Individual Targets Header"."Finance Rating")
            {
            }
            column(ClientMemberRating_HRIndividualTargetsHeader; "HR Individual Targets Header"."Customer Rating")
            {
            }
            column(LearningRating_HRIndividualTargetsHeader; "HR Individual Targets Header"."Training Rating")
            {
            }
            column(OperationalRating_HRIndividualTargetsHeader; "HR Individual Targets Header"."Service Rating")
            {
            }
            column(OverallRating_HRIndividualTargetsHeader; "HR Individual Targets Header"."Overall Rating")
            {
            }
            column(AppraisalNo_HRIndividualTargetsHeader; "HR Individual Targets Header"."Appraisal No")
            {
            }
            column(AppraisalDate_HRIndividualTargetsHeader; "HR Individual Targets Header"."Appraisal Date")
            {
            }
            column(EmployeeNo_HRIndividualTargetsHeader; "HR Individual Targets Header"."Employee No")
            {
            }
            column(EmployeeName_HRIndividualTargetsHeader; "HR Individual Targets Header"."Employee Name")
            {
            }
            column(AppraisalStage_HRIndividualTargetsHeader; "HR Individual Targets Header"."Supervisor Name")
            {
            }
            column(AppraisalType_HRIndividualTargetsHeader; "HR Individual Targets Header"."Appraisal Type")
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
            column(HR_Jobs_UserID; UserId)
            {
            }
            column(CI_Picture; CI.Picture)
            {
            }
            column(CI_Address; CI.Address)
            {
            }
            column(CI__Address_2______CI__Post_Code_; CI."Address 2" + ' ' + CI."Post Code")
            {
            }
            column(CI_City; CI.City)
            {
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(P_O__BoxCaption; P_O__BoxCaptionLbl)
            {
            }
            column(CI_Name; CI.Name)
            {
                IncludeCaption = true;
            }
            column(CI_Address2; CI."Address 2")
            {
            }

            trigger OnAfterGetRecord()
            begin
                "HR Individual Targets Header".CalcFields("Finance Rating", "Customer Rating");
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

    var
        CI: Record "Company Information";
        HR_JobsCaptionLbl: label 'HR Jobs';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Job_StatisticsCaptionLbl: label 'HR Job Statistics';
        P_O__BoxCaptionLbl: label 'P.O. Box';
}

