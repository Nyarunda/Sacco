report 50450 "Member Referees"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Member Referees.rdlc';

    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.";
            column(Name_Members; Members.Name)
            {
            }
            column(CompanyInfo_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInfo_Picture; CompanyInformation.Picture)
            {
            }
            column(Company_Name; CompanyInformation.Name)
            {
            }
            column(Company_Address; CompanyInformation.Address)
            {
            }
            column(Company_Picture; CompanyInformation.Picture)
            {
            }
            column(RegistrationFee_Members; 0)
            {
            }
            column(EmployerName_Members; "Employer Name")
            {
            }
            dataitem("Member Referees"; Members)
            {
                DataItemLink = "Recruited By" = field("No.");
                column(Sno; Sno)
                {
                }
                column(No_MemberReferees; "Member Referees"."No.")
                {
                }
                column(MemberNo_MemberReferees; "Member Referees"."Member No.")
                {
                }
                column(Name_MemberReferees; "Member Referees".Name)
                {
                }
                column(Email_MemberReferees; "Member Referees"."E-mail")
                {
                }
                column(RegDate; "Member Referees"."Registration Date")
                {
                }
                column(MemberName; "Member Referees".Name)
                {
                }
                column(Email; "Member Referees"."E-Mail")
                {
                }
                column(PhoneNo; "Member Referees"."Mobile Phone No.")
                {
                }
                column(EmployerCode; "Member Referees"."Employer Code")
                {
                }
                column(ShareCapital; ShareCapital)
                {
                }
                column(Sharedeposit; Sharedeposit)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    RegDate := 0D;
                    MemberName := '';
                    Email := '';
                    PhoneNo := '';
                    ShareCapital := 0;
                    Sharedeposit := 0;

                    Sharedeposit := MemberActivities.GetAccountBalance(Legacy.GetDepositAccounts("No."));
                    ShareCapital := MemberActivities.GetAccountBalance(Legacy.GetShareCapitalAccount("No."));

                    Sno += 1;
                end;
            }

            trigger OnPreDataItem()
            begin
                IF CompanyInformation.GET THEN
                    CompanyInformation.CALCFIELDS(CompanyInformation.Picture);
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

    var
        CompanyInformation: Record "Company Information";
        Sno: Integer;
        RegDate: Date;
        Member: Record Members;
        MemberActivities: Codeunit "Member Activities";
        Legacy: Codeunit Legacy;
        MemberName: Text;
        Email: Text;
        PhoneNo: Code[20];
        ShareCapital: Decimal;
        EmployerCode: Code[50];
        Empl: Record Customer;
        EmplNam: Text;
        Sharedeposit: Decimal;
}

