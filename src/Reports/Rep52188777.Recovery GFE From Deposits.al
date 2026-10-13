namespace CentralDB.CentralDB;

report 50459 "Recovery GFE From Deposits"
{
    ApplicationArea = All;
    Caption = 'Recovery GFE From Deposits';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Members; Members)
        {
            DataItemTableView = where("Member Status" = filter(New | Active | Dormant));

            trigger OnAfterGetRecord()
            var
                myInt: Integer;

            begin
                CurrentRecordNo += 1;

                SaccoActivities.RecoverBenevolentFromDeposits(Members."No.", Pdate, '', '', JTemplate, JBatch);

                dWindow.Update(2, CurrentRecordNo);
                dWindow.Update(3, NoOfRecords);
                dWindow.Update(1, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));
            end;

            trigger OnPreDataItem()
            var
                i: Integer;
                MonthlyBuffer: Record "Monthly Processes Buffer";
            begin
                if PDate = 0D then
                    Error('Posting date is required.');

                SaccoActivities.GetPaymentJournalTemplate(JTemplate, JBatch);
                SaccoActivities.JournalInit(JTemplate, JBatch);
                if (JTemplate = '') or (JBatch = '') then
                    Error('Payment Journal Batch and payment Template are required');

                if not Confirm('Kindly note the entries will be inserted into the Monthly buffer Table from which you will post them.', false) then
                    error('Aborting');

                MonthlyBuffer.reset();
                MonthlyBuffer.SetRange(Posted, false);
                if MonthlyBuffer.FindFirst() then
                    MonthlyBuffer.DeleteAll();

                dWindow.Open('Generating Schedules:     @1@@@@@@@@@\'
                                    + 'Counter   #2#########'
                                    + 'Total     #3#########'
                                    + 'Press Esc to abort');

                NoOfRecords := Members.Count;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(Pdate; Pdate)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        PDate: Date;
        JTemplate: Code[20];
        JBatch: Code[20];
        SaccoActivities: Codeunit "Sacco Activities";
        dWindow: Dialog;
        NoOfRecords: Integer;
        CurrentRecordNo: Integer;
}

