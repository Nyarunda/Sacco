report 50571 "Hr next of kin"
{
    ApplicationArea = All;
    Caption = 'Hr next of kin';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Hr next of kin.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Employee; Employee)
        {
            RequestFilterFields = "No.", Status, "Job Title";

            column(EmployeeNo; "No.")
            {
            }
            column(FirstName; "First Name")
            {
            }
            column(MiddleName; "Middle Name")
            {
            }
            column(LastName; "Last Name")
            {
            }
            column(EmployeeName; FullName())
            {
            }

            dataitem(HREmployeeKin; "HR Employee Kin")
            {
                DataItemLink = "Employee Code" = field("No.");
                DataItemTableView = where(Type = const("Next of Kin"));

                column(Type; Type)
                {
                }
                column(Relationship; Relationship)
                {
                }
                column(SurName; SurName)
                {
                }
                column(OtherNames; "Other Names")
                {
                }
                column(IDNoPassportNo; "ID No/Passport No")
                {
                }
                column(DateOfBirth; "Date Of Birth")
                {
                }
                column(Occupation; Occupation)
                {
                }
                column(Address; Address)
                {
                }
                column(OfficeTelNo; "Office Tel No")
                {
                }
                column(HomeTelNo; "Home Tel No")
                {
                }
                column(Email; "E-mail")
                {
                }
            }
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
            }
        }

        actions
        {
            area(Processing)
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
