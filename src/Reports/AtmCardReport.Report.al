Report 50282 "Atm Card Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Atm Card Report.rdlc';

    dataset
    {
        dataitem("ATM Applications"; "ATM Applications")
        {
            RequestFilterFields = "Account No";
            column(ReportForNavId_1; 1)
            {
            }
            column(CName; Company.Name)
            {
            }
            column(CAddress; Company.Address)
            {
            }
            column(CPicture; Company.Picture)
            {
            }
            column(AccNo; "ATM Applications"."Account No")
            {
            }
            column(ProductType; "ATM Applications"."Account Type")
            {
            }
            column(AtmNo; "ATM Applications"."Card No")
            {
            }
            column(AccountName; "ATM Applications"."Account Name")
            {
            }
            column(CardIssuedBy; "ATM Applications"."Card Issued By")
            {
            }
            column(ApprovedBy; ApprovedBy)
            {
            }
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
        Company.Get;
        Company.CalcFields(Company.Picture);
    end;

    var
        ApprovedBy: Text;
        Company: Record "Company Information";
}

