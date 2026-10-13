namespace CentralDB.CentralDB;
using Microsoft.Sales.Customer;
using Microsoft.Finance.GeneralLedger.Journal;
using System.Security.User;

report 50476 "Genarete Loan Penalty Checkoff"
{
    Caption = 'Genarete Loan Penalty Checkoff';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where(Posted = const(true), "Mobile Loan" = const(false), "Outstanding Principal" = filter('>0'), "Disbursement Date" = filter(<> ''), "Stop Interest Due" = const(false), "Loan Product Type" = filter(<> 'L43' & <> 'L30'));
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            var
                LRec: Record Loans;
                LastDate: Date;
                TChannel: Enum "Transaction Channel";
                Customer: Record Customer;
                LSchedule: Record "Loan Repayment Schedule";
                Members: Record Members;
            begin
                Loans.CalcFields("Last Int. Due Date", "Employer Code");
                if Customer.get(Loans."Employer Code") then begin
                    if Customer."Checkoff Agreement Date" = '' then
                        CurrReport.skip;
                end;

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


                LSchedule.Reset();
                LSchedule.SetRange("Loan No.", "Loan No.");
                LSchedule.SetRange("Repayment Date", CalcDate('+3D', PDate));
                if LSchedule.FindFirst() then
                    SaccoActivities.GenerateLoanPenalty(LSchedule."Loan No.", PDate, false);
            end;

            trigger OnPostDataItem()
            begin
                dWindow.Close;
                Message('Process Completed\%1\%2', JTemplate, JBatch);
            end;

            trigger OnPreDataItem()
            var
                IntDate: Date;
                Usersetup: Record "User Setup";
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

                if PDate = 0D then
                    PDate := Today;
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


