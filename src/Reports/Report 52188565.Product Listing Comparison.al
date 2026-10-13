
Report 50228 "Product Listing Comparison"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Product Listing Comparison.rdlc';

    dataset
    {
        dataitem("Product Setup"; "Product Setup")
        {
            RequestFilterFields = "Product ID", "Product Class";
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


                if "Product Setup"."Product Category" = "Product Setup"."Product Category"::"Registration Fee" then
                    CurrReport.Skip();

                if "Product Setup"."Product Class" = "Product Setup"."product class"::Credit then
                    if "Product Setup"."Loan Account [G/L]" = '' then
                        CurrReport.Skip;


                Acc := "Loan Account [G/L]";


                if "Product Setup"."Product Class" = "Product Setup"."product class"::Savings then begin
                    if VendorPostingGroup.Get("Product Setup"."Product Posting Group") then
                        Acc := VendorPostingGroup."Receivables Account";

                end;
                if Acc = '' then
                    CurrReport.Skip;

                ListingBalance := 0;
                GLBalance := 0;

                Loans.Reset;
                Loans.SetRange("Loan Product Type", "Product Setup"."Product ID");
                Loans.SetFilter("Date Filter", '..%1', AsAt);
                if Loans.FindFirst then begin
                    repeat
                        Loans.CalcFields("Outstanding Principal");
                        ListingBalance += Loans."Outstanding Principal";
                    until Loans.Next = 0;
                end;




                MemberAccounts.Reset;
                MemberAccounts.SetRange("Product Type", "Product Setup"."Product ID");
                MemberAccounts.SetFilter("Date Filter", '..%1', AsAt);
                if MemberAccounts.FindFirst then begin
                    repeat
                        MemberAccounts.CalcFields("Net Change (LCY)");
                        ListingBalance += MemberAccounts."Net Change (LCY)";
                    until MemberAccounts.Next = 0;
                end;



                GL.Reset;
                GL.SetRange("No.", Acc);
                GL.SetFilter("Date Filter", '..%1', AsAt);
                if GL.FindFirst then begin
                    GL.CalcFields("Net Change");
                    GLBalance := GL."Net Change";
                    if "Product Setup"."Product Class" = "Product Setup"."product class"::Savings then
                        GLBalance := GL."Net Change" * -1;
                end;



                if "Product Setup"."Product Category" = "Product Setup"."Product Category"::"Dividend Account" then begin


                    GL.Reset;
                    GL.SetRange("No.", '200026');
                    GL.SetFilter("Date Filter", '..%1', AsAt);
                    if GL.FindFirst then begin
                        GL.CalcFields("Net Change");
                        if "Product Setup"."Product Class" = "Product Setup"."product class"::Savings then
                            GLBalance += GL."Net Change" * -1;
                    end;
                end;


                Difference := GLBalance - ListingBalance;

                //IF GLBalance <> ListingBalance THEN
                //MESSAGE('Product: %1\TB: %2\Listing %3\Difference %4',"Loan Products Setup"."Product Description",GLBalance,ListingBalance,Difference);
            end;

            trigger OnPreDataItem()
            begin
                if AsAt = 0D then
                    AsAt := Today;
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
        Acc: Code[20];
        VendorPostingGroup: Record "Customer Posting Group";
        LoanLedger: Record "Credit Ledger Entry";
}

