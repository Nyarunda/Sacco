table 50601 "Distribution Lines"
{
    Caption = 'Distribution Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Header No."; Code[20])
        {
            Caption = 'Hearder No.';
            Editable = false;
        }
        field(2; "Loan No"; Code[20])
        {
            Caption = 'Loan No';
            Editable = false;
        }
        field(3; "Guarantor Member No."; Code[20])
        {
            Caption = 'Guarantor Member No.';
            Editable = false;
        }
        field(4; "Guarantor Name"; Text[70])
        {
            Caption = 'Guarantor Name';
            Editable = false;
        }
        field(5; "Approved Amount"; Decimal)
        {
            Caption = 'Approved Amount';
            Editable = false;
        }
        field(6; "Current Outstanding Balance"; Decimal)
        {
            Caption = 'Current Outstanding Balance';
            Editable = false;
        }
        field(7; "Current Outstanding Interest"; Decimal)
        {
            Caption = 'Current Outstanding Interest';
            Editable = false;
        }
        field(8; "Disbributed Amount"; Decimal)
        {
            Caption = 'Disbributed Amount';
            Editable = false;
        }
        field(9; Posted; Boolean)
        {
            Editable = false;
        }
        field(10; "Guarantor Outstanding Loan No."; code[20])
        {
            Editable = false;
        }
        field(11; "Has Defaulter Loan"; Boolean)
        {
            Editable = false;
        }
        field(12; "Recovery Method"; Enum "Guarantor Recovery Method")
        {
            Caption = 'Recovery Method';
            Editable = false;
        }
        field(13; "Amount from Savings"; Decimal)
        {
            Caption = 'Amount from Savings';
            Editable = false;
        }
        field(14; "Amount as Loan"; Decimal)
        {
            Caption = 'Amount as Loan';
            Editable = false;
        }
        field(15; "Guarantor Savings Account"; Code[20])
        {
            Caption = 'Guarantor Savings Account';
            Editable = false;
        }
        field(16; "Recovery Header No."; Code[20])
        {
            Caption = 'Recovery Header No.';
            Editable = false;
        }
        field(17; Reversed; Boolean)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist("Credit Ledger Entry" where("Document No." = field("Header No."),
                                                            //"Loan No." = field("Guarantor Outstanding Loan No."),
                                                            Reversed = const(true)));
        }
    }
    keys
    {
        key(PK; "Header No.", "Loan No", "Guarantor Member No.")
        {
            Clustered = true;
        }
    }
}
