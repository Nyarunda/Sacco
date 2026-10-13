
Report 50222 "Savings Ledger Missing in TB"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Savings Ledger Missing in TB.rdlc';

    dataset
    {
        dataitem(MLedger; "Savings Ledger Entry")
        {
            RequestFilterFields = "Posting Date";
            column(ReportForNavId_1; 1)
            {
            }
            column(EntryNo; MLedger."Entry No.")
            {
            }
            column(CustomerNo; MLedger."Account No.")
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
            column(AmountLCY; MLedger."Amount (LCY)")
            {
            }
            column(TransactionType; '')
            {
            }
            column(LoanNo; '')
            {
            }
            column(GLAcc; GLAcc)
            {
            }
            column(GLName; GLName)
            {
            }

            trigger OnAfterGetRecord()
            begin


                //j+=1

                //LREcText +=': '+MLedger."Loan No";

                Found := false;
                GLAcc := VendorPostingGroup."Receivables Account";

                GLName := '';

                GLEntry.Reset;
                GLEntry.SetRange("Entry No.", MLedger."Entry No.");
                GLEntry.SETRANGE(Amount, MLedger."Amount (LCY)");
                GLEntry.SetFilter("G/L Account No.", GL);
                if GLEntry.FindFirst then
                    Found := true
                else begin

                    GLEntry.Reset;
                    GLEntry.SetRange("Entry No.", MLedger."Entry No.");
                    if GLEntry.FindFirst then begin
                        GLAcc := GLEntry."G/L Account No.";
                        if GLREc.Get(GLAcc) then
                            GLName := GLREc.Name;
                    end;
                end;


                /*
                Product.RESET;
                Product.SETRANGE("Loan Account",'<>%1','');
                IF Product.FINDFIRST THEN BEGIN
                    REPEAT
                        GLEntry.RESET;
                        //GLEntry.SETRANGE("G/L Account No.",Product."Loan Account");
                        GLEntry.SETRANGE("Entry No.",MLedger."Entry No.");
                        //GLEntry.SETRANGE(Amount,MLedger."Amount (LCY)");
                
                        GLEntry.SETFILTER("G/L Account No.",'10051..10073');
                        IF GLEntry.FINDFIRST THEN
                            Found := TRUE;
                
                    UNTIL (Product.NEXT=0) OR (Found);
                END;
                */


                if Found then
                    CurrReport.Skip;


                if not Found then
                    j += 1;

            end;

            trigger OnPostDataItem()
            begin
                Message('%1', j);
            end;

            trigger OnPreDataItem()
            begin


                Product.Get(LoanType);

                VendorPostingGroup.Get(Product."Product Posting Group");

                MLedger.SetRange("Product Type", LoanType);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(GL; GL)
                {
                    ApplicationArea = Basic;
                    TableRelation = "G/L Account";
                }
                field(Product; LoanType)
                {
                    ApplicationArea = Basic;
                    TableRelation = "Product Setup";
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
        GLAcc: Code[20];
        GLName: Text;
        GLREc: Record "G/L Account";
        LoanType: Code[20];
        TType: Option " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Benevolent Fund","Deposit Contribution","Penalty Charged","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Discharge Fee",Prepayment,"Withdrawable Deposits","Xmas Contribution","Penalty Paid","Dev Shares","Co-op Shares","Welfare Contribution 2","Loan Penalty","Loan Guard","Reschedule Fees",Konza,Juja,"Housing Water","Housing Title","Housing Main","M Pesa Charge ","Insurance Charge","Insurance Paid","FOSA Account","Partial Disbursement","Loan Due","FOSA Shares","Loan Form Fee","PassBook Fee","Normal shares","FOSA Securities","Savings to Savings","Loan Ledger Fee","Risk Fund Charged","Risk Fund Paid","MDF Contribution","Insurance Indemnity","Valuation Fee","Clearance Fee","Statement Fee","Lease Income","FOSA Service Fee","Membership Card","Tender Fee","Car Track","Fixed Deposit","Rejoining Fee";
        GL: Text;
        VendorPostingGroup: Record "Customer Posting Group";
}

