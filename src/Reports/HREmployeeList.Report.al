Report 51105 "HR Employee List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/HR Employee List layout.rdlc';

    dataset
    {
        dataitem(HREmployees; Employee)
        {
            RequestFilterFields = "No.", "Job ID", "Personal ID No.", "Employee Type", Status;
            column(ReportForNavId_6075; 6075)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(Grade; Grade) { }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(UserId; UserId)
            {
            }
            column(CI_Name; CI.Name)
            {
                IncludeCaption = true;
            }
            column(CI_Address; CI.Address)
            {
                IncludeCaption = true;
            }
            column(CI_City; CI.City)
            {
                IncludeCaption = true;
            }
            column(CI_EMail; CI."E-Mail")
            {
                IncludeCaption = true;
            }
#pragma warning disable AL0432
            column(CI_HomePage; CI."Home Page")
#pragma warning restore AL0432
            {
                IncludeCaption = true;
            }
            column(CI_Address2; CI."Address 2")
            {
                IncludeCaption = true;
            }
            column(CI_PostCode; CI."Post Code")
            {
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
                IncludeCaption = true;
            }
            column(CI_Picture; CI.Picture)
            {
                IncludeCaption = true;
            }
            column(HR_Employees__No__; "No.")
            {
            }
            column(HR_Employees__ID_Number_; "Personal ID No.")
            {
            }
            column(HR_Employees__Job_Description_; "Job Description")
            {
            }
            column(HR_Employees__Date_Of_Joining_the_Company_; "Employment Date")
            {
            }
            column(HR_Employees__FullName; HREmployees.FullName)
            {
            }
            column(HR_Employees__Cell_Phone_Number_; "Mobile Phone No.")
            {
            }
            column(EmployeeCaption; EmployeeCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Employee_ListCaption; Employee_ListCaptionLbl)
            {
            }
            column(P_O__BoxCaption; P_O__BoxCaptionLbl)
            {
            }
            column(HR_Employees__No__Caption; FieldCaption("No."))
            {
            }
            column(HR_Employees__ID_Number_Caption; FieldCaption("Personal ID No."))
            {
            }
            column(HR_Employees__Job_Description_Caption; FieldCaption("Job Description"))
            {
            }
            column(HR_Employees__Date_Of_Joining_the_Company_Caption; FieldCaption("Employment Date"))
            {
            }
            column(Full_NamesCaption; Full_NamesCaptionLbl)
            {
            }
            column(LengthOfService_HREmployees; HREmployees."Years of Service")
            {
            }
            column(LenghtOfServices; LenghtOfServices)
            {
            }
            column(DateOfBirth_HREmployees; HREmployees."Birth Date")
            {
            }
            column(Gender_HREmployees; HREmployees.Gender)
            {
            }
            column(LeaveBalance_HREmployees; HREmployees."Leave Balance")
            {
            }
            column(DateOfJoiningtheCompany_HREmployees; HREmployees."Birth Date")
            {
            }
            column(Age1; Age1)
            {
            }
            column(Job_ID; "Job ID")
            { }

            column(Job_Reference; "Job Reference") { }
            column(Job_Description; "Job Description") { }
            column(Status; Status) { }
            column(Mobile_Phone_No_; "Mobile Phone No.") { }
            column(Retirement_Date; "Retirement Date") { }
            column(Employee_Type; "Employee Type") { }
            column(Filters; Filters) { }
            column(First_Name; "First Name")
            { }
            column(Middle_Name; "Middle Name")
            { }
            column(Last_Name; "Last Name")
            { }
            column(Job_Title; "Job Title")
            { }
            column(E_Mail; "E-Mail")
            { }
            column(Birth_Date; "Birth Date")
            { }
            column(Gender; Gender)
            { }
            column(Manager; SupervisorName)
            { }
            column(Employment_Date; "Employment Date")
            { }
            column(Extension; Extension)
            { }
            column(Bank_Account_No_; "Bank Account No.")
            { }
            column(Branch_Code; "Branch Code")
            { }
            column(Bank_Code; "Bank Code")
            { }
            column(Bank_Name; "Bank Name")
            { }
            column(Branch_Name; "Branch Name")
            { }
            column(Personal_ID_No_; "Personal ID No.")
            { }
            column(PIN; PIN)
            { }
            column(NSSF_No_; "NSSF No.")
            { }
            column(SHIF_No_; "NHIF No.")
            { }
            column(Department; Department)
            { }
            column(Member_No; "Member No")
            { }
            column(HELB_No_; "HELB No.")
            { }
            column(Company_E_Mail; "Company E-Mail")
            { }
            column(Marital_Status; "Marital Status")
            {
            }
            column(Emergency_Contact; EmergencyContact)
            { }
            column(Emergency_Contact_Relationship; EmergencyContactRelationship)
            { }
            column(Emergency_Contact_Number; EmergencyContactNumber)
            { }

            dataitem(SalaryDetails; "Staff Payroll Details")
            {
                DataItemLink = "Employee Code" = field("No.");
                column(Basic_Pay; "Basic Pay")
                { }

            }
            dataitem("Next of Kin BOSA"; "Next of Kin.")
            {
                DataItemLink = "No." = field("Member No");
            }

            trigger OnPreDataItem()
            begin
                Filters := HREmployees.GetFilters;
            end;

            trigger OnAfterGetRecord()
            var
                UserSetup: Record "User Setup";
                Employees: Record Employee;
                HREmployeeKin: Record "HR Employee Kin";
            begin
                LenghtOfServices := HrDates.DetermineAge(HREmployees."Employment Date", Today);
                HREmployees."Leave Balance" := GetLeaveBalance(HREmployees."No.", 'ANNUAL', Today);
                HREmployees."Retirement Date" := CalcDate('60Y', HREmployees."Birth Date");
                Age1 := '';
                EmergencyContact := '';
                EmergencyContactRelationship := '';
                EmergencyContactNumber := '';
                if HREmployees."Birth Date" <> 0D then
                    Age1 := HrDates.DetermineAge(HREmployees."Birth Date", Today);
                // Age1 := Date2DMY(Today, 3) - Date2DMY("Birth Date", 3);
                //Age1 := ROUND((Today - HREmployees."Birth Date"), 1, '=');
                if UserSetup.get("Supervisor Code") then begin
                    Employees.get(UserSetup."Staff No");
                    SupervisorName := Employees.FullName();
                end;

                HREmployeeKin.SetRange("Employee Code", HREmployees."No.");
                HREmployeeKin.SetRange(Type, HREmployeeKin.Type::"Next of Kin");
                if HREmployeeKin.FindFirst() then begin
                    EmergencyContact := StrSubstNo('%1 %2', HREmployeeKin.SurName, HREmployeeKin."Other Names");
                    EmergencyContactRelationship := HREmployeeKin.Relationship;
                    EmergencyContactNumber := HREmployeeKin."Home Tel No";
                    if EmergencyContactNumber = '' then
                        EmergencyContactNumber := HREmployeeKin."Office Tel No";
                end;

            end;
        

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

        CI.Get();
        CI.CalcFields(CI.Picture);
    end;

    var
        CI: Record "Company Information";
        EmployeeCaptionLbl: label 'Employee';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Employee_ListCaptionLbl: label 'Employee List';
        P_O__BoxCaptionLbl: label 'P.O. Box';
        Full_NamesCaptionLbl: label 'Full Names';
        HrDates: Codeunit "HR Codeunit.";
        LenghtOfServices: Text[100];
        Age1: Text[100];
        SupervisorName: Text;
        EmergencyContact: Text[150];
        EmergencyContactRelationship: Text[50];
        EmergencyContactNumber: Text[100];

        Filters: Text;
}
