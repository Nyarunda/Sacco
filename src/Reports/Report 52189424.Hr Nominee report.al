report 50202 "Hr Nominee report"
{
    ApplicationArea = All;
    Caption = 'Hr Nominee report';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Hr Nominee report.rdlc';
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

            dataitem(HREmployeeBeneficiary; "HR Employee Beneficiary")
            {
                DataItemLink = "Employee Code" = field("No.");
                DataItemTableView = where(Type = const(Beneficiary));

                column(NomineeName; NomineeName)
                {
                }
                column(IDNo; "ID No.")
                {
                }
                column(DateOfBirth; "Date Of Birth")
                {
                }
                column(Allocation; Allocation)
                {
                }
                column(Occupation; Occupation)
                {
                }
                column(Address; Address)
                {
                }
                column(GuardianName; "Guardian Name")
                {
                }
                column(GuardianPhoneNo; "Guardian Phone No.")
                {
                }
                column(GuardianIDNo; "Guardian ID No.")
                {
                }
                column(Relationship; Relationship)
                {
                }
                column(MobilePhoneNo; "Mobile Phone No.")
                {
                }
                column(HomeTelNo; "Home Tel No")
                {
                }
                column(VerificationDocument; "Verification Document")
                {
                }
                column(CountryCode; "Country Code")
                {
                }
                column(Type; Type)
                {
                }
                column(Email; "E-mail")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    NomineeName := StrSubstNo('%1 %2', SurName, "Other Names");
                end;
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

    var
        NomineeName: Text[151];
}
