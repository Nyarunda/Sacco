report 50098 "Savings Variance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Savings Variance_NEW.rdlc';

    dataset
    {
        dataitem(SavingsAccounts; "Savings Accounts")
        {
            DataItemTableView = SORTING("Member No.") WHERE("Product Category" = CONST("Deposit Contribution"));
            RequestFilterFields = "No.", "Registration Date", "Date Filter";
            column(RegDate; RegDate)
            {
            }
            column(DateFilter; DateFilter)
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
            column(RegistrationDate_SavingsAccounts; SavingsAccounts."Registration Date")
            {
            }
            column(EmployerCode_SavingsAccounts; SavingsAccounts."Employer Code")
            {
            }
            column(ProductType_SavingsAccounts; SavingsAccounts."Product Type")
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
            column(PhoneNo_SavingsAccounts; SavingsAccounts."Phone No.")
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
            column(Credits; SavingsAccounts."Credit Amount")
            {
            }
            column(MonthlyContribold; SavingsAccounts."Monthly Contribution")
            {
            }
            column(Varianceold; SavingsAccounts."Monthly Contribution" - SavingsAccounts."Credit Amount")
            {
            }
            column(MonthlyContribution; MonthlyContribution)
            {
            }
            column(Variance; MonthlyContribution - SavingsAccounts."Credit Amount")
            {
            }
            column(OLDmember; SavingsAccounts."Old Member No.")
            {
            }
            column(BalToday; SavingsAccounts.Balance)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //SavingsAccounts.SETCURRENTKEY(SavingsAccounts."Member No.");
                SNo += 1;
                MonthlyContribution := 0;
                /* SavAccChangeLog.RESET;
                SavAccChangeLog.SETRANGE("Account No.",SavingsAccounts."No.");
                SavAccChangeLog.SETFILTER("Date Changed",'%1..%2',
                SavingsAccounts.GETRANGEMIN("Date Filter"),SavingsAccounts.GETRANGEMAX("Date Filter"));
                IF SavAccChangeLog.FINDLAST THEN
                     MonthlyContribution := SavAccChangeLog."Old Monthly Contribution"
                  ELSE
                     MonthlyContribution := SavingsAccounts."Monthly Contribution"; */

                ChangeLogEntry.RESET;
                ChangeLogEntry.SETRANGE("Table Caption", 'Savings Accounts');
                ChangeLogEntry.SETRANGE("Field Caption", 'Monthly Contribution');
                ChangeLogEntry.SETRANGE("Primary Key Field 1 Value", SavingsAccounts."No.");
                ChangeLogEntry.SETRANGE("Type of Change", ChangeLogEntry."Type of Change"::Modification);
                ChangeLogEntry.SETFILTER("Date and Time", '>%1', CREATEDATETIME(SavingsAccounts.GETRANGEMAX("Date Filter"), 235900T));
                /* ChangeLogEntry.SETFILTER("Date and Time",'%1..%2',
                  CREATEDATETIME(SavingsAccounts.GETRANGEMIN("Date Filter"),0T),
                 CREATEDATETIME(SavingsAccounts.GETRANGEMAX("Date Filter"),2359T)); */
                IF ChangeLogEntry.FINDFIRST THEN
                    EVALUATE(MonthlyContribution, ChangeLogEntry."Old Value")
                ELSE
                    MonthlyContribution := SavingsAccounts."Monthly Contribution";

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

    trigger OnInitReport()
    begin
        StatusPermission.RESET;
        StatusPermission.SETRANGE(StatusPermission."User ID", USERID);
        StatusPermission.SETRANGE(StatusPermission.Reports, TRUE);
        IF NOT StatusPermission.FIND('-') THEN BEGIN
            ERROR('You Do Not have Permission to perform this action');
        END;
    end;

    trigger OnPreReport()
    begin
        IF CompanyInformation.GET THEN
            /*CompanyInformation.CALCFIELDS(CompanyInformation.Picture);*/
          CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
#pragma warning disable AL0432
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
#pragma warning restore AL0432

        IF SavingsAccounts.GETFILTER(SavingsAccounts."Date Filter") = '' THEN
            ERROR('Please specify a date filter before proceeding');


        RegDate := SavingsAccounts.GETFILTER("Registration Date");
        DateFilter := SavingsAccounts.GETFILTER("Date Filter");

    end;

    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        SNo: Integer;
        RegDate: Text;
        DateFilter: Text;
        MonthlyContribution: Decimal;
        ChangeLogEntry: Record "Change Log Entry";
        SavAccChangeLog: Record "Change Log Entry";
        StatusPermission: Record "User Setup";
}

