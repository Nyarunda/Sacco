Report 51124 "Employee Confirmation Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Employee Confirmation Report.rdlc';

    dataset
    {
        dataitem("HR Employee Confirmation"; "HR Employee Confirmation")
        {
            RequestFilterFields = No;
            column(ReportForNavId_1000000000; 1000000000)
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
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(ProbationStartDate_HREmployeeConfirmation; "HR Employee Confirmation"."Probation Start Date")
            {
            }
            column(ProbationEndDate_HREmployeeConfirmation; "HR Employee Confirmation"."Probation End Date")
            {
            }
            column(ConfirmationDate_HREmployeeConfirmation; "HR Employee Confirmation"."Confirmation Date")
            {
            }
            column(Designation_HREmployeeConfirmation; "HR Employee Confirmation".Designation)
            {
            }
            column(No_HREmployeeConfirmation; "HR Employee Confirmation".No)
            {
            }
            column(EmployeeNumber_HREmployeeConfirmation; "HR Employee Confirmation"."Employee Number")
            {
            }
            column(EmployeeName_HREmployeeConfirmation; "HR Employee Confirmation"."Employee Name")
            {
            }
            column(RequestDate_HREmployeeConfirmation; "HR Employee Confirmation"."Request Date")
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

    trigger OnPreReport()
    begin
        CI.Get;
        CI.CalcFields(CI.Picture);
    end;

    var
        CI: Record "Company Information";
        HREmp: Record Employee;
}

