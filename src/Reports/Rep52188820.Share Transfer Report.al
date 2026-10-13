
report 50513 "Share Transfer Report"
{
    Caption = 'Share Transfer';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Share Transfer Report.rdlc';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem(Transfers; "Share Transfer")
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
            column(Name; '')
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
            dataitem(SourceAccountTransfer; "Share Transfer Lines")
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
                column(Destination_Account_Name; "Destination Account Name")
                {
                }
                column(Destination_Account_No_; "Destination Account No.")
                {
                }
                column(Destination_Account_Type; "Destination Account Type")
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



                Source.Reset;
                Source.SetRange("No.", Transfers.No);
                if Source.FindFirst then begin
                    AccountType := Format(Source."Source Account Type");
                    AccountNo := Source."Source Account No.";
                    Product := Source."Product Name";
                    Balance := Source."Available Balance";
                    TransferAmount := Source."Source Amount";
                    LoanNo := Source."Source Loan No.";
                    TType := Format(Source."Source Transaction Type");

                    CheckReport.InitTextVariable();
                    CheckReport.FormatNoText(NumberText, Source."Source Amount", '');
                end;


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
        NumberText: array[2] of Text[80];
        CheckReport: Report Check;
        CompanyInfo: Record "Company Information";//CompanyInfo_Picture
        Source: Record "Share Transfer Lines";
}

