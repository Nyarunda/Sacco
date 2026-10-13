report 50569 "Loan Guard Report2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/oldlayouts/Loan Guard Report.rdlc';

    dataset
    {
        dataitem("Loans Register"; Loans)
        {
            DataItemTableView = SORTING("Loan No.")
                                ORDER(Ascending);
            RequestFilterFields = "Loan No.", "Disbursement Date", "Loan Product Type", "Member No.", "Latest Disb. Posting Date";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; '')
            {
            }
            column(USERID; USERID)
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
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanySMS; CompanyInfo."SMS Line")
            {
            }
            column(Loans__Loan__No__; "Loan No.")
            {
            }
            column(Loans__Client_Code_; "Member No.")
            {
            }
            column(Loans__Client_Name_; "Member Name")
            {
            }
            column(Loans__Requested_Amount_; "Requested Amount")
            {
            }
            column(TotalsLoanOutstanding_Loans; "Loans Register"."Total Outstanding Balance")
            {
            }
            column(Loans__Approved_Amount_; "Approved Amount")
            {
            }
            column(Upfronts; Upfronts)
            {
            }
            column(Netdisbursed; Loans."Amount To Disburse")
            {
            }
            column(EmployerName_Loans; "Loans Register"."Employer Name")
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


            column(Loans_Loans__Outstanding_Balance_; "Loans Register"."Outstanding Principal")
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
            column(Loans__Top_Up_Amount_; "Top Up Amount")
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
            column(Loans_Loans__Outstanding_Balance__Control1102760040; "Loans Register"."Outstanding Principal")
            {
            }
            column(Loans__Oustanding_Interest__Control1102760041; "Outstanding Interest")
            {
            }

            column(Loans__Top_Up_Amount__Control1000000001; "Top Up Amount")
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
            column(Loans__Loan__No__Caption; FIELDCAPTION("Loan No."))
            {
            }
            column(Client_No_Caption; Client_No_CaptionLbl)
            {
            }
            column(Comment; Comment)
            {
            }
            column(Loans__Client_Name_Caption; FIELDCAPTION("Member Name"))
            {
            }
            column(Loans__Requested_Amount_Caption; FIELDCAPTION("Requested Amount"))
            {
            }
            column(Loans__Approved_Amount_Caption; FIELDCAPTION("Approved Amount"))
            {
            }
            column(Loans__Loan_Status_Caption; FIELDCAPTION("Status"))
            {
            }
            column(Outstanding_LoanCaption; Outstanding_LoanCaptionLbl)
            {
            }
            column(PeriodCaption; PeriodCaptionLbl)
            {
            }
            column(Loans__Application_Date_Caption; FIELDCAPTION("Application Date"))
            {
            }
            column(Approved_DateCaption; Approved_DateCaptionLbl)
            {
            }
            column(Loans__Oustanding_Interest_Caption; FIELDCAPTION("Outstanding Interest"))
            {
            }
            column(Loan_TypeCaption_Control1102760043; Loan_TypeCaption_Control1102760043Lbl)
            {
            }
            column(Loans__Last_Pay_Date_Caption; FIELDCAPTION("Last Pay Date"))
            {
            }
            column(Loans__Top_Up_Amount_Caption; FIELDCAPTION("Top Up Amount"))
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
            column(NAME; NAME)
            {
            }
            column(Rno; Rno)
            {
            }
            column(OustandingInterest_LoansRegister; "Loans Register"."Outstanding Interest")
            {
            }
            column(ClientCode_LoansRegister; "Loans Register"."Member No.")
            {
            }
            column(ClientName_LoansRegister; "Loans Register"."Member Name")
            {
            }
            column(NetLoanDisbursed_LoansRegister; "Loans Register"."Net To Be Disbursed")
            {
            }
            column(LoanProductTypeName_LoansRegister; "Loans Register"."Loan Product Type Name")
            {
            }
            column(IDNO; IDNO)
            {
            }
            column(DOB; DOB)
            {
            }
            column(gender; Gender)
            {
            }
            column(Gender_LoansRegister; Gender)
            {
            }

            column(TheAmount; "Net To Be Disbursed")
            {
            }
            column(LoanNum; LoanNum)
            {
            }
            column(Rescheduleby_LoansRegister; "Loans Register"."Reschedule by")
            {
            }

            trigger OnAfterGetRecord()
            begin


                Rno := Rno + 1;
                cust.RESET;
                cust.SETRANGE(cust."No.", "Loans Register"."Member No.");
                IF cust.FIND('-') THEN BEGIN
                    IDNO := cust."ID No.";
                    DOB := cust."Date of Birth";
                    Gender := cust.Gender;
                END;

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
        IF CompanyInfo.GET THEN BEGIN
            CompanyInfo.CALCFIELDS(Picture);

            CompanyAddress := CompanyInfo.Address;
            CompanyEmail := CompanyInfo."E-Mail";

        END
    end;

    var
        RPeriod: Decimal;
        BatchL: Code[100];

        LocationFilter: Code[20];
        TotalApproved: Decimal;
        cust: Record Members;
        BOSABal: Decimal;
        SuperBal: Decimal;
        Deposits: Decimal;
        CompanyCode: Code[20];
        LoanType: Text[50];
        LCount: Integer;
        RFilters: Text[250];

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
        CompanyAddress: Code[50];
        CompanyEmail: Text[50];
        CompanyTel: Code[500];
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

        TotalLoanBal: Decimal;
        TotalBand: Decimal;

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
        NAME: Text;
        PICTURE: Text;
        Rno: Integer;
        Loans_RegisterCaptionLbl: Label 'Approved Loans Report';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Loan_TypeCaptionLbl: Label 'Loan Type';
        Client_No_CaptionLbl: Label 'Client No.';
        Outstanding_LoanCaptionLbl: Label 'Outstanding Loan';
        PeriodCaptionLbl: Label 'Period';
        Approved_DateCaptionLbl: Label 'Approved Date';
        Loan_TypeCaption_Control1102760043Lbl: Label 'Loan Type';
        Verified_By__________________________________________________CaptionLbl: Label 'Verified By..................................................';
        Confirmed_By__________________________________________________CaptionLbl: Label 'Confirmed By..................................................';
        Sign________________________CaptionLbl: Label 'Sign........................';
        Sign________________________Caption_Control1102755003Lbl: Label 'Sign........................';
        Date________________________CaptionLbl: Label 'Date........................';
        Date________________________Caption_Control1102755005Lbl: Label 'Date........................';
        NameCreditOff: Label 'Name......................................';
        NameCreditDate: Label 'Date........................................';
        NameCreditSign: Label 'Signature..................................';
        NameCreditMNG: Label 'Name......................................';
        NameCreditMNGDate: Label 'Date.....................................';
        NameCreditMNGSign: Label 'Signature..................................';
        NameCEO: Label 'Name........................................';
        NameCEOSign: Label 'Signature...................................';
        NameCEODate: Label 'Date.....................................';
        CreditCom1: Label 'Name........................................';
        CreditCom1Sign: Label 'Signature...................................';
        CreditCom1Date: Label 'Date.........................................';
        CreditCom2: Label 'Name........................................';
        CreditCom2Sign: Label 'Signature....................................';
        CreditCom2Date: Label 'Date..........................................';
        CreditCom3: Label 'Name.........................................';
        CreditComDate3: Label 'Date..........................................';
        CreditComSign3: Label 'Signature..................................';
        Comment: Label '....................';
        IDNO: Code[30];
        DOB: Date;
        gender: Option;
        TheAmount: Decimal;
        Loans: Record "Loans";
        ValAmount: Decimal;
        ThatAmount: Decimal;
        LoanNum: Code[20];
}

