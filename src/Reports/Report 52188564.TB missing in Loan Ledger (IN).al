
Report 50227 "TB missing in Loan Ledger (IN)"
{
    // 
    // 
    // GLEntry.SETFILTER("Transaction Type",'%1|%2|%3|%4|%5|%6',
    // GLEntry."Transaction Type"::Loan,GLEntry."Transaction Type"::Repayment,GLEntry."Transaction Type"::"Interest Due",
    // GLEntry."Transaction Type"::"Interest Paid",GLEntry."Transaction Type"::"Penalty Charged",GLEntry."Transaction Type"::"Penalty Paid"
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/TB missing in Loan Ledger (IN).rdlc';


    dataset
    {
        dataitem(MLedger; "G/L Entry")
        {
            RequestFilterFields = "Posting Date";
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
            column(TransactionType; TType)
            {
            }
            column(LoanNo; '')
            {
            }
            column(TType; TType)
            {
            }

            trigger OnAfterGetRecord()
            begin

                //IF Loans.GET(MLedger."Loan No") THEN
                //CurrReport.SKIP;

                //j+=1;

                //LREcText +=': '+MLedger."Loan No";

                Found := false;
                TType := '';



                GLEntry.Reset;
                GLEntry.SetRange("Entry No.", MLedger."Entry No.");
                GLEntry.SetRange(Amount, MLedger.Amount);
                GLEntry.SetFilter("Transaction Type", 'Interest Due|Interest Paid|Penalty Due|Penalty Paid');
                if GLEntry.FindFirst then begin
                    if Loans.Get(GLEntry."Loan No.") then begin
                        if Loans."Loan Product Type" = LoanType then
                            Found := true
                    end
                    else
                        CurrReport.Skip;

                end
                else begin

                    GLEntry.Reset;
                    GLEntry.SetRange("Entry No.", MLedger."Entry No.");
                    if GLEntry.FindFirst then
                        TType := Format(GLEntry."Transaction Type");
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

                //MLedger.SETFILTER("G/L Account No.",'10051..10073|20001..20023');
                //MLedger.SETFILTER("G/L Account No.",'10051..10073');
                //MLedger.SETFILTER("G/L Account No.",'20001..20023');
                MLedger.SetFilter("G/L Account No.", Product."Loan Interest Receivable [G/L]");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(LoanType; LoanType)
                {
                    ApplicationArea = Basic;
                    TableRelation = "Product Setup" where("Product Class" = const(Credit));
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
        GLEntry: Record "Credit Ledger Entry";
        Product: Record "Product Setup";
        Found: Boolean;
        MemberLedgerEntry: Record "G/L Entry";
        TType: Text;
        LoanType: Code[10];
}

