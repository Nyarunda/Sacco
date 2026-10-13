Report 50274 "Loan Topup Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loan Topup Report.rdlc';

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
            column(InterestDue_Loans; Loans."Interest Due")
            {
            }
            column(DateFilter; DateFilter)
            {
            }
            column("Sum"; Sum)
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
            column(BridgeAmt; BridgeAmt)
            {
            }

            trigger OnAfterGetRecord()
            begin


                BridgeAmt := 0;
                Loans.CalcFields("Top Up Amount");
                BridgeAmt := Loans."Top Up Amount";
                /*
                TopUp.Reset;
                TopUp.SetRange("Loan No.", Loans."Loan No.");
                TopUp.SetRange("Member No.", Loans."Member No.");
                if TopUp.FindFirst then begin
                    TopUp.CalcSums("Total Top Up");
                    BridgeAmt := TopUp."Total Top Up";
                end;
                */

                if TopUpOnly then
                    if BridgeAmt = 0 then
                        CurrReport.Skip;

                sno += 1;
            end;

            trigger OnPreDataItem()
            begin

                if Summary then
                    Sum := 1
                else
                    Sum := 0;


                DateFilter := Loans.GetFilter("Disbursement Date");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Summary; Summary)
                {
                    ApplicationArea = Basic;
                }
                field("Top Up Only"; TopUpOnly)
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
        TopUp: Record "Loan Top Up";
        BridgeAmt: Decimal;
        "Sum": Integer;
        Summary: Boolean;
        DateFilter: Text;
        TopUpOnly: Boolean;
}

