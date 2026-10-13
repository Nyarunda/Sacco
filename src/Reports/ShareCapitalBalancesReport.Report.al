Report 50200 "Share Capital Balances Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Share Capital Balances Test Report.rdl';

    dataset
    {
        dataitem(Customer; Members)
        {
            PrintOnlyIfDetail = false;
            RequestFilterFields = "No.", Status, "Employer Code", "Phone No.";//phone no should be "Personal No"====removed UnknownRecord50312
            column(ReportForNavId_4645; 4645)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            /*
            column(COMPANYNAME; COMPANYNAME)
            {
            }*/
            column(Company_Name; Company.Name)
            {
            }
            column(CompanyName; "Company Name")
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(CompanyAddress; CompanyAddress)
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
            column(CurrReport_PAGENO; '')//[CurrPageNo := ]  Report.PageNo([NewPageNo: Integer])
            {
            }
            column(UserId; UserId)
            {
            }
            column(PersonalNo_MembersRegister; Customer."Phone No.")//Personal No
            {
            }
            column(IDNo_MembersRegister; Customer."ID No.")
            {
            }
            column(MobilePhoneNo_MembersRegister; Customer."Mobile Phone No.")
            {
            }
            column(No_MembersRegister; Customer."No.")
            {
            }
            column(Name_MembersRegister; Customer.Name)
            {
            }
            column(Status_MembersRegister; Customer.Status)
            {
            }
            /*column(SharesRetained_MembersRegister; Customer.Amount)//"Shares Retained"
            {
            }*/
            column(SharesRetained_MembersRegister; SharesCapital)//"Shares Retained"
            {
            }
            column(GlobalDimension2Code_MembersRegister; Customer."Global Dimension 2 Code")
            {
            }
            column(EmployerCode_MembersRegister; Customer."Employer Code")
            {
            }
            column(EntryNo; EntryNo)
            {
            }

            trigger OnAfterGetRecord()
            begin
                EntryNo := EntryNo + 1;
                SharesCapital := 0;
                MembReg.Reset;
                MembReg.SetRange("Member No.", Customer."No.");
                if MembReg.FindFirst then begin
                    repeat
                        if MembReg."Product Category" = MembReg."product category"::"Share Capital" then
                            SharesCapital := MemberActivities.GetAccountBalance(MembReg."No.");


                    until MembReg.Next = 0;
                end;
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
        Batches: Record "Batch Processing Parameter";//UnknownRecord50318

        LocationFilter: Code[20];
        TotalApproved: Decimal;
        Cust: Record Members;
        SharesCapital: Decimal;
        MembReg: Record "Savings Accounts";
        MemberActivities: Codeunit "Member Activities";
        BOSABal: Decimal;
        SuperBal: Decimal;
        LAppl: Record Loans;//UnknownRecord50312
        Deposits: Decimal;
        CompanyCode: Code[20];
        LoanType: Text[50];
        //LoanProdType: Record UnknownRecord50322;
        LCount: Integer;
        RFilters: Text[250];
        DValue: Record "Dimension Value";
        //VALREPAY: Record UnknownRecord50306;
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
        GenSetUp: Record "General Ledger Setup";//UnknownRecord50339
        LoanApp: Record "Loan Appraisal";//UnknownRecord50312
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
        //LoanG: Record UnknownRecord50313;
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
        BRIDGEDLOANS: Record "Loan Top Up";//UnknownRecord50317
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
        LoanTopUp: Record "Loan Top Up";//UnknownRecord50317
        "Interest Payable": Decimal;
        "general set-up": Record "General Ledger Setup";//UnknownRecord50339
        Days: Integer;
        EndMonthInt: Decimal;
        BRIDGEBAL2: Decimal;
        DefaultInfo: Text[80];
        TOTALBRIDGED: Decimal;
        DEpMultiplier: Decimal;
        MAXAvailable: Decimal;
        SalDetails: Record "Salary Grades";//UnknownRecord50314
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
        //BANDING: Record UnknownRecord50343;
        NtTakeHome: Decimal;
        ATHIRD: Decimal;
        Psalary: Decimal;
        LoanApss: Record "Loan Appraisal";//UnknownRecord50312
        TotalLoanBal: Decimal;
        TotalBand: Decimal;
        LoanAp: Record "Loan Appraisal";//UnknownRecord50312
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
        Loantop: Record "Loan Top Up";//UnknownRecord50317
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
}







