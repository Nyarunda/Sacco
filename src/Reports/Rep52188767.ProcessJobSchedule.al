namespace CentralDB.CentralDB;

report 50449 "Process Job Schedule"
{
    Caption = 'Process Job Schedule';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
    }


    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(ProcessID; ProcessID)
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


    trigger OnPreReport()
    var
        myInt: Integer;
        Jobs: Codeunit "Custom Job Scheduler";
    begin
        if ProcessID <= 0 then
            ProcessAllSkyServiceJobs(Jobs)
        else begin
            if not (ProcessID in [12, 13, 14, 15]) then
                Error('Invalid Process ID %1. Use 12=DEPOSIT, 13=WITHDRAWAL, 14=MOBILE_LOAN_DISBURSEMENT, or 15=INTERNAL.', ProcessID);

            Jobs.processjob(ProcessID);
        end;
    end;

    local procedure ProcessAllSkyServiceJobs(var Jobs: Codeunit "Custom Job Scheduler")
    begin
        Jobs.processjob(12);
        Jobs.processjob(13);
        Jobs.processjob(14);
        Jobs.processjob(15);
    end;

    var
        ProcessID: integer;
}
