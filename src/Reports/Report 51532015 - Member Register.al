/// <summary>
/// Report Member Register (ID 51532015).
/// </summary>
report 50367 "Member Register2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layout/Member Register.rdl';

    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.", "Member Status", "Employer Code", "Registration Date", "Group Account", "Global Dimension 1 Code", "Global Dimension 2 Code", Nationality, "Date Filter";
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
            column(No_Members; Members."No.")
            {
            }
            column(PayrollStaffNo; Members."Payroll/Staff No.")
            {
            }
            column(Name; Members.Name)
            {
            }
            column(RegistrationDate; Members."Registration Date")
            {
            }
            column(DateofBirth; Members."Date of Birth")
            {
            }
            column(EmployerCode; Members."Employer Code")
            {
            }
            column(IDNumber; Members."ID No.")
            {
            }
            column(Status; Members."Member Status")
            {
            }
            column(SCount; SNo)
            {
            }
            column(MemberCategory; Members."Member Category")
            {
            }
            column(EMail; Members."E-Mail")
            {
            }
            column(CurrentAddress; Members."Address" + ' ' + Members.City)
            {
            }

            column(Gender; Members.Gender)
            {
            }
            column(BranchCode; Members."Global Dimension 2 Code")
            {
            }
            column(BankAccountNo; Members."Bank Account No.")
            {
            }
            column(MobilePhoneNo_Members; Members."Mobile Phone No.")
            {
            }
            column(ShareCapital; "Share Capital")
            {
            }
            column(MainSahares; "Main Shares")
            {
            }
            column(Gross_Dividends; "Gross Dividends")
            {

            }
            column(FosaLoans; FosaLoans)
            {
            }
            column(BosaLoans; BosaLoans)
            {
            }
            column(AllLoans; AllLoans)
            {
            }
            column(EmployerCode_Members; Members."Employer Code")
            {
            }
            column(EmployerName; EmployerName)
            {
            }

            column(Age; Age)
            {
            }

            trigger OnAfterGetRecord()
            begin

                SNo += 1;
                "Main Shares" := 0;
                "Share Capital" := 0;
                Age := 0;
                EmployerName := '';
                FosaLoans := 0;
                BosaLoans := 0;

                SavingsAccounts.Reset;
                SavingsAccounts.SetRange("Member No.", Members."No.");
                SavingsAccounts.SetFilter("Product Category", '%1', SavingsAccounts."Product Category"::"Deposit Contribution");
                if SavingsAccounts.FindFirst then begin
                    SavingsAccounts.CalcFields("Balance (LCY)");
                    "Main Shares" := SavingsAccounts."Balance (LCY)"
                end;


                SavingsAccounts.Reset;
                SavingsAccounts.SetRange("Member No.", Members."No.");
                SavingsAccounts.SetFilter("Product Category", '%1', SavingsAccounts."Product Category"::"Share Capital");
                if SavingsAccounts.FindFirst then begin
                    SavingsAccounts.CalcFields("Balance (LCY)");
                    "Share Capital" := SavingsAccounts."Balance (LCY)"
                end;

                // Loans.Reset;
                // Loans.SetRange("Member No.", Members."No.");
                // Loans.SetFilter("Total Outstanding Balance", '<>0');
                // Loans.SetFilter("Loan Group", '%1', Loans."Loan Group"::BOSA);
                // Loans.SetAutoCalcFields("Total Outstanding Balance");
                // if Loans.FindFirst then
                //     repeat
                //         BosaLoans += Loans."Total Outstanding Balance";
                //     until Loans.Next = 0;

                // Loans.Reset;
                // Loans.SetRange("Member No.", Members."No.");
                // Loans.SetFilter("Total Outstanding Balance", '<>0');
                // Loans.SetFilter("Loan Group", '%1', Loans."Loan Group"::FOSA);
                // Loans.SetAutoCalcFields("Total Outstanding Balance");
                // if Loans.FindFirst then
                //     repeat
                //         FosaLoans += Loans."Total Outstanding Balance";
                //     until Loans.Next = 0;

                Loans.Reset;
                Loans.SetRange("Member No.", Members."No.");
                Loans.SetFilter("Total Outstanding Balance", '<>0');
                Loans.SetAutoCalcFields("Total Outstanding Balance");
                Loans.SetLoadFields("Total Outstanding Balance", "Loan No.");
                if Loans.FindFirst then
                    repeat
                        AllLoans += Loans."Total Outstanding Balance";
                    until Loans.Next = 0;


                if Members."Date of Birth" <> 0D then Age := Round((Today - Members."Date of Birth") / 365, 1, '=');

                Customer.Reset;
                Customer.SetRange(Customer."No.", Members."Employer Code");
                if Customer.Find('-') then EmployerName := Customer.Name;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {

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

    trigger OnInitReport()
    var
        myInt: Integer;
    begin
        UserSetup.Get(UserId);
        if not UserSetup.Reports then
            Error('You do not have any permissions to access this report. Contact the administrator!');
    end;

    var
        UserSetup: Record "User Setup";
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        SNo: Integer;
        SavingAcc: Record "vendor";
        CreditAcc: Record "Member Accounts";
        LoanAcc: Record Loans;
        AplhaDeposit: Decimal;
        SharesCapital: Decimal;
        RegFees: Decimal;
        CreditLoans: Decimal;
        BankingLoans: Decimal;
        AlphaDepositProduct: Code[10];
        SharesCapitalProduct: Code[10];
        RegFeesProduct: Code[10];
        ShortTLoans: Decimal;
        LongTLoans: Decimal;
        TotalLoans: Decimal;

        Cust: Record Members;
        dWindow: Dialog;
        NoOfRecords: Integer;
        CurrentRecordNo: Integer;
        Update: Boolean;
        DFilter: Text;
        CFilter: Text;
        d: Integer;
        m: Integer;
        y: Integer;
        SavingsAccounts: Record "Savings Accounts";
        "Share Capital": Decimal;
        "Main Shares": Decimal;
        BosaLoans: Decimal;
        FosaLoans: Decimal;
        AllLoans: Decimal;
        Loans: Record Loans;
        EmployerName: Text;
        Customer: Record Customer;
        Age: Integer;
}

