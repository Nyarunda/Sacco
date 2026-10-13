
Codeunit 50088 "HR Leave Jnl.- Check Line"
{
    TableNo = "HR Leave Journal Line.";

    trigger OnRun()
    var
        TempJnlLineDim: Record "Journal Line Dimension" temporary;
    begin
        GLSetup.Get;
        if Rec."Global Dimension 1 Code" <> '' then begin
            TempJnlLineDim."Table ID" := Database::"HR Leave Journal Line.";
            TempJnlLineDim."Journal Template Name" := Rec."Journal Template Name";
            TempJnlLineDim."Journal Batch Name" := Rec."Journal Batch Name";
            TempJnlLineDim."Journal Line No." := Rec."Line No.";
            TempJnlLineDim."Dimension Code" := GLSetup."Global Dimension 1 Code";
            TempJnlLineDim."Dimension Value Code" := Rec."Global Dimension 1 Code";
            TempJnlLineDim.Insert;
        end;
        if Rec."Global Dimension 2 Code" <> '' then begin
            //AZIZTempJnlLineDim."Table ID" := Database::Table39003937;
            TempJnlLineDim."Journal Template Name" := Rec."Journal Template Name";
            TempJnlLineDim."Journal Batch Name" := Rec."Journal Batch Name";
            TempJnlLineDim."Journal Line No." := Rec."Line No.";
            TempJnlLineDim."Dimension Code" := GLSetup."Global Dimension 2 Code";
            TempJnlLineDim."Dimension Value Code" := Rec."Global Dimension 2 Code";
            TempJnlLineDim.Insert;
        end;
        RunCheck(Rec, TempJnlLineDim);
    end;

    var
        Text000: label 'The combination of dimensions used in %1 %2, %3, %4 is blocked. %5';
        Text001: label 'A dimension used in %1 %2, %3, %4 has caused an error. %5';
        GLSetup: Record "General Ledger Setup";
        FASetup: Record "HR Setup.";
        DimMgt: Codeunit DimensionManagement;
        CallNo: Integer;
        Text002: label 'The Posting Date Must be within the open leave periods';
        Text003: label 'The Posting Date Must be within the allowed Setup date';
        LeaveEntries: Record "HR Leave Ledger Entries.";
        Text004: label 'The Allocation of Leave days has been done for the period';
        HRLeaveCal: Record "HR Leave Calendar.";


    procedure RunCheck(var InsuranceJnlLine: Record "HR Leave Journal Line."; var JnlLineDim: Record "Journal Line Dimension")
    var
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
    begin
        if InsuranceJnlLine."Leave Entry Type" = InsuranceJnlLine."leave entry type"::Negative then begin
            InsuranceJnlLine.TestField("Leave Calendar Code");
        end;

        InsuranceJnlLine.TestField("Document No.");
        InsuranceJnlLine.TestField("Posting Date");
        InsuranceJnlLine.TestField("Staff No.");
        CallNo := 1;
        /*s
        IF NOT DimMgt.CheckJnlLineDimComb(JnlLineDim) THEN
          ERROR(
            Text000,
            TABLECAPTION,"Journal Template Name","Journal Batch Name","Line No.",
            DimMgt.GetDimCombErr);

        TableID[1] := DATABASE::Table39005571;
        No[1] := "Leave Calendar Code";
        //IF NOT DimMgt.GetDimensionNo(JnlLineDim,TableID,No) THEN //commented to allow posting
         IF NOT DimMgt.CheckJnlLineDimValuePosting(JnlLineDim,TableID,No) THEN
          IF "Line No." <> 0 THEN
            ERROR(
              Text001,
              TABLECAPTION,"Journal Template Name","Journal Batch Name","Line No.",
              DimMgt.GetDimValuePostingErr)
          ELSE
            ERROR(DimMgt.GetDimValuePostingErr);
          */
        ValidatePostingDate(InsuranceJnlLine);

    end;


    procedure ValidatePostingDate(var InsuranceJnlLine: Record "HR Leave Journal Line.")
    begin
        if InsuranceJnlLine."Leave Entry Type" = InsuranceJnlLine."leave entry type"::Negative then begin
            InsuranceJnlLine.TestField("Leave Calendar Code");
        end;
        InsuranceJnlLine.TestField("Document No.");
        InsuranceJnlLine.TestField("Posting Date");
        InsuranceJnlLine.TestField("Staff No.");
        if (InsuranceJnlLine."Posting Date" < InsuranceJnlLine."Leave Period Start Date") or
           (InsuranceJnlLine."Posting Date" > InsuranceJnlLine."Leave Period End Date") then
            // ERROR(FORMAT(Text002));



            FASetup.Get();
        //Dann
        fn_HRCalendar;

        if (HRLeaveCal."Start Date" <> 0D) and (HRLeaveCal."End Date" <> 0D) then begin
            //IF ("Posting Date"<HRLeaveCal."Start Date") OR
            // ("Posting Date">HRLeaveCal."End Date")  THEN
            // ERROR(FORMAT(Text003));
        end;
        /*         LeaveEntries.RESET;
            LeaveEntries.SETRANGE(LeaveEntries."Leave Type","Leave Type");
           IF LeaveEntries.FIND('-') THEN BEGIN
        IF LeaveEntries."Leave Entry Type"=LeaveEntries."Leave Entry Type"::"Leave Allocation" THEN BEGIN
        IF (LeaveEntries."Posting Date"<"Leave Period Start Date") OR
            (LeaveEntries."Posting Date">"Leave Period End Date")  THEN
            ERROR(FORMAT(Text004));
                    END;
          END;
           */

    end;

    local procedure fn_HRCalendar()
    begin
        HRLeaveCal.Reset;
        HRLeaveCal.SetRange(HRLeaveCal."Current Leave Calendar", true);
        if not HRLeaveCal.Find('-') then Error('HR Calendar not created');
    end;
}

