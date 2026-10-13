
Report 50335 "Debt Collector Allocation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Debt Collector Allocation.rdlc';

    dataset
    {
        dataitem(Loans; Loans)
        {
            RequestFilterFields = "Loan No.", "Application Date", "Loan Product Type", "Member No.", Source, "Debt Collector Type", "Debt Collector", "Debt Coll. Date";
            DataItemTableView = where("Debt Collector" = filter(<> ''));

            column(ReportForNavId_1; 1)
            {
            }
            column(AmountPaid; AmountPaid)
            {
            }
            column(RShipOfficer; RShipOfficer)
            {
            }
            column(Debt_Collector_Type; "Debt Collector Type")
            {
            }
            column(Debt_Collector_Code; "Debt Collector")
            {
            }
            column(Debt_Collector_Name; "Debt Collector Name")
            {
            }
            column(Date_Assigned; "Debt Coll. Date")
            {
            }
            column(Amount_Assigned; "Debt Coll. Def Amount")
            {
            }
            column(CurrentDefaultedBalance; DefAmount)
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

                sno += 1;
                Cust.Get(Loans."Member No.");
                AmountPaid := 0;
                DefAmount := 0;
                Loans.CalcFields("Outstanding Interest");

                SActivities.GetDefaultedAmount(Loans."Loan No.", Today, ExpectedAmt, AmtPaid, DefAmount, DaysInArrear, ArrearsDate, true, GracePeriod);
                DefAmount += Loans."Outstanding Interest";

                LRec.Reset();
                LRec.SetRange("Loan No.", "Loan No.");
                LRec.setfilter("Date Filter", '%1..', "Debt Coll. Date");
                if LRec.FindFirst() then begin
                    LRec.CalcFields("Principal Paid", "Interest Paid");
                    AmountPaid := LRec."Principal Paid" + LRec."Interest Paid";
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
                field("Repayment Day"; day)
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
        Company.Get;
        Company.CalcFields(Company.Picture);
    end;

    var
        AmountPaid: Decimal;
        LRec: Record loans;
        ProductType: Text;
        ExpectedAmt: Decimal;
        AmtPaid: Decimal;
        DefAmount: Decimal;
        DaysInArrear: Integer;
        ArrearsDate: Date;

        MemberBiodata: Text;
        Company: Record "Company Information";
        sno: Integer;
        day: Integer;
        BridgeAmt: Decimal;
        RSchedule: Record "Loan Repayment Schedule";
        TopUp: Record "Loan Top Up";
        Members: Record Members;
        RO: Text;
        MDep: Decimal;
        RShipOfficer: Code[20];
        Cust: Record Members;
        BranchCode: Text;
        GracePeriod: DateFormula;
        SActivities: Codeunit "Sacco Activities";
}

