
Report 50226 "Loan Ledger Missing in TB (IN)"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loan Ledger Missing in TB (IN).rdlc';

    dataset
    {
        dataitem(MLedger; "Credit Ledger Entry")
        {
            DataItemTableView = where("Transaction Type" = filter("Interest Due" | "Interest Paid" | "Penalty Due" | "Penalty Paid"));
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
            column(TransactionType; MLedger."Transaction Type")
            {
            }
            column(LoanNo; MLedger."Loan No.")
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

                if Loans.Get(MLedger."Loan No.") then begin
                    if Loans."Loan Product Type" <> LoanType then
                        CurrReport.Skip;
                end
                else
                    CurrReport.Skip;

                //j+=1

                //LREcText +=': '+MLedger."Loan No";

                Found := false;
                GLAcc := '';
                GLName := '';

                GLEntry.Reset;
                GLEntry.SetRange("Entry No.", MLedger."Entry No.");
                //GLEntry.SETRANGE(Amount,MLedger."Amount (LCY)");
                //GLEntry.SETFILTER("G/L Account No.",'20001..20023');

                GLEntry.SetFilter("G/L Account No.", Product."Loan Interest Receivable [G/L]");
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
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Loan Type"; LoanType)
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
        GLEntry: Record "G/L Entry";
        Product: Record "Product Setup";
        Found: Boolean;
        GLAcc: Code[20];
        GLName: Text;
        GLREc: Record "G/L Account";
        LoanType: Code[20];
}

