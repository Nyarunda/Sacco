report 50588 "Delete Loan Schedules"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'Delete Imported Loan Schedules';
    ProcessingOnly = true;

    dataset
    {
        dataitem(Schedule; "Loan Repayment Schedule")
        {
            DataItemTableView = where("Line No." = filter(>= 1000));
            trigger OnPreDataItem()
            var
                Loan: Record "Old Loans";
                ToDelete: List of [RecordID];
                RecRef: RecordRef;
                i: Integer;
            begin
                DeleteCount := 0;
                Schedule.FindSet();
                repeat
                    Loan.Reset();
                    Loan.SetRange("Loan  No.", Schedule."Loan No.");
                    if not Loan.FindFirst() then begin
                        ToDelete.Add(Schedule.RecordId);
                    end;
                    
                until Schedule.Next() = 0;

                if ToDelete.Count = 0 then begin
                    Message('No imported schedule lines found for deletion.');
                    CurrReport.Break();
                end;

                for i := 1 to ToDelete.Count do begin
                    RecRef.Get(ToDelete.Get(i));
                    RecRef.Delete();
                    DeleteCount += 1;
                end;

                CurrReport.Break();
            end;
        }
    }

    trigger OnPostReport()
    begin
        Message('%1 imported loan schedule line(s) with Line No. >= 1000 were deleted.', DeleteCount);
    end;

    var
        DeleteCount: Integer;
}