
Report 50296 "Debt Collection"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Debt Collection.rdlc';

    dataset
    {
        dataitem(Loans; Loans)
        {
            RequestFilterFields = "Loan No.", "Application Date", "Loan Product Type", "Member No.", Source, "Debt Collector Type", "Debt Collector", "Debt Coll. Date";
            DataItemTableView = where("Debt Collector" = filter(<> ''));

            column(ReportForNavId_1; 1)
            {
            }
            dataitem(CLedger; "Credit Ledger Entry")
            {
                DataItemLink = "Loan No." = field("Loan No.");
                DataItemTableView = where(Reversed = const(false), "Transaction Type" = filter("Principal Repayment" | "Interest Paid"), "User ID" = filter(<> ''), Amount = filter(<> 0), "Amount (LCY)" = filter(<> 0));

                column(Description; Description)
                {
                }
                column(Transaction_Type; "Transaction Type")
                {
                }
                column(Posting_Date; "Posting Date")
                {
                }
                column(AmountPaid; AmountPaid)
                {
                }
                column(RShipOfficer; RShipOfficer)
                {
                }
                column(Debt_Collector_Type; Loans."Debt Collector Type")
                {
                }
                column(Debt_Collector_Code; Loans."Debt Collector")
                {
                }
                column(Debt_Collector_Name; Loans."Debt Collector Name")
                {
                }
                column(Date_Assigned; Loans."Debt Coll. Date")
                {
                }
                column(Amount_Assigned; Loans."Debt Coll. Def Amount")
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

                trigger OnPreDataItem()
                begin
                    //SetRange("Posting Date", Loans."Debt Coll. Date", Today);
                end;

                trigger OnAfterGetRecord()
                begin

                    if "Posting Date" < SDAte then
                        CurrReport.Skip();

                    if "Posting Date" > EDAte then
                        CurrReport.Skip();

                    sno += 1;
                    Cust.Get(Loans."Member No.");
                    Loans.CalcFields("Outstanding Interest", "Outstanding Principal");


                    AmountPaid := 0;
                    DefAmount := 0;
                    CalcFields(Amount);

                    AmountPaid := Amount;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Start Date"; SDAte)
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; EDAte)
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
        SDAte: Date;
        EDAte: Date;
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
        SActivities: Codeunit "Sacco Activities";
}

