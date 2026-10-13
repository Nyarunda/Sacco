
Report 50215 "HR Leave Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/HR Leave Summary.rdlc';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem("HR Leave Application."; "HR Leave Application.")
        {
            RequestFilterFields = "Application Code";
            column(ReportForNavId_3725; 3725)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; 0)
            {
            }
            column(UserId; UserId)
            {
            }
            column(HR_Leave_Application__Application_Code_; "Application Code")
            {
            }
            column(HR_Leave_Application__Application_Date_; "Application Date")
            {
            }
            column(HR_Leave_Application__Employee_No_; "Applicant Staff No.")
            {
            }
            column(HR_Leave_Application__Job_Tittle_; "Job Tittle")
            {
            }
            column(HR_Leave_Application_Supervisor; "Applicant Supervisor")
            {
            }
            column(HR_Leave_Application__Leave_Type_; "Leave Type")
            {
            }
            column(HR_Leave_Application__Days_Applied_; "Days Applied")
            {
            }
            column(HR_Leave_Application__Start_Date_; "Start Date")
            {
            }
            column(HR_Leave_Application__Return_Date_; "Return Date")
            {
            }
            column(HR_Leave_Application_Reliever; Reliever)
            {
            }
            column(HR_Leave_Application__Reliever_Name_; "Reliever Name")
            {
            }
            column(HR_Leave_ApplicationCaption; HR_Leave_ApplicationCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(HR_Leave_Application__Application_Code_Caption; FieldCaption("Application Code"))
            {
            }
            column(HR_Leave_Application__Application_Date_Caption; FieldCaption("Application Date"))
            {
            }
            column(HR_Leave_Application__Employee_No_Caption; FieldCaption("Applicant Staff No."))
            {
            }
            column(HR_Leave_Application__Job_Tittle_Caption; FieldCaption("Job Tittle"))
            {
            }
            column(HR_Leave_Application_SupervisorCaption; FieldCaption("Applicant Supervisor"))
            {
            }
            column(HR_Leave_Application__Leave_Type_Caption; FieldCaption("Leave Type"))
            {
            }
            column(HR_Leave_Application__Days_Applied_Caption; FieldCaption("Days Applied"))
            {
            }
            column(HR_Leave_Application__Start_Date_Caption; FieldCaption("Start Date"))
            {
            }
            column(HR_Leave_Application__Return_Date_Caption; FieldCaption("Return Date"))
            {
            }
            column(HR_Leave_Application_RelieverCaption; FieldCaption(Reliever))
            {
            }
            column(HR_Leave_Application__Reliever_Name_Caption; FieldCaption("Reliever Name"))
            {
            }
            column(Picture; CI.Picture)
            {
            }
            dataitem(Employee; Employee)
            {
                DataItemLink = "No." = field("Applicant Staff No.");
                column(ReportForNavId_1102755010; 1102755010)
                {
                }
                column(Total_Leave_Days; "Total (Leave Days)")
                {
                }
                column(Leave_Balance; "Leave Balance")
                {
                }
                dataitem("HR Leave Ledger Entries."; "HR Leave Ledger Entries.")
                {
                    DataItemLink = "Staff No." = field("No.");
                    column(ReportForNavId_1102755019; 1102755019)
                    {
                    }
                    column(No_of_Days; "No. of days")
                    {
                    }
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
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequireHRPayrollAccess();

        CI.Reset;
        CI.Get;
        CI.CalcFields(CI.Picture);
    end;

    var
        HR_Leave_ApplicationCaptionLbl: label 'HR Leave Application';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        CI: Record "Company Information";
}
