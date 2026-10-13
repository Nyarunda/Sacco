
Report 51008 "Interest Refund"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Interest Refund.rdlc';

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where("Repay Mode" = const(Salary));
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



                DefAmount := 0;
                Variance := 0;

                GetDefaultedAmount(Loans."Loan No.", Today, ExpectedAmt, AmtPaid, DefAmount, DaysInArrear, ArrearsDate, false);

                if DefAmount < 0 then begin
                    Variance := DefAmount * -1;
                end;


                if Variance > 0 then begin


                    LoanType.TestField("Loan Interest Income [G/L]");
                    SaccoActivities.JournalInsert(
                        JTemplate,
                        JBatch,
                        'PREF-' + "Loan No.",
                        PDate,
                        AccType::Credit,
                        Loans."Member No.",
                        'Principal Refund',
                        AccType::"G/L Account",
                        '',
                        Variance,
                        "Loan No.",
                        Loans."Loan No.",
                        Transtype::"Principal Repayment",
                        "Global Dimension 1 Code",
                        "Booking Branch",
                        true,
                        TChannel::" ",
                        0
                        );

                    Accounts.Reset();
                    Accounts.SetRange("Member No.", Loans."Member No.");
                    Accounts.SetRange("Product Category", Accounts."Product Category"::"Ordinary Savings");
                    if not Accounts.FindFirst() then begin
                        Members.get(Loans."Member No.");
                        ProductFactory.Reset();
                        ProductFactory.SetRange("Product Category", ProductFactory."Product Category"::"Ordinary Savings");
                        if ProductFactory.FindFirst() then
                            MActivities.CreateSavingsAccount(ProductFactory, Members, 0, true, ProductFactory."Repay Mode");
                    end;

                    Accounts.Reset();
                    Accounts.SetRange("Member No.", Loans."Member No.");
                    Accounts.SetRange("Product Category", Accounts."Product Category"::"Ordinary Savings");
                    if Accounts.FindFirst() then begin

                        SaccoActivities.JournalInsert(
                            JTemplate,
                            JBatch,
                            'PREF-' + "Loan No.",
                            PDate,
                            AccType::Savings,
                            Accounts."No.",
                            'Principal Refund',
                            AccType::"G/L Account",
                            '',
                            -Variance,
                            "Loan No.",
                            Loans."Loan No.",
                            Transtype::" ",
                            "Global Dimension 1 Code",
                            "Booking Branch",
                            true,
                            TChannel::" ",
                            0
                            );


                    end
                    else begin

                        SaccoActivities.JournalInsert(
                            JTemplate,
                            JBatch,
                            'PREF-' + "Loan No.",
                            PDate,
                            AccType::Savings,
                            Loans."Disbursement Account No",
                            'Principal Refund',
                            AccType::"G/L Account",
                            '',
                            -Variance,
                            "Loan No.",
                            Loans."Loan No.",
                            Transtype::" ",
                            "Global Dimension 1 Code",
                            "Booking Branch",
                            true,
                            TChannel::" ",
                            0
                            );

                    end;

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

                Loans.SetFilter("Disbursement Date", '%1..%2', DMY2Date(01, 12, 2022), DMY2Date(23, 01, 2023));
                Loans.SetFilter("Loan product type", '<>L07&<>L08&<>L09&<>L05');
                //l07,8,9,5
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

        AmountPaid: Decimal;
        LRec: Record loans;
        ProductType: Text;
        ExpectedAmt: Decimal;
        AmtPaid: Decimal;
        DefAmount: Decimal;
        DaysInArrear: Integer;
        ArrearsDate: Date;
        Accounts: Record "Member Accounts";
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
        MActivities: codeunit "MEmber Activities";
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


    procedure GetDefaultedAmount(LoanNo: Code[20]; AsAt: Date; var ExpectedAmt: Decimal; var AmtPaid: Decimal; var DefAmount: Decimal; var DaysInArrear: Integer; var ArrearsDate: Date; CurrentPayment: Boolean)
    var
        Loans: Record Loans;
        LSchedule: Record "Loan Repayment Schedule";
        LastDate: Date;
        TRep: Decimal;
    begin

        ExpectedAmt := 0;
        AmtPaid := 0;
        DefAmount := 0;
        DaysInArrear := 0;

        Loans.Reset;
        Loans.SetRange("Loan No.", LoanNo);
        if CurrentPayment then
            Loans.SetFilter("Date Filter", '..%1', Today)
        else
            Loans.SetFilter("Date Filter", '..%1', AsAt);
        if Loans.FindFirst then begin
            Loans.CalcFields("Outstanding Principal");
            AmtPaid := Loans."Approved Amount" - Loans."Outstanding Principal";

            if (Loans."Loan Rescheduled") then begin

                LSchedule.Reset;
                LSchedule.SetRange("Loan No.", Loans."Loan No.");
                //LSchedule.SETFILTER("Monthly Principal",'>%1',0);
                if LSchedule.FindFirst then begin

                    Loans.Reset;
                    Loans.SetRange("Loan No.", LoanNo);
                    if CurrentPayment then
                        Loans.SetFilter("Date Filter", '%1..%2', CalcDate('-CM', LSchedule."Repayment Date"), Today)
                    else
                        Loans.SetFilter("Date Filter", '%1..%2', CalcDate('-CM', LSchedule."Repayment Date"), AsAt);
                    if Loans.FindFirst then begin
                        Loans.CalcFields("Principal Repayment");
                        AmtPaid := Loans."Principal Repayment";
                    end;
                end;
            end;
        end;



        if AmtPaid < 0 then
            AmtPaid := 0;





        Loans.Reset;
        Loans.SetRange("Loan No.", LoanNo);
        Loans.SetFilter("Date Filter", '..%1', AsAt);
        if Loans.FindFirst then begin
            Loans.CalcFields("Schedule Principal");
            if Loans."Disbursement Date" = 0D then
                Loans."Disbursement Date" := Loans."Application Date";

            //Loans.TestField("Disbursement Date");

            ExpectedAmt := Loans."Schedule Principal";

            LastDate := Loans."Repayment Start Date";
        end;

        DefAmount := ExpectedAmt - AmtPaid;


        LSchedule.Reset;
        LSchedule.SetRange("Loan No.", Loans."Loan No.");
        LSchedule.SetFilter("Monthly Principal", '>%1', 0);
        if LSchedule.FindFirst then begin
            repeat
                TRep += LSchedule."Monthly Principal";
                if AmtPaid >= TRep then
                    LastDate := LSchedule."Repayment Date";
            until (LSchedule.Next = 0);
        end;

        //MESSAGE('%1',DefAmount);
        if DefAmount > 0 then begin
            ArrearsDate := Loans."Repayment Start Date";
            LSchedule.Reset;
            LSchedule.SetRange("Loan No.", Loans."Loan No.");
            LSchedule.SetFilter("Repayment Date", '%1..', LastDate);
            if LSchedule.FindFirst then
                ArrearsDate := LSchedule."Repayment Date" + 1;

            DaysInArrear := AsAt - ArrearsDate;
            DaysInArrear += 1;
        end
        else
            DaysInArrear := 0;
    end;

}

