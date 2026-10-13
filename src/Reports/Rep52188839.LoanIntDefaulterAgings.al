namespace UnitedWomen_Production.UnitedWomen_Production;
using Microsoft.Sales.Customer;
using Microsoft.HumanResources.Employee;

report 50541 "Loan Int Defaulter Agings"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loans Int Defaulter Aging.rdlc';

    dataset
    {
        dataitem(Loans; Loans)
        {

            CalcFields = "Loans Category-SASRA", "Outstanding Principal", "Outstanding Interest";


            DataItemTableView = WHERE(Posted = const(true),
                                      "Outstanding Principal" = FILTER(<> 0));

            RequestFilterFields = Source, "Loan Product Type", "Outstanding Principal", "Date Filter", "Global Dimension 1 Code";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; 0)
            {
            }
            column(USERID; USERID)
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
            column(ApprovedAmount_Loans; Loans."Approved Amount")
            {
            }
            column(Loans_Loans__Staff_No_; Loans."Staff No")
            {
            }
            column(Loans__Client_Name_; Loans."Member Name")
            {
            }
            column(Loans_Loans__Outstanding_Balance_; Loans."Outstanding Interest")
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
            column(Loans_Loans__Outstanding_Balance__Control1000000016; Loans."Outstanding principal")
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
            column(Loans__Loan__No__Caption; FIELDCAPTION("Loan No."))
            {
            }
            column(Loan_TypeCaption; Loan_TypeCaptionLbl)
            {
            }
            column(Staff_No_Caption; Staff_No_CaptionLbl)
            {
            }
            column(Loans__Client_Name_Caption; FIELDCAPTION("Member Name"))
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
                Loans.CALCFIELDS("Outstanding Interest");
                IF Loans."Outstanding Interest" > 0 THEN BEGIN

                    IF Loans."Loans Category-SASRA" = Loans."Loans Category-SASRA"::Performing THEN BEGIN
                        "0Month" := Loans."Outstanding Interest";
                        Over3MonthC := Over3MonthC + 1;

                    END ELSE IF Loans."Loans Category-SASRA" = Loans."Loans Category-SASRA"::Watch THEN BEGIN
                        "1Month" := Loans."Outstanding Interest";
                        "1MonthC" := "1MonthC" + 1;

                    END ELSE IF Loans."Loans Category-SASRA" = Loans."Loans Category-SASRA"::Substandard THEN BEGIN
                        "2Month" := Loans."Outstanding Interest";
                        "2MonthC" := "2MonthC" + 1;

                    END ELSE IF Loans."Loans Category-SASRA" = Loans."Loans Category-SASRA"::Doubtful THEN BEGIN
                        "3Month" := Loans."Outstanding Interest";
                        "3MonthC" := "3MonthC" + 1;

                    END ELSE IF Loans."Loans Category-SASRA" = Loans."Loans Category-SASRA"::Loss THEN BEGIN
                        Over3Month := Loans."Outstanding Interest";
                        Over3MonthC := Over3MonthC + 1;

                    END;
                END;

                GrandTotal := GrandTotal + Loans."Outstanding Interest";


                IF ("1Month" + "2Month" + "3Month" + Over3Month) > 0 THEN
                    NoLoans := NoLoans + 1;

                IF HREmployees.GET(Loans.Relationship) THEN
                    RelationManager := HREmployees."First Name" + '' + HREmployees."Middle Name" + '' + HREmployees."Last Name"
                ELSE
                    RelationManager := '';
            end;

            trigger OnPreDataItem()
            begin
                //CurrReport.CREATETOTALS("0Month", "1Month", "2Month", "3Month", Over3Month);
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
        Cust: Record Customer;
        "StaffNo.": Text[30];
        Deposits: Decimal;
        GrandTotal: Decimal;
        "0Month": Decimal;
        LoanProduct: Record "Product Setup";
        FirstMonthDate: Date;
        EndMonthDate: Date;
        Loans_Aging_Analysis__SASRA_CaptionLbl: Label 'Loans Aging Analysis (SASRA)';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Loan_TypeCaptionLbl: Label 'Loan Type';
        Staff_No_CaptionLbl: Label 'Staff No.';
        Oustanding_BalanceCaptionLbl: Label 'Oustanding Balance';
        PerformingCaptionLbl: Label 'Performing';
        V1___30_Days_CaptionLbl: Label '(1 - 30 Days)';
        V0_Days_CaptionLbl: Label '(0 Days)';
        WatchCaptionLbl: Label 'Watch';
        V31___180_Days_CaptionLbl: Label '(31 - 180 Days)';
        SubstandardCaptionLbl: Label 'Substandard';
        V181___360_Days_CaptionLbl: Label '(181 - 360 Days)';
        DoubtfulCaptionLbl: Label 'Doubtful';
        Over_360_DaysCaptionLbl: Label 'Over 360 Days';
        LossCaptionLbl: Label 'Loss';
        TotalsCaptionLbl: Label 'Totals';
        CountCaptionLbl: Label 'Count';
        Grand_TotalCaptionLbl: Label 'Grand Total';
        LossDate: Date;
        CountDays: Integer;
        "Amount Paid": Decimal;
        ExpectedRepayment: Decimal;
        DefaultedAmount: Decimal;
        HREmployees: Record Employee;
        RelationManager: Text;
}
