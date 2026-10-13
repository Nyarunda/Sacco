
Report 50075 "Loan Daily Transactions"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loan Daily Transactions.rdlc';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem(Buffer; "Daily Trans-Buffer")
        {
            column(ReportForNavId_4645; 4645)
            {
            }
            column(CompPicture; CompanyInformation.Picture)
            {
            }
            column(CompName; CompanyInformation.Name)
            {
            }
            column(ProductID_Buffer; PDesc)
            {
            }
            column(Issued_Buffer; Buffer.Issued)
            {
            }
            column(Paid_Buffer; Buffer.Paid)
            {
            }
            column(IssuedCount_Buffer; Buffer."Issued Count")
            {
            }
            column(PaidCount_Buffer; Buffer."Paid Count")
            {
            }
            column(LedgerFees_Buffer; Buffer."Ledger Fees")
            {
            }
            column(Insurance_Buffer; Buffer.Insurance)
            {
            }
            column(ProductGroup_Buffer; Buffer."Product Group")
            {
            }
            column(DateFilter; DateFilter)
            {
            }
            column(Branch; Branch)
            {
            }

            trigger OnAfterGetRecord()
            begin
                ProductFactory.Get(Buffer."Product ID");

                PDesc := ProductFactory.Description;
            end;

            trigger OnPreDataItem()
            begin

                dWindow.Open('Updating Accounts:        @1@@@@@@@@@\'
                                            + 'Counter   #2#########'
                                            + 'Total     #3#########'
                                            + 'Product   #4#########'
                                            + 'Press Esc to abort');


                DailyBuffer.Reset;
                DailyBuffer.SetRange("User ID", UserId);
                DailyBuffer.DeleteAll;

                DateFilter := Format(SDate) + ' .. ' + Format(EDate);

                ProductFactory.Reset;
                ProductFactory.SetRange("Product Class", ProductFactory."product class"::Credit);
                if ProductFactory.Find('-') then begin
                    repeat

                        CurrentRecordNo := 0;
                        DailyBuffer.Init;
                        DailyBuffer."Product ID" := ProductFactory."Product ID";
                        DailyBuffer."User ID" := UserId;

                        Loans.Reset;
                        Loans.SetRange("Loan Product Type", ProductFactory."Product ID");
                        Loans.SetRange("Disbursement Date", SDate, EDate);
                        if Branch <> '' then
                            Loans.SetRange("Booking Branch", Branch);
                        Loans.SetRange(Loans.Posted, true);
                        if Loans.Find('-') then begin
                            NoOfRecords := Loans.Count;
                            dWindow.Update(4, ProductFactory."Product ID" + ' - Issued');
                            repeat
                                CurrentRecordNo += 1;
                                if Loans."Amount To Disburse" > 0 then
                                    DailyBuffer.Issued += Loans."Amount To Disburse"
                                else
                                    DailyBuffer.Issued += Loans."Approved Amount";
                                DailyBuffer."Issued Count" := NoOfRecords;
                                //DailyBuffer."Ledger Fees":=Loans."Ledger Fees";
                                //DailyBuffer.Insurance:=Loans.Insurance;
                                DailyBuffer."Product Group" := ProductFactory."Loan Source";

                                dWindow.Update(2, CurrentRecordNo);
                                dWindow.Update(3, NoOfRecords);
                                dWindow.Update(1, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));
                            until Loans.Next = 0;
                        end;

                        Loans.Reset;
                        Loans.SetRange("Loan Product Type", ProductFactory."Product ID");
                        Loans.SetRange(Loans.Posted, true);
                        Loans.SetRange("Date Filter", SDate, EDate);
                        if Branch <> '' then
                            Loans.SetRange("Booking Branch", Branch);
                        Loans.SetFilter("Principal Repayment", '>0');
                        if Loans.Find('-') then begin
                            NoOfRecords := Loans.Count;
                            dWindow.Update(4, ProductFactory."Product ID" + ' - Paid');
                            repeat
                                Loans.CalcFields("Principal Repayment");
                                CurrentRecordNo += 1;
                                DailyBuffer.Paid += Loans."Principal Repayment";
                                DailyBuffer."Paid Count" := CurrentRecordNo;
                                DailyBuffer."Product Group" := ProductFactory."Loan Source";
                                dWindow.Update(2, CurrentRecordNo);
                                dWindow.Update(3, NoOfRecords);
                                dWindow.Update(1, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));
                            until Loans.Next = 0;
                        end;


                        DailyBuffer.Insert;

                    until ProductFactory.Next = 0;
                end;
                dWindow.Close;


                CompanyInformation.Get;
                CompanyInformation.CalcFields(Picture);

                Buffer.SetRange("User ID", UserId);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Start Date"; SDate)
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; EDate)
                {
                    ApplicationArea = Basic;
                }
                field(Branch; Branch)
                {
                    ApplicationArea = Basic;
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
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
        RSchedule: Record "Loan Repayment Schedule";
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
        Members: Record Members;
        Loans: Record Loans;
        SDate: Date;
        EDate: Date;
        DailyBuffer: Record "Daily Trans-Buffer";
        CompanyInformation: Record "Company Information";
        DateFilter: Text;
        Branch: Code[20];
        PDesc: Text;
}

