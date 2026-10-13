namespace UnitedWomen_Production.UnitedWomen_Production;

using Microsoft.Purchases.Vendor;
using Microsoft.Finance.GeneralLedger.Account;

report 50035 "Vendor Listing Balance Report"
{
    ApplicationArea = All;
    Caption = 'Vendor Listing Balance eport';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Vendor Listing Balance Report.rdlc';

    dataset
    {
        dataitem("Vendor Posting Group"; "Vendor Posting Group")
        {
            RequestFilterFields = Code, "Payables Account";
            column(ReportForNavId_1; 1)
            {
            }
            column(Code_LoanProductsSetup; Code)
            {
            }
            column(ProductName; ProductName)
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

                ProductName := '';
                Acc := "Payables Account";


                if Acc = '' then
                    CurrReport.Skip;

                ListingBalance := 0;
                GLBalance := 0;

                Vendor.Reset;
                Vendor.SetRange("Vendor Posting Group", "Vendor Posting Group".Code);
                Vendor.SetFilter("Date Filter", '..%1', AsAt);
                if Vendor.FindFirst then begin
                    repeat
                        Vendor.CalcFields("Net Change (LCY)");
                        ListingBalance += Vendor."Net Change (LCY)";
                        ProductName += Vendor.Name + '';
                    until Vendor.Next = 0;
                end;



                GL.Reset;
                GL.SetRange("No.", Acc);
                GL.SetFilter("Date Filter", '..%1', AsAt);
                if GL.FindFirst then begin
                    GL.CalcFields("Net Change");
                    GLBalance := GL."Net Change";
                    GLBalance := GL."Net Change" * -1;
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
        Vendor: Record Vendor;
        Difference: Decimal;
        ProductName: Text;
        MemberAccounts: Record "Savings Accounts";
        Acc: Code[20];
        LoanLedger: Record "Credit Ledger Entry";
}

