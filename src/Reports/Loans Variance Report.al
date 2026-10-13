report 50099 "Loans Variance Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loans Variance Report.rdlc';

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = WHERE(Posted = CONST(true));
            RequestFilterFields = "Loan No.", "Application Date", "Loan Product Type", "Member No.", "Disbursement Date", Status, "Outstanding Principal", "Date Filter", "Employer Code";
            column(LoanNo_Loans; Loans."Loan No.")
            {
            }
            column(MemberNo_Loans; Loans."Member No.")
            {
            }
            column(MemberName_Loans; Loans."Member Name")
            {
            }
            column(LoanStatus; Loans.Status)
            {
            }
            column(LoanProductType_Loans; Loans."Loan Product Type")
            {
            }
            column(LoanProductTypeName_Loans; Loans."Loan Product Type Name")
            {
            }
            column(Employer; Loans."Employer Code")
            {
            }
            column(RequestedAmount; Loans."Requested Amount")
            {
            }
            column(ApprovedAmount; Loans."Approved Amount")
            {
            }
            column(Topup; TopUpAmnt)
            {
            }
            column(NetAmount; NetAmount)
            {
            }
            column(Installemnt; Loans.Installments)
            {
            }
            column(Repayment; Loans.Repayment)
            {
            }
            column(IssueDate; Loans."Disbursement Date")
            {
            }
            column(RepaymentStart; Loans."Repayment Start Date")
            {
            }
            column(OutInt; Loans."Outstanding Interest")
            {
            }
            column(OutBal; Loans."Outstanding Principal")
            {
            }
            column(ExpectedDateOf; Loans."Completion Date")
            {
            }
            column(Boosting; Loans."Deposit Boosting")
            {
            }
            column(ApplicationDate_Loans; Loans."Application Date")
            {
            }
            column(OutBill; '')
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
            column(ArrearsDays; ArrearsDays)
            {
            }
            column(Abbrev; ABBR)
            {
            }
            column(AbbrevC; ABBRC)
            {
            }
            column(PrincPay; Loans."Principal Paid")
            {
            }
            column(IntPay; Loans."Interest Paid")
            {
            }
            column(TotalPaid; Loans."Principal Paid" + Loans."Interest Paid")
            {
            }
            column(Variance; Variance)
            {
            }
            column(StaffNo_Loans; Loans."Staff No")
            {
            }
            column(Loan_princ; Loans."Loan Principle Repayment")
            {
            }
            column(Loan_Int; Loans."Loan Interest Repayment")
            {
            }
            column(Int_Due; Loans."Interest Due")
            {
            }
            column(Total_Expected; TotExp)
            {
            }
            column(CurrentOutstandingBalance_Loans; Loans."Outstanding Principal")
            {
            }
            column(Employer_Code; EmpCode)
            {
            }
            column(DisbursementDate_Loans; Loans."Disbursement Date")
            {
            }

            trigger OnAfterGetRecord()
            begin
                ArrearsDays := 0;
                TopUpAmnt := 0;
                NetAmount := 0;
                sno += 1;
                ABBR := '';
                ABBRC := '';
                Variance := 0;
                TotExp := 0;

                Loans.CALCFIELDS("Outstanding Principal", "Outstanding Interest", "Total Outstanding Balance");
                IF Loans.Installments <> 0 THEN
                    ArrearsDays := ROUND((((Loans."Outstanding Principal" - Loans.Repayment) / Loans.Installments) * 30), 1, '<');
                IF ArrearsDays < 0 THEN ArrearsDays := 0;


                Topup.RESET;
                Topup.SETRANGE(Topup."Loan No.", "Loan No.");
                IF Topup.FIND('-') THEN BEGIN
                    REPEAT
                        TopUpAmnt := TopUpAmnt + Topup."Total Top Up";
                    UNTIL
                    Topup.NEXT = 0;
                END;


                NetAmount := Loans."Approved Amount" - TopUpAmnt;


                IF ProdFac.GET(Loans."Loan Product Type") THEN BEGIN
                    ABBR := ProdFac.Description;
                END;

                /*
                IF Cust.GET(Loans."Employer Code") THEN BEGIN
                  ABBRC:=Cust."Employer Code";
                  END;
                  */
                /*
              TotExp:=Loans."Interest Due"+Loans."Loan Principle Repayment";
              Variance:=TotExp - (Loans."Current Repayments Minus Topup"+Loans."Interest Paid Minus Topup");
              */

                TotExp := Loans.Repayment;
                Variance := TotExp - (Loans."Principal Paid" + Loans."Interest Paid");


                IF Members.GET(Loans."Member No.") THEN BEGIN
                    EmpCode := Members."Employer Code";
                END;

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

    trigger OnPreReport()
    begin

        IF Loans.GETFILTER(Loans."Date Filter") = '' THEN
            ERROR('Please specify a date filter before proceeding');


        Company.GET;
        /*Company.CALCFIELDS(Company.Picture);*/

    end;

    var
        ProductType: Text;
        MemberBiodata: Text;
        Company: Record "Company Information";
        sno: Integer;
        ArrearsDays: Integer;
        Topup: Record "Loan Top Up";
        NetAmount: Decimal;
        TopUpAmnt: Decimal;
        ABBR: Code[35];
        ProdFac: Record "Product Setup";
        Cust: Record Customer;
        ABBRC: Code[35];
        Variance: Decimal;
        TotExp: Decimal;
        EmpCode: Code[20];
        Members: Record Members;
}

