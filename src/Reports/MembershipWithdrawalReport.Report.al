Report 50188 "Membership Withdrawal Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Membership Withdrawal Report.rdlc';

    dataset
    {
        dataitem("Membership Withdrawals"; "Member Exit")
        {
            PrintOnlyIfDetail = false;
            RequestFilterFields = "No.", "Member No.", "Closing Date", Status, "Closure Type";
            CalcFields = "Application Date", "Customer Feedback", Contact, "Maturity Date";

            column(ReportForNavId_4645; 4645)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(Customer_Feedback; "Customer Feedback")
            {
            }
            column(Interest_to_Rejoin; "Interest to Rejoin")
            {
            }
            column(Date_to_Rejoin; "Date to Rejoin")
            {
            }
            column(Maturity_Date; "Maturity Date")
            {
            }
            column(Contact; Contact)
            {
            }
            column(Application_Date; "Application Date")
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Address_2; Company."Address 2")
            {
            }
            column(Company_Phone_No; Company."Phone No.")
            {
            }
            column(Company_Fax_No; Company."Fax No.")
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }
            column(CurrReport_PAGENO; 0)
            {
            }
            column(UserId; UserId)
            {
            }
            column(EntryNo; EntryNo)
            {
            }
            column(No_MembershipWithdrawals; "Membership Withdrawals"."No.")
            {
            }
            column(MemberNo_MembershipWithdrawals; "Membership Withdrawals"."Member No.")
            {
            }
            column(MemberName_MembershipWithdrawals; "Membership Withdrawals"."Member Name")
            {
            }
            column(ClosingDate_MembershipWithdrawals; Format("Membership Withdrawals"."Closing Date"))
            {
            }
            column(Status_MembershipWithdrawals; "Membership Withdrawals".Status)
            {
            }
            column(Posted_MembershipWithdrawals; "Membership Withdrawals".Posted)
            {
            }
            column(TotalLoan_MembershipWithdrawals; "Membership Withdrawals"."Total Loan Outstanding")
            {
            }
            column(TotalInterest_MembershipWithdrawals; "Membership Withdrawals"."Total Interest")
            {
            }
            column(MemberDeposits_MembershipWithdrawals; "Membership Withdrawals"."Non-Withdrawable Savings")
            {
            }
            column(NoSeries_MembershipWithdrawals; "Membership Withdrawals"."No. Series")
            {
            }
            column(ClosureType_MembershipWithdrawals; "Membership Withdrawals"."Closure Type")
            {
            }
            column(ModeOfDisbursement_MembershipWithdrawals; '')
            {
            }
            column(PayingBank_MembershipWithdrawals; "Membership Withdrawals"."Paying Bank")
            {
            }
            column(ChequeNo_MembershipWithdrawals; "Membership Withdrawals"."Cheque No.")
            {
            }
            column(FOSAAccountNo_MembershipWithdrawals; '')
            {
            }
            column(Payee_MembershipWithdrawals; "Membership Withdrawals"."Member Name")
            {
            }
            column(NetPay_MembershipWithdrawals; "Membership Withdrawals"."Total Refundable")
            {
            }
            column(RiskFund_MembershipWithdrawals; '')
            {
            }
            column(RiskBeneficiary_MembershipWithdrawals; '')
            {
            }
            column(RiskRefundable_MembershipWithdrawals; '')
            {
            }
            column(TotalAdds_MembershipWithdrawals; 0)
            {
            }
            column(TotalLesses_MembershipWithdrawals; 0)
            {
            }
            column(UnpaidDividends_MembershipWithdrawals; 0)
            {
            }
            column(TotalLoansFOSA_MembershipWithdrawals; 0)
            {
            }
            column(TotalOustandingIntFOSA_MembershipWithdrawals; 0)
            {
            }
            column(ReasonforWithdrawal_MembershipWithdrawals; "Membership Withdrawals"."Reason for Withdrawal")
            {
            }
            column(NetPayabletotheMember_MembershipWithdrawals; "Membership Withdrawals"."Total Refundable")
            {
            }
            column(RiskFundArrears_MembershipWithdrawals; 0)
            {
            }

            trigger OnAfterGetRecord()
            begin
                EntryNo := EntryNo + 1;
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

    trigger OnInitReport()
    begin
        Company.Get();
        Company.CalcFields(Company.Picture);
    end;

    trigger OnPreReport()
    begin
        if "COMPY INFOR".Get then begin
            "COMPY INFOR".CalcFields("COMPY INFOR".Picture);
            Name := "COMPY INFOR".Name;
        end;
    end;

    var
        RPeriod: Decimal;
        BatchL: Code[100];
        LocationFilter: Code[20];
        TotalApproved: Decimal;
        Cust: Record Members;
        BOSABal: Decimal;
        SuperBal: Decimal;
        Deposits: Decimal;
        CompanyCode: Code[20];
        LoanType: Text[50];
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
        Verified_By__________________________________________________CaptionLbl: label 'Verified By..................';
        Confirmed_By__________________________________________________CaptionLbl: label 'Confirmed By..................';
        Sign________________________CaptionLbl: label 'Sign...............';
        Sign________________________Caption_Control1102755003Lbl: label 'Sign...............';
        Date________________________CaptionLbl: label 'Date..............';
        Date________________________Caption_Control1102755005Lbl: label 'Date..............';
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
        LoanG: Record "Loan Security";
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
        Company: Record "Company Information";
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
        NameCreditOff: label 'Name.......................';
        NameCreditDate: label 'Date........................';
        NameCreditSign: label 'Signature..................';
        NameCreditMNG: label 'Name.......................';
        NameCreditMNGDate: label 'Date........................';
        NameCreditMNGSign: label 'Signature..................';
        NameCEO: label 'Name......................';
        NameCEOSign: label 'Signature.................';
        NameCEODate: label 'Date.......................';
        CreditCom1: label 'Name......................';
        CreditCom1Sign: label 'Signature.................';
        CreditCom1Date: label 'Date.......................';
        CreditCom2: label 'Name......................';
        CreditCom2Sign: label 'Signature.................';
        CreditCom2Date: label 'Date......................';
        CreditCom3: label 'Name.....................';
        CreditComDate3: label 'Date......................';
        CreditComSign3: label 'Signature.................';
        Comment: label '....................';
        "COMPY INFOR": Record "Company Information";
        Name: Text;
        PICTURE: Text;
        EntryNo: Integer;
        PrevousMobileNo: Code[20];
}

