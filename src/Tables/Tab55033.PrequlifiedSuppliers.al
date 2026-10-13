table 55033 "Prequlified Suppliers"
{
     Caption = 'Vendor Prequalification';
    DataClassification = CustomerContent;
    

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(2; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = CustomerContent;
            TableRelation = Vendor;
        }
        field(3; "Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
            DataClassification = CustomerContent;
        }
        field(4; "Category Code"; Code[20])
        {
            Caption = 'Category Code';
            DataClassification = CustomerContent;
        }
        field(5; "Prequalification Date"; Date)
        {
            Caption = 'Prequalification Date';
            DataClassification = CustomerContent;
        }
        field(6; "Expiry Date"; Date)
        {
            Caption = 'Expiry Date';
            DataClassification = CustomerContent;
        }
        field(7; "Compliance Status"; Option)
        {
            Caption = 'Compliance Status';
            OptionMembers = "Compliant","Non-Compliant","Under Review";
            OptionCaption = 'Compliant,Non-Compliant,Under Review';
            DataClassification = CustomerContent;
        }
        field(8; "Document Reference"; Text[250])
        {
            Caption = 'Document Reference';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Vendor No.", "Category Code")
        {
        }
    }
}
