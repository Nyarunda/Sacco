
report 50461 "Recover Registration From Depo"
{
    Caption = 'Recover Registration From Depo';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem("Savings Accounts"; "Savings Accounts")
        {
            DataItemTableView = where(Status = filter(Active | New | Dormant), "Balance (LCY)" = filter('<1000'), "Product Category" = filter("Registration Fee"));

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

                dWindow.Open('Registration Fee Recovery:     @1@@@@@@@@@\'
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

                PSetup.Reset();
                PSetup.SetRange("Product Category", PSetup."Product Category"::"Registration Fee");
                if PSetup.FindFirst() then;

                Members.Get("Savings Accounts"."Member No.");
                Members.TestField("Member Class");

                if SourceAccount = SourceAccount::FOSA then
                    if Members."Member Class" = 'CLASS A' then
                        CurrReport.Skip();

                if (Members."Registration Date" <> 0D) and (Members.Type = Members.Type::Member) then begin
                    if Members."Registration Date" >= PSetup."Registration Start Date" then
                        MA.RegistrationFeeAutoRecoveryFromDeposits("Savings Accounts"."Member No.", PDate, SourceAccount);
                end;

                dWindow.Update(2, CurrentRecordNo);
                dWindow.Update(3, NoOfRecords);
                dWindow.Update(1, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));
            end;

            trigger OnPostDataItem()
            var
                myInt: Integer;
            begin
                dWindow.Close;
                Message('Registration Recovery Done %1 %2', JTemplate, JBatch);
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
    var
        PDate: Date;
        SourceAccount: Option " ",Deposits,FOSA;
        JTemplate: Code[20];
        JBatch: Code[20];
        dWindow: Dialog;
        NoOfRecords: Integer;
        CurrentRecordNo: Integer;
}
