
Report 50171 "Loans Defaulter Aging - SACCO"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loans Defaulter Aging - SACCO.rdlc';

    dataset
    {
        dataitem(Loans; Loans)
        {
            //CalcFields = "Outstanding Principal", "Outstanding Interest";
            //DataItemTableView = where("Loan No." = filter(<> ''), Posted = const(true), "Outstanding Principal" = filter(> 0));
            DataItemTableView = where(Posted = const(true));
            RequestFilterFields = "Loan No.", "Loan Product Type", "Member No.";
            column(Employer_Code; "Employer Code")
            {
            }
            column(FOSAShares; FOSAShares)
            {
            }
            column(LoanCategory; Loans."Loans Category-SACCO")
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
            column(RO; RO)
            {
            }
            column(BranchCode; BranchCode)
            {
            }
            column(MemberDeposits; MemberDeposits)
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
            column(Debt_Collector_Name; "Debt Collector Name")
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
            column(Loans_Loans__Outstanding_Balance_; Loans."Outstanding Principal")
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
            column(Loans_Loans__Outstanding_Balance__Control1000000016; Loans."Outstanding Principal")
            {
            }
            column(Loans_Loans__Outstanding_Interest__Control1000000016; Loans."Outstanding Interest")
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
            column(Completion_Date; "Completion Date")
            {
            }
            column(Installment_Period; "Installment Period")
            {
            }
            column(Appraised_By; "Appraised By")
            {
            }
            column(Repayment_Start_Date; "Repayment Start Date")
            {
            }
            column(Self_Guaranteed; "Self Guaranteed")
            {
            }
            column(id_No; MemberDetails[1])
            {
            }
            column(Reg_Date; MemberDetails[2])
            {
            }
            column(Dob; MemberDetails[3])
            {
            }
            column(Email; MemberDetails[4])
            {
            }
            column(Collateral_type; MemberDetails[5])
            {
            }
            column(Collateral_Reg_No; MemberDetails[6])
            {
            }

            trigger OnAfterGetRecord()
            begin
                "0Month" := 0;
                "1Month" := 0;
                "2Month" := 0;
                "3Month" := 0;
                Over3Month := 0;
                "Amount Paid" := 0;
                CountDays := 0;
                ExpectedRepayment := 0;
                BranchCode := '';
                RO := '';
                for i := 1 to 10 do
                    MemberDetails[i] := '';

                Cust.Get(Loans."Member No.");

                PhoneNo := Cust."Mobile Phone No.";
                MemberDetails[1] := Cust."ID No.";
                MemberDetails[2] := Format(Cust."Registration Date");
                MemberDetails[3] := Format(Cust."Date of Birth");
                MemberDetails[4] := Cust."E-Mail";

                LSecurity.Reset();
                LSecurity.SetRange("Loan No.", Loans."Loan No.");
                LSecurity.SetRange("Guarantor Type", LSecurity."Guarantor Type"::Collateral);
                if LSecurity.FindSet(false) then
                    repeat
                        Security.Get(LSecurity."Collateral Reg. No.");
                        MemberDetails[5] := Format(Security."Collateral Type");
                        MemberDetails[6] := Format(LSecurity."Collateral Reg. No.");
                    until LSecurity.Next() = 0;



                RO := Cust."Relationship Officer Name";
                BranchCode := Cust."Global Dimension 2 Code";

                MemberDeposits := 0;

                if not SASRACategory.Get(Loans."Loan No.", UNAme) then
                    CurrReport.Skip
                else begin

                    Loans.CalcFields("Loans Category-SACCO");

                    Loans."Outstanding Principal" := SASRACategory."Total Outstanding Balance";

                    if Loans."Loans Category-SACCO" = Loans."loans category-sacco"::Perfoming then begin
                        "0Month" := Loans."Outstanding Principal";
                        "0MonthC" := "0MonthC" + 1;

                    end else
                        if Loans."Loans Category-SACCO" = Loans."loans category-sacco"::Watch then begin
                            "1Month" := Loans."Outstanding Principal";
                            "1MonthC" := "1MonthC" + 1;

                        end else
                            if Loans."Loans Category-SACCO" = Loans."loans category-sacco"::Substandard then begin
                                "2Month" := Loans."Outstanding Principal";
                                "2MonthC" := "2MonthC" + 1;

                            end else
                                if Loans."Loans Category-SACCO" = Loans."loans category-sacco"::Doubtful then begin
                                    "3Month" := Loans."Outstanding Principal";
                                    "3MonthC" := "3MonthC" + 1;

                                end else
                                    if Loans."Loans Category-SACCO" = Loans."loans category-sacco"::Loss then begin
                                        Over3Month := Loans."Outstanding Principal";
                                        Over3MonthC := Over3MonthC + 1;

                                    end;
                end;

                GrandTotal := GrandTotal + Loans."Outstanding Principal";


                //IF ("0Month"+"1Month"+"2Month"+"3Month"+Over3Month) > 0 THEN
                NoLoans := NoLoans + 1;

                if HREmployees.Get(Loans.Relationship) then
                    RelationManager := HREmployees."First Name" + '' + HREmployees."Middle Name" + '' + HREmployees."Last Name"
                else
                    RelationManager := '';

                MDep := 0;


                FosaDeposits := MActivities.GetAccountBalance(Legacy.GetOrdinaryAccount(Loans."Member No."));
                FOSAShares := MActivities.GetAccountBalance(Legacy.GetShareCapitalAccount(Loans."Member No."));
                MDep := MActivities.GetAccountBalance(Legacy.GetDepositAccounts(Loans."Member No."));


            end;

            trigger OnPostDataItem()
            begin
                //MESSAGE('%1',GrandTotal);
            end;

            trigger OnPreDataItem()
            var

            begin
                SASRACategory.Reset();
                SASRACategory.SetRange("User Name", '<>%1', '');
                if SASRACategory.FindFirst() then
                    UNAme := SASRACategory."User Name"
                else begin

                    //Report.Run(Report::"SACCO Loan Categorization", false, false);
                    UNAme := UserId;
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
        Cust: Record Members;
        "StaffNo.": Text[30];
        Deposits: Decimal;
        GrandTotal: Decimal;
        "0Month": Decimal;
        LoanProduct: Record "Product Setup";
        FirstMonthDate: Date;
        EndMonthDate: Date;
        i: Integer;
        MemberDetails: array[10] of Text[50];
        Security: Record "Loan Collateral Register";
        LSecurity: Record "Loan Security";
        Loans_Aging_Analysis__SASRA_CaptionLbl: label 'Loans Aging Analysis (SACCO)';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Loan_TypeCaptionLbl: label 'Loan Type';
        Staff_No_CaptionLbl: label 'Staff No.';
        Oustanding_BalanceCaptionLbl: label 'Oustanding Balance';
        PerformingCaptionLbl: label 'Performing';
        V1___30_Days_CaptionLbl: label '(31 - 60 Days)';
        V0_Days_CaptionLbl: label '(0 - 30 Days)';
        WatchCaptionLbl: label 'Watch';
        V31___180_Days_CaptionLbl: label '(61 - 90 Days)';
        SubstandardCaptionLbl: label 'Substandard';
        V181___360_Days_CaptionLbl: label '(91 - 120 Days)';
        DoubtfulCaptionLbl: label 'Doubtful';
        Over_360_DaysCaptionLbl: label 'Over 121 Days';
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
        UNAme: Code[50];
}

