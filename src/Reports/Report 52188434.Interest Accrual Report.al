
Report 50077 "Interest Accrual Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Interest Accrual Report.rdlc';

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where("Loan Product Type" = filter(<> ''));
            column(ReportForNavId_1; 1)
            {
            }
            column(IntDueDate; Format(IntDueDate))
            {
            }
            column(ProductBased; ProductBased)
            {
            }
            column(InterestDue_Loans; Loans."Interest Due")
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
            column(LoanProductType_Loans; Loans."Loan Product Type Name")
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
            column(OutBal; LBal)
            {
            }
            column(OutInt; Loans."Outstanding Interest")
            {
            }
            column(OutBill; Loans."Outstanding Penalty")
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

            trigger OnAfterGetRecord()
            begin
                sno += 1;

                if Loans."Disbursement Date" >= IntDueDate then
                    CurrReport.Skip;

                LBal := 0;
                IntDue := 0;

                ProductSetup.Get(Loans."Loan Product Type");
                if Loans."Loan Product Type Name" <> ProductSetup.Description then begin
                    Loans."Loan Product Type Name" := ProductSetup.Description;
                    Loans.Modify;
                end;

                LRec.Reset;
                LRec.SetRange("Loan No.", Loans."Loan No.");
                LRec.SetFilter("Date Filter", '..%1', CalcDate('-1D', IntDueDate));
                if LRec.FindFirst then begin
                    LRec.CalcFields("Outstanding Principal");
                    LBal := LRec."Outstanding Principal";
                end;


                LRec.Reset;
                LRec.SetRange("Loan No.", Loans."Loan No.");
                LRec.SetFilter("Date Filter", '%1', IntDueDate);
                if LRec.FindFirst then begin
                    LRec.CalcFields("Interest Due");
                    IntDue := LRec."Interest Due";
                end;
            end;

            trigger OnPreDataItem()
            begin

                if IntDueDate = 0D then
                    Error('Interest Due Date is Mandatory');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("IntDue Date"; IntDueDate)
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
        day: Integer;
        BridgeAmt: Decimal;
        ProductBased: Integer;
        Summary: Boolean;
        IntDueDate: Date;
        LBal: Decimal;
        IntDue: Decimal;
        LRec: Record Loans;
        ProductSetup: Record "Product Setup";
}

