
Report 50235 "Credit Ledger"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Credit Ledger.rdlc';

    dataset
    {
        dataitem(Credit; "Credit Ledger Entry")
        {
            column(ReportForNavId_4645; 4645)
            {
            }
            column(EntryNo_Credit; Credit."Entry No.")
            {
            }
            column(CustomerNo_Credit; Credit."Account No.")
            {
            }
            column(PostingDate_Credit; Credit."Posting Date")
            {
            }
            column(DocumentNo_Credit; Credit."Document No.")
            {
            }
            column(Description_Credit; Credit.Description)
            {
            }
            column(Amount_Credit; Credit.Amount)
            {
            }
            column(LoanNo_Credit; Credit."Loan No.")
            {
            }
            column(LoanType_Credit; '')
            {
            }
            column(TransactionType_Credit; Credit."Transaction Type")
            {
            }
            column(AmountLCY_Credit; Credit."Amount (LCY)")
            {
            }

            trigger OnAfterGetRecord()
            begin
                CurrentRecordNo += 1;


                /*
                IF LRec.GET(Credit."Loan No.") THEN BEGIN
                    Credit."Group Code" := LRec."Group Code";
                    Credit.MODIFY;
                END;
                */


                dWindow.Update(2, CurrentRecordNo);
                dWindow.Update(3, NoOfRecords);
                dWindow.Update(1, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));

            end;

            trigger OnPostDataItem()
            begin
                dWindow.Close;
                Message('Completed');
            end;

            trigger OnPreDataItem()
            begin

                /*
                dWindow.OPEN('Generating Schedules:     #1#########\'
                                            +'Accounts:             #2#########\'
                                            +'Counter:              #3#########\'
                                            +'Progress:             @4@@@@@@@@@\'
                                            +'Press Esc to abort');
                
                
                */

                dWindow.Open('Retrieving Ledgers        @1@@@@@@@@@\'
                                            + 'Counter   #2#########'
                                            + 'Total     #3#########'
                                            + 'Press Esc to abort');



                //Credit.SETRANGE("Loan Type",LoanProduct);
                NoOfRecords := Credit.Count;

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
        LoansCaptionLbl: label 'Loans';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        VarienceCaptionLbl: label 'Varience';
        Text001: label 'Document No. Must be equal to No.';
        GeneratesuccMSG: label 'Interest Posted Successfully';
        AlreadyPostedErr: label 'This transaction Has already been posted';
        NoTemplateErr: label 'Ensure the Bills Template is set up in banking setup';
        NoBatchErr: label 'Ensure the Bills Batch is set up in the banking setup';
        dWindow: Dialog;
        NoOfRecords: Integer;
        CurrentRecordNo: Integer;
        Paid: Decimal;
        Expected: Decimal;
        Variance: Decimal;
        Jtemplate: Code[10];
        JBatch: Code[10];
        DocNo: Code[20];
        PDate: Date;
        AcctType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Savings,Credit,Member;
        TransType: Option " ",Loan,Repayment,"Interest Due","Interest Paid",Bills,Appraisal,"Ledger Fee";
        ProductFactory: Record "Product Setup";
        SavAcc: Record "Savings Accounts";
        ProdFac: Record "Product Setup";
        LoanProduct: Code[20];
        GLEntry: Record "G/L Entry";
        LRec: Record Loans;
}

