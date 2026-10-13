namespace CentralDB.CentralDB;
using Microsoft.Foundation.Company;

report 50447 GFE
{
    DefaultLayout = RDLC;
    Caption = 'Next of Kin';
    RDLCLayout = './src/Layouts/GFE.rdlc';
    UsageCategory = ReportsandAnalysis;
    dataset
    {
        dataitem(NextofKin; "Next of Kin.")
        {
            RequestFilterFields = "No.", Deceased, Relationship;
            column(CompanyName; Company.Name)
            {
            }
            column(CompanyPicture; Company.Picture)
            {
            }
            column(Allocation; "%Allocation")
            {
            }
            column(Beneficiary; Beneficiary)
            {
            }
            column(DateofBirth; "Date of Birth")
            {
            }
            column(Deceased; Deceased)
            {
            }
            column(E_Mail; "E-Mail")
            {
            }
            column(Email; Email)
            {
            }
            column(EmployeeNo; "Employee No.")
            {
            }
            column(IDNo; "ID No.")
            {
            }
            column(MobilePhoneNo; "Mobile Phone No.")
            {
            }
            column(Name; Name)
            {
            }
            column(Next_Of_Kin; "Next Of Kin")
            {
            }
            column(No; "No.")
            {
            }
            column(StaffNo; StaffNo)
            {
            }
            column(PrincipalIDNo; "Principal ID No.")
            {
            }
            column(Relationship; Relationship)
            {
            }
            column(Spouse; Spouse)
            {
            }
            column(Type; "Type")
            {
            }
            column(MemberName; MemberName)
            {
            }
            column(DOB; DOB)
            {
            }
            trigger OnPreDataItem()
            begin
                Company.Get;
                Company.CalcFields(Picture);
            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                CoverLimit := 0;
                StaffNo := '';
                MemberName := '';
                DOB := 0D;

                if not Members.Get("No.") then
                    CurrReport.skip;

                MemberName := Members.Name;
                StaffNo := Members."Payroll/Staff No.";
                DOB := Members."Date of Birth";
                if "Principal ID No." = '' then
                    "Principal ID No." := Members."ID No.";

            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        Company: Record "Company Information";
        MemberName: Text[60];
        Members: Record Members;
        CoverLimit: Decimal;
        BBFSetup: Record "BBF Entitlement";
        StaffNo: code[20];
        DOB: Date;
}

