
Report 50229 "Product Int List Comparison"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Product Int List Comparison.rdlc';

    dataset
    {
        dataitem("Product Setup"; "Product Setup")
        {
            DataItemTableView = where("Product Class" = const(Credit));
            RequestFilterFields = "Product ID";
            column(ReportForNavId_1; 1)
            {
            }
            column(Code_LoanProductsSetup; "Product ID")
            {
            }
            column(ProductName; Description)
            {
            }
            column(GLBalance; GLBalance)
            {
            }
            column(ListingBalance; ListingBalance)
            {
            }
            column(Difference; Difference)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if "Product Setup"."Loan Interest Receivable [G/L]" = '' then
                    CurrReport.Skip;

                ListingBalance := 0;
                GLBalance := 0;

                Loans.Reset;
                Loans.SetRange("Loan Product Type", "Product Setup"."Product ID");
                Loans.SetFilter("Date Filter", '..%1', AsAt);
                if Loans.FindFirst then begin
                    repeat
                        Loans.CalcFields("Outstanding Interest", "Outstanding Penalty");
                        ListingBalance += Loans."Outstanding Interest" + Loans."Outstanding Penalty";
                    until Loans.Next = 0;
                end;




                GL.Reset;
                GL.SetRange("No.", "Product Setup"."Loan Interest Receivable [G/L]");
                GL.SetFilter("Date Filter", '..%1', AsAt);
                if GL.FindFirst then begin
                    GL.CalcFields("Net Change");
                    GLBalance := GL."Net Change";
                end;

                Difference := GLBalance - ListingBalance;

                //IF GLBalance <> ListingBalance THEN
                //MESSAGE('Product: %1\TB: %2\Listing %3\Difference %4',"Loan Products Setup"."Product Description",GLBalance,ListingBalance,Difference);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(AsAt; AsAt)
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

    var
        GLBalance: Decimal;
        ListingBalance: Decimal;
        AsAt: Date;
        GL: Record "G/L Account";
        Loans: Record Loans;
        Difference: Decimal;
        MemberAccounts: Record "Savings Accounts";
}

