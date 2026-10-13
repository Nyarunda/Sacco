
Report 50076 "Product Activity Variance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Product Activity Variance.rdlc';

    dataset
    {
        dataitem(Buffer; "Product Trans. Analysis")
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
            column(ProductGroup_Buffer; Buffer."Product Group")
            {
            }
            column(DateFilter; DateFilter)
            {
            }
            column(Branch; Branch)
            {
            }
            column(ProductClassType_Buffer; Buffer."Product Class Type")
            {
            }
            column(LowerDate_Buffer; Buffer."Lower Date")
            {
            }
            column(UpperDate_Buffer; Buffer."Upper Date")
            {
            }
            column(Variance_Buffer; Buffer.Variance)
            {
            }
            column(SDate; Format(SDate))
            {
            }
            column(EDate; Format(EDate))
            {
            }
            column(ProductCategory_Buffer; Buffer."Product Category")
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
                //ProductFactory.SETRANGE("Product Class Type",ProductFactory."Product Class Type"::Loan);
                if ProductFactory.Find('-') then begin
                    repeat

                        DailyBuffer.Init;
                        DailyBuffer."Product ID" := ProductFactory."Product ID";
                        DailyBuffer."User ID" := UserId;
                        DailyBuffer."Product Class Type" := ProductFactory."Product Class";
                        DailyBuffer."Product Category" := ProductFactory."Product Category";

                        if ProductFactory."Product Class" = ProductFactory."product class"::Credit then begin

                            Loans.Reset;
                            Loans.SetRange("Loan Product Type", ProductFactory."Product ID");
                            Loans.SetRange(Loans.Posted, true);
                            Loans.SetRange("Date Filter", 0D, SDate);
                            if Branch <> '' then
                                Loans.SetRange("Booking Branch", Branch);
                            if Loans.Find('-') then begin
                                CurrentRecordNo := 0;
                                NoOfRecords := Loans.Count;
                                dWindow.Update(4, ProductFactory."Product ID" + ' - Lower Limit');
                                repeat
                                    Loans.CalcFields("Outstanding Principal");
                                    CurrentRecordNo += 1;
                                    DailyBuffer."Lower Date" += Loans."Outstanding Principal";
                                    DailyBuffer."Product Group" := ProductFactory."Loan Source";
                                    dWindow.Update(2, CurrentRecordNo);
                                    dWindow.Update(3, NoOfRecords);
                                    dWindow.Update(1, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));
                                until Loans.Next = 0;
                            end;

                            Loans.Reset;
                            Loans.SetRange("Loan Product Type", ProductFactory."Product ID");
                            Loans.SetRange(Loans.Posted, true);
                            Loans.SetRange("Date Filter", 0D, EDate);
                            if Branch <> '' then
                                Loans.SetRange("Booking Branch", Branch);
                            if Loans.Find('-') then begin
                                CurrentRecordNo := 0;
                                NoOfRecords := Loans.Count;
                                dWindow.Update(4, ProductFactory."Product ID" + ' - Upper Limit');
                                repeat
                                    Loans.CalcFields("Outstanding Principal");
                                    CurrentRecordNo += 1;
                                    DailyBuffer."Upper Date" += Loans."Outstanding Principal";
                                    DailyBuffer."Product Group" := ProductFactory."Loan Source";
                                    dWindow.Update(2, CurrentRecordNo);
                                    dWindow.Update(3, NoOfRecords);
                                    dWindow.Update(1, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));
                                until Loans.Next = 0;
                            end;



                        end;


                        if ProductFactory."Product Class" = ProductFactory."product class"::Savings then begin

                            SavAcc.Reset;
                            SavAcc.SetRange("Product Type", ProductFactory."Product ID");
                            SavAcc.SetRange("Date Filter", 0D, SDate);
                            if Branch <> '' then
                                SavAcc.SetRange("Global Dimension 2 Code", Branch);
                            if SavAcc.Find('-') then begin
                                CurrentRecordNo := 0;
                                NoOfRecords := SavAcc.Count;
                                dWindow.Update(4, ProductFactory."Product ID" + ' - Lower Limit');
                                repeat
                                    SavAcc.CalcFields("Balance (LCY)");
                                    CurrentRecordNo += 1;
                                    DailyBuffer."Lower Date" += SavAcc."Balance (LCY)";
                                    dWindow.Update(2, CurrentRecordNo);
                                    dWindow.Update(3, NoOfRecords);
                                    dWindow.Update(1, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));
                                until SavAcc.Next = 0;
                            end;

                            SavAcc.Reset;
                            SavAcc.SetRange("Product Type", ProductFactory."Product ID");
                            SavAcc.SetRange("Date Filter", 0D, EDate);
                            if Branch <> '' then
                                SavAcc.SetRange("Global Dimension 2 Code", Branch);
                            if SavAcc.Find('-') then begin
                                CurrentRecordNo := 0;
                                NoOfRecords := SavAcc.Count;
                                dWindow.Update(4, ProductFactory."Product ID" + ' - Upper Limit');
                                repeat
                                    SavAcc.CalcFields("Balance (LCY)");
                                    CurrentRecordNo += 1;
                                    DailyBuffer."Upper Date" += SavAcc."Balance (LCY)";
                                    dWindow.Update(2, CurrentRecordNo);
                                    dWindow.Update(3, NoOfRecords);
                                    dWindow.Update(1, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));
                                until SavAcc.Next = 0;
                            end;

                        end;


                        DailyBuffer.Variance := DailyBuffer."Upper Date" - DailyBuffer."Lower Date";

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
                field("Lower Limit Date"; SDate)
                {
                    ApplicationArea = Basic;
                }
                field("Upper Limit Date"; EDate)
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
        SaccoActivities: Codeunit "Sacco Activities";
        dWindow: Dialog;
        NoOfRecords: Integer;
        CurrentRecordNo: Integer;
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
        SDate: Date;
        EDate: Date;
        DailyBuffer: Record "Product Trans. Analysis";
        CompanyInformation: Record "Company Information";
        DateFilter: Text;
        Branch: Code[20];
        Loans: Record Loans;
        SavAcc: Record "Savings Accounts";
        PDesc: Text;
}

