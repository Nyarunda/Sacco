table 50091 "Transaction Keyword Setup"
{
    Caption = 'Transaction Keyword Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Keyword Code"; Code[20])
        {
            Caption = 'Keyword Code';
            DataClassification = CustomerContent;
        }
        field(2; "Keyword Type"; Option)
        {
            Caption = 'Keyword Type';
            DataClassification = CustomerContent;
            OptionCaption = 'After #,Prefix,Contains,Exact';
            OptionMembers = "After #",Prefix,Contains,Exact;
        }
        field(3; "Product Code"; Code[20])
        {
            Caption = 'Product Code';
            DataClassification = CustomerContent;
            TableRelation = "Product Setup"."Product ID";
        }
        field(4; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(5; Active; Boolean)
        {
            Caption = 'Active';
            DataClassification = CustomerContent;
            InitValue = true;
        }
        field(6; Priority; Integer)
        {
            Caption = 'Priority';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Keyword Code")
        {
            Clustered = true;
        }
        key(PriorityKey; Priority)
        {
        }
    }
}
