report 50055 "Online Membership Application"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Online Membership Application.rdlc';

    dataset
    {
        dataitem("Member Application"; "Member Registration")
        {
            CalcFields = Picture, Signature;
            RequestFilterFields = "No.";
            column(ApplicantNo; "Member Application"."No.")
            {
            }
            column(AppName; "Member Application".Name)
            {
            }
            column(AppAddress; "Member Application".Address)
            {
            }
            column(AppphoneNo; "Member Application"."Mobile Phone No.")
            {
            }
            column(SecondName; "Member Application"."Middle Name")
            {
            }
            column(LastName; "Member Application".surname)
            {
            }
            column(AppDate; "Member Application"."Application Date")
            {
            }
            column(EmpCode; "Member Application"."Employer Code")
            {
            }
            column(DateofBirth; "Member Application"."Date of Birth")
            {
            }
            column(AppEmail; "Member Application"."E-Mail")
            {
            }
            column(Department; "Member Application"."Cost Center")
            {
            }
            column(IDNo; "Member Application"."ID No.")
            {
            }
            column(StaffNo; "Member Application"."Payroll/Staff No.")
            {
            }
            column(EmploymentTerms; "Member Application"."Terms of Employment")
            {
            }
            column(MobilePhone; "Member Application"."Mobile Phone No.")
            {
            }
            column(FirstName; "Member Application"."First Name")
            {
            }
            column(PostCode; "Member Application"."Post Code")
            {
            }
            column(City; "Member Application".City)
            {
            }
            column(County; "Member Application".County)
            {
            }
            column(CurrentAdress; "Member Application".Address)
            {
            }
            column(AppPhoto; "Member Application".Picture)
            {
            }
            column(AppSignature; "Member Application".Signature)
            {
            }
            column(KRAPIn; "Member Application"."KRA PIN")
            {
            }
            column(Employername; "Member Application"."Employer Name")
            {
            }
            column(CompanyName; CompanyInformation.Name)
            {
            }
            column(CompanyLogo; CompanyInformation.Picture)
            {
            }
            column(CompanyPostCode; CompanyInformation."Post Code")
            {
            }
            column(CompanyCity; CompanyInformation.City)
            {
            }
            column(CompanyAdress; CompanyInformation.Address)
            {
            }
            dataitem("Next of Kin Application"; "Next of Kin.")
            {
                DataItemLink = "No." = FIELD("No.");
                column(AccountNo; "Next of KIN Application"."No.")
                {
                }
                column(NOKName; "Next of KIN Application".Name)
                {
                }
                column(NOKID; "Next of KIN Application"."ID No.")
                {
                }
                column(RelationShip; "Next of KIN Application".Relationship)
                {
                }
                column(PercentageAllocation; "Next of KIN Application"."%Allocation")
                {
                }
                column(PhoneNo; "Next of KIN Application"."Mobile Phone No.")
                {
                }
                column(NOKDateofBirth; "Next of KIN Application"."Date of Birth")
                {
                }
                column(Counter; Counter)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Counter += 1;
                end;

                trigger OnPreDataItem()
                begin
                    Counter := 0;
                end;
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
        CompanyInformation.GET();
        CompanyInformation.CALCFIELDS(Picture);
    end;

    var
        CompanyInformation: Record "Company Information";
        Counter: Integer;
        ImageData: Record "Member Images";
}

