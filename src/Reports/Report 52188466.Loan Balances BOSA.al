
Report 50129 "Loan Balances BOSA"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loan Balances BOSA.rdlc';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem("Loans Register"; Loans)
        {
            DataItemTableView = sorting("Loan No.") where(Posted = filter(true));
            RequestFilterFields = "Loan No.", "Loan Product Type", "Member No.", "Requested Amount";
            column(ReportForNavId_4645; 4645)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Address2; Company."Address 2")
            {
            }
            column(Company_PhoneNo; Company."Phone No.")
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }
            column(Company_Picture; Company.Picture)
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
            column(IssuedDate_LoansRegister; Loans."Disbursement Date")
            {
            }
            column(S_No; SN)
            {
            }
            column(Loan_No; "Loans Register"."Loan No.")
            {
            }
            column(Client_Code; "Member No.")
            {
            }
            column(Client_Name; "Loans Register"."Member Name")
            {
            }
            column(Loan_Product_Type; "Loans Register"."Loan Product Type Name")
            {
            }
            column(Approved_Amount; "Loans Register"."Approved Amount")
            {
            }
            column(Installments; "Loans Register".Installments)
            {
            }
            column(Remaining_Instl; RInst)
            {
            }
            column(Interest_Due; "Loans Register"."Interest Due")
            {
            }
            column(Outstanding_Bal; Loans."Outstanding Principal")
            {
            }
            column(No; LineNo)
            {
            }
            column(Outstanding; Outstanding)
            {
            }
            column(Company_City; Company.City)
            {
            }
            column(ApplicationDate_LoansRegister; "Loans Register"."Application Date")
            {
            }
            column(RequestedAmount_LoansRegister; "Loans Register"."Requested Amount")
            {
            }
            column(Interest_LoansRegister; Loans."Installment Period")
            {
            }
            column(StaffNo_LoansRegister; "Loans Register"."Staff No")
            {
            }

            trigger OnAfterGetRecord()
            begin
                LineNo := LineNo + 1;
                /*IntAmount:=0;
                RInst:=0;
                IF (Loans."Outstanding Balance" > 0) AND (Loans.Interest > 0) THEN
                IntAmount:=ROUND((Loans."Outstanding Balance")*(Loans.Interest/1200),0.05,'>');
                
                IF (Loans."Outstanding Balance" > 0) AND (Loans.Repayment > 0) THEN
                //RInst:=ROUND(Loans."Outstanding Balance"/(Loans.Repayment-IntAmount),1,'>');
                
                 "Net Repayment":=Repayment-IntAmount;*/

            end;

            trigger OnPreDataItem()
            begin
                LineNo := 0;
                //CurrReport.CREATETOTALS("Net Repayment");
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

    var
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
        SN: Integer;
        Company: Record "Company Information";
        IntAmount: Decimal;
        RInst: Integer;
        "Net Repayment": Decimal;
        Loans: Record Loans;
        LineNo: Integer;
        Outstanding: Decimal;
}

