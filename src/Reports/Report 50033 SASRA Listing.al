
Report 50033 "Sasra Listing"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Sasra Listing.rdlc';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem(Loans; Loans)
        {
            CalcFields = "Outstanding Principal", "Outstanding Interest";
            DataItemTableView = sorting("Loan No.") order(ascending) where(Posted = filter(true));
            RequestFilterFields = "Loan No.", "Loan Product Type", "Member No.";
            column(Employer_Code; "Employer Code")
            {
            }
            column(FOSAShares; FOSAShares)
            {
            }
            column(LoanCategory; Loans."Loans Category-Audit")
            {
            }
            column(Annual_Interest__; "Annual Interest %")
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
            column(Loan_Restructured; "Loan Restructured")
            {
            }
            column(BranchCode; BranchCode)
            {
            }
            column(Installments; Installments)
            {
            }
            column(Repayment_Frequency; "Repayment Frequency")
            {
            }
            column(SASRA_Days_Arrears; "SASRA Days Arrears")
            {
            }
            column(ArrearsSacco; Loans."Total Arrears")
            {
            }
            column(ArrearsSasra; Loans."SASRA Arrears")
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
            column(Loan_Product_Type_Name; "Loan Product Type Name")
            {
            }
            column(Loans_Loans__Staff_No_; Loans."Staff No")
            {
            }
            column(Loans__Client_Name_; Loans."Member Name")
            {
            }
            column(Loans_Loans__Outstanding_Balance_; Loans."Outstanding Principal")
            {
            }
            column(DOB; DOB)
            {
            }
            column(Gender; Gender)
            {
            }

            column(Loans_Loans__Outstanding_Balance__Control1000000016; Loans."Outstanding Principal")
            {
            }
            column(Loans__Approved_Amount_; "Approved Amount")
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
            column(Completion_Date; "Completion Date")
            {
            }
            column(Loans_Category_SASRA; "Loans Category-SASRA")
            {
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
                DOB := 0D;
                Gender := '';

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
                DOB := Cust."Date of Birth";
                Gender := Format(Cust.Gender);
                BranchCode := Cust."Global Dimension 2 Code";

                GrandTotal := GrandTotal + Loans."Outstanding Principal";


                //IF ("0Month"+"1Month"+"2Month"+"3Month"+Over3Month) > 0 THEN
                NoLoans := NoLoans + 1;

            end;

            trigger OnPostDataItem()
            begin
                //MESSAGE('%1',GrandTotal);
            end;

            trigger OnPreDataItem()
            begin

                GrandTotal := 0;
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

    var
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
        Gender: Text[20];
        Cust: Record Members;
        "StaffNo.": Text[30];
        Deposits: Decimal;
        GrandTotal: Decimal;
        "0Month": Decimal;
        DOB: Date;
        LoanProduct: Record "Product Setup";
        FirstMonthDate: Date;
        EndMonthDate: Date;
        Loans_Aging_Analysis__SASRA_CaptionLbl: label 'Loans Aging Analysis (SASRA)';
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



}

