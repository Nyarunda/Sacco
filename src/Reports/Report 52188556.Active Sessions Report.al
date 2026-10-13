
Report 50219 "Active Sessions Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Active Sessions Report.rdlc';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            column(ReportForNavId_13; 13)
            {
            }
            column(Name_CompanyInformation; "Company Information".Name)
            {
            }
            column(Picture_CompanyInformation; "Company Information".Picture)
            {
            }
        }
        dataitem("Active Session"; "Active Session")
        {
            DataItemTableView = where("Client Type" = const("Windows Client"));
            RequestFilterFields = "User ID", "Login Datetime";
            column(ReportForNavId_1; 1)
            {
            }
            column(UserSID_ActiveSession; "Active Session"."User SID")
            {
            }
            column(ServerInstanceID_ActiveSession; "Active Session"."Server Instance ID")
            {
            }
            column(SessionID_ActiveSession; "Active Session"."Session ID")
            {
            }
            column(ServerInstanceName_ActiveSession; "Active Session"."Server Instance Name")
            {
            }
            column(ServerComputerName_ActiveSession; "Active Session"."Server Computer Name")
            {
            }
            column(UserID_ActiveSession; "Active Session"."User ID")
            {
            }
            column(ClientType_ActiveSession; "Active Session"."Client Type")
            {
            }
            column(ClientComputerName_ActiveSession; "Active Session"."Client Computer Name")
            {
            }
            column(LoginDatetime_ActiveSession; "Active Session"."Login Datetime")
            {
            }
            column(DatabaseName_ActiveSession; "Active Session"."Database Name")
            {
            }
            column(SessionUniqueID_ActiveSession; "Active Session"."Session Unique ID")
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

