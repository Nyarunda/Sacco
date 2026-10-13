
/// <summary>
/// Table Committment (ID 50254).
/// </summary>
Table 50254 Committment
{

    fields
    {
        field(1; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Commitment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Document Type"; enum "Custom Document Type")
        {
            DataClassification = ToBeClassified;
            ValuesAllowed = LPO, Requisition, Imprest, "Payment Voucher", PettyCash, PurchInvoice, StaffClaim, StaffAdvance, StaffSurrender;
        }
        field(5; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Month Budget"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Month Actual"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Committed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Committed By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Committed Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Committed Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Committed Machine"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Cancelled; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Cancelled By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Cancelled Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Cancelled Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Cancelled Machine"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Shortcut Dimension 1 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Shortcut Dimension 2 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Shortcut Dimension 3 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Shortcut Dimension 4 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "G/L Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(24; Budget; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Vendor/Cust No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(26; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Vendor,Customer;
        }
        field(27; "Budget Check Criteria"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Current Month","Whole Year";
        }
        field(28; "Actual Source"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "G/L Entry","Analysis View Entry";
        }
        field(29; "Document Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Commitment Line Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "G/L Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Vendor Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Based on Totaling Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Reversed By Doc Type"; Enum "Custom Document Type")
        {
            DataClassification = ToBeClassified;
            ValuesAllowed = LPO, Requisition, Imprest, "Payment Voucher", PettyCash, PurchInvoice, StaffClaim, StaffAdvance, StaffSurrender;
        }
        field(37; "Reversed By Doc No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
    }

    keys
    {
        key(Key1; "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

