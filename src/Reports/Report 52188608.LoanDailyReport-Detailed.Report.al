Report 50271 "Loan Daily Report - Detailed"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loan Daily Report - Detailed.rdlc';

    dataset
    {
        dataitem(Loans; Loans)
        {
            CalcFields = "Outstanding Principal", "Outstanding Interest", "Last Pay Date";
            DataItemTableView = where(Posted = const(true));
            RequestFilterFields = "Loan No.", "Member No.", "Loan Product Type";
            column(ReportForNavId_1; 1)
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
            column(OutBill; Loans."Principal Arrears")
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
            column(BridgeAmt; AmtPaid)
            {
            }
            column(PhoneNo; Cust."Mobile Phone No.")
            {
            }
            column(SDate; Format(SDate))
            {
            }
            column(EDate; Format(EDate))
            {
            }
            column(IntPaid; IntPaid)
            {
            }
            column(PenaltyPaid; PenaltyPaid)
            {
            }
            column(AppraisalPaid; AppraisalPaid)
            {
            }

            trigger OnAfterGetRecord()
            begin
                sno += 1;

                Cust.Get(Loans."Member No.");
                AmtPaid := 0;
                IntPaid := 0;
                PenaltyPaid := 0;
                AppraisalPaid := 0;

                LRec.Reset;
                LRec.SetRange("Loan No.", Loans."Loan No.");
                LRec.SetRange("Date Filter", SDate, EDate);
                LRec.SetFilter("Principal Paid", '>0');
                if LRec.Find('-') then begin
                    LRec.CalcFields("Principal Paid");
                    AmtPaid := LRec."Principal Paid";
                end;

                CLedger.Reset;
                CLedger.SetRange("Loan No.", Loans."Loan No.");
                CLedger.SetRange("Transaction Type", CLedger."transaction type"::"Interest Paid");
                CLedger.SetRange("Posting Date", SDate, EDate);
                if CLedger.FindFirst then begin
                    CLedger.CalcSums("Amount (LCY)");
                    IntPaid := CLedger."Amount (LCY)" * -1;
                end;

                CLedger.Reset;
                CLedger.SetRange("Loan No.", Loans."Loan No.");
                CLedger.SetRange("Transaction Type", CLedger."transaction type"::"Penalty Paid");
                CLedger.SetRange("Posting Date", SDate, EDate);
                if CLedger.FindFirst then begin
                    CLedger.CalcSums("Amount (LCY)");
                    PenaltyPaid := CLedger."Amount (LCY)" * -1;
                end;

                CLedger.Reset;
                CLedger.SetRange("Loan No.", Loans."Loan No.");
                CLedger.SetRange("Transaction Type", CLedger."transaction type"::"Appraisal Paid");
                CLedger.SetRange("Posting Date", SDate, EDate);
                if CLedger.FindFirst then begin
                    CLedger.CalcSums("Amount (LCY)");
                    AppraisalPaid := CLedger."Amount (LCY)" * -1;
                end;

                TPaid := AmtPaid + IntPaid + AppraisalPaid + PenaltyPaid;

                if TPaid = 0 then
                    CurrReport.Skip;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Start Date"; SDate)
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; EDate)
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
        ProductType: Text;
        MemberBiodata: Text;
        Company: Record "Company Information";
        sno: Integer;
        Credit: Record Customer;
        ProdFac: Record "Product Setup";
        LoansProcess: Codeunit "Sacco Activities";
        day: Integer;
        BridgeAmt: Decimal;
        SDate: Date;
        EDate: Date;
        LRec: Record Loans;
        AmtPaid: Decimal;
        Cust: Record Members;
        IntPaid: Decimal;
        PenaltyPaid: Decimal;
        AppraisalPaid: Decimal;
        TPaid: Decimal;
        CLedger: Record "Credit Ledger Entry";
}

