Report 51102 "HR Company Activities"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/HR Company Activities.rdlc';

    dataset
    {
        dataitem("HR Company Activities"; "HR Company Activities")
        {
            RequestFilterFields = "Code", "Employee Responsible";
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
            column(ActivityStatus_HRCompanyActivities; "HR Company Activities"."Activity Status")
            {
            }
            column(Code_HRCompanyActivities; "HR Company Activities".Code)
            {
            }
            column(AcitivityDescription_HRCompanyActivities; "HR Company Activities"."Acitivity Description")
            {
            }
            column(Date_HRCompanyActivities; "HR Company Activities".Date)
            {
            }
            column(Venue_HRCompanyActivities; "HR Company Activities".Venue)
            {
            }
            dataitem("HR Activity Participants"; "HR Activity Participants")
            {
                DataItemLink = "Document No." = field(Code);
                column(ReportForNavId_5; 5)
                {
                }
                column(Participant_HRActivityParticipants; "HR Activity Participants".Participant)
                {
                }
                column(Notified_HRActivityParticipants; "HR Activity Participants".Notified)
                {
                }
                column(Contribution_HRActivityParticipants; "HR Activity Participants".Contribution)
                {
                }
                column(ParticipantName_HRActivityParticipants; "HR Activity Participants"."Participant Name")
                {
                }
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
        HR_JobsCaptionLbl: label 'HR Jobs';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Job_StatisticsCaptionLbl: label 'HR Job Statistics';
        P_O__BoxCaptionLbl: label 'P.O. Box';
        MyUserID: Text;
        UserSetup: Record "User Setup";
}

