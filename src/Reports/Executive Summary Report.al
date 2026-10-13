report 50049 "Executive Summary Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Executive Summary Report.rdlc';

    dataset
    {
        /*
        dataitem(DataItem1;Table39004076)
        {
            RequestFilterFields = "Date Filter";
            column(CompName;COMPANYNAME)
            {
            }
            column(Tdate;FORMAT(TODAY,0,4))
            {
            }
            column(UserID;USERID)
            {
            }
            column(DateFilter;"Executive Report"."Date Filter")
            {
            }
            column(JVDeposits;"Executive Report"."JV Deposits")
            {
            }
            column(JVWithdrawals;"Executive Report"."JV Withdrawals")
            {
            }
            column(CashDeposits;"Executive Report"."Cash Deposits")
            {
            }
            column(ChequeDeposits;"Executive Report"."Cheque Deposits")
            {
            }
            column(PaybillDeposits;"Executive Report"."Paybill Deposits")
            {
            }
            column(ATMDeposits;"Executive Report"."ATM Deposits")
            {
            }
            column(CashWithdrawals;"Executive Report"."Cash Withdrawals")
            {
            }
            column(BankersCheques;"Executive Report"."Bankers Cheques")
            {
            }
            column(EFTPayments;"Executive Report"."EFT Payments")
            {
            }
            column(ATMWithdrawals;"Executive Report"."ATM Withdrawals")
            {
            }
            column(MNdegeWithdrawals;"Executive Report"."M-Ndege Withdrawals")
            {
            }
        }
        */
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
}

