report 50445 "Share Capital Recovery"
{
    Caption = 'Share Capital Recovery';
    ProcessingOnly = true;
    dataset
    {
        dataitem("Savings Accounts"; "Savings Accounts")
        {
            DataItemTableView = where(Status = filter(New | Active | Dormant), "Product Category" = filter("Share Capital"));
            RequestFilterFields = "No.";
            trigger OnPreDataItem()
            var
                i: Integer;
                MonthlyBuffer: Record "Monthly Processes Buffer";
                SaccoActivities: Codeunit "Sacco Activities";
            begin

                SaccoActivities.GetPaymentJournalTemplate(JTemplate, JBatch);
                SaccoActivities.JournalInit(JTemplate, JBatch);

                if SourceAccount = SourceAccount::" " then
                    Error('Source of funds account must have a value');

                if not Confirm('Kindly note the entries will be inserted into the Monthly buffer Table from which you will post them.') then
                    error('Aborting');

                MonthlyBuffer.reset();
                MonthlyBuffer.SetRange(Posted, false);
                if MonthlyBuffer.FindFirst() then
                    MonthlyBuffer.DeleteAll();

                dWindow.Open('Generating Share Capital:     @1@@@@@@@@@\'
                                        + 'Counter   #2#########'
                                        + 'Total     #3#########'
                                        + 'Press Esc to abort');

                NoOfRecords := "Savings Accounts".Count;
            end;

            trigger OnAfterGetRecord()
            var
                MA: Codeunit "Member Activities";
            begin
                CurrentRecordNo += 1;

                MA.SharesAutoRecoveryFromDeposits("Savings Accounts"."Member No.", PDate, SourceAccount);

                dWindow.Update(2, CurrentRecordNo);
                dWindow.Update(3, NoOfRecords);
                dWindow.Update(1, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));
            end;

            trigger OnPostDataItem()
            var
                myInt: Integer;
            begin
                dWindow.Close;
                Message('Done processing %1 %2', Jtemplate, JBatch);
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
                    field(PDate; PDate)
                    {
                        ApplicationArea = basic;
                    }
                    field(SourceAccount; SourceAccount)
                    {
                        ApplicationArea = basic;
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
    Var
        PDate: Date;
        SourceAccount: Option " ",Deposits,FOSA;
        JTemplate: Code[20];
        JBatch: Code[20];
        dWindow: Dialog;
        NoOfRecords: Integer;
        CurrentRecordNo: Integer;
}
