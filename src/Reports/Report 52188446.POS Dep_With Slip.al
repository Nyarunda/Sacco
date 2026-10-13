
Report 50093 "POS Dep_With Slip"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/POS Dep_With Slip.rdlc';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(Transactions; "Teller Transaction")
        {
            DataItemTableView = sorting("Transaction No.");
            RequestFilterFields = "No. Series";
            column(ReportForNavId_5806; 5806)
            {
            }
            column(TransType; TransType)
            {
            }
            column(No_Transactions; Transactions."Transaction No.")
            {
            }
            column(AccountNo_Transactions; Transactions."Account No.")
            {
            }
            column(NumberText_1_; NumberText[1])
            {
            }
            column(AccountName_Transactions; Transactions."Account Name")
            {
            }
            column(TransactionType_Transactions; Transactions."Transaction Type")
            {
            }
            column(Amount_Transactions; Transactions.Amount)
            {
            }
            column(Cashier_Transactions; Transactions.Cashier)
            {
            }
            column(TransactionDate_Transactions; Transactions."Transaction Date")
            {
            }
            column(TransactionTime_Transactions; Transactions."Time Posted")
            {
            }
            column(Posted_Transactions; Transactions.Posted)
            {
            }
            column(NoSeries_Transactions; Transactions."No. Series")
            {
            }
            column(AccountType_Transactions; Transactions."Account Type")
            {
            }
            column(AccountDescription_Transactions; Transactions."Account Name")
            {
            }
            column(ChequeType_Transactions; Transactions."Cheque Type")
            {
            }
            column(ChequeNo_Transactions; Transactions."Cheque No")
            {
            }
            column(ChequeDate_Transactions; Transactions."Cheque Date")
            {
            }
            column(Payee_Transactions; Transactions.Payee)
            {
            }
            column(Description_Transactions; Transactions.Remarks)
            {
            }
            column(Type_Transactions; Transactions.Type)
            {
            }
            column(TransactionDescription_Transactions; Transactions."Transaction Description")
            {
            }
            column(Remarks_Transactions; Transactions.Remarks)
            {
            }
            column(Status_Transactions; Transactions.Status)
            {
            }
            column(DatePosted_Transactions; Transactions."Date Posted")
            {
            }
            column(TimePosted_Transactions; Transactions."Time Posted")
            {
            }
            column(PostedBy_Transactions; Transactions."Posted By")
            {
            }
            column(ExpectedMaturityDate_Transactions; Transactions."Expected Maturity Date")
            {
            }
            column(CurrencyCode_Transactions; Transactions."Currency Code")
            {
            }
            column(PostDated_Transactions; Transactions."Post Dated")
            {
            }
            column(Select_Transactions; Transactions.Select)
            {
            }
            column(BookBalance_Transactions; Transactions."Book Balance")
            {
            }
            column(Overdraft_Transactions; Transactions.Overdraft)
            {
            }
            column(AvailableBalance_Transactions; Transactions."Available Balance")
            {
            }
            column(AllocatedAmount_Transactions; Transactions."Allocated Amount")
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Picture; '')
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_Phone_No; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_Phone_No2; CompanyInfo."Phone No. 2")
            {
            }
            column(TellerMsg; CompanyInfo."Teller Slip Msg")
            {
            }
            column(CompanyInfo_E_Mail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(BOSAAccountNo_Transactions; Cust."Old Member No." + ' - ' + Transactions."Member No.")
            {
            }
            column(Charges_Transactions; Transactions.Charges)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if Cust.Get(Transactions."Member No.") then;
                TransType := Format(Transactions.Type);
                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(NumberText, Amount, ' ');
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get();
                CompanyInfo.CalcFields(CompanyInfo.Picture);
            end;
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

    var
        DUPLICATECaptionLbl: label 'DUPLICATE';
        Amount_received__CaptionLbl: label 'Amount received :';
        Account_Name_CaptionLbl: label 'Account Name:';
        Account_No_CaptionLbl: label 'Account No:';
        Member_No_CaptionLbl: label 'Member No:';
        Time_CaptionLbl: label 'Time:';
        Date_CaptionLbl: label 'Date:';
        Transaction_No_CaptionLbl: label 'Transaction No.';
        Deposited_By_______________________________________CaptionLbl: label 'Deposited By :.....................................';
        You_were_served_by__CaptionLbl: label 'You were served by :';
        THANK_YOUCaptionLbl: label 'THANK YOU';
        Better_life_for_our_members_globallyCaptionLbl: label 'Better life for our members globally';
        CompanyInfo: Record "Company Information";
        CheckReport: Report Check;
        NumberText: array[2] of Text[80];
        TransType: Text;
        Cust: Record Members;
}

