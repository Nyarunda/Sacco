
report 50037 "Transfer UnAllocated"
{
    ApplicationArea = All;
    Caption = 'Transfer UnAllocated';
    ProcessingOnly = true;
    UsageCategory = History;
    dataset
    {
        dataitem("Savings Accounts"; "Savings Accounts")
        {
            DataItemTableView = where(Status = filter(Active | New | Dormant), "Balance (LCY)" = filter('>0'), "Product Category" = filter("Unallocated Fund"));

            trigger OnPreDataItem()
            var
                i: Integer;
                MonthlyBuffer: Record "Monthly Processes Buffer";
                SaccoActivities: Codeunit "Sacco Activities";
                GenJournalBatch: Record "Gen. Journal Batch";
            begin
                JTemplate := 'GENERAL';
                JBatch := 'UNALLOCATE';

                IF NOT GenJournalBatch.GET(Jtemplate, JBatch) THEN BEGIN
                    GenJournalBatch.INIT;
                    GenJournalBatch."Journal Template Name" := Jtemplate;
                    GenJournalBatch.Name := JBatch;
                    GenJournalBatch.INSERT;
                END;

                SaccoActivities.JournalInit(JTemplate, JBatch);


                if not Confirm('Kindly note the entries will be inserted into the general journal from which you will post them.') then
                    error('Aborting');


                dWindow.Open('Unallocated Transfer:     @1@@@@@@@@@\'
                                        + 'Counter   #2#########'
                                        + 'Total     #3#########'
                                        + 'Press Esc to abort');

                NoOfRecords := "Savings Accounts".Count;
            end;

            trigger OnAfterGetRecord()
            var
                MA: Codeunit "Member Activities";
                Members: Record Members;
                PSetup: Record "Product Setup";
            begin
                CurrentRecordNo += 1;

                MA.UnallocatedTransfer("Savings Accounts"."Member No.", PDate, JTemplate, JBatch);

                dWindow.Update(2, CurrentRecordNo);
                dWindow.Update(3, NoOfRecords);
                dWindow.Update(1, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));
            end;

            trigger OnPostDataItem()
            var
                SaccoActivities: Codeunit "Sacco Activities";
            begin
                dWindow.Close;
                //SaccoActivities.JournalPost(JTemplate, JBatch);
                Message('Unallocated funds were transferred  successfully.');
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
                        Visible = false;
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
    var
        PDate: Date;
        SourceAccount: Option " ",Deposits,FOSA;
        JTemplate: Code[10];
        JBatch: Code[10];
        dWindow: Dialog;
        NoOfRecords: Integer;
        CurrentRecordNo: Integer;
}
