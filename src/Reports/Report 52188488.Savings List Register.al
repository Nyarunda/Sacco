Report 50151 "Savings List Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Savings List Register.rdlc';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.", "Recruited by Type", "Recruited By", "Registration Date", "Member Status";
            column(ReportForNavId_1; 1)
            { }
            column(ShowFuuzaTxt; ShowFuuzaTxt)
            { }
            column(FuuzaLimit; FuuzaLimit)
            { }
            column(CompanyInformation_Name; CompanyInformation.Name)
            { }
            column(CompanyInformation_Picture; CompanyInformation.Picture) { }
            column(CompanyAddress; CompanyAddress) { }
            column(CompanyTelephone; CompanyTelephone) { }
            column(CommunicationOnline; CommunicationOnline) { }
            column(No_SavingsAccounts; Members."No.") { }
            column(Name_SavingsAccounts; Members.Name) { }
            column(GlobalDimension1Code_SavingsAccounts; ShareCapitalBalance) { }
            column(GlobalDimension2Code_SavingsAccounts; DepositBalance) { }
            column(EmployerCode_SavingsAccounts; HolidaySavingsBalance) { }
            column(ProductType_SavingsAccounts; FixedDepositBalance) { }
            column(ProductName_SavingsAccounts; MemberWalletBalance) { }
            column(MemberNo_SavingsAccounts; DistributionAccountBalance) { }
            column(PayrollStaffNo_SavingsAccounts; InterestOnDepositBalance) { }
            column(PhoneNo_SavingsAccounts; JuniorSavingsBalance) { }
            column(RecruitedBy_SavingsAccounts; '') { }
            column(RecruitedByName_SavingsAccounts; '') { }
            column(TotalBalanceAmount; TotalBalanceAmount) { }
            column(IDNumber_SavingsAccounts; "ID No.") { }
            column(BirthCertificateNo_SavingsAccounts; '') { }
            column(SalespersonCode_SavingsAccounts; '') { }
            column(CreatedBy_SavingsAccounts; '') { }
            column(Source_SavingsAccounts; '') { }
            column(Status_SavingsAccounts; '') { }
            column(BalanceLCY_SavingsAccounts; '') { }
            column(SCount; SNo) { }
            column(MaturityDate; '') { }
            column(OldMemberNo_SavingsAccounts; '') { }
            column(CustomerCID_SavingsAccounts; '') { }
            column(OldAccountNo_SavingsAccounts; '') { }

            trigger OnAfterGetRecord()
            begin
                ClearBalances();

                if ShowFuuza then begin
                    ShowFuuzaTxt := 'Yes';
                    FuuzaLimit := Sky.GetFuuzaLimit(Members."No.", Today);
                end else begin
                    ShowFuuzaTxt := '';
                    FuuzaLimit := 0;
                end;

                if BranchCode <> '' then
                    if Members."Global Dimension 2 Code" <> BranchCode then
                        CurrReport.Skip();

                ShareCapitalBalance := GetProductBalance(Members."No.", 'Share Capital');
                DepositBalance := GetProductBalance(Members."No.", 'Deposit Contribution');
                HolidaySavingsBalance := GetProductBalance(Members."No.", 'Holiday Savings');
                FixedDepositBalance := GetProductBalance(Members."No.", 'Fixed Deposit');
                MemberWalletBalance := GetProductBalance(Members."No.", 'Virtual Account');
                DistributionAccountBalance := GetDistributionBalance(Members."No.");
                InterestOnDepositBalance := GetInterestOnDepositBalance(Members."No.");
                JuniorSavingsBalance := GetProductBalance(Members."No.", 'Junior Savings');

                TotalBalanceAmount := ShareCapitalBalance + DepositBalance + HolidaySavingsBalance + FixedDepositBalance + MemberWalletBalance + JuniorSavingsBalance;
                SNo += 1;
            end;
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
                field(ShowFuuza; ShowFuuza)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        MActivities.CheckViewReportsPermmission(UserId);

        if CompanyInformation.Get() then;
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
#pragma warning disable AL0432
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
#pragma warning restore AL0432
    end;

    trigger OnInitReport()
    begin
        UserSetup.Get(UserId);
        if not UserSetup.Reports then
            Error('You do not have any permissions to access this report. Contact the administrator!');
    end;

    local procedure ClearBalances()
    begin
        ShareCapitalBalance := 0;
        DepositBalance := 0;
        HolidaySavingsBalance := 0;
        FixedDepositBalance := 0;
        MemberWalletBalance := 0;
        DistributionAccountBalance := 0;
        InterestOnDepositBalance := 0;
        JuniorSavingsBalance := 0;
        TotalBalanceAmount := 0;
    end;

    local procedure GetProductBalance(MemberNo: Code[20]; ProductCategory: Text): Decimal
    var
        SavingsAcc: Record "Savings Accounts";
        BalanceValue: Decimal;
    begin
        SavingsAcc.Reset();
        SavingsAcc.SetRange("Member No.", MemberNo);
        case ProductCategory of
            'Share Capital':
                SavingsAcc.SetRange("Product Category", SavingsAcc."Product Category"::"Share Capital");
            'Deposit Contribution':
                SavingsAcc.SetRange("Product Category", SavingsAcc."Product Category"::"Deposit Contribution");
            'Holiday Savings':
                SavingsAcc.SetRange("Product Category", SavingsAcc."Product Category"::"Holiday Savings");
            'Fixed Deposit':
                SavingsAcc.SetRange("Product Category", SavingsAcc."Product Category"::"Fixed Deposit");
            'Virtual Account':
                SavingsAcc.SetRange("Product Category", SavingsAcc."Product Category"::"Virtual Account");
            'Junior Savings':
                SavingsAcc.SetRange("Product Category", SavingsAcc."Product Category"::"Junior Savings");
        end;
        if SavingsAcc.FindSet() then
            repeat
                SavingsAcc.CalcFields("Balance (LCY)");
                BalanceValue += SavingsAcc."Balance (LCY)";
            until SavingsAcc.Next() = 0;
        exit(BalanceValue);
    end;

    local procedure GetDistributionBalance(MemberNo: Code[20]): Decimal
    var
        MemberAcc: Record "Savings Accounts";
        DistributionBalance: Decimal;
    begin
        MemberAcc.Reset();
        MemberAcc.SetRange("Member No.", MemberNo);
        MemberAcc.SetRange("Product Category", MemberAcc."Product Category"::"Dividend Account");
        if MemberAcc.FindSet() then
            repeat
                MemberAcc.CalcFields("Balance (LCY)");
                DistributionBalance += MemberAcc."Balance (LCY)";
            until MemberAcc.Next() = 0;
        exit(DistributionBalance);
    end;

    local procedure GetInterestOnDepositBalance(MemberNo: Code[20]): Decimal
    var
        SaccoAccount: Record "SACCO Account";
        InterestBalance: Decimal;
    begin
        SaccoAccount.Reset();
        SaccoAccount.SetRange("Member No.", MemberNo);
        if SaccoAccount.FindSet() then
            repeat
                InterestBalance += SaccoAccount."Interest on Deposits";
            until SaccoAccount.Next() = 0;
        exit(InterestBalance);
    end;

    var
        UserSetup: Record "User Setup";
        BranchCode: Code[10];
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        SNo: Integer;
        ShowFuuzaTxt: Text;
        ShowFuuza: Boolean;
        FuuzaLimit: Decimal;
        Sky: Codeunit "Sky MBanking";
        MActivities: Codeunit "Member Activities";
        ShareCapitalBalance: Decimal;
        DepositBalance: Decimal;
        HolidaySavingsBalance: Decimal;
        FixedDepositBalance: Decimal;
        MemberWalletBalance: Decimal;
        DistributionAccountBalance: Decimal;
        InterestOnDepositBalance: Decimal;
        JuniorSavingsBalance: Decimal;
        TotalBalanceAmount: Decimal;
}
