
Report 50233 "Credit Ledger Missing in TB"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Credit Ledger Missing in GL.rdlc';

    dataset
    {
        dataitem(Credit; "Credit Ledger Entry")
        {
            DataItemTableView = where("Amount (LCY)" = filter(<> 0), "Document No." = filter(<> ''));
            RequestFilterFields = "Posting Date", "Transaction Type";
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
            column(GL; GL)
            {
            }
            column(GLName; GLName)
            {
            }
            column(TransactionType_Credit; Credit."Transaction Type")
            {
            }
            column(LoanType_Credit; Credit."Loan Type") //[LoanType_Credit]
            {
            }

            trigger OnAfterGetRecord()
            begin
                CurrentRecordNo += 1;

                ProductFactory.Get(LoanProduct);

                GLEntry.Reset;
                GLEntry.SetRange("Entry No.", Credit."Entry No.");
                GLEntry.SetRange("Transaction No.", Credit."Transaction No.");
                GLEntry.SetRange("Document No.", Credit."Document No.");
                //GLEntry.SETRANGE("Source No.",Credit."Account No.");
                GLEntry.SetRange("G/L Account No.", ProductFactory.GetReceivablesAccount(LoanProduct, Credit."Transaction Type"));
                GLEntry.SetRange(Amount, Credit."Amount (LCY)");
                if GLEntry.FindFirst then
                    CurrReport.Skip;


                GL := '';
                GLName := '';
                GLEntry.Reset;
                GLEntry.SetRange("Entry No.", Credit."Entry No.");
                if GLEntry.FindFirst then begin
                    GL := GLEntry."G/L Account No.";
                    if GLAcc.Get(GL) then
                        GLName := GLAcc.Name;
                end;


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

                if TransType = TransType::" " then
                    Error('Enter Transaction Type');

                dWindow.Open('Retrieving Ledgers        @1@@@@@@@@@\'
                                            + 'Counter   #2#########'
                                            + 'Total     #3#########'
                                            + 'Press Esc to abort');



                Credit.SetRange("Loan Type", LoanProduct);
                NoOfRecords := Credit.Count;

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Loan Product"; LoanProduct)
                {
                    ApplicationArea = Basic;
                    TableRelation = "Product Setup"."Product ID" where("Product Class" = const(Credit));

                }
                field("Transaction Type"; TransType)
                {
                    ApplicationArea = Basic;
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
        DisbProducts: Record "Product Setup";
        Paid: Decimal;
        Expected: Decimal;
        Variance: Decimal;
        LRec: Record Loans;
        Jtemplate: Code[10];
        JBatch: Code[10];
        DocNo: Code[20];
        PDate: Date;
        AcctType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Savings,Credit,Member;
        TransType: Option " ",Loan,Repayment,"Interest Due","Interest Paid",Bills,Appraisal,"Ledger Fee";
        ProductFactory: Record "Product Setup";
        SavAcc: Record "Savings Accounts";
        ProdFac: Record "Product Setup";
        Cust: Record Members;
        LoanProduct: Code[20];
        GLEntry: Record "G/L Entry";
        GL: Code[20];
        GLName: Text;
        GLAcc: Record "G/L Account";
}

