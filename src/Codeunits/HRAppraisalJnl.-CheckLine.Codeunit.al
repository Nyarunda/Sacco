Codeunit 50129 "HR Appraisal Jnl.-Check Line"
{
    TableNo = "HR Appraisal Journal Line";

    trigger OnRun()
    var
        TempJnlLineDim: Record "Journal Line Dimension" temporary;
    begin
        GLSetup.Get;

        if Rec."Shortcut Dimension 1 Code" <> '' then begin
            TempJnlLineDim."Table ID" := Database::"HR Appraisal Journal Line";
            TempJnlLineDim."Journal Template Name" := Rec."Journal Template Name";
            TempJnlLineDim."Journal Batch Name" := Rec."Journal Batch Name";
            TempJnlLineDim."Journal Line No." := Rec."Line No.";
            TempJnlLineDim."Dimension Code" := GLSetup."Global Dimension 1 Code";
            TempJnlLineDim."Dimension Value Code" := Rec."Shortcut Dimension 1 Code";
            TempJnlLineDim.Insert;
        end;
        if Rec."Shortcut Dimension 2 Code" <> '' then begin
            TempJnlLineDim."Table ID" := Database::"HR Appraisal Journal Line";
            TempJnlLineDim."Journal Template Name" := Rec."Journal Template Name";
            TempJnlLineDim."Journal Batch Name" := Rec."Journal Batch Name";
            TempJnlLineDim."Journal Line No." := Rec."Line No.";
            TempJnlLineDim."Dimension Code" := GLSetup."Global Dimension 2 Code";
            TempJnlLineDim."Dimension Value Code" := Rec."Shortcut Dimension 2 Code";
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
        AppriasalEntries: Record "HR Leave Ledger Entries.";
        Text004: label 'The Allocation of Leave days has been done for the period';


    procedure ValidatePostingDate(var InsuranceJnlLine: Record "HR Appraisal Journal Line")
    begin
        //  IF "Leave Entry Type"="Leave Entry Type"::Negative THEN BEGIN
        InsuranceJnlLine.TestField("Appraisal Period");
        //END;
        InsuranceJnlLine.TestField("Document No.");
        InsuranceJnlLine.TestField("Posting Date");
        InsuranceJnlLine.TestField("Staff No.");
        if (InsuranceJnlLine."Posting Date" < InsuranceJnlLine."Appraisal Period Start Date") or
           (InsuranceJnlLine."Posting Date" > InsuranceJnlLine."Appraisal Period End Date") then
            // ERROR(FORMAT(Text002));

            FASetup.Get();
            /*
            IF (FASetup."Leave Posting Period[FROM]"<>0D) AND (FASetup."Leave Posting Period[TO]"<>0D) THEN BEGIN
              IF ("Posting Date"<FASetup."Appraisal Posting Period[FROM]") OR
                 ("Posting Date">FASetup."Appraisal Posting Period[TO]")  THEN
                 ERROR(FORMAT(Text003));
            END;*/

    end;


    procedure RunCheck(var InsuranceJnlLine: Record "HR Appraisal Journal Line"; var JnlLineDim: Record "Journal Line Dimension")
    var
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
    begin
        //IF "Appraisal Entry Type"="Appraisal Entry Type"::Negative THEN BEGIN
        InsuranceJnlLine.TestField("Appraisal No.");
        //END;
        InsuranceJnlLine.TestField("Document No.");
        InsuranceJnlLine.TestField("Posting Date");
        InsuranceJnlLine.TestField("Staff No.");
        CallNo := 1;

        /*  IF NOT DimMgt.CheckJnlLineDimComb(JnlLineDim) THEN
            ERROR(
              Text000,
              TABLECAPTION,"Journal Template Name","Journal Batch Name","Line No.",
              DimMgt.GetDimCombErr);*/

        //  TableID[1] := DATABASE::Table39006175;
        TableID[1] := Database::"HR Appraisal Journal Line";
        No[1] := InsuranceJnlLine."Appraisal No.";
        //IF NOT DimMgt.GetDimensionNo(JnlLineDim,TableID,No) THEN
        if InsuranceJnlLine."Line No." <> 0 then
            Error(
              Text001,
              InsuranceJnlLine.TableCaption, InsuranceJnlLine."Journal Template Name", InsuranceJnlLine."Journal Batch Name", InsuranceJnlLine."Line No.",
              DimMgt.GetDimValuePostingErr)
        else
            Error(DimMgt.GetDimValuePostingErr);
        ValidatePostingDate(InsuranceJnlLine);

    end;
}

