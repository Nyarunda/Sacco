
Report 50356 "Loan Repayment Analysis"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loan Repayment Analysis.rdlc';

    dataset
    {
        dataitem(Loans; Loans)
        {
            RequestFilterFields = "Loan No.", "Repay Mode", "Employer Code", "Application Date", "Loan Product Type", "Member No.", Source;
            DataItemTableView = where(Posted = const(true));

            column(DefaultedPrincipal; DefaultedPrincipal)
            {
            }
            column(DefaultedInterest; DefaultedInterest)
            {
            }
            column(CurrentPrincipal; CurrentPrincipal)
            {
            }
            column(CurrentInterest; CurrentInterest)
            {
            }
            column(TotalExpectedPrincipal; TotalExpectedPrincipal)
            {
            }
            column(TotalExpectedInterest; TotalExpectedInterest)
            {
            }
            column(PrincipalPaid; PrincipalPaid)
            {
            }
            column(InterestPaid; InterestPaid)
            {
            }
            column(PrincipalVariance; PrincipalVariance)
            {
            }
            column(InterestVariance; InterestVariance)
            {
            }
            column(Repayment; Repayment)
            {
            }
            column(SecurityType; SecurityType)
            {
            }
            column(SecurityValue; SecurityValue)
            {
            }
            column(Total_Guaranteed; "Total Guaranteed")
            {
            }
            column(Member_Category; "Member Category")
            {
            }
            column(Last_Principal_Pay_Date; "Last Principal Pay Date")
            {
            }
            column(Repay_Mode; "Repay Mode")
            {
            }
            column(Debt_Collector; "Debt Collector")
            {
            }
            column(Debt_Collector_Name; "Debt Collector Name")
            {
            }
            column(Total_Arrears; "Total Arrears")
            {
            }
            column(Loan; "Schedule Repayment")
            {
            }
            column(Schedule_Interest; "Schedule Interest")
            {
            }
            column(EmpCode; EmpCode)
            {
            }
            column(EmpName; EmpName)
            {
            }
            column(RShipOfficer; RShipOfficer)
            {
            }
            column(BranchCode; BranchCode)
            {
            }
            column(InterestCalculationMethod_Loans; Loans."Interest Calculation Method")
            {
            }
            column(DisbursementDate_Loans; Format(Loans."Disbursement Date"))
            {
            }
            column(LastPayDate_Loans; Format(Loans."Last Pay Date"))
            {
            }
            column(ExpectedDateofCompletion_Loans; Format(Loans."Completion Date"))
            {
            }
            column(LoansCategorySASRA_Loans; Loans."Loans Category-SASRA")
            {
            }
            column(LoanNo_Loans; Loans."Loan No.")
            {
            }
            column(ApplicationDate_Loans; Loans."Application Date")
            {
            }
            column(LoanProductType_Loans; Loans."Loan Product Type")
            {
            }
            column(LoanProductTypeName_Loans; Loans."Loan Product Type Name")
            {
            }
            column(MemberNo_Loans; Loans."Member No.")
            {
            }
            column(CustomerCID; Loans."Form Serial No")
            {
            }
            column(MemberName_Loans; Loans."Member Name")
            {
            }
            column(Installemnt; Loans.Installments)
            {
            }
            column(RequestedAmount; Loans."Requested Amount")
            {
            }
            column(ApprovedAmount; Loans."Approved Amount")
            {
            }
            column(OutBal; Loans."Outstanding Principal")
            {
            }
            column(OutInt; Loans."Outstanding Interest")
            {
            }
            column(Picture; Company.Picture)
            {
            }
            column(Address; Company.Address)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(sno; sno)
            {
            }
            column(BridgeAmt; BridgeAmt)
            {
            }
            column(TotalLoanBal; Loans."Total Outstanding Balance")
            {
            }
            column(OutstandingPenalty_Loans; Loans."Outstanding Penalty")
            {
            }

            trigger OnAfterGetRecord()
            begin
                if SalaryDate = 0D then
                    Error('Enter SalaryDate Date');
                ;

                sno += 1;
                EmpCode := LoanS."Employer Code";
                EmpName := LoanS."Employer Name";

                if ("Disbursement Date" >= SalaryDate) then
                    CurrReport.Skip();

                if "Loan Account" = '' then begin
                    "Loan Account" := "Loan Product Type" + '-' + "Member No.";
                    Modify();
                end;
                LRec.Reset();

                LRec.get(Loans."Loan No.");
                LRec.CalcFields("Schedule Principal");

                if LRec."Schedule Principal" = 0 then begin
                    SAct.GenerateRepaymentSchedule(LRec);
                end;
                PSetup.Get("Loan Product Type");

                DefDate := CalcDate('-1M+CM', SalaryDate);
                CutOffDate := CalcDate('-CM+9D', SalaryDate);
                DefAmt := 0;


                if PSetup."Skip Salary Cutoff Date" then begin

                    if ("Disbursement Date" > DefDate) and ("Disbursement Date" < SalaryDate) then begin


                        LRec.SetFilter("Date Filter", '..%1', SalaryDate - 1);
                        LRec.CalcFields("Outstanding Principal", LRec."Outstanding Interest");
                        TotalExpectedPrincipal := LRec.Repayment - LRec."Outstanding Interest";
                        if TotalExpectedPrincipal > LRec."Outstanding Principal" then
                            TotalExpectedPrincipal := LRec."Outstanding Principal";
                    end
                    else begin
                        SAct.GetDefaultedAmountMinusOne(Loans."Loan No.", DefDate, ExpAmt, AmtPaid, DefAmt, DaysDef, ArrearsDate, SalaryDate - 1);
                    end;
                end
                else begin
                    //SAct.GetDefaultedAmountMinusOne(Loans."Loan No.", DefDate, ExpAmt, AmtPaid, DefAmt, DaysDef, ArrearsDate, SalaryDate - 1);
                    SAct.GetDefaultedAmountMinusOne(Loans."Loan No.", DefDate, ExpAmt, AmtPaid, DefAmt, DaysDef, ArrearsDate, SalaryDate - 1);
                end;


                if not PSetup."Skip Salary Cutoff Date" then
                    if "Disbursement Date" > CutOffDate then
                        CurrReport.Skip();


                if PSetup."Skip Salary Cutoff Date" then begin
                    if ("Disbursement Date" > DefDate) and ("Disbursement Date" < SalaryDate) then begin

                    end;
                end;


                LRec.SetFilter("Date Filter", '..%1', SalaryDate - 1);
                LRec.CalcFields("Outstanding Interest", "Outstanding Principal");

                TotalExpectedInterest := LRec."Outstanding Interest";
                DefaultedPrincipal := DefAmt;
                CurrentPrincipal := LRec.Repayment - LRec."Outstanding Interest";
                if CurrentPrincipal < 0 then
                    CurrentPrincipal := 0;


                TotalExpectedPrincipal := DefaultedPrincipal + CurrentPrincipal;

                if TotalExpectedPrincipal > LRec."Outstanding Principal" then
                    TotalExpectedPrincipal := LRec."Outstanding Principal";


                //if TotalExpectedInterest <= 0 then
                if TotalExpectedPrincipal <= 0 then
                    CurrReport.Skip();

                LRec.SetFilter("Date Filter", '%1..%2', CalcDate('-CM', SalaryDate), CalcDate('CM', SalaryDate));
                LRec.CalcFields("Principal Paid", "Interest Paid");
                PrincipalPaid := LRec."Principal Paid";
                InterestPaid := LRec."Interest Paid";


                PrincipalVariance := TotalExpectedPrincipal - PrincipalPaid;
                InterestVariance := TotalExpectedInterest - InterestPaid;




            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(SalaryDate; SalaryDate)
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
    end;

    var
        ProductType: Text;
        SecurityType: Text;
        SecurityValue: Decimal;
        EmpCode: Code[20];
        EmpName: Text;
        LoanSec: Record "Loan Security";
        PSetup: Record "Product Setup";
        MemberBiodata: Text;
        Company: Record "Company Information";
        sno: Integer;
        day: Integer;
        BridgeAmt: Decimal;
        RSchedule: Record "Loan Repayment Schedule";
        LRec: Record "Loans";
        Members: Record Members;
        RO: Text;
        SalaryDate: Date;
        DefDate: Date;
        StartDate: Date;
        CutOffDate: Date;
        MDep: Decimal;
        RShipOfficer: Code[20];
        Cust: Record Members;
        BranchCode: Text;
        SAct: Codeunit "Sacco Activities";

        DefaultedPrincipal: Decimal;
        DefaultedInterest: Decimal;
        CurrentPrincipal: Decimal;
        CurrentInterest: Decimal;
        TotalExpectedPrincipal: Decimal;
        TotalExpectedInterest: Decimal;
        PrincipalPaid: Decimal;
        InterestPaid: Decimal;
        PrincipalVariance: Decimal;
        InterestVariance: Decimal;
        ExpAmt: Decimal;
        AmtPaid: Decimal;
        DefAmt: Decimal;
        DaysDef: Integer;
        ArrearsDate: Date;
}

