Report 51106 "HR Employees Statistics"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/HR Employees Statistics.rdlc';

    dataset
    {
        dataitem(Employee; Employee)
        {
            RequestFilterFields = "No.", Status;
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
            column(No_HREmployees; Employee."No.")
            {
            }
            column(Designation_HREmployees; Employee."Job Title")
            {
            }
            column(FullName_HREmployees; HREmp."First Name")
            {
            }
            column(Status_HREmployees; Employee.Status)
            {
            }
            column(DateOfBirth_HREmployees; Employee."Birth Date")
            {
            }
            column(Job_Title; HREmp."Job Title")
            {
            }
            column(JobDescription_HREmployees; Employee."Job Title")
            {
            }
            column(DepartmentCode_HREmployees; Employee."Department")
            {
            }
            column(Gender_HREmployees; Employee.Gender)
            {
            }
            column(MaritalStatus_HREmployees; Employee."Marital Status")
            {
            }
            column(FullPartTime_HREmployees; '')
            {
            }
            column(PensionFundAdministrator_HREmployees; HREmp."Last Name")
            {
            }
            column(Grade_HREmployees; '')
            {
            }
            column(SalaryStep_HREmployees; '')
            {
            }
            column(EmployeeCategory_HREmployees; '')
            {
            }
            column(Pension_House; '')
            {
            }
            column(HR_Status; Employee.Status)
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

