
/// <summary>
/// TableExtension tableextension52188403 (ID 50166) extends Record G/L Entry.
/// </summary>
TableExtension 50166 tableextension52188403 extends "G/L Entry"
{
    fields
    {
        field(50054; "Creation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50055; "Creation Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50056; "Remaining Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50057; "Time Posted"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50058; "Old No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50059; Channel; Enum "Transaction Channel")
        {
            DataClassification = ToBeClassified;
        }
        field(50060; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50061; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50062; "Recon. Loan No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Credit Ledger Entry"."Loan No." where("Entry No." = field("Entry No."), "Transaction No." = field("Transaction No.")));
        }
        field(50063; "Recon. Member No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Savings Ledger Entry"."Member No." where("Entry No." = field("Entry No."), "Transaction No." = field("Transaction No.")));
        }
        field(50064; "Bank Code"; Code[20])
        {
            Caption = 'Bank Code';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Bank Account Ledger Entry"."Bank Account No." where("External Document No." = field("External Document No."),
                                                                                       "Posting Date" = field("Posting Date"),
                                                                                       Reversed = const(false)));
        }
    }

    trigger OnModify()
    var
        myInt: Integer;
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if not UserSetup."Edit GL Entries" then begin
            Error('You do not have permission to edit GL entries Accounts.');
        end;
    end;
}
