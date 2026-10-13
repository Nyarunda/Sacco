
Report 50290 "Deceased Acc. With Balances"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Deceased Acc. With Balances.rdlc';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem(Members; Members)
        {

            DataItemTableView = where("Member Status" = const(Deceased));


            dataitem(SavingsAccounts; "Savings Accounts")
            {

                DataItemLink = "Member No." = field("No.");

                RequestFilterFields = "No.", "Product Type", "Product Category", "Member No.";

                DataItemTableView = where("Net Change (LCY)" = filter(> 0), "product category" = filter(<> "Share Capital"));
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
                column(BalanceLCY_SavingsAccounts; SavingsAccounts."Net Change (LCY)")
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

                trigger OnAfterGetRecord()
                begin
                    //SavingsAccounts.SETCURRENTKEY(SavingsAccounts."Member No.");




                    Cust.Get("Member No.");

                    if BranchCode <> '' then
                        if Cust."Global Dimension 2 Code" <> BranchCode then
                            CurrReport.Skip;

                    SNo += 1;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(BranchCode; BranchCode)
                {
                    ApplicationArea = Basic;
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
                }
            }
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
        BranchCode: Code[10];
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        SNo: Integer;
        MAccount: Record "Savings Accounts";
        FosaBal: Decimal;
        Cust: Record Members;
}

