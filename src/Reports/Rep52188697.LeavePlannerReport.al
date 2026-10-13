report 50360 "Leave Planner Report"
{
    ApplicationArea = All;
    Caption = 'Leave Planner Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/HR Leave Planner Report.rdlc';

    dataset
    {
        dataitem(HRLeavePlannerHeader; "HR Leave Planner Header")
        {
            RequestFilterFields = "Employee No";

            column(No; No)
            {
            }
            column(EmployeeNo; "Employee No")
            {
            }
            column(EmployeeName; "Employee Name")
            {
            }
            column(Supervisor; Supervisor)
            {
            }
            column(Year; Year)
            {
            }
            column(LeaveBalance; "Leave Balance")
            {
            }
            column(Department; Department)
            {
            }
            dataitem(HRPlannerLines; "HR Leave Planner Lines")
            {
                DataItemLink = "Leave Planner No" = field(No);

                column(Start_Date; "Start Date") { }
                column(No_of_Days; "No of Days") { }
                column(End_Date; "End Date") { }
                column(Return_Date; "Return Date") { }
                column(Intended_Purpose; "Intended Purpose") { }
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
    end;
}
