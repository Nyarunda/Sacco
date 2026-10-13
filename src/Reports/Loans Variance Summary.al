report 50045 "Loans Variance Summary"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loans Variance Summary.rdlc';

    dataset
    {
        dataitem(Customer; Customer)
        {
            //DataItemTableView = WHERE(Account Type=CONST(Employer));
            RequestFilterFields = "No.", "Date Filter";
            column(CI_Picture; CompanyInformation.Picture)
            {
            }
            column(CI_Name; CompanyInformation.Name)
            {
            }
            column(CI_Address; CompanyInformation.Address)
            {
            }
            column(No_Customer; Customer."No.")
            {
            }
            column(Name_Customer; Customer.Name)
            {
            }
            column(Principal; Principal)
            {
            }
            column(Interest; Interest)
            {
            }
            column(TotalExpected; TotalExpected)
            {
            }

            trigger OnAfterGetRecord()
            begin
                InitializeVariables;
                Loans.RESET;
                Loans.SETRANGE(Loans."Employer Code", Customer."No.");
                //Loans.SETFILTER("Date Filter",'%1',Customer."Date Filter");
                //Loans.SETRANGE("Date Filter",Customer."Date Filter");
                Loans.SETRANGE(Loans.Posted, TRUE);
                Loans.SETFILTER("Outstanding Principal", '>%1', 0);
                IF DisbursementDate <> 0D THEN
                    Loans.SETFILTER("Disbursement Date", '..%1', DisbursementDate);
                IF Loans.FINDFIRST THEN BEGIN
                    Loans.CALCSUMS("Loan Principle Repayment");
                    Loans.CALCSUMS("Loan Interest Repayment");
                    Loans.CALCSUMS(Repayment);
                    Principal += Loans."Loan Principle Repayment";
                    Interest += Loans."Loan Interest Repayment";
                    TotalExpected += (Loans."Loan Principle Repayment" + Loans."Loan Interest Repayment");
                END;
            end;

            trigger OnPreDataItem()
            begin

                IF Customer.GETFILTER("Date Filter") = '' THEN
                    ERROR(Text000);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Select)
                {
                    Caption = 'Select';
                    field("Disbursement Date"; DisbursementDate)
                    {
                        ApplicationArea = All;
                    }
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
        CompanyInformation.GET;
        CompanyInformation.CALCFIELDS(Picture);
    end;

    var
        CompanyInformation: Record "Company Information";
        Loans: Record Loans;
        Principal: Decimal;
        Interest: Decimal;
        Repayment: Decimal;
        Text000: Label 'Kindly specify the date filter before proceeding';
        TotalExpected: Decimal;
        DisbursementDate: Date;

    local procedure InitializeVariables()
    begin
        Principal := 0;
        Interest := 0;
        Repayment := 0;
        TotalExpected := 0
    end;
}

