
Report 50157 "End of Day Coinage Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/End of Day Coinage Report.rdlc';

    dataset
    {
        dataitem(TreasuryTeller; "Treasury/Teller Transactions")
        {
            RequestFilterFields = "No. Series", "Transaction Date", "Transaction Type", "From Account", "To Account";
            column(ReportForNavId_1000000001; 1000000001)
            {
            }
            column(Code_TreasuryTeller; TreasuryTeller.Code)
            {
            }
            column(Description_TreasuryTeller; TreasuryTeller.Description)
            {
            }
            column(TransactionDate_TreasuryTeller; TreasuryTeller."Date Received")
            {
            }
            column(TransactionType_TreasuryTeller; TreasuryTeller."Transaction Type")
            {
            }
            column(FromTill_TreasuryTeller; TreasuryTeller."From Till")
            {
            }
            column(ToTill_TreasuryTeller; TreasuryTeller."To Till")
            {
            }
            column(IssuedBy_TreasuryTransactions; "Issued By")
            {
            }
            column(ReceivedBy_TreasuryTransactions; "Received By")
            {
            }
            column(CompanyInfo_name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfoPic; CompanyInfo.Picture)
            {
            }
            dataitem(Coinage; Coinage)
            {
                DataItemLink = No = field(Code);
                RequestFilterFields = No, "Code";
                DataItemTableView = sorting(Code);
                column(ReportForNavId_1000000000; 1000000000)
                {
                }
                column(No_TreasuryCoinage; Code)
                {
                }
                column(Code_TreasuryCoinage; Code)
                {
                }
                column(Description_TreasuryCoinage; Description)
                {
                }
                column(Type_TreasuryCoinage; Type)
                {
                }
                column(Value_TreasuryCoinage; Value)
                {
                }
                column(Quantity_TreasuryCoinage; Quantity)
                {
                }
                column(TotalAmount_TreasuryCoinage; "Total Amount")
                {
                }
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
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
}

