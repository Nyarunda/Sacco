namespace AL_.AL_;

report 50466 "Generate M Loan Schedule"
{
    Caption = 'Generate M Loan Schedule';
    ProcessingOnly = true;
    dataset
    {
        dataitem(RolloverLogs; "Rollover Logs")
        {
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin

                if Loans.Get(RolloverLogs."Loan no.") then begin
                    if Loans.Installments = 1 then begin
                        Loans.Installments += 1;
                        Loans."Completion Date" := CalcDate('+1M', Loans."Completion Date");
                        Loans.Modify();
                        Commit();
                        SaccoActivities.GenerateMobileRepaymentSchedule(Loans);
                        Commit();
                    end;
                end;
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
        Loans: Record Loans;
        SaccoActivities: Codeunit "Sacco Activities";
}
