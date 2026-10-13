
Report 51007 "Div Interest Correction"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Div Interest Correction.rdlc';

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where("Loan Product Type" = const('L16'), "Outstanding Interest" = filter(> 0));
            column(Loan_No_; "Loan No.")
            {

            }
            column(Member_No_; "Member No.")
            {

            }
            column(Member_Name; "Member Name")
            {

            }
            column(Loan_Product_Type_Name; "Loan Product Type Name")
            {

            }
            column(Disbursement_Date; "Disbursement Date")
            {

            }
            column(Outstanding_Principal; "Outstanding Principal")
            {
            }
            column(ExpectedInterest; ExpectedInterest)
            {

            }
            column(InterestCharged; InterestCharged)
            {

            }
            column(Variance; Variance)
            {

            }

            trigger OnAfterGetRecord()
            var
                TChannel: Enum "Transaction Channel";

            begin

                CurrentRecordNo += 1;
                dWindow.Update(2, CurrentRecordNo);
                dWindow.Update(3, NoOfRecords);
                dWindow.Update(1, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));

                ExpectedInterest := 0;
                InterestCharged := 0;
                Variance := 0;
                PDate := today;
                Members.get(Loans."Member No.");
                if Members.Blocked <> Members.Blocked::" " then begin
                    Members.Blocked := Members.Blocked::" ";
                    Members.Modify();
                end;

                Loans.calcfields("Outstanding Interest");

                InterestCharged := Loans."Outstanding Interest";

                LoanType.Get("Loan Product Type");

                if InterestCharged > 0 then begin

                    Variance := InterestCharged - ExpectedInterest;

                    LoanType.TestField("Loan Interest Income [G/L]");
                    SaccoActivities.JournalInsert(
                        JTemplate,
                        JBatch,
                        'DC-' + "Loan No.",
                        PDate,
                        AccType::Credit,
                        Loans."Member No.",
                        'Interest Due Reversal',
                        AccType::"G/L Account",
                        LoanType."Loan Interest Income [G/L]",
                        -Variance,
                        "Loan No.",
                        Loans."Loan No.",
                        Transtype::"Interest Due",
                        "Global Dimension 1 Code",
                        "Booking Branch",
                        true,
                        TChannel::" ",
                        0
                        );


                end;


                if Variance = 0 then
                    CurrReport.Skip();
            End;

            trigger OnPostDataItem()
            begin
                dWindow.Close;
                Message('%1\%2', JTemplate, JBatch);
            end;

            trigger OnPreDataItem()
            begin

                //Loans.SetFilter("Disbursement Date", '%1..', DMY2Date(01, 12, 2022));
                dWindow.Open('Corrections :              @1@@@@@@@@@\'
                                            + 'Counter   #2#########'
                                            + 'Total     #3#########'
                                            + 'Press Esc to abort');

                NoOfRecords := Count;



                JTemplate := '';
                JBatch := '';

                SaccoActivities.GetGeneralJournalTemplate(JTemplate, JBatch);


                SaccoActivities.JournalInit(JTemplate, JBatch);
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
        SaccoActivities: Codeunit "Sacco Activities";
        dWindow: Dialog;
        NoOfRecords: Integer;
        CurrentRecordNo: Integer;
        Updated: Boolean;
        ProductSetup: Record "Product Setup";
        DepositProduct: Code[10];
        ShareCapProduct: Code[10];
        AsAt: Date;
        ProductFactory: Record "Product Setup";
        MinDeposits: Decimal;
        Found: Boolean;
        Amount: array[5] of Decimal;
        Temp: Record "User Setup";
        JTemplate: Code[20];
        JBatch: Code[20];
        LineN: Integer;
        TransType: Enum "Transaction Type Enum";
        AccType: Enum "Gen. Journal Account Type";
        AccountNo: array[3] of Code[20];
        Description: array[3] of Text;
        membno: Code[50];
        JLine: Record "Gen. Journal Line";
        MinShares: Decimal;
        DepAccount: Record "Savings Accounts";
        ShareCapitalNos: Record "Share Capital Nos";
        DepAcc: Code[20];
        PDate: Date;
        DepAmt: Decimal;
        Variance: Decimal;
        ExpectedInterest: Decimal;
        InterestCharged: Decimal;
        CLedger: Record "Credit Ledger Entry";
        LoanType: Record "Product Setup";
        MonthlyInterest: Decimal;
        TDays: Integer;
        Days: Integer;
        EndMonth: Date;
        IntDue: Decimal;
        CurrDay: Integer;
        Members: Record Members;
}

