tableextension 50064 "BAnk Reconcilliation Line" extends "Bank Acc. Reconciliation Line"
{
    fields
    {
        field(90000; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(50013; Reconciled; Boolean)
        {
            Caption = 'Reconciled';
            DataClassification = ToBeClassified;
        }
        field(50017; "Ext. Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50189; "Match Option"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Date & Document No & Amount","Document No & Amount";
        }

        field(50190; "Same Document Nos"; Integer)
        {
            CalcFormula = count("Bank Acc. Reconciliation Line" where("Statement No." = field("Statement No."), "Document No." = field("Document No."),
                                                         "Bank Account No." = field("Bank Account No.")));
            FieldClass = FlowField;
        }
        field(50063; "Statement Guid No."; Guid)
        {
            DataClassification = ToBeClassified;
        }
    }


    procedure SetStyleText() StyleText: Text[20]
    begin
        StyleText := '';
        case "Match Option" of
            "Match Option"::"Document No & Amount":
                StyleText := 'StandardAccent';
            "Match Option"::"Date & Document No & Amount":
                StyleText := 'Favorable';
        end;
    end;

    procedure CustomRemoveApplication(AppliedType: Option)
    var
        BankAccRecMatchBuffer: Record "Bank Acc. Rec. Match Buffer";
        BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
        ManyToOneBLEFound: Boolean;
        BankAccLedgEntry: Record "Bank Account Ledger Entry";
        CheckLedgEntry: Record "Check Ledger Entry";
        BankAccSetStmtNo: Codeunit "Bank Acc. Entry Set Recon.-No.";
        CheckSetStmtNo: Codeunit "Check Entry Set Recon.-No.";
    begin
        if "Statement Type" = "Statement Type"::"Bank Reconciliation" then
            case AppliedType of
            /*Type::"Bank Account Ledger Entry":
               begin
                   FilterManyToOneMatches(BankAccRecMatchBuffer);
                   if BankAccRecMatchBuffer.FindFirst() then begin
                       BankAccLedgEntry.Reset();
                       BankAccLedgEntry.SetRange("Entry No.", BankAccRecMatchBuffer."Ledger Entry No.");
                       BankAccLedgEntry.SetRange(Open, true);
                       BankAccLedgEntry.SetRange(
                           "Statement Status", BankAccLedgEntry."Statement Status"::"Bank Acc. Entry Applied");
                       if BankAccLedgEntry.FindFirst() then begin
                           ManyToOneBLEFound := true;
                           BankAccSetStmtNo.RemoveReconNo(BankAccLedgEntry, Rec, false);
                           BankAccRecMatchBuffer.Delete();
                       end;
                   end;


                   BankAccRecMatchBuffer.Reset();
                   BankAccRecMatchBuffer.SetRange("Ledger Entry No.", BankAccLedgEntry."Entry No.");
                   BankAccRecMatchBuffer.SetRange("Statement No.", Rec."Statement No.");
                   BankAccRecMatchBuffer.SetRange("Bank Account No.", Rec."Bank Account No.");
                   if (BankAccRecMatchBuffer.FindSet()) and (ManyToOneBLEFound) then begin
                       repeat
                           BankAccReconciliationLine.SetRange("Statement Line No.", BankAccRecMatchBuffer."Statement Line No.");
                           BankAccReconciliationLine.SetRange("Statement No.", BankAccRecMatchBuffer."Statement No.");
                           BankAccReconciliationLine.SetRange("Bank Account No.", BankAccRecMatchBuffer."Bank Account No.");
                           if BankAccReconciliationLine.FindFirst() then begin
                               BankAccReconciliationLine."Applied Entries" := 0;
                               BankAccReconciliationLine.Validate("Applied Amount", 0);
                               BankAccReconciliationLine.Modify();
                           end;
                       until BankAccRecMatchBuffer.Next() = 0;

                       BankAccRecMatchBuffer.DeleteAll();
                   end;

                   BankAccLedgEntry.Reset();
                   BankAccLedgEntry.SetCurrentKey("Bank Account No.", Open);
                   BankAccLedgEntry.SetRange("Bank Account No.", "Bank Account No.");
                   BankAccLedgEntry.SetRange(Open, true);
                   BankAccLedgEntry.SetRange(
                     "Statement Status", BankAccLedgEntry."Statement Status"::"Bank Acc. Entry Applied");
                   BankAccLedgEntry.SetRange("Statement No.", "Statement No.");
                   BankAccLedgEntry.SetRange("Statement Line No.", "Statement Line No.");
                   BankAccLedgEntry.LockTable();
                   CheckLedgEntry.LockTable();
                   if BankAccLedgEntry.Find('-') then
                       repeat
                           BankAccSetStmtNo.RemoveReconNo(BankAccLedgEntry, Rec, true);
                       until BankAccLedgEntry.Next() = 0;
                   "Applied Entries" := 0;
                   Validate("Applied Amount", 0);
                   Modify;
               end;
           Type::"Check Ledger Entry":
               begin
                   CheckLedgEntry.Reset();
                   CheckLedgEntry.SetCurrentKey("Bank Account No.", Open);
                   CheckLedgEntry.SetRange("Bank Account No.", "Bank Account No.");
                   CheckLedgEntry.SetRange(Open, true);
                   CheckLedgEntry.SetRange(
                     "Statement Status", CheckLedgEntry."Statement Status"::"Check Entry Applied");
                   CheckLedgEntry.SetRange("Statement No.", "Statement No.");
                   CheckLedgEntry.SetRange("Statement Line No.", "Statement Line No.");
                   BankAccLedgEntry.LockTable();
                   CheckLedgEntry.LockTable();
                   if CheckLedgEntry.Find('-') then
                       repeat
                           CheckSetStmtNo.RemoveReconNo(CheckLedgEntry, Rec, true);
                       until CheckLedgEntry.Next() = 0;
                   "Applied Entries" := 0;
                   Validate("Applied Amount", 0);
                   "Check No." := '';
                   Modify;
               end;
            */
            end;

    end;
}
