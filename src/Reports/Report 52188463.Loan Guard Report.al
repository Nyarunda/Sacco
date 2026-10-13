
Report 50126 "Loan Guard Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loan Guard Report.rdlc';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = sorting("Loan No.") order(ascending) where(Posted = filter(true));
            RequestFilterFields = "Loan No.", "Loan Product Type", "Member No.", "Type of Disbursement";
            CalcFields = "Total Disbursed";
            column(Outstanding_Principal; "Outstanding Principal")
            {
            }
            column(Total_Disbursed; "Amount to Disburse")
            { }
            column(Total_Outstanding_Balance; "Total Outstanding Balance")
            {
            }
            column(DepositBalance; DepositBalance)
            {
            }
            column(OutLoanPeriod; OutLoanPeriod)
            {
            }
            column(ReportForNavId_4645; 4645)
            {
            }
            column(picture; CompanyInfo.Picture)
            {
            }
            column(Phone_No; CompanyInfo."Phone No.")
            {
            }
            column(email; CompanyInfo."E-Mail")
            {
            }
            column(address; CompanyInfo.Address)
            {
            }
            column(Name; CompanyInfo.Name)
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
            column(CapturedBy_Loans; Loans."Captured By")
            {
            }
            column(UserId; UserId)
            {
            }
            column(LoanType; Loans."Loan Product Type Name")
            {
            }
            column(LoanProductTypeName_Loans; Loans."Loan Product Type Name")
            {
            }
            column(RFilters; RFilters)
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
            column(Loans__Approved_Amount_; "Approved Amount")
            {
            }
            column(Net_To_Be_Disbursed; "Net To Be Disbursed")
            { }
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
            column(Loans_Loans__Loan_Product_Type_; Loans."Loan Product Type")
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
            column(Gender; cust.Gender)
            {
            }
            column(LCount; LCount)
            {
            }
            column(Loans_Loans__Outstanding_Balance__Control1102760040; Loans."Outstanding Principal")
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
            column(Idno; IDno)
            {
            }
            column(Dob; Dob)
            {
            }
            column(Rho; Rho)
            {
            }

            trigger OnAfterGetRecord()
            begin

                Rho := Rho + 1;
                /*
                BOSABal:=0;
                SuperBal:=0;
                Deposits:=0;
                LCount:=LCount+1;
                CompanyCode:='';
                
                LocationFilter:='';
                RPeriod:=Loans.Installments;
                IF (Loans."Outstanding Balance" > 0) AND (Loans.Repayment > 0) THEN
                RPeriod:=Loans."Outstanding Balance"/Loans.Repayment;
                
                BatchL:='';
                IF Batches.GET(Loans."Batch No.") THEN BEGIN
                Batches.CALCFIELDS(Batches."Currect Location");
                BatchL:=Batches."Currect Location";
                END;
                
                IF Loans.GETFILTER(Loans."Location Filter") <> '' THEN  BEGIN
                ApprovalSetup.RESET;
                ApprovalSetup.SETRANGE(ApprovalSetup."Approval Type",ApprovalSetup."Approval Type"::"File Movement");
                ApprovalSetup.SETFILTER(ApprovalSetup.Stage,Loans.GETFILTER(Loans."Location Filter"));
                IF ApprovalSetup.FIND('-') THEN
                LocationFilter:=ApprovalSetup.Station;
                END;
                
                IF LocationFilter = '' THEN
                TotalApproved:=TotalApproved+Loans."Approved Amount"
                ELSE BEGIN
                IF LocationFilter = BatchL THEN
                TotalApproved:=TotalApproved+Loans."Approved Amount"
                END;
                
                //Get balance of BOSA Loans + super loans
                IF (Loans.Source=Loans.Source::BOSA) OR (Loans."Loan Product Type"='SUPER') THEN BEGIN
                cust.RESET;
                cust.SETRANGE(cust."No.",Loans."Client Code");
                cust.SETRANGE(cust."Customer Type",cust."Customer Type"::Member);
                IF cust.FIND('-') THEN BEGIN
                cust.CALCFIELDS(cust."Outstanding Balance",cust."Current Shares");
                BOSABal:=cust."Outstanding Balance";
                Deposits:=ABS(cust."Current Shares");
                CompanyCode:=cust."Employer Code";
                END ELSE BEGIN
                cust.RESET;
                cust.SETRANGE(cust."No.",Loans."BOSA No");
                cust.SETRANGE(cust."Customer Type",cust."Customer Type"::Member);
                
                IF cust.FIND('-') THEN BEGIN
                cust.CALCFIELDS(cust."Outstanding Balance",cust."Current Shares");
                BOSABal:=cust."Outstanding Balance";
                Deposits:=ABS(cust."Current Shares");
                CompanyCode:=cust."Employer Code";
                
                END;
                END;
                LAppl.RESET;
                LAppl.SETRANGE(LAppl."Client Code",Loans."Account No");
                LAppl.SETRANGE(LAppl."Loan Product Type",'SUPER');
                LAppl.SETFILTER(LAppl."Outstanding Balance",'>0');
                LAppl.SETRANGE(LAppl.Posted,TRUE);
                IF LAppl.FIND('-') THEN BEGIN
                REPEAT
                LAppl.CALCFIELDS(LAppl."Outstanding Balance");
                SuperBal:=SuperBal+LAppl."Outstanding Balance";
                UNTIL LAppl.NEXT=0;
                END;
                END;
                
                //Loans."Net Amount":=Loans."Approved Amount"-Loans."Top Up Amount";
                
                //Get The Loan Type
                */

                CompanyCode := '';
                if cust.Get(Loans."Member No.") then
                    CompanyCode := cust."Employer Code";

                LCount := LCount + 1;

                cust.Reset;
                cust.SetRange(cust."No.", Loans."Member No.");
                if cust.Find('-') then begin
                    Dob := cust."Date of Birth";
                    IDno := cust."ID No.";

                end;
                DepositBalance := MActivities.GetAccountBalance(Legacy.GetDepositAccounts("Member No."));
                OutLoanPeriod := 0;
                LSchedule.Reset();
                LSchedule.SetRange("Loan No.", "Loan No.");
                LSchedule.SetFilter("Repayment Date", '>=%1', Today);
                if LSchedule.FindFirst() then
                    OutLoanPeriod := LSchedule.Count;

            end;

            trigger OnPreDataItem()
            begin
                if LoanProdType.Get(Loans.GetFilter(Loans."Loan Product Type")) then
                    LoanType := LoanProdType.Description;
                LCount := 0;

                if Loans.GetFilter(Loans."Booking Branch") <> '' then begin
                    DValue.Reset;
                    DValue.SetRange(DValue."Global Dimension No.", 2);
                    DValue.SetRange(DValue.Code, Loans.GetFilter(Loans."Booking Branch"));
                    if DValue.Find('-') then
                        RFilters := 'Branch: ' + DValue.Name;

                end;
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
        CompanyInfo.Get();
        CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        OutLoanPeriod: Integer;
        DepositBalance: Decimal;
        Legacy: Codeunit Legacy;
        LSchedule: Record "Loan repayment schedule";
        SActivities: Codeunit "Sacco Activities";
        MActivities: Codeunit "Member Activities";
        RPeriod: Decimal;
        BatchL: Code[100];
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
        Loans_RegisterCaptionLbl: label 'Loans Register';
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
        IDno: Code[50];
        Dob: Date;
        vend: Record "Savings Accounts";
        CompanyInfo: Record "Company Information";
        Rho: Integer;
        Gender: Integer;
}

