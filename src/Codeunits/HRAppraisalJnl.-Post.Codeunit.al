Codeunit 50077 "HR Appraisal Jnl.-Post"
{
    TableNo = "HR Appraisal Journal Line";

    trigger OnRun()
    begin
        InsuranceJnlLine.Copy(Rec);
        Code;
        Rec.Copy(InsuranceJnlLine);
    end;

    var
        Text000: label 'Do you want to post the journal lines?';
        Text001: label 'There is nothing to post.';
        Text002: label 'The journal lines were successfully posted.';
        Text003: label 'The journal lines were successfully posted. You are now in the %1 journal.';
        InsuranceJnlTempl: Record "HR Appraisal Journal Template";
        InsuranceJnlLine: Record "HR Appraisal Journal Line";
        InsuranceJnlPostBatch: Codeunit "HR Appraisal Jnl.-Post Batch";
        TempJnlBatchName: Code[10];

    local procedure "Code"()
    begin
        InsuranceJnlTempl.Get(InsuranceJnlLine."Journal Template Name");
        InsuranceJnlTempl.TestField("Force Posting Report", false);

        if not Confirm(Text000, false) then
            exit;

        TempJnlBatchName := InsuranceJnlLine."Journal Batch Name";

        InsuranceJnlPostBatch.Run(InsuranceJnlLine);

        if InsuranceJnlLine."Line No." = 0 then
            Message(Text001)
        else
            if TempJnlBatchName = InsuranceJnlLine."Journal Batch Name" then
                Message(Text002)
            else
                Message(
                  Text003,
                  InsuranceJnlLine."Journal Batch Name");

        if not InsuranceJnlLine.Find('=><') or (TempJnlBatchName <> InsuranceJnlLine."Journal Batch Name") then begin
            InsuranceJnlLine.Reset;
            InsuranceJnlLine.FilterGroup := 2;
            InsuranceJnlLine.SetRange("Journal Template Name", InsuranceJnlLine."Journal Template Name");
            InsuranceJnlLine.SetRange("Journal Batch Name", InsuranceJnlLine."Journal Batch Name");
            InsuranceJnlLine.FilterGroup := 0;
            InsuranceJnlLine."Line No." := 1;
        end;
    end;
}

