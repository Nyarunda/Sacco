namespace UnitedWomen_Production.UnitedWomen_Production;

using Microsoft.Finance.GeneralLedger.Ledger;

report 50031 "GL Transactions By Channels"
{
    ApplicationArea = All;
    Caption = 'GL Transactions By Channels';
    ExcelLayout = 'Layouts/GL Transactions By Channels.xlsx';
    DefaultLayout = Excel;
    UsageCategory = History;
    dataset
    {
        dataitem(GLEntry; "G/L Entry")
        {
            column(GLAccountNo; "G/L Account No.")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(Description; Description)
            {
            }
            column(DocumentNo; "Document No.")
            {
            }
            column(GLAccountName; "G/L Account Name")
            {
            }
            column(Channel; Channel)
            {
            }
            column(Reversed; Reversed)
            {
            }
            column(BalAccountNo; "Bal. Account No.")
            {
            }
            column(BalAccountType; "Bal. Account Type")
            {
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
}
