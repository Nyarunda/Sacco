report 50381 "HR Transport Logs"
{
    ApplicationArea = All;
    Caption = 'HR Transport Logs';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/HR Transport Logs.rdlc';
    dataset
    {
        dataitem(HRTransportApplication; "HR Transport Application")
        {
            RequestFilterFields = "Start Date", "Employee No";
            column(Code; "Code")
            {
            }
            column(CI_name; CI.Name)
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
            column(EmployeeName; "Employee Name")
            {
            }
            column(EmployeeNo; "Employee No")
            {
            }
            column(StartDate; "Start Date")
            {
            }
            column(EndDate; "End Date")
            {
            }
            column(EstimatedStartTime; "Estimated Start Time")
            {
            }
            column(EstimatedEndTime; "Estimated End Time")
            {
            }
            column(Vehicle; Vehicle)
            {
            }
            column(Purpose; "Purpose")
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
