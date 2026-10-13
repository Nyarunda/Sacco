
Report 50116 "Credit Cheque Deposit Slip"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Credit Cheque Deposit Slip.rdlc';

    dataset
    {
        dataitem(Transactions; "Teller Transaction")
        {
            DataItemTableView = sorting("Transaction No.");
            RequestFilterFields = "No. Series";
            column(ReportForNavId_5806; 5806)
            {
            }
            column(Transactions_Transactions__Book_Balance_; Transactions."Book Balance")
            {
            }
            column(Transactions_No; "Transaction No.")
            {
            }
            column(AccountNo; "Account No.")
            {
            }
            column(AccountName; "Account Name")
            {
            }
            column(Amount; Amount)
            {
            }
            column(PayrollNo; StaffNo)
            {
            }
            column(Prod_Name; 'x')
            {
            }
            column(Transactions__Transaction_Date_; Format("Transaction Date"))
            {
            }
            column(Transactions_Transactions__Transaction_Time_; Format(Transactions."Transaction Time"))
            {
            }
            column(Transactions__Cheque_No_; "Cheque No")
            {
            }
            column(ChequeDate_Transactions; Format(Transactions."Cheque Date"))
            {
            }
            column(Transactions_Type; Type)
            {
            }
            column(CashierName; Cashier)
            {
            }
            column(BranchCode; Transactions."Global Dimension 2 Code")
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(Company_Address; CompanyInfo.Address)
            {
            }
            column(Co_phone; CompanyInfo."Phone No.")
            {
            }
            column(Company_Pic; CompanyInfo.Picture)
            {
            }
            column(NumberText; NumberText[1])
            {
            }
            column(Transactions_Transactions_Cashier; Transactions.Cashier)
            {
            }
            column(Amount_WithdrawnCaption; Amount_WithdrawnCaptionLbl)
            {
            }
            column(Book_Balance_Caption; Book_Balance_CaptionLbl)
            {
            }
            column(Transaction_No_Caption; Transaction_No_CaptionLbl)
            {
            }
            column(Account_No_Caption; Account_No_CaptionLbl)
            {
            }
            column(Account_Name_Caption; Account_Name_CaptionLbl)
            {
            }
            column(Date_Caption; Date_CaptionLbl)
            {
            }
            column(Time_Caption; Time_CaptionLbl)
            {
            }
            column(Transactions__Cheque_No_Caption; FieldCaption("Cheque No"))
            {
            }
            column(Member_No_Caption; Member_No_CaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(Signature_Caption; Signature_CaptionLbl)
            {
            }
            column(I_acknowledge_receipt_of_the_above_amountCaption; I_acknowledge_receipt_of_the_above_amountCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1000000048; EmptyStringCaption_Control1000000048Lbl)
            {
            }
            column(I_D_No_Caption; I_D_No_CaptionLbl)
            {
            }
            column(Availbal; Available_Balance_CaptionLbl)
            {
            }
            column(BookBal_; Book_Balance_Caption_Control1102760006Lbl)
            {
            }
            column(EmptyStringCaption_Control1102756001; EmptyStringCaption_Control1102756001Lbl)
            {
            }
            column(al; Name_CaptionLbl)
            {
            }
            column(Withdrawn_By_______________________________________Caption; Withdrawn_By_______________________________________CaptionLbl)
            {
            }
            column(You_were_served_by__Caption; You_were_served_by__CaptionLbl)
            {
            }
            column(THANK_YOUCaption; THANK_YOUCaptionLbl)
            {
            }
            column(Better_life_for_our_members_globallyCaption; Better_life_for_our_members_globallyCaptionLbl)
            {
            }
            column(Transactions_Transaction_Type; "Transaction Type")
            {
            }
            column(ExpectedMaturityDate; "Expected Maturity Date")
            {
            }
            column(ChequeNo_Transactions; Transactions."Cheque No")
            {
            }
            column(TransactionDescription_Transactions; Transactions."Transaction Description")
            {
            }
            column(Cashier_Transactions; Transactions.Cashier)
            {
            }
            column(NumberText_1_; NumberText[1])
            {
            }
            column(SumTransactionCharges; SumTransactionCharges)
            {
            }
            column(AvailableBalance; "Available Balance")
            {
            }
            column(NewAvailable; "Available Balance")
            {
            }
            column(Dublicate; Transactions.Dublicate)
            {
            }
            column(NewAccountBalance_Transactions; Transactions."New Account Balance")
            {
            }
            dataitem("Cashier Transaction Lines"; "Teller Lines")
            {
                DataItemLink = "Member No." = field("Member No."), "Transaction No." = field("Transaction No.");
                column(ReportForNavId_12; 12)
                {
                }
                column(Desc; Desc)
                {
                }
                column(TransactionType_CashierTransactionLines; "Cashier Transaction Lines"."Transaction Type")
                {
                }
                column(LoanNo_CashierTransactionLines; "Cashier Transaction Lines"."Loan No.")
                {
                }
                column(Amount_CashierTransactionLines; "Cashier Transaction Lines".Amount)
                {
                }
                column(Type_CashierTransactionLines; "Cashier Transaction Lines".Type)
                {
                }
                column(AccountNo_CashierTransactionLines; "Cashier Transaction Lines"."Account No.")
                {
                }
                column(Description_CashierTransactionLines; "Cashier Transaction Lines".Description)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if "Cashier Transaction Lines".Type = "Cashier Transaction Lines".Type::Savings then begin
                        Desc := 'Savings Product';
                        if Savings.Get("Cashier Transaction Lines"."Account No.") then
                            if PFact.Get(Savings."Product Type") then
                                Desc := PFact.Description;
                    end;

                    if "Cashier Transaction Lines".Type = "Cashier Transaction Lines".Type::Credit then begin
                        Desc := 'Loan Product';
                        if Loans.Get("Cashier Transaction Lines"."Loan No.") then
                            if PFact.Get(Loans."Loan Product Type") then
                                Desc := PFact.Description;
                    end;

                    if "Cashier Transaction Lines".Type = "Cashier Transaction Lines".Type::"G/L Account" then begin
                        Desc := "Cashier Transaction Lines".Description;

                    end;
                end;
            }
            dataitem("Transaction Charges Lines"; "Transaction Charges Lines")
            {
                DataItemLink = "Transaction Type" = field("Transaction Type");
                column(ReportForNavId_8541; 8541)
                {
                }
                column(Description; Description)
                {
                }
                column(ChAmount; ChAmount)
                {
                }
                column(Transaction_Charges_Transaction_Type; "Transaction Type")
                {
                }
                column(Transaction_Charges_Charge_Code; '')
                {
                }
                column(WithDrawnAmnt; WithDrawnAmnt)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                StaffNo := '';
                //ProductName:='';
                CashierName := '';
                user.Reset;
                user.SetRange("User Name", UserId);
                if user.Find('-') then begin
                    CashierName := user."Full Name";
                end;

                //calculate the charges
                SavingsLedgerEntry.Reset;
                SavingsLedgerEntry.SetRange("Account No.", "Account No.");
                SavingsLedgerEntry.SetRange("Document No.", "Transaction No.");
                SavingsLedgerEntry.SetRange(Reversed, false);
                if SavingsLedgerEntry.FindSet then begin
                    SavingsLedgerEntry.CalcSums(Amount);
                    SumTransactionCharges := SavingsLedgerEntry.Amount - Amount;
                    //MESSAGE('the trans charges are %1',SumTransactionCharges);
                end;

                Savings.Reset;
                Savings.SetRange(Savings."No.", Transactions."Account No.");
                Savings.SetAutoCalcFields("Payroll/Staff No.");
                if Savings.Find('-') then begin
                    StaffNo := Savings."Payroll/Staff No.";
                    //ProductName:=Savings."Product Name";
                end;


                CheckReport.InitTextVariable();

                CheckReport.FormatNoText(NumberText, Amount, '');
                WithDrawnAmnt := '';
                if Transactions.Type = Transactions.Type::"Cash Withdrawal" then
                    WithDrawnAmnt := 'Amount Withdrwan'
                else
                    WithDrawnAmnt := 'Cheque Amount';
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
        Amount_WithdrawnCaptionLbl: label 'Amount Withdrawn';
        Book_Balance_CaptionLbl: label 'Book Balance:';
        Transaction_No_CaptionLbl: label 'Transaction No.';
        Account_No_CaptionLbl: label 'Account No:';
        Account_Name_CaptionLbl: label 'Account Name:';
        Date_CaptionLbl: label 'Date:';
        Time_CaptionLbl: label 'Time:';
        Member_No_CaptionLbl: label 'Member No:';
        EmptyStringCaptionLbl: label '..........................................................';
        Signature_CaptionLbl: label 'Signature:';
        I_acknowledge_receipt_of_the_above_amountCaptionLbl: label 'I acknowledge the above Deposit';
        EmptyStringCaption_Control1000000048Lbl: label '..........................................................';
        I_D_No_CaptionLbl: label 'I/D No.';
        Available_Balance_CaptionLbl: label 'Available Balance:';
        Book_Balance_Caption_Control1102760006Lbl: label 'Book Balance:';
        EmptyStringCaption_Control1102756001Lbl: label '..........................................................';
        Name_CaptionLbl: label 'Name:';
        Withdrawn_By_______________________________________CaptionLbl: label 'Withdrawn By :.....................................';
        You_were_served_by__CaptionLbl: label 'You were served by :';
        THANK_YOUCaptionLbl: label 'THANK YOU';
        Better_life_for_our_members_globallyCaptionLbl: label 'Better life for our members globally';
        CompanyInfo: Record "Company Information";
        CheckReport: Report Check;
        SumTransactionCharges: Decimal;
        ChAmount: Decimal;
        AvailableBalance: Decimal;
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        Savings: Record "Savings Accounts";
        StaffNo: Code[20];
        AmountInWords: array[2] of Text;
        NumberText: array[2] of Text[80];
        WithDrawnAmnt: Text[25];
        user: Record User;
        CashierName: Text;
        Desc: Text;
        PFact: Record "Product Setup";
        Loans: Record Loans;
        GL: Record "G/L Account";
}

