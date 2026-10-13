
Report 50220 "System Events"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/System Events.rdlc';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            column(ReportForNavId_8; 8)
            {
            }
            column(Name_CompanyInformation; "Company Information".Name)
            {
            }
            column(Picture_CompanyInformation; "Company Information".Picture)
            {
            }
        }
        dataitem("Session Event"; "Session Event")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(SessionID_SessionEvent; "Session Event"."Session ID")
            {
            }
            column(EventType_SessionEvent; "Session Event"."Event Type")
            {
            }
            column(EventDatetime_SessionEvent; "Session Event"."Event Datetime")
            {
            }
            column(ClientComputerName_SessionEvent; "Session Event"."Client Computer Name")
            {
            }
            column(UserID_SessionEvent; "Session Event"."User ID")
            {
            }
            column(Comment_SessionEvent; "Session Event".Comment)
            {
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
}

