
Report 50234 "TB Missing in Credit Ledger"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/GL Missing in Credit Ledger.rdlc';

    dataset
    {
        dataitem(GL; "G/L Entry")
        {
            column(ReportForNavId_4645; 4645)
            {
            }
            column(EntryNo_Credit; "Entry No.")
            {
            }
            column(CustomerNo_Credit; GL."G/L Account No.")
            {
            }
            column(PostingDate_Credit; "Posting Date")
            {
            }
            column(DocumentNo_Credit; "Document No.")
            {
            }
            column(Description_Credit; Description)
            {
            }
            column(Amount_Credit; Amount)
            {
            }
            column(LoanNo_Credit; '')
            {
            }
            column(LoanType_Credit; '')
            {
            }
            column(TransactionType_Credit; '')
            {
            }

            trigger OnAfterGetRecord()
            var
                "`": Integer;
            begin
                CurrentRecordNo += 1;


                if Savings then begin


                    SLedger.Reset;
                    SLedger.SetRange("Entry No.", GL."Entry No.");
                    SLedger.SETRANGE("Transaction No.", GL."Transaction No.");
                    //SLedger.SetRange("Account No.", GL."Source No.");
                    SLedger.SETRANGE("Document No.", GL."Document No.");
                    SLedger.SETRANGE("Posting Date", GL."Posting Date");
                    SLedger.SETRANGE("Amount (LCY)", GL.Amount);
                    if SLedger.FindFirst then
                        CurrReport.Skip;

                end
                else begin

                    CLEntry.Reset;
                    CLEntry.SETRANGE("Entry No.", GL."Entry No.");
                    //CLEntry.SETRANGE("Loan Type",LoanProduct);
                    CLEntry.SetRange("Transaction No.", GL."Transaction No.");
                    //CLEntry.SetRange("Customer No.", GL."Source No.");
                    CLEntry.SetRange("Document No.", GL."Document No.");
                    CLEntry.SetRange("Posting Date", GL."Posting Date");
                    //CLEntry.SETFILTER("Transaction Type",'%1|%2',CLEntry."Transaction Type"::"Loan Disbursement",CLEntry."Transaction Type"::"Principal Repayment");
                    CLEntry.SetRange("Amount (LCY)", GL.Amount);
                    if CLEntry.FindFirst then
                        CurrReport.Skip;

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

                dWindow.Open('Retrieving Ledgers        @1@@@@@@@@@\'
                                            + 'Counter   #2#########'
                                            + 'Total     #3#########'
                                            + 'Press Esc to abort');





                ProductFactory.Get(LoanProduct);
                Message(ProductFactory.GetReceivablesAccount(LoanProduct, TransType));


                ProductFactory.Get(LoanProduct);
                if ProductFactory."Product Class" = ProductFactory."product class"::Savings then
                    Savings := true;

                if Savings then begin

                    CustomerPostingGroup.Get(ProductFactory."Product Posting Group");
                    GL.SetRange("G/L Account No.", CustomerPostingGroup."Payables Account");

                end
                else
                    GL.SetRange("G/L Account No.", ProductFactory.GetReceivablesAccount(LoanProduct, TransType));

                NoOfRecords := GL.Count;


                Message('%1\%2', GL.Count, CustomerPostingGroup."Payables Account");

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
                    TableRelation = "Product Setup"."Product ID";
                }
                field("Trans Type"; TransType)
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
        Paid: Decimal;
        Expected: Decimal;
        Variance: Decimal;
        Jtemplate: Code[10];
        JBatch: Code[10];
        DocNo: Code[20];
        PDate: Date;
        AcctType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        ProductFactory: Record "Product Setup";
        SavAcc: Record "Savings Accounts";
        ProdFac: Record "Product Setup";
        LoanProduct: Code[20];
        CLEntry: Record "Credit Ledger Entry";
        SLedger: Record "Savings Ledger Entry";
        Savings: Boolean;
        CustomerPostingGroup: Record "Vendor Posting Group";
}

