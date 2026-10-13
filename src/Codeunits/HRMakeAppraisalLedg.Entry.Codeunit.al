Codeunit 50079 "HR Make Appraisal Ledg. Entry"
{

    trigger OnRun()
    begin
    end;


    /*procedure CopyFromJnlLine(var InsCoverageLedgEntry: Record "HR Leave Ledger Entries."; var InsuranceJnlLine: Record "HR Appraisal Journal Line")
    begin
        with InsCoverageLedgEntry do begin
            "User ID" := UserId;
            "Appraisal Period" := InsuranceJnlLine."Appraisal Period";
            "Staff No." := InsuranceJnlLine."Staff No.";
            "Staff Name" := InsuranceJnlLine."Staff Name";
            "Posting Date" := InsuranceJnlLine."Posting Date";
            "Appraisal Entry Type" := InsuranceJnlLine."Appraisal Entry Type";
            "Appraisal Type" := InsuranceJnlLine."Appraisal Type";
            "Appraisal Approval Date" := InsuranceJnlLine."Appraisal Approval Date";
            if "Appraisal Approval Date" = 0D then
                "Appraisal Approval Date" := "Posting Date";
            "Document No." := InsuranceJnlLine."Document No.";
            "External Document No." := InsuranceJnlLine."External Document No.";
            Score := InsuranceJnlLine.Score;
            "Appraisal Posting Description" := InsuranceJnlLine.Description;
            "Global Dimension 1 Code" := InsuranceJnlLine."Shortcut Dimension 1 Code";
            "Global Dimension 2 Code" := InsuranceJnlLine."Shortcut Dimension 2 Code";
            "Source Code" := InsuranceJnlLine."Source Code";
            "Journal Batch Name" := InsuranceJnlLine."Journal Batch Name";
            "Reason Code" := InsuranceJnlLine."Reason Code";
            Closed := SetDisposedFA(InsCoverageLedgEntry."Staff No.");
            "No. Series" := InsuranceJnlLine."Posting No. Series";
            "Self Appraisal" := InsuranceJnlLine."Self Rating";
            "Supervisor Appraisal" := InsuranceJnlLine."Supervisor Rating";
            "Agreed Appraisal" := InsuranceJnlLine."Agreed Rating";
        end;
    end; */


    procedure CopyFromInsuranceCard(var InsCoverageLedgEntry: Record "HR Leave Ledger Entries."; var Insurance: Record "HR Appraisal Journal Line")
    begin
        /*WITH InsCoverageLedgEntry DO BEGIN
          "FA Class Code" := Insurance."FA Class Code";
          "FA Subclass Code" := Insurance."FA Subclass Code";
          "FA Location Code" := Insurance."FA Location Code";
          "Location Code" := Insurance."Location Code";
        END;*/

    end;


    procedure SetDisposedFA(FANo: Code[20]): Boolean
    var
        FASetup: Record "HR Setup.";
    begin
        /*FASetup.GET;
        FASetup.TESTFIELD("Insurance Depr. Book");
        IF FADeprBook.GET(FANo,FASetup."Insurance Depr. Book") THEN
          EXIT(FADeprBook."Disposal Date" > 0D)
        ELSE
          EXIT(FALSE);
         */

    end;


    procedure UpdateLeaveApp(LeaveCode: Code[20]; Status: Option)
    var
        LeaveApplication: Record "HR Leave Application.";
    begin
    end;
}

