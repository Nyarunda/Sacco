report 50038 "Bosa Receipting Report"

{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Bosa Receipting Report.rdlc';

    dataset
    {
        dataitem("Receipts & Payments"; "Receipt Header")
        {
            DataItemTableView = WHERE(Posted = FILTER(true), "Customer Type" = filter(Member));
            RequestFilterFields = "Posting Date", "Account No.", "No.", "Account Type";
            CalcFields = "Total Amount";
            column(TransactionNo_ReceiptsPayments; "Receipts & Payments"."No.")
            {
            }
            column(AccountNo_ReceiptsPayments; "Receipts & Payments"."Account No.")
            {
            }
            column(Name_ReceiptsPayments; "Receipts & Payments"."Member Name")
            {
            }
            column(Amount_ReceiptsPayments; "Receipts & Payments"."Amount Recieved")
            {
            }
            column(ChequeNo_ReceiptsPayments; "Receipts & Payments"."Cheque No.")
            {
            }
            column(ChequeDate_ReceiptsPayments; "Receipts & Payments"."Cheque/Deposit Slip Date")
            {
            }
            column(Posted_ReceiptsPayments; "Receipts & Payments".Posted)
            {
            }
            column(UserID_ReceiptsPayments; "Receipts & Payments"."Created By")
            {
            }
            column(AllocatedAmount_ReceiptsPayments; "Receipts & Payments"."Amount Recieved")
            {
            }
            column(Total_Amount; "Receipts & Payments"."Total Amount")
            {

            }
            column(TransactionDate_ReceiptsPayments; "Receipts & Payments"."Posting Date")
            {
            }
            column(AccountType_ReceiptsPayments; "Receipts & Payments"."Account Type")
            {
            }
            column(ModeofPayment_ReceiptsPayments; "Receipts & Payments"."Pay Mode")
            {
            }
            column(Description_ReceiptsPayments; "Receipts & Payments".Narration)
            {
            }
            column(PhoneNumber_ReceiptsPayments; "Receipts & Payments"."Global Dimension 2 Code")
            {
            }
            column(FosaAccount_ReceiptsPayments; "Receipts & Payments"."Global Dimension 1 Code")
            {
            }
            column(Serial; Serial)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_City; Company.City)
            {
            }
            column(Company_Phone; Company."Phone No.")
            {
            }

            column(Company_Picture; Company.Picture)
            {
            }
            column(Amount; Amount)
            {
            }
            column(Amount_Recieved; "Amount Recieved")
            {

            }
            column(AmountReversed; "Reversed Amount")
            {
            }

            trigger OnAfterGetRecord()
            Var
                GLE: Record "G/L Entry";
            begin
                "Reversed Amount" := 0;
                GLE.Reset();
                GLE.SetRange("Document No.", "Receipts & Payments"."No.");
                GLE.SetRange(Reversed, true);
                If GLE.FindFirst() then "Reversed Amount" := "Receipts & Payments"."Total Amount";

            end;

            trigger OnPreDataItem()
            begin
                Serial := 1;
                Amount := 0;
                "Reversed Amount" := 0;
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
        Company.GET();
        Company.CALCFIELDS(Picture);
    end;

    var
        Serial: Integer;
        Company: Record "Company Information";
        Amount: Decimal;
        "Reversed Amount": Decimal;
}