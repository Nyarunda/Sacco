page 50069 "HR EMPLOYEE"
{
    Caption = 'HR EMPLOYEE';
    PageType = List;
    SourceTable = Employee;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s first name.';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s middle name.';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s last name.';
                }
                field(Initials; Rec.Initials)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s initials.';
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s job title.';
                }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies an alternate name that you can use to search for the record in question when you cannot remember the value in the Name field.';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s address.';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies additional address information.';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the city of the address.';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the postal code.';
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the county of the employee.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s telephone number.';
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s private telephone number.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s private email address.';
                }
                field("Alt. Address Code"; Rec."Alt. Address Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a code for an alternate address.';
                }
                field("Alt. Address Start Date"; Rec."Alt. Address Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the starting date when the alternate address is valid.';
                }
                field("Alt. Address End Date"; Rec."Alt. Address End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the last day when the alternate address is valid.';
                }
                field("Birth Date"; Rec."Birth Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s date of birth.';
                }
                field("Social Security No."; Rec."Social Security No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the social security number of the employee.';
                }
                field("Union Code"; Rec."Union Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s labor union membership code.';
                }
                field("Union Membership No."; Rec."Union Membership No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s labor union membership number.';
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s gender.';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the country/region of the address.';
                }
                field("Manager No."; Rec."Manager No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Manager No. field.';
                }
                field("Emplymt. Contract Code"; Rec."Emplymt. Contract Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employment contract code for the employee.';
                }
                field("Statistics Group Code"; Rec."Statistics Group Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a statistics group code to assign to the employee for statistical purposes.';
                }
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date when the employee began to work for the company.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employment status of the employee.';
                }
                field("Inactive Date"; Rec."Inactive Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date when the employee became inactive, due to disability or maternity leave, for example.';
                }
                field("Cause of Inactivity Code"; Rec."Cause of Inactivity Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a code for the cause of inactivity by the employee.';
                }
                field("Termination Date"; Rec."Termination Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date when the employee was terminated, due to retirement or dismissal, for example.';
                }
                field("Grounds for Term. Code"; Rec."Grounds for Term. Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a termination code for the employee who has been terminated.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                }
                field("Resource No."; Rec."Resource No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a resource number for the employee.';
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if a comment has been entered for this entry.';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when this record was last modified.';
                }
                field("Total Absence (Base)"; Rec."Total Absence (Base)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Absence (Base) field.';
                }
                field(Extension; Rec.Extension)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s telephone extension.';
                }
                field(Pager; Rec.Pager)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s pager number.';
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Fax No. field.';
                }
                field("Company E-Mail"; Rec."Company E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s email address at the company.';
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Title field.';
                }
                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a salesperson or purchaser code for the employee.';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. Series field.';
                }
                field("Last Modified Date Time"; Rec."Last Modified Date Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Modified Date Time field.';
                }
                field("Employee Posting Group"; Rec."Employee Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s type to link business transactions made for the employee with the appropriate account in the general ledger.';
                }
                field("Bank Branch No."; Rec."Bank Branch No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a number of the bank branch.';
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number used by the bank for the bank account.';
                }
                field(IBAN; Rec.IBAN)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the bank account''s international bank account number.';
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Balance field.';
                }
                field("SWIFT Code"; Rec."SWIFT Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the SWIFT code (international bank identifier code) of the bank where the employee has the account.';
                }
                field("Application Method"; Rec."Application Method")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how to apply payments to entries for this employee.';
                }
                field(Image; Rec.Image)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the picture of the employee.';
                }
                field("Privacy Blocked"; Rec."Privacy Blocked")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether to limit access to data for the data subject during daily operations. This is useful, for example, when protecting data from changes while it is under privacy review.';
                }
                field("Cost Center Code"; Rec."Cost Center Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cost Center Code field.';
                }
                field("Cost Object Code"; Rec."Cost Object Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cost Object Code field.';
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Branch Code field.';
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bank Code field.';
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bank Name field.';
                }
                field("Branch Name"; Rec."Branch Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Branch Name field.';
                }
                field("Personal ID No."; Rec."Personal ID No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Personal ID No. field.';
                }
                field(PIN; Rec.PIN)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PIN field.';
                }
                field("NSSF No."; Rec."NSSF No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the NSSF No. field.';
                }
                field("NHIF No."; Rec."NHIF No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the NHIF No. field.';
                }
                field("Physically Challenged"; Rec."Physically Challenged")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Physically Challenged field.';
                }
                field("Physically Challenged Details"; Rec."Physically Challenged Details")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Physically Challenged Details field.';
                }
                field("Physically Challenged Grade"; Rec."Physically Challenged Grade")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Physically Challenged Grade field.';
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member No field.';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field("Supervisor Code"; Rec."Supervisor Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supervisor Code field.';
                }
                field("Reimbursed Leave Days"; Rec."Reimbursed Leave Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reimbursed Leave Days field.';
                }
                field("Total Leave Taken"; Rec."Total Leave Taken")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Leave Taken field.';
                }
                field("Total (Leave Days)"; Rec."Total (Leave Days)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total (Leave Days) field.';
                }
                field("Allocated Leave Days"; Rec."Allocated Leave Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Allocated Leave Days field.';
                }
                field("End of Contract Date"; Rec."End of Contract Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the End of Contract Date field.';
                }
                field("Leave Period Filter"; Rec."Leave Period Filter")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Leave Period Filter field.';
                }
                field("Mutliple Bank A/Cs"; Rec."Mutliple Bank A/Cs")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mutliple Bank A/Cs field.';
                }
                field("No. Of Bank A/Cs"; Rec."No. Of Bank A/Cs")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. Of Bank A/Cs field.';
                }
                field("Annual Leave Account"; Rec."Annual Leave Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Annual Leave Account field.';
                }
                field("Compassionate Leave Acc."; Rec."Compassionate Leave Acc.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Compassionate Leave Acc. field.';
                }
                field("Maternity Leave Acc."; Rec."Maternity Leave Acc.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maternity Leave Acc. field.';
                }
                field("Paternity Leave Acc."; Rec."Paternity Leave Acc.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Paternity Leave Acc. field.';
                }
                field("Sick Leave Acc."; Rec."Sick Leave Acc.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sick Leave Acc. field.';
                }
                field("Study Leave Acc"; Rec."Study Leave Acc")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Study Leave Acc field.';
                }
                field("Appraisal Method"; Rec."Appraisal Method")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Appraisal Method field.';
                }
                field("Leave Type"; Rec."Leave Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Leave Type field.';
                }
                field("Employee Type"; Rec."Employee Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Type field.';
                }
                field("Leave Balance"; Rec."Leave Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Leave Balance field.';
                }
                field("Employee Category"; Rec."Employee Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Category field.';
                }
                field("Last Employer Name"; Rec."Last Employer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Employer Name field.';
                }
                field("Last Employer Phone"; Rec."Last Employer Phone")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Employer Phone field.';
                }
                field("Last Employer Email"; Rec."Last Employer Email")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Employer Email field.';
                }
                field("Last Employer Address"; Rec."Last Employer Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Employer Address field.';
                }
                field("HELB No."; Rec."HELB No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the HELB No. field.';
                }
                field("Passport No."; Rec."Passport No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Passport No. field.';
                }
                field(District; Rec.District)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the District field.';
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location field.';
                }
                field("Sub-Location"; Rec."Sub-Location")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sub-Location field.';
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Marital Status field.';
                }
                field("Place of Birth"; Rec."Place of Birth")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Place of Birth field.';
                }
                field("National Id"; Rec."National Id")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the National Id field.';
                }
                field(CurrYearStart; Rec.CurrYearStart)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the CurrYearStart field.';
                }
                field(CurrYearEnd; Rec.CurrYearEnd)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the CurrYearEnd field.';
                }
                field("Probation Period"; Rec."Probation Period")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Probation Period field.';
                }
                field("Probation Start Date"; Rec."Probation Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Probation Start Date field.';
                }
                field("Probation End Date"; Rec."Probation End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Probation End Date field.';
                }
                field("Years of Service"; Rec."Years of Service")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Years of Service field.';
                }
                field("Salary Increment Month"; Rec."Salary Increment Month")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Salary Increment Month field.';
                }
                field("Location County"; Rec."Location County")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location County field.';
                }
                field("Retirement Date"; Rec."Retirement Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Retirement Date field.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
            }
        }
    }
}
