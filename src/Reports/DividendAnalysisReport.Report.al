Report 50342 "Dividend Analysis Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Dividend Analysis Report.rdlc';

    dataset
    {
        dataitem(DivProduct; "Product Setup")
        {
            DataItemTableView = where("Dividend Calc. Method" = filter(<> " "));
            column(ReportForNavId_1; 1)
            {
            }
            column(ProductID_DivProduct; DivProduct.Description)
            {
            }
            column(Gross; Gross)
            {
            }
            column(WTax; WTax)
            {
            }
            column(Net; Net)
            {
            }
            column(ProcessingFee; ProcessingFee)
            {
            }
            column(ExciseDuty; ExciseDuty)
            {
            }
            column(SMS; SMS)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Gross := 0;
                WTax := 0;
                Net := 0;
                ProcessingFee := 0;
                ExciseDuty := 0;
                SMS := 0;

                Buffer.Reset;
                Buffer.SetRange("Product Type", DivProduct."Product ID");
                Buffer.SetRange(Transaction, Buffer.Transaction::Gross);
                if Buffer.FindFirst then begin
                    Buffer.CalcSums(Amount);
                    Gross := Buffer.Amount * -1;
                end
                else begin

                    Buffer.Reset;
                    Buffer.SetRange("Product Type Name", DivProduct.Description);
                    Buffer.SetRange(Transaction, Buffer.Transaction::Gross);
                    if Buffer.FindFirst then begin
                        Buffer.CalcSums(Amount);
                        Gross := Buffer.Amount * -1;
                    end
                end;

                Buffer.Reset;
                Buffer.SetRange("Product Type", DivProduct."Product ID");
                Buffer.SetRange(Transaction, Buffer.Transaction::Tax);
                if Buffer.FindFirst then begin
                    Buffer.CalcSums(Amount);
                    WTax := Buffer.Amount;
                end
                else begin

                    Buffer.Reset;
                    Buffer.SetRange("Product Type Name", DivProduct.Description);
                    Buffer.SetRange(Transaction, Buffer.Transaction::Tax);
                    if Buffer.FindFirst then begin
                        Buffer.CalcSums(Amount);
                        WTax := Buffer.Amount;
                    end
                end;

                Net := Gross - WTax;


                Buffer.Reset;
                Buffer.SetRange(Transaction, Buffer.Transaction::"Processing Fee");
                if Buffer.FindFirst then begin
                    Buffer.CalcSums(Amount);
                    ProcessingFee := Buffer.Amount;
                end;


                Buffer.Reset;
                Buffer.SetRange(Transaction, Buffer.Transaction::"Duty on Processing Fee");
                if Buffer.FindFirst then begin
                    Buffer.CalcSums(Amount);
                    ExciseDuty := Buffer.Amount;
                end;


                Buffer.Reset;
                Buffer.SetRange(Transaction, Buffer.Transaction::SMS);
                if Buffer.FindFirst then begin
                    Buffer.CalcSums(Amount);
                    SMS := Buffer.Amount;
                end;
            end;
        }
        dataitem(Loans; "Product Setup")
        {
            DataItemTableView = where("Product Class" = filter(Credit));
            column(ReportForNavId_8; 8)
            {
            }
            column(ProductID_Loans; Loans.Description)
            {
            }
            column(Penalty; Penalty)
            {
            }
            column(Appraisal; Appraisal)
            {
            }
            column(Interest; Interest)
            {
            }
            column(Principal; Principal)
            {
            }
            column(TLoan; TLoan)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Penalty := 0;
                Appraisal := 0;
                Interest := 0;
                Principal := 0;
                TLoan := 0;


                Buffer.Reset;
                Buffer.SetRange("Loan Product", Loans."Product ID");
                Buffer.SetRange(Transaction, Buffer.Transaction::Loan);
                Buffer.SetRange("Transaction Type", Buffer."transaction type"::"Penalty Paid");
                if Buffer.FindFirst then begin
                    Buffer.CalcSums(Amount);
                    Penalty := Buffer.Amount * -1;
                end;

                Buffer.Reset;
                Buffer.SetRange("Loan Product", Loans."Product ID");
                Buffer.SetRange(Transaction, Buffer.Transaction::Loan);
                Buffer.SetRange("Transaction Type", Buffer."transaction type"::"Appraisal Paid");
                if Buffer.FindFirst then begin
                    Buffer.CalcSums(Amount);
                    Appraisal := Buffer.Amount * -1;
                end;

                Buffer.Reset;
                Buffer.SetRange("Loan Product", Loans."Product ID");
                Buffer.SetRange(Transaction, Buffer.Transaction::Loan);
                Buffer.SetRange("Transaction Type", Buffer."transaction type"::"Interest Paid");
                if Buffer.FindFirst then begin
                    Buffer.CalcSums(Amount);
                    Interest := Buffer.Amount * -1;
                end;

                Buffer.Reset;
                Buffer.SetRange("Loan Product", Loans."Product ID");
                Buffer.SetRange(Transaction, Buffer.Transaction::Loan);
                Buffer.SetRange("Transaction Type", Buffer."transaction type"::"Principal Repayment");
                if Buffer.FindFirst then begin
                    Buffer.CalcSums(Amount);
                    Principal := Buffer.Amount * -1;
                end;

                TLoan := Penalty + Appraisal + Interest + Principal;

                if TLoan = 0 then
                    CurrReport.Skip;
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
        Buffer: Record "Dividend Posting";
        Gross: Decimal;
        WTax: Decimal;
        Net: Decimal;
        ProcessingFee: Decimal;
        ExciseDuty: Decimal;
        Penalty: Decimal;
        Appraisal: Decimal;
        Interest: Decimal;
        Principal: Decimal;
        TLoan: Decimal;
        SMS: Decimal;
}

