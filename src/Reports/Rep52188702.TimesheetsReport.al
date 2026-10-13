report 50365 "Timesheets Report"
{
    ApplicationArea = All;
    Caption = 'HR Timesheets Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/HR Timesheet Reports.rdlc';

    dataset
    {
        dataitem(ClockInTimesheet; "ClockIn Timesheet")
        {
            RequestFilterFields = "Working Date", "Staff No";

            column(CI_Picture; CI.Picture)
            {
            }
            column(CI_Address; CI.Address)
            {
            }
            column(COMPANYNAME; CI.Name)
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
            column(StaffNo; "Staff No")
            {
            }
            column(StaffName; "Staff Name")
            {
            }
            column(Week; Week)
            {
            }
            column(WorkingDate; "Working Date")
            {
            }
            column(ClockIn_Time; "ClockIn Time")
            {
            }
            column(Clock_Out_Time; "Clock Out Time")
            {
            }
            column(Hours; Hours)
            {
            }

        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPreReport()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequireHRPayrollAccess();

        CI.Reset;
        CI.Get();
        CI.CalcFields(CI.Picture);
    end;

    var
        CI: Record "Company Information";



}
