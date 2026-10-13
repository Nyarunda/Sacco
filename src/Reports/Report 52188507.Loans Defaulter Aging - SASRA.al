
Report 50170 "Loans Defaulter Aging - SASRA"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loans Defaulter Aging - SASRA.rdlc';

    dataset
    {
        dataitem(Loans; Loans)
        {
            //CalcFields = "Outstanding Principal", "Outstanding Interest";
            DataItemTableView = where(Posted = const(true));
            RequestFilterFields = "Loan No.", "Loan Product Type", "Member No.";
            column(Employer_Code; "Employer Code")
            {
            }
            column(Employer_Name; "Employer Name")
            {
            }
            column(FOSAShares; FOSAShares)
            {
            }
            column(LoanCategory; Loans."Loans Category-SASRA")
            {
            }
            column(FosaDeposits; FosaDeposits)
            {
            }
            column(ReportForNavId_4645; 4645)
            {
            }
            column(IFRS_Stage; IFRS_Stage)
            {
            }
            column(ECL; ECL)
            {
            }
            column(DisbursementDate_Loans; Loans."Disbursement Date")
            {
            }
            column(PhoneNo; PhoneNo)
            {
            }
            column(TotalArrears_Loans; SASRACategory."Total Arrears")
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
            column(Debt_Collector_Name; "Debt Collector Name")
            {
            }
            column(MemberDeposits; MemberDeposits)
            {
            }
            column(ArrearsSacco; SASRACategory."Total Arrears")
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
            column(Loans_Loans__Staff_No_; Loans."Staff No")
            {
            }
            column(Loans__Client_Name_; Loans."Member Name")
            {
            }
            column(Requested_Amount; "Requested Amount")
            {
            }
            column(Approved_Amount; "Approved Amount")
            {
            }
            column(Loan_Interest_Repayment; "Loan Interest Repayment")
            {
            }
            column(Repayment; Repayment)
            {
            }
            column(Last_Pay_Date; "Last Pay Date")
            {
            }
            column(TotalOutstandingBalance_Loans; Loans."Total Outstanding Balance")
            {
            }
            column(Loans_Loans__Outstanding_Balance_; Loans."Outstanding Principal")
            {
            }
            column(Interest_Paid; "Interest Paid")
            {
            }
            column(Annual_Interest__; "Annual Interest %")
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
            column(Loan_Product_Type_Name; "Loan Product Type Name")
            {
            }
            column(Outstanding_Interest; "Outstanding Interest")
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
            column(Loan_Rescheduled; "Loan Rescheduled")
            {
            }
            column(Completion_Date; "Completion Date")
            {
            }
            column(Installment_Period; Loans.Installments)
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
            column(DividendBal; MemberDetails[7])
            {
            }
            column(CollateralValue; MemberDetails[8])
            {
            }
            column(Loan_Principle_Repayment; "Loan Principle Repayment")
            {
            }
            column(Principal_Arrears; "Principal Arrears")
            {
            }
            column(Principal_Paid; "Principal Paid")
            {
            }
            column(PrincExpected; PrincExpected)
            {
            }
            column(DaysArrears; DaysArrears)
            {
            }

            trigger OnAfterGetRecord()
            var
                i: Integer;
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
                PrincExpected := 0;
                DaysArrears := 0;

                //UpdateSasra;


                Cust.Get(Loans."Member No.");

                PhoneNo := Cust."Mobile Phone No.";

                RO := Cust."Relationship Officer Name";
                BranchCode := Cust."Global Dimension 2 Code";
                for i := 1 to 10 do
                    MemberDetails[i] := '';

                MemberDetails[1] := Cust."ID No.";
                MemberDetails[2] := Format(Cust."Registration Date");
                MemberDetails[3] := Format(Cust."Date of Birth");
                MemberDetails[4] := Cust."E-Mail";

                LSecurity.Reset();
                LSecurity.SetRange("Loan No.", Loans."Loan No.");
                LSecurity.SetRange("Guarantor Type", LSecurity."Guarantor Type"::Collateral);
                if LSecurity.FindSet(false) then
                    repeat
                        if Security.Get(LSecurity."Collateral Reg. No.") then;
                        MemberDetails[5] := Format(Security."Collateral Type");
                        MemberDetails[6] := Format(LSecurity."Collateral Reg. No.");
                        MemberDetails[8] := Format(Security."Collateral Value");
                    until LSecurity.Next() = 0;

                MemberDeposits := 0;
                IFRS_Stage := '';
                ECL := 0;
                if not SASRACategory.Get(Loans."Loan No.", UserId) then
                    CurrReport.Skip
                else begin

                    IFRS_Stage := format(SASRACategory."IFRS Stage");
                    ECL := SASRACategory.ECL;

                    Loans.CalcFields("Loans Category-SASRA", "Principal Arrears");

                    //Loans."Outstanding Principal" := SASRACategory."Outstanding Principal";
                    Loans."Principal Paid" := SASRACategory."Principal Paid";
                    Loans."Interest Paid" := SASRACategory."Interest Paid";


                    if Loans."Loans Category-SASRA" = Loans."Loans Category-SASRA"::Performing then begin
                        "0Month" := Loans."Outstanding Principal";
                        "0MonthC" := "0MonthC" + 1;

                    end else
                        if Loans."Loans Category-SASRA" = Loans."Loans Category-SASRA"::Watch then begin
                            "1Month" := Loans."Outstanding Principal";
                            "1MonthC" := "1MonthC" + 1;

                        end else
                            if Loans."Loans Category-SASRA" = Loans."Loans Category-SASRA"::Substandard then begin
                                "2Month" := Loans."Outstanding Principal";
                                "2MonthC" := "2MonthC" + 1;

                            end else
                                if Loans."Loans Category-SASRA" = Loans."Loans Category-SASRA"::Doubtful then begin
                                    "3Month" := Loans."Outstanding Principal";
                                    "3MonthC" := "3MonthC" + 1;

                                end else
                                    if Loans."Loans Category-SASRA" = Loans."Loans Category-SASRA"::Loss then begin
                                        Over3Month := Loans."Outstanding Principal";
                                        Over3MonthC := Over3MonthC + 1;

                                    end;
                end;

                GrandTotal := GrandTotal + Loans."Outstanding Principal";
                PrincExpected := SASRACategory."Principal Expected";
                DaysArrears := SASRACategory."Days in Arrears";

                //IF ("0Month"+"1Month"+"2Month"+"3Month"+Over3Month) > 0 THEN
                NoLoans := NoLoans + 1;


                /*
                if HREmployees.Get(Loans.Relationship) then
                    RelationManager := HREmployees."First Name" + '' + HREmployees."Middle Name" + '' + HREmployees."Last Name"
                else
                    RelationManager := '';
                */


                FosaDeposits := MActivities.GetAccountBalance(Legacy.GetOrdinaryAccount(Loans."Member No."));
                FOSAShares := MActivities.GetAccountBalance(Legacy.GetShareCapitalAccount(Loans."Member No."));
                MemberDetails[7] := Format(MActivities.GetAccountBalance(Legacy.GetDividendAccount(Loans."Member No.")));
                MDep := MActivities.GetAccountBalance(Legacy.GetDepositAccounts(Loans."Member No."));
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
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        IFRS_Stage: Text;
        ECL: Decimal;
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
        i: Integer;
        MemberDetails: array[10] of Text[50];
        Security: Record "Loan Collateral Register";
        LSecurity: Record "Loan Security";
        LoanProduct: Record "Product Setup";
        FirstMonthDate: Date;
        EndMonthDate: Date;
        Loans_Aging_Analysis__SASRA_CaptionLbl: label 'Loans Aging Analysis (SASRA)';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Loan_TypeCaptionLbl: label 'Loan Type';
        Staff_No_CaptionLbl: label 'Staff No.';
        Oustanding_BalanceCaptionLbl: label 'Oustanding Balance';
        PerformingCaptionLbl: label 'Performing';
        V1___30_Days_CaptionLbl: label '(31 - 60 Days)';
        V0_Days_CaptionLbl: label '(0 - 30 Days)';
        WatchCaptionLbl: label 'Watch';
        V31___180_Days_CaptionLbl: label '(61 - 180 Days)';
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
        SASRACategory: Record "Sasra Categorization";
        MemberDeposits: Decimal;
        SavingsAccounts: Record "Savings Accounts";
        Arrears: Decimal;
        BranchCode: Code[10];
        RO: Text;
        MDep: Decimal;
        RShipOfficer: Code[20];
        PrincExpected: decimal;
        DaysArrears: Decimal;
        FOSAShares: Decimal;
        FosaDeposits: Decimal;
        LoanCategory: Text;
        MActivities: Codeunit "Member Activities";
        Legacy: Codeunit Legacy;
        UNAme: Code[50];
}

