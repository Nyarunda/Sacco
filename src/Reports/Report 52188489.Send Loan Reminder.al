
Report 50152 "Send Loan Reminder"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Send Loan Reminder.rdlc';
    UsageCategory = Tasks;

    dataset
    {
        dataitem("Loans Register"; Loans)
        {
            DataItemTableView = sorting("Loan No.") order(ascending) where(Posted = filter(true), "Total Outstanding Balance" = filter(> 0), "Loan Product Type" = filter(<> 'HISTORICAL'), "Disbursement Date" = filter(<> ''));
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Loan No.", "Application Date", "Loan Product Type", "Member No.", Source;
            column(ReportForNavId_4645; 4645)
            {
            }
            column(RO; cust."Relationship Officer Name")
            {
            }
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
            column(LoanType; LoanType)
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
            column(PenaltyCharged_LoansRegister; "Outstanding Penalty")
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
            column(Netdisbursed; Netdisbursed)
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

            trigger OnAfterGetRecord()
            var
                Msg: Text;
                ExpectedPayDate: Date;
                SaccoActivities: Codeunit "Sacco Activities";
                Members: Record Members;
                SkyMbanking: Codeunit "Sky Mbanking";
                ExpectedAmt: Decimal;
                AmtPaid: Decimal;
                DefAmount: Decimal;
                DaysInArrear: Integer;
                ArrearsDate: Date;
                GracePeriod: DateFormula;
            begin




                if DueDate <> 0D then begin
                    ExpectedPayDate := SaccoActivities.GetLoanRePaymentDate("Loans Register", DueDate);
                    if ExpectedPayDate <> DueDate then
                        CurrReport.Skip;
                end;


                DefAmount := 0;
                DaysInArrear := 0;
                SaccoActivities.GetDefaultedAmount("Loans Register"."Loan No.", DueDate, ExpectedAmt, AmtPaid, DefAmount, DaysInArrear, ArrearsDate, true, GracePeriod);

                if DefAmount < 200 then
                    CurrReport.Skip;

                if SendSMS = true then begin

                    Members.Get("Loans Register"."Member No.");
                    Msg := 'Dear ' + SkyMbanking.FirstName("Loans Register"."Member Name") + ', kindly repay your ' + "Loans Register"."Loan Product Type Name" + ' loan to reduce your balance. Use Paybill No:238447 to make repayments' +
                    '. Regards.';

                    //SkyMbanking.SendSms(SMSSource::LoanRemind,Members."Mobile Phone No.",Msg,"Loans Register"."Loan No.","Loans Register"."Disbursement Account No",FALSE,210,FALSE);
                    MemberActivities.SendSms(Smssource::"Loan Reminder", Members."Mobile Phone No.", Msg, "Loans Register"."Loan No.", "Loans Register"."Disbursement Account No", false, false);

                end;






                "Loans Register".CalcFields("Relationship Officer");

                cust.Get("Loans Register"."Member No.");

                if BranchCode <> '' then
                    if cust."Global Dimension 2 Code" <> BranchCode then
                        CurrReport.Skip;


                Deposit := 0;
                SavAcc.Reset;
                SavAcc.SetRange(SavAcc."Member No.", "Member No.");
                SavAcc.SetRange("Product Category", SavAcc."product category"::"Deposit Contribution");
                if SavAcc.Find('-') then begin
                    SavAcc.CalcFields(SavAcc."Balance (LCY)");
                    Deposit := SavAcc."Balance (LCY)";
                end;
            end;

            trigger OnPreDataItem()
            begin

                if DueDate = 0D then
                    Error('Enter Due Date');
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
                field("Loans Due Date"; DueDate)
                {
                    ApplicationArea = Basic;
                }
                field("Send SMS Notification"; SendSMS)
                {
                    ApplicationArea = Basic;
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
        RPeriod: Decimal;
        BatchL: Code[100];
        ApprovalSetup: Codeunit System.Automation."Approvals Mgmt.";
        LocationFilter: Code[20];
        TotalApproved: Decimal;
        Cust: Record Members;
        BOSABal: Decimal;
        SuperBal: Decimal;
        LAppl: Record Loans;
        Deposits: Decimal;
        CompanyCode: Code[20];
        LoanType: Text[50];
        LoanProdType: Record "Product Setup";
        LCount: Integer;
        RFilters: Text[250];
        DValue: Record "Dimension Value";
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
        SendSMS: Boolean;
        DueDate: Date;
        SMSSource1: Enum "SMS Source Enum";
        MemberActivities: Codeunit "Member Activities";
        SMSSource: Enum "SMS Source Enum";
}

