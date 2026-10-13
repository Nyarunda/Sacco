namespace UnitedWomen_Production.UnitedWomen_Production;

using Microsoft.Finance.GeneralLedger.Ledger;

query 50000 "GL Transacations Query"
{
    Caption = 'GL Transactions Query';
    QueryType = Normal;

    elements
    {
        dataitem(GLEntry; "Savings Ledger Entry")
        {
            DataItemTableFilter = Reversed = const(false), "Credit Amount" = filter(> 0);
            column(DocumentNo; "Document No.")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(Description; Description)
            {
            }
            column(Amount; Amount)
            {
            }
            column(Channel; Channel)
            {
            }
            column(User_ID; "User ID")
            {
            }
            column(CreditAmount; "Credit Amount (LCY)")
            {
            }
            column(Product_Category; "Product Category")
            {
            }
            column(Member_No_; "Member No.")
            {
            }


        }
    }


    trigger OnBeforeOpen()
    begin

    end;
}
