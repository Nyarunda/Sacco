
Codeunit 50083 "HR Leave Jnl.-Post"
{
    TableNo = "HR Leave Journal Line.";

    trigger OnRun()
    begin
        HRJournalLine.Copy(Rec);
        Code;
        Rec.Copy(HRJournalLine);
    end;

    var
        Text000: label 'Do you want to post the journal lines?';
        Text001: label 'There is nothing to post.';
        Text002: label 'The journal lines were successfully posted.';
        Text003: label 'The journal lines were successfully posted. You are now in the %1 journal.';
        HRJournalLineTemplate: Record "HR Leave Journal Template.";
        HRJournalLine: Record "HR Leave Journal Line.";
        HRJournalPostBatch: Codeunit "HR Leave Jnl.- Post Batch";
        TempJnlBatchName: Code[10];
        Text004: label 'Since you are making a Negative Adjustment, "Number of Days" Should be Less Than Zero and not %1';

    local procedure "Code"()
    begin

        HRJournalLineTemplate.Get(HRJournalLine."Journal Template Name");
        HRJournalLineTemplate.TestField("Force Posting Report", false);

        //   IF NOT CONFIRM(Text000,FALSE) THEN
        //     EXIT;

        TempJnlBatchName := HRJournalLine."Journal Batch Name";

        HRJournalPostBatch.Run(HRJournalLine);

        if HRJournalLine."Line No." = 0 then
            Message(Text001)
        else
            if TempJnlBatchName = HRJournalLine."Journal Batch Name" then begin
                Message(Text002);
                HRJournalLine.DeleteAll
            end
            else begin
                Message(
                  Text003,
              HRJournalLine."Journal Batch Name");
            end;
        if not HRJournalLine.Find('=><') or (TempJnlBatchName <> HRJournalLine."Journal Batch Name") then begin
            HRJournalLine.Reset;
            HRJournalLine.FilterGroup := 2;
            HRJournalLine.SetRange("Journal Template Name", HRJournalLine."Journal Template Name");
            HRJournalLine.SetRange("Journal Batch Name", HRJournalLine."Journal Batch Name");
            HRJournalLine.FilterGroup := 0;
            HRJournalLine."Line No." := 1;
        end;
    end;
}

