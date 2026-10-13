report 50383 "Fuuza Interest Report"
{
    Caption = 'Fuuza Interest Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Fuuza Interest Report.rdlc';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Fuuza Interest Buffer"; "Fuuza Interest Buffer")
        {
            RequestFilterFields = "Interest Date";

            column(AccountNo; FosaAccount."No.")
            {
            }
            column(AccountName; FosaAccount.name)
            {
            }
            column(FOSA_Account; FosaAccount."No.")
            {
            }
            column(Product_Name; FosaAccount."Product Name")
            {
            }
            column(Virtual_Balance__LCY_; FosaAccount."Virtual Balance (LCY)")
            {
            }
            column(Interest_Rate; "Interest Rate")
            {
            }
            column(Interest_Amount; "Interest Amount")
            {
            }
            column(Interest_Date; "Interest Date")
            {
            }
            column(Account_Balance; "Account Balance")
            {
            }
            column(MemberNo; FosaAccount."Member No.")
            {
            }
            column(FOSAAccount; FosaAccount."No.")
            {
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin

                FosaAccount.reset;
                FosaAccount.SetRange("Virtual Account No.", "Account No");
                FosaAccount.FindFirst();
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        VirtualRec: Record "Savings Accounts";
        FosaAccount: Record "Savings Accounts";
}
