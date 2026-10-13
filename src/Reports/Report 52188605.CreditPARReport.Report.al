Report 50268 "Credit PAR Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Credit PAR Report.rdlc';

    dataset
    {
        dataitem(Buffer; "Daily Trans-Buffer")
        {
            column(ReportForNavId_4645; 4645)
            {
            }
            column(LoanBalance_Buffer; Buffer."Loan Balance")
            {
            }
            column(NonPerforming_Buffer; Buffer."Non-Performing")
            {
            }
            column(DefaultedAmount_Buffer; Buffer."Defaulted Amount")
            {
            }
            column(PAR_Buffer; Buffer.PAR)
            {
            }
            column(CompPicture; CompanyInformation.Picture)
            {
            }
            column(CompName; CompanyInformation.Name)
            {
            }
            column(ProductID_Buffer; Buffer."Product ID")
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

            trigger OnPreDataItem()
            var
                GracePeriod: DateFormula;
            begin

                dWindow.Open('Updating Accounts:        @1@@@@@@@@@\'
                                            + 'Counter   #2#########'
                                            + 'Total     #3#########'
                                            + 'Product   #4#########'
                                            + 'Press Esc to abort');


                DailyBuffer.Reset;
                DailyBuffer.SetRange("User ID", UserId);
                DailyBuffer.DeleteAll;

                DateFilter := '..' + Format(EDate);

                ProductFactory.Reset;
                ProductFactory.SetRange("Product Class", ProductFactory."product class"::Credit);
                if ProductFactory.Find('-') then begin
                    repeat

                        CurrentRecordNo := 0;
                        PDefault := 0;

                        DailyBuffer.Init;
                        DailyBuffer."Product ID" := ProductFactory.Description;
                        DailyBuffer."User ID" := UserId;

                        Loans.Reset;
                        Loans.SetRange("Loan Product Type", ProductFactory."Product ID");
                        Loans.SetRange("Date Filter", 0D, EDate);
                        if Branch <> '' then
                            Loans.SetRange("Booking Branch", Branch);
                        Loans.SetRange(Loans.Posted, true);
                        Loans.SetFilter("Outstanding Principal", '<>0');
                        if Loans.Find('-') then begin
                            NoOfRecords := Loans.Count;
                            dWindow.Update(4, ProductFactory."Product ID");
                            repeat
                                CurrentRecordNo += 1;
                                CountMonths := 0;
                                AmtDefaulted := 0;
                                Loans.CalcFields("Outstanding Principal");

                                DailyBuffer."Loan Balance" += Loans."Outstanding Principal";


                                LoansProcess.GetDefaultedAmount(Loans."Loan No.", EDate, Expected, Paid, AmtDefaulted, DaysInArrear, ArrearsDate, false, GracePeriod);
                                CountMonths := ROUND(DaysInArrear / 30, 1, '=');

                                if Loans."Loan Product Type" = 'M-YETU' then begin
                                    if (Loans."Disbursement Date" = 0D) or (Loans."Disbursement Date" <= 20180914D) then begin
                                        CountMonths := 2;
                                    end;
                                end;


                                /*
                                CASE CountMonths OF
                                  0: Loans."Current Loans Category-SASRA":=Loans."Current Loans Category-SASRA"::Perfoming;
                                  1: Loans."Current Loans Category-SASRA":=Loans."Current Loans Category-SASRA"::Watch;
                                  2..6: Loans."Current Loans Category-SASRA":=Loans."Current Loans Category-SASRA"::Substandard;
                                  7..12: Loans."Current Loans Category-SASRA":=Loans."Current Loans Category-SASRA"::Doubtful;
                                  ELSE Loans."Current Loans Category-SASRA":=Loans."Current Loans Category-SASRA"::Loss;
                                END;
                                */

                                DailyBuffer."Defaulted Amount" += AmtDefaulted;
                                if CountMonths >= 1 then
                                    DailyBuffer."Non-Performing" += Loans."Outstanding Principal";

                                DailyBuffer."Product Group" := ProductFactory."Loan Source";

                                dWindow.Update(2, CurrentRecordNo);
                                dWindow.Update(3, NoOfRecords);
                                dWindow.Update(1, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));
                            until Loans.Next = 0;
                        end;
                        if DailyBuffer."Loan Balance" > 0 then
                            DailyBuffer.PAR := ROUND(DailyBuffer."Non-Performing" / DailyBuffer."Loan Balance" * 100);
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
                field("As At"; EDate)
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
        LoansProcess: Codeunit "Sacco Activities";
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
        Members: Record Members;
        Loans: Record Loans;
        SDate: Date;
        EDate: Date;
        DailyBuffer: Record "Daily Trans-Buffer";
        CompanyInformation: Record "Company Information";
        DateFilter: Text;
        Branch: Code[20];
        CountMonths: Integer;
        AmtDefaulted: Decimal;
        PDefault: Decimal;
        DaysInArrear: Integer;
        ArrearsDate: Date;
}

