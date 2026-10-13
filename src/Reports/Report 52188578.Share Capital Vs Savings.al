
Report 50241 "Share Capital Vs Savings"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Share Capital Vs Savings.rdlc';

    dataset
    {
        dataitem(SavingsAccounts; "Savings Accounts")
        {
            //DataItemTableView = sorting("Member No.");
            RequestFilterFields = "No.", "Product Category", "Member No.";
            column(ReportForNavId_1; 1)
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }
            column(No_SavingsAccounts; SavingsAccounts."No.")
            {
            }
            column(Name_SavingsAccounts; SavingsAccounts.Name)
            {
            }
            column(GlobalDimension1Code_SavingsAccounts; SavingsAccounts."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_SavingsAccounts; SavingsAccounts."Global Dimension 2 Code")
            {
            }
            column(EmployerCode_SavingsAccounts; '')
            {
            }
            column(ProductType_SavingsAccounts; SavingsAccounts."Product Name")
            {
            }
            column(ProductName_SavingsAccounts; SavingsAccounts."Product Name")
            {
            }
            column(MemberNo_SavingsAccounts; SavingsAccounts."Member No.")
            {
            }
            column(PayrollStaffNo_SavingsAccounts; SavingsAccounts."Payroll/Staff No.")
            {
            }
            column(PhoneNo_SavingsAccounts; SavingsAccounts."Mobile Phone No.")
            {
            }
            column(RecruitedBy_SavingsAccounts; '')
            {
            }
            column(RecruitedByName_SavingsAccounts; '')
            {
            }
            column(IDNumber_SavingsAccounts; SavingsAccounts."ID No.")
            {
            }
            column(BirthCertificateNo_SavingsAccounts; '')
            {
            }
            column(SalespersonCode_SavingsAccounts; '')
            {
            }
            column(CreatedBy_SavingsAccounts; '')
            {
            }
            column(Source_SavingsAccounts; '')
            {
            }
            column(Status_SavingsAccounts; SavingsAccounts.Status)
            {
            }
            column(BalanceLCY_SavingsAccounts; SavingsAccounts."Balance (LCY)")
            {
            }
            column(SCount; SNo)
            {
            }
            column(MaturityDate; '')
            {
            }
            column(OldMemberNo_SavingsAccounts; '')
            {
            }
            column(CustomerCID_SavingsAccounts; '')
            {
            }
            column(OldAccountNo_SavingsAccounts; SavingsAccounts."Old Account No.")
            {
            }
            column(FosaBal; FosaBal)
            {
            }
            column(BusinessBal; BusinessBal)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //SavingsAccounts.SETCURRENTKEY(SavingsAccounts."Member No.");
                SNo += 1;

                FosaBal := 0;
                BusinessBal := 0;

                MAccount.Reset;
                MAccount.SetRange("Product Category", MAccount."product category"::Business);
                MAccount.SetRange("Member No.", SavingsAccounts."Member No.");
                if SavingsAccounts.GetFilter("Date Filter") <> '' then
                    MAccount.SetFilter("Date Filter", SavingsAccounts.GetFilter("Date Filter"));
                if MAccount.FindFirst then begin
                    MAccount.CalcFields("Balance (LCY)");
                    BusinessBal := MAccount."Balance (LCY)";
                end;


                MAccount.Reset;
                MAccount.SetRange("Product Category", MAccount."product category"::"Ordinary Savings");
                MAccount.SetRange("Member No.", SavingsAccounts."Member No.");
                if SavingsAccounts.GetFilter("Date Filter") <> '' then
                    MAccount.SetFilter("Date Filter", SavingsAccounts.GetFilter("Date Filter"));
                if MAccount.FindFirst then begin
                    MAccount.CalcFields("Balance (LCY)");
                    FosaBal := MAccount."Balance (LCY)";
                end;


                if FosaBal < 100000 then
                    if BusinessBal < 100000 then
                        CurrReport.Skip;
            end;

            trigger OnPreDataItem()
            begin

                SavingsAccounts.SetRange("Product Category", SavingsAccounts."product category"::"Share Capital");

                SavingsAccounts.SetFilter("Balance (LCY)", '<%1', 15000);
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
    begin
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
#pragma warning disable AL0432
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
#pragma warning restore AL0432
    end;

    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        SNo: Integer;
        MAccount: Record "Savings Accounts";
        FosaBal: Decimal;
        BusinessBal: Decimal;
}

