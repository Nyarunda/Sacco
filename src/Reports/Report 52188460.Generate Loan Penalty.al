
Report 50123 "Generate Loan Penalty"
{
    ProcessingOnly = true;
    Caption = 'Generate Loan Penalty';
    UsageCategory = Tasks;

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where(Posted = const(true), "Mobile Loan" = const(false), "Outstanding Principal" = filter('>0'), "Disbursement Date" = filter(<> ''), "Stop Penalty" = const(false));
            RequestFilterFields = "Member No.", "Loan No.", "Member Category";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            var
                LRec: Record Loans;
                LastDate: Date;
                TChannel: Enum "Transaction Channel";
                Customer: Record Customer;
                Members: Record Members;
                LoanType: Record "Product Setup";
            begin
                Loans.CalcFields("Last Int. Due Date", "Employer Code");
                if Customer.get(Loans."Employer Code") then begin
                    if Customer."Checkoff Agreement Date" <> '' then
                        CurrReport.skip;
                end;

                if Loans."Disbursement Date" > Today then
                    CurrReport.Skip();

                LoanType.Get(Loans."Loan Product Type");
                if LoanType."Nature of Loan Type" = LoanType."Nature of Loan Type"::Defaulter then
                    CurrReport.skip();

                Members.Get(Loans."Member No.");
                if (Members."Member Status" <> Members."Member Status"::New) and
                    (Members."Member Status" <> Members."Member Status"::Active) and
                    (Members."Member Status" <> Members."Member Status"::Dormant) then
                    CurrReport.Skip();

                NoOfRecords := Loans.Count;
                dWindow.Update(2, NoOfRecords);

                dWindow.Update(1, Loans."Member Name" + ' ' + Loans."Loan No.");
                CurrentRecordNo += 1;
                Exception := false;

                dWindow.Update(3, CurrentRecordNo);
                dWindow.Update(4, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));


                LRec.Reset;
                LRec.SetRange("Loan No.", Loans."Loan No.");
                LRec.SetFilter("Outstanding Principal", '<=0');
                if LRec.FindFirst then
                    CurrReport.Skip;


                SaccoActivities.GenerateLoanPenalty("Loan No.", PDate, false);

            end;

            trigger OnPostDataItem()
            begin
                ///SaccoActivities.JournalPost(JTemplate,JBatch);

                dWindow.Close;
                Message('Process Completed\%1\%2', JTemplate, JBatch);
            end;

            trigger OnPreDataItem()
            var
                IntDate: Date;
                Usersetup: Record "User Setup";
                IntBuffer: Record "Monthly Processes Buffer";
            begin

                Usersetup.Get(UserId);
                if not Usersetup."Generate Penalty" then
                    Error('You do not have permission to generate penalty');

                dWindow.Open('Generating Penalty:                 #1#########\'
                                    + 'Total Loans:                #2#########\'
                                    + 'Counter:                    #3#########\'
                                    + 'Progress:                   @4@@@@@@@@@\'
                                    + 'Press Esc to abort');



                SaccoSetup.Get;
                //SaccoSetup.TestField("Penalty Days From Exp. Pay Day");


                if PDate = 0D then
                    PDate := Today;

                IntBuffer.Reset;
                IntBuffer.SetRange(Posted, false);
                if IntBuffer.FindFirst then begin
                    IntBuffer.DeleteAll;
                end;

                //SaccoActivities.GetGeneralJournalTemplate(JTemplate, JBatch);

                //SaccoActivities.JournalInit(JTemplate, JBatch);

                //Loans.SETRANGE("Loan No.",'BLN1757');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Posting Date"; PDate)
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
        AcctType: Enum "Gen. Journal Account Type";
        BalAcctType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        ExpectedAmt: Decimal;
        AmtPaid: Decimal;
        DefAmount: Decimal;
        DaysInArrear: Integer;
        ArrearsDate: Date;
        LoanType: Record "Product Setup";
        DocNo: Code[20];
        PDate: Date;
        "Document No.": Code[20];
        LoanAmount: Decimal;
        CustMember: Record Members;
        CurrDate: Date;
        FirstMonthDate: Date;
        CurrMonth: Date;
        MidDate: Date;
        EndDate: Date;
        LastMonthDate: Date;
        FirstDay: Date;
        FirstDate: Date;
        IntCharged: Decimal;
        Principle: Decimal;
        MonthDays: Integer;
        dWindow: Dialog;
        CurrentRecordNo: Integer;
        NoOfRecords: Integer;
        SaccoActivities: Codeunit "Sacco Activities";
        BillDate: Date;
        Exception: Boolean;
        ProdFact: Record "Product Setup";
        Options: Option "Generate & Post","Generate Only";
        SaccoSetup: Record "Sacco Setup";
        IntDueDate: Date;
        CLedger: Record "Credit Ledger Entry";
        ExpectedPayDate: Date;
        MemberActivities: Codeunit "Member Activities";
        PenaltyDate: Date;
        JTemplate: Code[10];
        JBatch: Code[10];
        PenAmt: Decimal;
}

