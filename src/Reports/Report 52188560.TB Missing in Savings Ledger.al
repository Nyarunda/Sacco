
Report 50223 "TB Missing in Savings Ledger"
{
    // 
    // 
    // MemberLedgerEntry.SETFILTER("Transaction Type",'%1|%2|%3|%4|%5|%6',
    // MemberLedgerEntry."Transaction Type"::Loan,MemberLedgerEntry."Transaction Type"::Repayment,MemberLedgerEntry."Transaction Type"::"Interest Due",
    // MemberLedgerEntry."Transaction Type"::"Interest Paid",MemberLedgerEntry."Transaction Type"::"Penalty Charged",MemberLedgerEntry."Transaction Type"::"Penalty Paid"
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/TB Missing in Savings Ledger.rdlc';


    dataset
    {
        dataitem(MLedger; "G/L Entry")
        {
            RequestFilterFields = "Posting Date", "G/L Account No.";
            column(ReportForNavId_1; 1)
            {
            }
            column(EntryNo; MLedger."Entry No.")
            {
            }
            column(CustomerNo; MLedger."G/L Account No.")
            {
            }
            column(PostingDate; MLedger."Posting Date")
            {
            }
            column(DocumentNo; MLedger."Document No.")
            {
            }
            column(Description; MLedger.Description)
            {
            }
            column(Amount; MLedger.Amount)
            {
            }
            column(AmountLCY; MLedger.Amount)
            {
            }
            column(TransactionType; Type)
            {
            }
            column(LoanNo; '')
            {
            }
            column(TType; Type)
            {
            }

            trigger OnAfterGetRecord()
            begin

                Type := '';
                Found := false;

                MemberLedgerEntry.Reset;
                MemberLedgerEntry.SetRange("Entry No.", MLedger."Entry No.");
                MemberLedgerEntry.SetRange(Amount, MLedger.Amount);
                MemberLedgerEntry.SetRange("Product Type", Product."Product ID");
                if MemberLedgerEntry.FindFirst then begin
                    CurrReport.Skip;
                end
                else begin

                    MemberLedgerEntry.Reset;
                    MemberLedgerEntry.SetRange("Entry No.", MLedger."Entry No.");
                    if MemberLedgerEntry.FindFirst then begin
                        MemberLedgerEntry.CalcFields("Product Type");
                        Type := Format(MemberLedgerEntry."Product Type");
                    end;
                end;



                if not Found then
                    j += 1;
            end;

            trigger OnPostDataItem()
            begin
                Message('%1', j);
            end;

            trigger OnPreDataItem()
            begin

                Product.Get(ProductType);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(ProductType; ProductType)
                {
                    ApplicationArea = Basic;
                    TableRelation = "Product Setup" where("Product Class" = const(Savings));
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Loans: Record Loans;
        j: Integer;
        LREcText: Text;
        GLEntry: Record "G/L Entry";
        Product: Record "Product Setup";
        Found: Boolean;
        MemberLedgerEntry: Record "Savings Ledger Entry";
        LoanType: Code[10];
        TType: Option " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Benevolent Fund","Deposit Contribution","Penalty Charged","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Discharge Fee",Prepayment,"Withdrawable Deposits","Xmas Contribution","Penalty Paid","Dev Shares","Co-op Shares","Welfare Contribution 2","Loan Penalty","Loan Guard","Reschedule Fees",Konza,Juja,"Housing Water","Housing Title","Housing Main","M Pesa Charge ","Insurance Charge","Insurance Paid","FOSA Account","Partial Disbursement","Loan Due","FOSA Shares","Loan Form Fee","PassBook Fee","Normal shares","FOSA Securities","Savings to Savings","Loan Ledger Fee","Risk Fund Charged","Risk Fund Paid","MDF Contribution","Insurance Indemnity","Valuation Fee","Clearance Fee","Statement Fee","Lease Income","FOSA Service Fee","Membership Card","Tender Fee","Car Track","Fixed Deposit","Rejoining Fee";
        Type: Text;
        ProductType: Code[20];
}

