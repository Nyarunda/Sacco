
Report 50125 "Loans Register"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loans Register.rdlc';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem("Loans Register"; Loans)
        {
            DataItemTableView = sorting("Loan No.") order(ascending) where(Posted = filter(true));
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Loan No.", "Application Date", "Date Filter", "Loan Product Type", "Member No.", "Loan Officer", Source;
            CalcFields = "Total Arrears", "Interest Arrears", "Principal Arrears", "Outstanding Principal", "Outstanding Insurance", "Outstanding Penalty", "Outstanding Interest", "Last Paid Amount";
            column(ReportForNavId_4645; 4645)
            {
            }
            column(RO; cust."Relationship Officer Name")
            {
            }
            column(Outstanding_Insurance; "Outstanding Insurance")
            { }
            column(RelationshipOfficer_LoansRegister; "Loans Register"."Relationship Officer")
            {
            }
            column(OutPenalty; "Outstanding Penalty")
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; 0)
            {
            }
            column(CapturedBy_LoansRegister; "Loans Register"."Captured By")
            {
            }
            column(UserId; UserId)
            {
            }
            column(GlobalDimension2Code_LoansRegister; "Loans Register"."Booking Branch")
            {
            }
            column(Deposit; Deposit)
            {
            }
            column(LoanType; "Loan Product Type Name")
            {
            }
            column(Staff_No; "Staff No")
            {
            }
            column(ID_No; cust."ID No.")
            {
            }
            column(RFilters; RFilters)
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoAddress; CompanyInfo.Address)
            {
            }
            column(CompanyInfoAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyInfoPic; CompanyInfo.Picture)
            {
            }
            column(Loans__Loan__No__; "Loan No.")
            {
            }
            column(Loans__Client_Code_; "Member No.")
            {
            }
            column(Appraised_By; "Appraised By")
            {
            }
            column(PenaltyCharged_LoansRegister; "Outstanding Penalty")
            {
            }
            column(Amount_To_Disburse; "Amount To Disburse")
            {
            }
            column(Repayment; Repayment)
            {
            }
            column(Loan_Principle_Repayment; "Loan Principle Repayment")
            {
            }
            column(Loan_Interest_Repayment; "Loan Interest Repayment")
            {
            }
            column(Total_Arrears; "Total Arrears")
            {
            }
            column(Repay_Mode; "Repay Mode")
            {
            }
            column(Installments; Installments)
            {
            }
            column(Loans__Client_Name_; "Member Name")
            {
            }
            column(Loans__Requested_Amount_; "Requested Amount")
            {
            }
            column(TotalsLoanOutstanding_Loans; "Total Outstanding Balance")
            {
            }
            column(BranchCode_LoansRegister; cust."Global Dimension 2 Code")
            {
            }
            column(RepaymentMethod_LoansRegister; "Repay Mode")
            {
            }
            column(Interest_LoansRegister; "Interest Due")
            {
            }
            column(LastPayDate_LoansRegister; "Loans Register"."Last Pay Date")
            {
            }
            column(InstalmentPeriod_LoansRegister; Installments)
            {
            }
            column(Loans__Approved_Amount_; "Approved Amount")
            {
            }
            column(Penalty; "Outstanding Penalty")
            {
            }
            column(Last_Paid_Amount; "Last Paid Amount")
            {

            }
            column(Posted_By; "Posted By")
            {

            }

            column(OutstandingBalance_LoansRegister; "Outstanding Principal")
            {
            }
            column(OustandingInterest_LoansRegister; "Outstanding Interest")
            {
            }
            column(TotalArrears_LoansRegister; "Loans Register"."Total Arrears")
            {
            }
            column(Upfronts; Upfronts)
            {
            }
            column(Netdisbursed; Netdisbursed + PartialAmt)
            {
            }
            column(TotalUpfronts; TotalUpfronts)
            {
            }
            column(EmployerCode_Loans; "Loans Register"."Employer Code")
            {
            }
            column(TotalNetPay; TotalNetPay)
            {
            }
            column(Loans_Installments; Installments)
            {
            }
            column(Loans__Loan_Status_; Status)
            {
            }
            column(Loans_Loans__Outstanding_Balance_; "Outstanding Principal")
            {
            }
            column(Loans__Application_Date_; "Application Date")
            {
            }
            column(Loans__Issued_Date_; "Disbursement Date")
            {
            }
            column(Loans__Oustanding_Interest_; "Outstanding Interest")
            {
            }
            column(Loans_Loans__Loan_Product_Type_; "Loans Register"."Loan Product Type")
            {
            }
            column(Loans_Loans__Loan_Product_Type_Name; "Loans Register"."Loan Product Type Name")
            {
            }
            column(Completion_Date; "Completion Date")
            {
            }
            column(Loans__Last_Pay_Date_; "Last Pay Date")
            {
            }
            column(Loans__Approved_Amount__Control1102760017; "Approved Amount")
            {
            }
            column(Loans__Requested_Amount__Control1102760038; "Requested Amount")
            {
            }
            column(LCount; LCount)
            {
            }
            column(Loans_Loans__Outstanding_Balance__Control1102760040; "Outstanding Principal")
            {
            }
            column(Loans__Oustanding_Interest__Control1102760041; "Outstanding Interest")
            {
            }
            column(Loans_RegisterCaption; Loans_RegisterCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Loan_TypeCaption; Loan_TypeCaptionLbl)
            {
            }
            column(Loans__Loan__No__Caption; FieldCaption("Loan No."))
            {
            }
            column(Client_No_Caption; Client_No_CaptionLbl)
            {
            }
            column(Comment; Comment)
            {
            }
            column(Loans__Client_Name_Caption; FieldCaption("Member Name"))
            {
            }
            column(Loans__Requested_Amount_Caption; FieldCaption("Requested Amount"))
            {
            }
            column(Loans__Approved_Amount_Caption; FieldCaption("Approved Amount"))
            {
            }
            column(Loans__Loan_Status_Caption; FieldCaption(Status))
            {
            }
            column(Captured_By; "Captured By")
            {
            }
            column(Approved_By; "Approved By")
            {
            }

            column(Top_Up_Amount; "Top Up Amount")
            {
            }
            column(Employer_Name; "Employer Name")
            {
            }
            column(Outstanding_LoanCaption; Outstanding_LoanCaptionLbl)
            {
            }
            column(PeriodCaption; PeriodCaptionLbl)
            {
            }
            column(Loans__Application_Date_Caption; FieldCaption("Application Date"))
            {
            }
            column(Approved_DateCaption; Approved_DateCaptionLbl)
            {
            }
            column(Loans__Oustanding_Interest_Caption; FieldCaption("Outstanding Interest"))
            {
            }
            column(Loan_TypeCaption_Control1102760043; Loan_TypeCaption_Control1102760043Lbl)
            {
            }
            column(Loans__Last_Pay_Date_Caption; FieldCaption("Last Pay Date"))
            {
            }
            column(Verified_By__________________________________________________Caption; Verified_By__________________________________________________CaptionLbl)
            {
            }
            column(Confirmed_By__________________________________________________Caption; Confirmed_By__________________________________________________CaptionLbl)
            {
            }
            column(Sign________________________Caption; Sign________________________CaptionLbl)
            {
            }
            column(Sign________________________Caption_Control1102755003; Sign________________________Caption_Control1102755003Lbl)
            {
            }
            column(Date________________________Caption; Date________________________CaptionLbl)
            {
            }
            column(Date________________________Caption_Control1102755005; Date________________________Caption_Control1102755005Lbl)
            {
            }
            column(NameCreditOff; NameCreditOff)
            {
            }
            column(NameCreditDate; NameCreditDate)
            {
            }
            column(NameCreditSign; NameCreditSign)
            {
            }
            column(NameCreditMNG; NameCreditMNG)
            {
            }
            column(NameCreditMNGDate; NameCreditMNGDate)
            {
            }
            column(NameCreditMNGSign; NameCreditMNGSign)
            {
            }
            column(NameCEO; NameCEO)
            {
            }
            column(NameCEOSign; NameCEOSign)
            {
            }
            column(NameCEODate; NameCEODate)
            {
            }
            column(CreditCom1; CreditCom1)
            {
            }
            column(CreditCom1Date; CreditCom1Date)
            {
            }
            column(CreditCom2; CreditCom2)
            {
            }
            column(CreditCom2Sign; CreditCom2Sign)
            {
            }
            column(CreditCom2Date; CreditCom2Date)
            {
            }
            column(CreditCom3; CreditCom3)
            {
            }
            column(CreditComDate3; CreditComDate3)
            {
            }
            column(CreditComSign3; CreditComSign3)
            {
            }
            column(COMPPIC; PICTURE)
            {
            }
            column(Name; Name)
            {
            }
            column(repayment_period; "Loans Register"."Installment Period")
            {
            }
            column(ShareCapital; ShareCapital)
            {
            }
            column(DaysArrears; DaysArrears)
            {
            }
            column(Loan_Restructured; "Loan Restructured")
            {
            }
            column(Date_Rescheduled; "Date Rescheduled")
            {
            }
            column(Loans_Category_SASRA; "Loans Category-SASRA")
            {
            }
            column(RemainigInstallments; RemainigInstallments)
            { }

            trigger OnPreDataItem()
            begin
                if GetFilter("Date Filter") <> '' then begin
                    RFilters := GetFilter("Date Filter");
                    AsAt := GetRangeMax("Date Filter");
                end else begin
                    RFilters := '..' + Format(Today);
                    AsAt := Today;
                end;
                GenSetUp.Get();

            end;

            trigger OnAfterGetRecord()
            var
                SActivities: codeunit "Sacco Activities";
            begin

                DaysArrears := 0;
                PrincExpected := 0;
                "Loans Register".CalcFields("Top Up Amount");

                Netdisbursed := 0;
                PartialAmt := 0;

                Netdisbursed := "Amount to Disburse";

                if (GenSetUp."Go Live Date" <> 0D) and ("Loans Register"."Disbursement Date" <= GenSetUp."Go Live Date") then begin
                    PartialDisbHeader.Reset();
                    PartialDisbHeader.SetRange("Loan No.", "Loans Register"."Loan No.");
                    PartialDisbHeader.SetRange(Posted, true);
                    PartialDisbHeader.SetFilter("Posting Date", '<=%1', AsAt);
                    if PartialDisbHeader.FindSet() then
                        repeat
                            PartialDisbHeader.CalcFields(Reversed);
                            if not PartialDisbHeader.Reversed then begin
                                PartialDisbLine.Reset();
                                PartialDisbLine.SetRange("Header No.", PartialDisbHeader."No.");
                                PartialDisbLine.SetRange("Loan No.", "Loans Register"."Loan No.");
                                PartialDisbLine.CalcSums("Amount to Disbuse");
                                PartialAmt += PartialDisbLine."Amount to Disbuse";
                            end;
                        until PartialDisbHeader.Next() = 0;
                end;


                cust.Get("Loans Register"."Member No.");

                if BranchCode <> '' then
                    if cust."Global Dimension 2 Code" <> BranchCode then
                        CurrReport.Skip;


                Deposit := 0;
                SavAcc.Reset;
                SavAcc.SetRange(SavAcc."Member No.", "Member No.");
                SavAcc.SetFilter("Product Category", '%1|%2', SavAcc."product category"::"Micro Member Deposit", SavAcc."product category"::"Deposit Contribution");
                SavAcc.SetFilter("Date Filter", RFilters);
                SavAcc.SetLoadFields("Balance (LCY)");
                SavAcc.SetAutoCalcFields(SavAcc."Balance (LCY)");
                if SavAcc.Find('-') then
                    repeat
                        Deposit += SavAcc."Balance (LCY)";
                    until SavAcc.Next() = 0;

                SavAcc.Reset;
                SavAcc.SetRange(SavAcc."Member No.", "Member No.");
                SavAcc.SetRange("Product Category", SavAcc."product category"::"Share Capital");
                SavAcc.SetFilter("Date Filter", RFilters);
                SavAcc.SetLoadFields("Balance (LCY)");
                SavAcc.SetAutoCalcFields(SavAcc."Balance (LCY)");
                if SavAcc.Find('-') then begin
                    ShareCapital := SavAcc."Balance (LCY)";
                end;


                if UpdatePriority then begin
                    if LoanProdType.get("Loan Product Type") then begin
                        if "Recovery Priority" <> LoanProdType."Recovery Priority" then begin
                            "Recovery Priority" := LoanProdType."Recovery Priority";
                            Modify();
                        end;
                    end;

                end;

                SASRACategory.Reset();
                SASRACategory.setrange("Loan No.", "Loans Register"."Loan No.");
                if SASRACategory.FindFirst() then;

                PrincExpected := SASRACategory."Principal Expected";
                DaysArrears := SASRACategory."Days in Arrears";
                RemainigInstallments := SActivities.GetRemainingInstallments("Loans Register"."Loan No.");
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
                field(UpdatePriority; UpdatePriority)
                {
                    ApplicationArea = All;

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

        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        RemainigInstallments: Decimal;
        RPeriod: Decimal;
        BatchL: Code[100];
        PartialAmt: decimal;
        PartialDisbHeader: Record "Partial Loans Disb. Header";
        PartialDisbLine: Record "Partial Loans Disb. Lines";
        ApprovalSetup: Codeunit System.Automation."Approvals Mgmt.";
        LocationFilter: Code[20];
        TotalApproved: Decimal;
        Cust: Record Members;
        BOSABal: Decimal;
        SuperBal: Decimal;
        UpdatePriority: Boolean;
        LAppl: Record Loans;
        Deposits: Decimal;
        CompanyCode: Code[20];
        LoanType: Text[50];
        LoanProdType: Record "Product Setup";
        LCount: Integer;
        RFilters: Text[250];
        DValue: Record "Dimension Value";
        PrincExpected: decimal;
        DaysArrears: Decimal;
        SASRACategory: Record "Sasra Categorization";
        Loans_RegisterCaptionLbl: label 'Approved Loans Report';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Loan_TypeCaptionLbl: label 'Loan Type';
        Client_No_CaptionLbl: label 'Client No.';
        Outstanding_LoanCaptionLbl: label 'Outstanding Loan';
        PeriodCaptionLbl: label 'Period';
        Approved_DateCaptionLbl: label 'Approved Date';
        Loan_TypeCaption_Control1102760043Lbl: label 'Loan Type';
        Verified_By__________________________________________________CaptionLbl: label 'Verified By..................................................';
        Confirmed_By__________________________________________________CaptionLbl: label 'Confirmed By..................................................';
        Sign________________________CaptionLbl: label 'Sign........................';
        Sign________________________Caption_Control1102755003Lbl: label 'Sign........................';
        Date________________________CaptionLbl: label 'Date........................';
        Date________________________Caption_Control1102755005Lbl: label 'Date........................';
        GenSetUp: Record "Sacco Setup";
        LoanApp: Record Loans;
        CustRec: Record Customer;
        CustRecord: Record Customer;
        TShares: Decimal;
        TLoans: Decimal;
        LoanShareRatio: Decimal;
        Eligibility: Decimal;
        TotalSec: Decimal;
        saccded: Decimal;
        saccded2: Decimal;
        grosspay: Decimal;
        Tdeduct: Decimal;
        Cshares: Decimal;
        "Cshares*3": Decimal;
        "Cshares*4": Decimal;
        QUALIFY_SHARES: Decimal;
        salary: Decimal;
        GShares: Decimal;
        Recomm: Decimal;
        GShares1: Decimal;
        NETTAKEHOME: Decimal;
        Msalary: Decimal;
        RecPeriod: Integer;
        FOSARecomm: Decimal;
        FOSARecoPRD: Integer;
        "Asset Value": Decimal;
        InterestRate: Decimal;
        RepayPeriod: Decimal;
        LBalance: Decimal;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        SecuredSal: Decimal;
        Linterest1: Integer;
        LOANBALANCE: Decimal;
        BRIDGEBAL: Decimal;
        LOANBALANCEFOSASEC: Decimal;
        TotalTopUp: Decimal;
        TotalIntPayable: Decimal;
        GTotals: Decimal;
        TempVal: Decimal;
        TempVal2: Decimal;
        "TempCshares*4": Decimal;
        "TempCshares*3": Decimal;
        InstallP: Decimal;
        RecomRemark: Text[150];
        InstallRecom: Decimal;
        TopUpComm: Decimal;
        TotalTopupComm: Decimal;
        "Interest Payable": Decimal;
        "general set-up": Record "Sacco Setup";
        Days: Integer;
        EndMonthInt: Decimal;
        BRIDGEBAL2: Decimal;
        DefaultInfo: Text[80];
        TOTALBRIDGED: Decimal;
        DEpMultiplier: Decimal;
        MAXAvailable: Decimal;
        Earnings: Decimal;
        Deductions: Decimal;
        BrTopUpCom: Decimal;
        LoanAmount: Decimal;
        CompanyInfo: Record "Company Information";
        CompanyAddress: Code[20];
        CompanyEmail: Text[30];
        CompanyTel: Code[20];
        CurrentAsset: Decimal;
        CurrentLiability: Decimal;
        FixedAsset: Decimal;
        Equity: Decimal;
        Sales: Decimal;
        SalesOnCredit: Decimal;
        AppraiseDeposits: Boolean;
        AppraiseShares: Boolean;
        AppraiseSalary: Boolean;
        AppraiseGuarantors: Boolean;
        AppraiseBusiness: Boolean;
        TLoan: Decimal;
        LoanBal: Decimal;
        GuaranteedAmount: Decimal;
        RunBal: Decimal;
        TGuaranteedAmount: Decimal;
        GuarantorQualification: Boolean;
        TotalLoanBalance: Decimal;
        TGAmount: Decimal;
        NetSalary: Decimal;
        Riskamount: Decimal;
        WarnBridged: Text;
        WarnSalary: Text;
        WarnDeposits: Text;
        WarnGuarantor: Text;
        WarnShare: Text;
        RiskGshares: Decimal;
        RiskDeposits: Decimal;
        BasicEarnings: Decimal;
        DepX: Decimal;
        LoanPrincipal: Decimal;
        loanInterest: Decimal;
        AmountGuaranteed: Decimal;
        StatDeductions: Decimal;
        GuarOutstanding: Decimal;
        TwoThirds: Decimal;
        Bridged_AmountCaption: Integer;
        LNumber: Code[20];
        TotalLoanDeductions: Decimal;
        TotalRepayments: Decimal;
        Totalinterest: Decimal;
        Band: Decimal;
        TotalOutstanding: Decimal;
        NtTakeHome: Decimal;
        ATHIRD: Decimal;
        Psalary: Decimal;
        LoanApss: Record Loans;
        TotalLoanBal: Decimal;
        TotalBand: Decimal;
        LoanAp: Record Loans;
        TotalRepay: Decimal;
        TotalInt: Decimal;
        LastFieldNo: Integer;
        TotLoans: Decimal;
        JazaLevy: Decimal;
        BridgeLevy: Decimal;
        Upfronts: Decimal;
        Netdisbursed: Decimal;
        TotalLRepayments: Decimal;
        BridgedRepayment: Decimal;
        OutstandingLrepay: Decimal;
        BRIGEDAMOUNT: Decimal;
        TOTALBRIGEDAMOUNT: Decimal;
        FinalInst: Decimal;
        NonRec: Decimal;
        TotalUpfronts: Decimal;
        TotalNetPay: Decimal;
        NameCreditOff: label 'Name......................................';
        NameCreditDate: label 'Date........................................';
        NameCreditSign: label 'Signature..................................';
        NameCreditMNG: label 'Name......................................';
        NameCreditMNGDate: label 'Date.....................................';
        NameCreditMNGSign: label 'Signature..................................';
        NameCEO: label 'Name........................................';
        NameCEOSign: label 'Signature...................................';
        NameCEODate: label 'Date.....................................';
        CreditCom1: label 'Name........................................';
        CreditCom1Sign: label 'Signature...................................';
        CreditCom1Date: label 'Date.........................................';
        CreditCom2: label 'Name........................................';
        CreditCom2Sign: label 'Signature....................................';
        CreditCom2Date: label 'Date..........................................';
        CreditCom3: label 'Name.........................................';
        CreditComDate3: label 'Date..........................................';
        CreditComSign3: label 'Signature..................................';
        Comment: label '....................';
        "COMPY INFOR": Record "Company Information";
        Name: Text;
        PICTURE: Text;
        SavAcc: Record "Savings Accounts";
        Deposit: Decimal;
        BranchCode: Code[10];
        ShareCapital: Decimal;
        AsAt: Date;
}

