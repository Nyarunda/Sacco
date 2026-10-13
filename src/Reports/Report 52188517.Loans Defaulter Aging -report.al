
Report 50180 "Loans Defaulter Aging -report"
{
    DefaultLayout = RDLC;
    caption = 'Loan Aging With Security';
    RDLCLayout = './src/Layouts/Loans Defaulter Aging -Security.rdlc';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem(Loans; Loans)
        {
            CalcFields = "Outstanding Principal", "Outstanding Interest", "Outstanding Insurance", "Outstanding Penalty", "Principal Paid", "Interest Paid", "Last Pay Date";
            DataItemTableView = sorting("Loan No.") order(ascending) where(Posted = filter(true));
            RequestFilterFields = "Loan No.", "Loan Product Type", "Member No.", "Loan Officer", "Date Filter";
            column(Employer_Code; "Employer Code")
            {
            }
            column(CompanyInfoPic; CompanyInfo.Picture)
            {
            }
            column(Loans_Aging_Analysis__SASRA_CaptionLbl; Loans_Aging_Analysis__SASRA_CaptionLbl)
            {
            }
            column(FOSAShares; FOSAShares)
            {
            }
            column(LoanCategory; LoanCategoryAsAt)
            {
            }
            column(SASRA_Months_Arrears; MonthsInArrearsAsAt)
            { }
            column(SASRA_Days_Arrears; DaysInArrearsAsAt)
            { }
            column(Purpose_of_Loan; LoanPurpose)
            {
            }
            column(FosaDeposits; FosaDeposits)
            {
            }
            column(ReportForNavId_4645; 4645)
            {
            }
            column(DisbursementDate_Loans; Loans."Disbursement Date")
            {
            }
            column(PhoneNo; PhoneNo)
            {
            }
            column(MDep; MDep)
            {
            }
            column(RO; "Loan Officer")
            {
            }
            column(BranchCode; BranchCode)
            {
            }
            column(MemberDeposits; MemberDeposits)
            {
            }
            column(Amount_Paid; Loans."Principal Paid")
            {
            }
            column(Interest_Amount_Paid; Loans."Interest Paid")
            {
            }
            column(ArrearsSacco; TotalArrearsAsAt)
            {
            }
            column(ArrearsSasra; TotalArrearsAsAt)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(AsAt, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; 0)
            {
            }
            column(UserId; UserId)
            {
            }
            column(Loans__Loan__No__; Loans."Loan No.")
            {
            }
            column(MemberNO; Loans."Member No.")
            {
            }
            column(Loans__Loan_Product_Type_; "Loan Product Type")
            {
            }
            column(Loans_Loans__Staff_No_; Loans."Staff No")
            {
            }
            column(Loans__Client_Name_; Loans."Member Name")
            {
            }
            column(Loans_Loans__Outstanding_Balance_; OutstandingPrincipalAsAt)
            {
            }
            column(Loans_Outstanding_Interest; OutstandingInterestAsAt)
            {
            }
            column(Loans_Total_Outstanding_Balance; OutstandingPrincipalAsAt + OutstandingInterestAsAt)
            {
            }
            column(V2Month_; "2Month")
            {
            }
            column(V3Month_; "3Month")
            {
            }
            column(Over3Month; Over3Month)
            {
            }
            column(V1Month_; "1Month")
            {
            }
            column(V0Month_; "0Month")
            {
            }
            column(Loans_Loans__Outstanding_Balance__Control1000000016; OutstandingPrincipalAsAt)
            {
            }
            column(Loans__Approved_Amount_; "Approved Amount")
            {
            }
            column(V1MonthC_; "1MonthC")
            {
            }
            column(V2MonthC_; "2MonthC")
            {
            }
            column(V3MonthC_; "3MonthC")
            {
            }
            column(Over3MonthC; Over3MonthC)
            {
            }
            column(NoLoans; NoLoans)
            {
            }
            column(GrandTotal; GrandTotal)
            {
            }
            column(V0Month__Control1102760031; "0Month")
            {
            }
            column(V1Month__Control1102760032; "1Month")
            {
            }
            column(V2Month__Control1102760033; "2Month")
            {
            }
            column(V3Month__Control1102760034; "3Month")
            {
            }
            column(Over3Month_Control1102760035; Over3Month)
            {
            }
            column(V0MonthC_; "0MonthC")
            {
            }
            column(Loans_Aging_Analysis__SASRA_Caption; Loans_Aging_Analysis__SASRA_CaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Loans__Loan__No__Caption; FieldCaption("Loan No."))
            {
            }
            column(Loan_TypeCaption; Loan_TypeCaptionLbl)
            {
            }
            column(Staff_No_Caption; Staff_No_CaptionLbl)
            {
            }
            column(Loans__Client_Name_Caption; FieldCaption("Member Name"))
            {
            }
            column(Oustanding_BalanceCaption; Oustanding_BalanceCaptionLbl)
            {
            }
            column(PerformingCaption; PerformingCaptionLbl)
            {
            }
            column(V1___30_Days_Caption; V1___30_Days_CaptionLbl)
            {
            }
            column(V0_Days_Caption; V0_Days_CaptionLbl)
            {
            }
            column(WatchCaption; WatchCaptionLbl)
            {
            }
            column(V31___180_Days_Caption; V31___180_Days_CaptionLbl)
            {
            }
            column(SubstandardCaption; SubstandardCaptionLbl)
            {
            }
            column(V181___360_Days_Caption; V181___360_Days_CaptionLbl)
            {
            }
            column(DoubtfulCaption; DoubtfulCaptionLbl)
            {
            }
            column(Over_360_DaysCaption; Over_360_DaysCaptionLbl)
            {
            }
            column(LossCaption; LossCaptionLbl)
            {
            }
            column(TotalsCaption; TotalsCaptionLbl)
            {
            }
            column(CountCaption; CountCaptionLbl)
            {
            }
            column(Grand_TotalCaption; Grand_TotalCaptionLbl)
            {
            }
            column(RelationshipManager; RelationManager)
            {
            }
            column(SecurityType; SecurityType)
            { }
            column(AmountGuaranteed; AmountGuaranteed)
            { }
            column(SelfGuarantee; SelfGuarantee)
            { }
            column(Guarantor; Guarantor)
            { }
            column(OwnDepositSecurity; OwnDepositSecurity)
            { }
            column(MotorVehicleSecurity; MotorVehicleSecurity)
            { }
            column(TitleDeedSecurity; TitleDeedSecurity)
            { }
            column(NSESharesSecurity; NSESharesSecurity)
            { }
            column(MoneyMarketFundSecurity; MoneyMarketFundSecurity)
            { }
            column(InsurancePolicySecurity; InsurancePolicySecurity)
            { }
            dataitem(LoanSecurityMatrix; "Loan Security")
            {
                DataItemLink = "Loan No." = field("Loan No.");

                column(SecurityMatrixType; SecurityMatrixType)
                {
                }
                column(SecurityMatrixAmount; "Current Committed")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SecurityMatrixType := GetSecurityTypeName(LoanSecurityMatrix);
                    if SecurityMatrixType = '' then
                        CurrReport.Skip();
                end;

                trigger OnPreDataItem()
                begin
                    SetFilter(Date, '..%1', AsAt);
                end;
            }

            trigger OnAfterGetRecord()
            var
                ProductSetup: Record "Product Setup";
            begin
                "0Month" := 0;
                "1Month" := 0;
                "2Month" := 0;
                "3Month" := 0;
                FosaDeposits := 0;
                FOSAShares := 0;
                LoanCategory := '';
                SelfGuarantee := 0;
                Guarantor := 0;
                OwnDepositSecurity := 0;
                MotorVehicleSecurity := 0;
                TitleDeedSecurity := 0;
                NSESharesSecurity := 0;
                MoneyMarketFundSecurity := 0;
                InsurancePolicySecurity := 0;
                LoanPurpose := GetLoanPurpose(Loans);

                Over3Month := 0;
                "Amount Paid" := 0;
                CountDays := 0;
                ExpectedRepayment := 0;
                BranchCode := '';
                RO := '';
                if ProductSetup.Get(Loans."Loan Product Type") then begin
                    if Loans.Source <> ProductSetup."Loan Source" then begin
                        Loans.Source := ProductSetup."Loan Source";
                        Loans.Modify();
                    end;
                end;


                Cust.Get(Loans."Member No.");

                PhoneNo := Cust."Mobile Phone No.";

                RO := Cust."Relationship Officer Name";
                BranchCode := Cust."Global Dimension 2 Code";


                FosaDeposits := GetSavingsBalanceAsAt(Legacy.GetOrdinaryAccount(Loans."Member No."));
                FOSAShares := GetSavingsBalanceAsAt(Legacy.GetFosaSharesAccount(Loans."Member No."));
                MemberDeposits := GetSavingsBalanceAsAt(Legacy.GetDepositAccounts(Loans."Member No."));


                Loans.CalcFields("Outstanding Principal", "Outstanding Interest", "Outstanding Penalty", "Outstanding Insurance");
                OutstandingPrincipalAsAt := Loans."Outstanding Principal";
                OutstandingInterestAsAt := Loans."Outstanding Interest";
                SASRAMgt.CategorizeLoanAsAt(Loans, AsAt, PrincipalArrearsAsAt, DaysInArrearsAsAt, MonthsInArrearsAsAt, InterestArrearsAsAt, LoanCategoryAsAt);
                TotalArrearsAsAt := PrincipalArrearsAsAt + InterestArrearsAsAt;

                if LoanCategoryAsAt = LoanCategoryAsAt::Performing then begin
                    "0Month" := OutstandingPrincipalAsAt;
                    "0MonthC" := "0MonthC" + 1;

                end else
                    if LoanCategoryAsAt = LoanCategoryAsAt::Watch then begin
                        "1Month" := OutstandingPrincipalAsAt;
                        "1MonthC" := "1MonthC" + 1;

                    end else
                        if LoanCategoryAsAt = LoanCategoryAsAt::Substandard then begin
                            "2Month" := OutstandingPrincipalAsAt;
                            "2MonthC" := "2MonthC" + 1;

                        end else
                            if LoanCategoryAsAt = LoanCategoryAsAt::Doubtful then begin
                                "3Month" := OutstandingPrincipalAsAt;
                                "3MonthC" := "3MonthC" + 1;

                            end else
                                if LoanCategoryAsAt = LoanCategoryAsAt::Loss then begin
                                    Over3Month := OutstandingPrincipalAsAt;
                                    Over3MonthC := Over3MonthC + 1;

                                end;

                GrandTotal := GrandTotal + OutstandingPrincipalAsAt;


                //IF ("0Month"+"1Month"+"2Month"+"3Month"+Over3Month) > 0 THEN
                NoLoans := NoLoans + 1;

                if HREmployees.Get(Loans.Relationship) then
                    RelationManager := HREmployees."First Name" + '' + HREmployees."Middle Name" + '' + HREmployees."Last Name"
                else
                    RelationManager := '';

                MDep := 0;
                SavingsAccounts.Reset;
                SavingsAccounts.SetRange("Member No.", Loans."Member No.");
                SavingsAccounts.SetRange("Product Category", SavingsAccounts."product category"::"Deposit Contribution");
                SavingsAccounts.SetFilter("Date Filter", '..%1', AsAt);
                SavingsAccounts.SetAutoCalcFields("Balance (LCY)");
                SavingsAccounts.SetLoadFields("Balance (LCY)");
                if SavingsAccounts.FindFirst then begin
                    MDep := SavingsAccounts."Balance (LCY)";
                end;

                // Get loan security type
                GetLoanSecurityTypeAndAmount(Loans."Loan No.", AsAt, SecurityType, AmountGuaranteed);

                /* if SecurityType = SecurityType::" " then
                    CurrReport.Skip(); */

            end;

            trigger OnPostDataItem()
            begin
                //MESSAGE('%1',GrandTotal);
            end;

            trigger OnPreDataItem()
            begin
                GrandTotal := 0;
                if GetFilter("Date Filter") = '' then
                    SetRange("Date Filter", 0D, Today);

                // The Date Filter is the report's single source of truth. Its
                // end date is used by calculations that require one exact date.
                AsAt := GetRangeMax("Date Filter");
                if AsAt = 0D then
                    AsAt := Today;

                SetFilter("Disbursement Date", '..%1', AsAt);
            end;
        }
    }

    labels
    {
    }
    trigger OnPreReport()
    begin

        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;


    var
        CompanyInfo: Record "Company Information";
        "1Month": Decimal;
        "2Month": Decimal;
        "3Month": Decimal;
        Over3Month: Decimal;
        ShowLoan: Boolean;
        AsAt: Date;
        LastDueDate: Date;
        DFormula: DateFormula;
        "0MonthC": Integer;
        "1MonthC": Integer;
        "2MonthC": Integer;
        "3MonthC": Integer;
        Over3MonthC: Integer;
        NoLoans: Integer;
        PhoneNo: Text[30];
        Cust: Record Members;
        "StaffNo.": Text[30];
        Deposits: Decimal;
        GrandTotal: Decimal;
        "0Month": Decimal;
        LoanProduct: Record "Product Setup";
        FirstMonthDate: Date;
        EndMonthDate: Date;
        Loans_Aging_Analysis__SASRA_CaptionLbl: label 'Loans Aging Analysis (With Security)';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Loan_TypeCaptionLbl: label 'Loan Type';
        Staff_No_CaptionLbl: label 'Staff No.';
        Oustanding_BalanceCaptionLbl: label 'Oustanding Balance';
        PerformingCaptionLbl: label 'Performing';
        V1___30_Days_CaptionLbl: label '(31 - 90 Days)';
        V0_Days_CaptionLbl: label '(0 - 30 Days)';
        WatchCaptionLbl: label 'Watch';
        V31___180_Days_CaptionLbl: label '(91 - 180 Days)';
        SubstandardCaptionLbl: label 'Substandard';
        V181___360_Days_CaptionLbl: label '(181 - 360 Days)';
        DoubtfulCaptionLbl: label 'Doubtful';
        Over_360_DaysCaptionLbl: label 'Over 360 Days';
        LossCaptionLbl: label 'Loss';
        TotalsCaptionLbl: label 'Totals';
        CountCaptionLbl: label 'Count';
        Grand_TotalCaptionLbl: label 'Grand Total';
        LossDate: Date;
        CountDays: Integer;
        "Amount Paid": Decimal;
        ExpectedRepayment: Decimal;
        DefaultedAmount: Decimal;
        HREmployees: Record Employee;
        RelationManager: Text;
        SASRACategory: Record "SACCO Categorization";
        MemberDeposits: Decimal;
        SavingsAccounts: Record "Savings Accounts";
        Arrears: Decimal;
        BranchCode: Code[10];
        RO: Text;
        MDep: Decimal;
        FOSAShares: Decimal;
        FosaDeposits: Decimal;
        LoanCategory: Text;
        MActivities: Codeunit "Member Activities";
        Legacy: Codeunit Legacy;
        SecurityType: Text[250];
        AmountGuaranteed: Decimal;
        SelfGuarantee: decimal;
        Guarantor: decimal;
        OwnDepositSecurity: Decimal;
        MotorVehicleSecurity: Decimal;
        TitleDeedSecurity: Decimal;
        NSESharesSecurity: Decimal;
        MoneyMarketFundSecurity: Decimal;
        InsurancePolicySecurity: Decimal;
        SecurityMatrixType: Text[100];
        LoanPurpose: Text[250];
        SASRAMgt: Codeunit "SASRA Categorization Mgt.";
        OutstandingPrincipalAsAt: Decimal;
        OutstandingInterestAsAt: Decimal;
        PrincipalArrearsAsAt: Decimal;
        InterestArrearsAsAt: Decimal;
        TotalArrearsAsAt: Decimal;
        DaysInArrearsAsAt: Integer;
        MonthsInArrearsAsAt: Integer;
        LoanCategoryAsAt: Option Performing,Watch,Substandard,Doubtful,Loss;

    local procedure GetLoanPurpose(Loan: Record Loans): Text[250]
    var
        MemberSalaryAppraisal: Record "Member Salary Appraisal";
    begin
        if Loan."Purpose of Loan" <> '' then
            exit(CopyStr(Loan."Purpose of Loan", 1, 250));

        if Loan."Salary Appraisal No." = '' then
            exit('');

        if MemberSalaryAppraisal.Get(Loan."Salary Appraisal No.") then
            exit(MemberSalaryAppraisal."Loan Purpose");

        exit('');
    end;


    procedure GetLoanSecurityTypeAndAmount(LoanNo: Code[20]; AsAtDate: Date; var SecurityType: Text[250]; var SecurityAmount: Decimal)
    var
        LoanSecurity: Record "Loan Security";
    begin
        SecurityType := '';
        SecurityAmount := 0;

        LoanSecurity.Reset();
        LoanSecurity.SetRange("Loan No.", LoanNo);
        LoanSecurity.SetFilter(Date, '..%1', AsAtDate);
        if not LoanSecurity.FindSet() then
            exit;

        repeat
            SecurityAmount += LoanSecurity."Amount Guaranteed";

            if LoanSecurity."Self Guarantee" then
                SelfGuarantee += LoanSecurity."Current Committed";

            if (LoanSecurity."Guarantor Type" = LoanSecurity."Guarantor Type"::Guarantor) and
               (not LoanSecurity."Self Guarantee")
            then
                Guarantor := Guarantor + LoanSecurity."Current Committed";


            case LoanSecurity."Guarantor Type" of
                LoanSecurity."Guarantor Type"::Guarantor:
                    AddSecurityType(SecurityType, 'Guarantor');
                LoanSecurity."Guarantor Type"::Lien:
                    begin
                        AddSecurityType(SecurityType, 'Lien');
                        OwnDepositSecurity += LoanSecurity."Current Committed";
                        ;
                    end;
                LoanSecurity."Guarantor Type"::Collateral:
                    case LoanSecurity."Collateral Type" of
                        LoanSecurity."Collateral Type"::"Motor Vehicle":
                            begin
                                AddSecurityType(SecurityType, 'Motor Vehicle');
                                MotorVehicleSecurity += LoanSecurity."Current Committed";
                                ;
                            end;
                        LoanSecurity."Collateral Type"::"Title Deed":
                            begin
                                AddSecurityType(SecurityType, 'Title Deed');
                                TitleDeedSecurity += LoanSecurity."Current Committed";
                                ;
                            end;
                        LoanSecurity."Collateral Type"::"NSE Shares":
                            begin
                                AddSecurityType(SecurityType, 'NSE Shares');
                                NSESharesSecurity += LoanSecurity."Current Committed";
                                ;
                            end;
                        LoanSecurity."Collateral Type"::"Money Market Fund":
                            begin
                                AddSecurityType(SecurityType, 'Money Market Fund');
                                MoneyMarketFundSecurity += LoanSecurity."Current Committed";
                                ;
                            end;
                        LoanSecurity."Collateral Type"::Insurance:
                            begin
                                AddSecurityType(SecurityType, 'Insurance Policies');
                                InsurancePolicySecurity += LoanSecurity."Current Committed";
                                ;
                            end;
                    end;
            end;
        until LoanSecurity.Next() = 0;
    end;

    // changes 092226
    procedure GetLoanSecurityTypeAndAmountOld(LoanNo: Code[20]; AsAtDate: Date; var SecurityType: Text[250]; var SecurityAmount: Decimal)
    var
        LoanSecurity: Record "Loan Security";
    begin
        SecurityType := '';
        SecurityAmount := 0;

        LoanSecurity.Reset();
        LoanSecurity.SetRange("Loan No.", LoanNo);
        LoanSecurity.SetFilter(Date, '..%1', AsAtDate);
        if not LoanSecurity.FindSet() then
            exit;

        repeat
            SecurityAmount += LoanSecurity."Amount Guaranteed";

            if LoanSecurity."Self Guarantee" then
                SelfGuarantee += LoanSecurity."Amount Guaranteed";

            if (LoanSecurity."Guarantor Type" = LoanSecurity."Guarantor Type"::Guarantor) and
               (not LoanSecurity."Self Guarantee")
            then
                Guarantor := Guarantor + LoanSecurity."Amount Guaranteed";

            case LoanSecurity."Guarantor Type" of
                LoanSecurity."Guarantor Type"::Guarantor:
                    AddSecurityType(SecurityType, 'Guarantor');
                LoanSecurity."Guarantor Type"::Lien:
                    begin
                        AddSecurityType(SecurityType, 'Lien');
                        OwnDepositSecurity += LoanSecurity."Amount Guaranteed";
                    end;
                LoanSecurity."Guarantor Type"::Collateral:
                    case LoanSecurity."Collateral Type" of
                        LoanSecurity."Collateral Type"::"Motor Vehicle":
                            begin
                                AddSecurityType(SecurityType, 'Motor Vehicle');
                                MotorVehicleSecurity += LoanSecurity."Amount Guaranteed";
                            end;
                        LoanSecurity."Collateral Type"::"Title Deed":
                            begin
                                AddSecurityType(SecurityType, 'Title Deed');
                                TitleDeedSecurity += LoanSecurity."Amount Guaranteed";
                            end;
                        LoanSecurity."Collateral Type"::"NSE Shares":
                            begin
                                AddSecurityType(SecurityType, 'NSE Shares');
                                NSESharesSecurity += LoanSecurity."Amount Guaranteed";
                            end;
                        LoanSecurity."Collateral Type"::"Money Market Fund":
                            begin
                                AddSecurityType(SecurityType, 'Money Market Fund');
                                MoneyMarketFundSecurity += LoanSecurity."Amount Guaranteed";
                            end;
                        LoanSecurity."Collateral Type"::Insurance:
                            begin
                                AddSecurityType(SecurityType, 'Insurance Policies');
                                InsurancePolicySecurity += LoanSecurity."Amount Guaranteed";
                            end;
                    end;
            end;
        until LoanSecurity.Next() = 0;
    end;








    local procedure AddSecurityType(var SecurityTypes: Text[250]; NewSecurityType: Text)
    var
        NormalizedSecurityTypes: Text[250];
        NormalizedNewSecurityType: Text;
    begin
        NormalizedSecurityTypes := DelChr(SecurityTypes, '=', ' ');
        NormalizedNewSecurityType := DelChr(NewSecurityType, '=', ' ');
        if StrPos(
            ',' + NormalizedSecurityTypes + ',',
            ',' + NormalizedNewSecurityType + ',') > 0
        then
            exit;

        if SecurityTypes = '' then
            SecurityTypes := CopyStr(NewSecurityType, 1, MaxStrLen(SecurityTypes))
        else
            SecurityTypes := CopyStr(
                SecurityTypes + ', ' + NewSecurityType,
                1,
                MaxStrLen(SecurityTypes));
    end;

    local procedure GetSavingsBalanceAsAt(AccountNo: Code[20]): Decimal
    var
        SavingsAccount: Record "Savings Accounts";
    begin
        if AccountNo = '' then
            exit(0);

        SavingsAccount.SetRange("No.", AccountNo);
        SavingsAccount.SetFilter("Date Filter", '..%1', AsAt);
        if SavingsAccount.FindFirst() then begin
            SavingsAccount.CalcFields("Balance (LCY)");
            exit(SavingsAccount."Balance (LCY)");
        end;

        exit(0);
    end;

    local procedure GetSecurityTypeName(LoanSecurity: Record "Loan Security"): Text[100]
    begin
        if LoanSecurity."Self Guarantee" then
            exit('Self Guarantee');

        case LoanSecurity."Guarantor Type" of
            LoanSecurity."Guarantor Type"::Guarantor:
                exit('Guarantor');
            LoanSecurity."Guarantor Type"::Lien:
                exit('Lien');
            LoanSecurity."Guarantor Type"::Collateral:
                exit(Format(LoanSecurity."Collateral Type"));
        end;

        exit('');
    end;

}
