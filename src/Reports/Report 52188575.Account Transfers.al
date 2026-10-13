
Report 50498 "Account Transfer"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Account Transfer.rdlc';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem(Transfers; "Account Transfers")
        {
            DataItemTableView = where(Posted = const(true));
            RequestFilterFields = No, "Transaction Date", "Created By";
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(ReportForNavId_1; 1)
            {
            }
            column(No; Transfers.No)
            {
            }
            column(Name; Name)
            {
            }
            column(MemberNo; "Member No")
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(TotalCredits; "Total Credits")
            {
            }
            column(TotalDebits; "Total Debits")
            {
            }

            column(CreatedBy; "Created By")
            {
            }
            column(TransactionDate_Transfers; Transfers."Transaction Date")
            {
            }
            column(CreatedBy_Transfers; Transfers."Created By")
            {
            }
            column(AccountType; AccountType)
            {
            }
            column(AccountNo; AccountNo)
            {
            }
            column(Product; Product)
            {
            }
            column(Balance; Balance)
            {
            }
            column(TransferAmount; TransferAmount)
            {
            }
            column(LoanNo; LoanNo)
            {
            }
            column(TType; TType)
            {
            }
            column(NumberText_1_; NumberText[1])
            {
            }
            dataitem(SourceAccountTransfer; "Source Account Transfer")
            {
                DataItemLink = "No." = field(No);
                column(Source_Account_No_; "Source Account No.")
                {
                }
                column(Source_Account_Name; "Source Account Name")
                {
                }
                column(Source_Loan_No_; "Source Loan No.")
                {
                }
                column(Available_Balance; "Available Balance")
                {
                }
                column(Source_Amount; "Source Amount")
                {
                }
                column(Source_Transaction_Type; "Source Transaction Type")
                {
                }
                column(Source_Account_Type; "Source Account Type")
                {
                }
            }



            dataitem(DestinationAccountTransfers; "Destination Account Transfers")
            {
                DataItemLink = "No." = field(No);
                column(Destination_Account_No_; "Destination Account No.")
                {
                }
                column(Destination_Account_Type; "Destination Account Type")
                {
                }
                column(Destination_Loan_No_; "Destination Loan No.")
                {
                }
                column(Destination_Amount; "Destination Amount")
                {
                }
                column(Destination_Transaction_Type; "Destination Transaction Type")
                {
                }
                column(Destination_Account_Name; "Destination Account Name")
                {
                }

            }

            trigger OnAfterGetRecord()
            begin
                AccountType := '';
                AccountNo := '';
                Product := '';
                Balance := 0;
                TransferAmount := 0;
                LoanNo := '';
                TType := '';
                Name := '';



                Source.Reset;
                Source.SetRange("No.", Transfers.No);
                if Source.FindFirst then begin
                    Name := Source."Source Account Name";
                    AccountType := Format(Source."Source Account Type");
                    AccountNo := Source."Source Account No.";
                    Product := Source."Product Name";
                    Balance := Source."Available Balance";
                    TransferAmount := Source."Source Amount";
                    LoanNo := Source."Source Loan No.";
                    TType := Format(Source."Source Transaction Type");

                end;

                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(NumberText, Transfers."Total Debits", '');

            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                CompanyInfo.Get();
                CompanyInfo.CalcFields(Picture)
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

    trigger OnPreReport()
    begin
        if CompanyInfo.Get then
            CompanyInfo.CalcFields(CompanyInfo.Picture);
        CompanyAddress := CompanyInfo.Address + ' -Post Code: ' + CompanyInfo."Post Code" + ' -City:' + CompanyInfo.City + ' Region: ' + CompanyInfo."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInfo."Phone No." + ' -Office Tel: ' + CompanyInfo."Phone No. 2";
#pragma warning disable AL0432
        CommunicationOnline := 'E-mail: ' + CompanyInfo."E-Mail" + '- Website: ' + CompanyInfo."Home Page";
#pragma warning restore AL0432
    end;

    var
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        AccountType: Text;
        AccountNo: Text;
        Product: Text;
        Balance: Decimal;
        TransferAmount: Decimal;
        LoanNo: Code[20];
        TType: Text;
        Name: Text;
        NumberText: array[2] of Text[80];
        CheckReport: Report Check;
        CompanyInfo: Record "Company Information";//CompanyInfo_Picture
        Source: Record "Source Account Transfer";
}

