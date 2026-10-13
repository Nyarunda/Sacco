table 51001 "Bank Reconciliation Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Transaction Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Document Type"; Option)
        {
            OptionMembers = " ",Payment,Receipt,"Bank Charge","Bank Interest";
        }
        field(5; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Statement Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Difference; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Cleared"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Reference No."; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Reference No.';
        }
        field(11; "Bank Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Bank Entry No.';
            Editable = false;
        }
        field(12; Matched; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Matched';
            Editable = false;
        }
        field(13; "Applied Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Applied Amount';
            Editable = false;
        }
        field(14; "Applied Entries"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Applied Entries';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    procedure GetDifference()
    begin
        Difference := Amount - "Statement Amount";
    end;

    trigger OnInsert()
    var
        BankRecValidation: Codeunit "Bank Rec. Validation";
    begin
        BankRecValidation.ValidateRequiredFields(Rec);
        BankRecValidation.CheckDuplicateReferences(Rec);
        BankRecValidation.ValidateAmountSign(Rec);
    end;

    trigger OnModify()
    var
        BankRecValidation: Codeunit "Bank Rec. Validation";
    begin
        BankRecValidation.ValidateRequiredFields(Rec);
        BankRecValidation.CheckDuplicateReferences(Rec);
        BankRecValidation.ValidateAmountSign(Rec);
    end;
}