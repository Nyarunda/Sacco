
Report 50094 "POS Cheque Slip"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/POS Cheque Slip.rdlc';

    dataset
    {
        dataitem(Transactions; "Teller Transaction")
        {
            DataItemTableView = sorting("Transaction No.");
            RequestFilterFields = "No. Series";
            column(ReportForNavId_5806; 5806)
            {
            }
            column(Cashier_Transactions; Transactions.Cashier)
            {
            }
            column(No_Transactions; Transactions."Transaction No.")
            {
            }
            column(Transactions_Type; Type)
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(TellerMsg; CompanyInfo."Teller Slip Msg")
            {
            }
            column(CompanyInfo_phone1; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_phone2; CompanyInfo."Phone No. 2")
            {
            }
            column(Transactions_Amount; Amount)
            {
            }
            column(ClearingCharges; Charges)
            {
            }
            column(Transactions__Cheque_No_; "Cheque No")
            {
            }
            column(NumberText_1_; NumberText[1])
            {
            }
            column(Transactions__Account_Name_; "Account Name")
            {
            }
            column(Transactions__Account_No_; "Account No.")
            {
            }
            column(AccountNo_Transactions; Transactions."Account No.")
            {
            }
            column(AccountName_Transactions; Transactions."Account Name")
            {
            }
            column(BOSAAccountNo_Transactions; Cust."Old Member No." + ' - ' + Transactions."Member No.")
            {
            }
            column(Transactions_Transactions_Cashier; Transactions.Cashier)
            {
            }
            column(Transactions_Transactions__Transaction_Time_; Transactions."Transaction Time")
            {
            }
            column(Transactions__Transaction_Date_; Format("Transaction Date"))
            {
            }
            column(Transactions_No; Transactions."Transaction No.")
            {
            }
            column(ChequeType_Transactions; Transactions."Cheque Type")
            {
            }
            column(Transactions_Transactions_Remarks; Transactions.Remarks)
            {
            }
            column(ChequeDepositRemarks_Transactions; Transactions.Remarks)
            {
            }
            column(Amount_DepositedCaption; Amount_DepositedCaptionLbl)
            {
            }
            column(Transactions__Cheque_No_Caption; FieldCaption("Cheque No"))
            {
            }
            column(Staff_Payroll_No_Caption; Staff_Payroll_No_CaptionLbl)
            {
            }
            column(Account_Name_Caption; Account_Name_CaptionLbl)
            {
            }
            column(Account_No_Caption; Account_No_CaptionLbl)
            {
            }
            column(TellerCaption; TellerCaptionLbl)
            {
            }
            column(Time_Caption; Time_CaptionLbl)
            {
            }
            column(Date_Caption; Date_CaptionLbl)
            {
            }
            column(Trans_No_Caption; Trans_No_CaptionLbl)
            {
            }
            column(Deposited_By_Caption; Deposited_By_CaptionLbl)
            {
            }
            column(Paidby_Transactions; '')
            {
            }
            column(Transactions_Transaction_Type; "Transaction Type")
            {
            }
            column(IDNo_Transactions; Transactions."ID No")
            {
            }
            column(ValueDate; Format(Transactions."Expected Maturity Date"))
            {
            }
            column(ChequeNo_Transactions; Transactions."Cheque No")
            {
            }

            trigger OnAfterGetRecord()
            begin

                if "Account Type" <> "Account Type"::Customer then
                    Cust.Get(Transactions."Member No.");

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
        CompanyInfo: Record "Company Information";
        Amount_DepositedCaptionLbl: label 'Amount Deposited';
        Staff_Payroll_No_CaptionLbl: label 'Staff/Payroll No:';
        Account_Name_CaptionLbl: label 'Account Name:';
        Account_No_CaptionLbl: label 'Account No:';
        TellerCaptionLbl: label 'Teller';
        Time_CaptionLbl: label 'Time:';
        Date_CaptionLbl: label 'Date:';
        Trans_No_CaptionLbl: label 'Trans No.';
        Deposited_By_CaptionLbl: label 'Deposited By:';
        NumberText: array[2] of Text[80];
        CheckReport: Report Check;
        Cust: Record Members;
}

