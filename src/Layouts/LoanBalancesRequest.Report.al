Report 50309 "Loan Balances Request"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loan Balances Request.rdlc';

    dataset
    {
        dataitem(Loans; Loans)
        {
            CalcFields = "Outstanding Interest";
            DataItemTableView = where("Outstanding Principal" = filter(> 0));
            RequestFilterFields = "Member No.";
            column(ReportForNavId_1; 1)
            {
            }
            column(Balances; Loans."Total Outstanding Balance")
            {
            }
            column(Princ; Princ)
            {
            }
            column(Ints; Ints)
            {
            }
            column(InstallmentAmt; InstallmentAmt)
            {
            }
            column(Interest_Arrears; InterestArrears)
            {
            }
            column(Principle_Arrears; PrincipalArrears)
            {
            }
            column(OutsInt; Loans."Outstanding Interest")
            {
            }
            column(Description; ProdName)
            {
            }
            column(Period_Remaining; PeriodRemaining)
            {
            }
            column(CurrDate; Today)
            {
            }
            column(SACCOACC; Loans."Loan No.")
            {
            }
            column(Name; Loans."Member Name")
            {
            }
            column(MemberNo; Loans."Member No.")
            {
            }
            column(Date_; Today)
            {
            }
            column(User; UserId)
            {
            }
            column(StaffNo; Loans."Staff No")
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(expRep; ExpectedRepayment)
            {
            }

            trigger OnAfterGetRecord()
            begin
                PeriodRemaining := 0;
                InterestArrears := 0;
                InstallmentAmt := 0;
                Princ := 0;
                Ints := 0;
                ProdName := '';

                if ProdFac.Get(Loans."Loan Product Type") then begin
                    ProdName := ProdFac."Description";
                end;
                /*
                Loans.RESET;
                Loans.SETRANGE(Loans."Loan Account",Loans."No.");
                Loans.SETRANGE(Loans.Posted,TRUE);
                Loans.SETFILTER(Loans."Outstanding Balance",'>0');
                IF Loans.FIND('-') THEN BEGIN
                Loans.CALCFIELDS(Loans."Outstanding Balance",Loans."Oustanding Interest",Loans."Current Repayment",Loans."Cummulative Billed Principle");
                   //IF Loans."Outstanding Balance">100 THEN BEGIN
                      Ints:=ROUND(Loans."Outstanding Balance"*Loans.Interest/1200)+Loans."Oustanding Interest";
                
                       //MESSAGE('Calc Int %1 Outs Int %2',Ints,Loans."Oustanding Interest");
                IF Loans."Loan Span"=Loans."Loan Span"::"Long Term" THEN BEGIN
                //IF "Expected Date of Completion"<>0D THEN
                //RemPeriod:=ROUND(("Expected Date of Completion"-TODAY)/30,1,'<');
                ExpectedRepayment:=Loans.Repayment-(Loans."Outstanding Balance"*Loans.Interest*0.01/12);
                END ELSE BEGIN
                //RemPeriod:=ROUND("Outstanding Balance"/Repayment,1,'<');
                ExpectedRepayment:=Loans.Repayment;//+"Oustanding Interest";
                END;
                END;
                */


                Loans.CalcFields(Loans."Outstanding Principal", Loans."Outstanding Interest");
                Ints := Loans."Outstanding Principal" + Loans."Outstanding Interest";
                Ints := Ints * -1;

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
        Company.Get();
        Company.CalcFields(Company.Picture);
    end;

    var
        ProdFac: Record "Product Setup";
        ProdName: Text;
        Princ: Decimal;
        Ints: Decimal;
        InstallmentAmt: Decimal;
        PrincipalArrears: Decimal;
        InterestArrears: Decimal;
        PeriodRemaining: Decimal;
        Company: Record "Company Information";
        OustInt: Decimal;
        ExpectedRepayment: Decimal;
}

