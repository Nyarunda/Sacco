
Report 50092 "Credit Receipt Slip"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Credit Receipt Slip.rdlc';

    dataset
    {
        dataitem(Transactions; "Teller Transaction")
        {
            column(ReportForNavId_1102755000; 1102755000)
            {
            }
            column(No_Transactions; Transactions."Transaction No.")
            {
            }
            column(TransactionNo_Transactions; Transactions."Transaction No.")
            {
            }
            column(NumberText_1_; NumberText[1])
            {
            }
            column(MemberNo_Transactions; Cust."Old Member No." + ' - ' + Transactions."Member No.")
            {
            }
            column(MemberName_Transactions; Transactions."Account Name")
            {
            }
            column(Amount_Transactions; Transactions.Amount)
            {
            }
            column(AllocatedAmount_Transactions; Transactions."Allocated Amount")
            {
            }
            column(Posted_Transactions; Transactions.Posted)
            {
            }
            column(Cashier_Transactions; Transactions.Cashier)
            {
            }
            column(Remarks_Transactions; Transactions.Remarks)
            {
            }
            column(TransactionDate_Transactions; Format(Transactions."Transaction Date"))
            {
            }
            column(TransactionTime_Transactions; Transactions."Transaction Time")
            {
            }
            column(DocumentDate_Transactions; Transactions."Cheque Date")
            {
            }
            column(id_no; Cust."ID No.")
            {
            }
            column(emp_no; Cust."Payroll/Staff No.")
            {
            }
            column(AccountName_Transactions; Transactions."Account Name")
            {
            }
            column(AccountNo_Transactions; Transactions."Account No.")
            {
            }
            column(Member_No_; Transactions."Member No.")
            {
            }
            column(CompanyName; companyInfo.Name)
            {
            }
            column(CompanyAddress; companyInfo.Address)
            {
            }
            column(CompanyCity; companyInfo.City)
            {
            }
            column(CompanyPhoneNo; companyInfo."Phone No.")
            {
            }
            column(CompanyPicture; companyInfo.Picture)
            {
            }
            dataitem("Receipt Allocation"; "Teller Lines")
            {
                DataItemLink = "Transaction No." = field("Transaction No.");
                column(ReportForNavId_1102755001; 1102755001)
                {
                }
                column(DocumentNo_ReceiptAllocation; "Receipt Allocation"."Transaction No.")
                {
                }
                column(MemberNo_ReceiptAllocation; "Receipt Allocation"."Member No.")
                {
                }
                column(TransactionType_ReceiptAllocation; "Receipt Allocation"."Transaction Type")
                {
                }
                column(LoanNo_ReceiptAllocation; "Receipt Allocation"."Loan No.")
                {
                }
                column(Amount_ReceiptAllocation; "Receipt Allocation".Amount)
                {
                }
                column(InterestAmount_ReceiptAllocation; "Receipt Allocation".Amount)
                {
                }
                column(TotalAmount_ReceiptAllocation; "Receipt Allocation".Amount)
                {
                }
                column(AmountBalance_ReceiptAllocation; "Receipt Allocation"."Outstanding Principal")
                {
                }
                column(InterestBalance_ReceiptAllocation; "Receipt Allocation"."Outstanding Interest")
                {
                }
                column(LoanID_ReceiptAllocation; "Receipt Allocation"."Loan No.")
                {
                }
                column(LoanProductCode_ReceiptAllocation; "Receipt Allocation"."Product Type")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    // IF "Transaction Type"="Transaction Type"::"Benevolent Fund" THEN
                    // "Receipt Allocation"."Loan ID":= '';
                end;
            }

            trigger OnAfterGetRecord()
            begin

                if Cust.Get(Transactions."Member No.") then
                    Comms := 0;



                //IF CashPayType.GET("Receipts & Payments"."Cash Window Pay Type") THEN
                //Comms:=CashPayType.Description;

                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(NumberText, Amount, ' ');
            end;

            trigger OnPreDataItem()
            begin

                companyInfo.Get();
                companyInfo.CalcFields(companyInfo.Picture);
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
        Cust: Record Members;
        Comms: Decimal;
        companyInfo: Record "Company Information";
        NumberText: array[2] of Text[80];
        LastFieldNo: Integer;
        CheckReport: Report Check;


    procedure CalAvailableBal()
    begin
    end;
}

