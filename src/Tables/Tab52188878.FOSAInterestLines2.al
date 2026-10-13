table 50580 "FOSA Interest Lines 2"
{
    Caption = 'FOSA Interest Lines 2';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Header No"; Code[10])
        {
            Caption = 'Header No';
            DataClassification = ToBeClassified;
        }
        field(2; "A/C No"; Code[100])
        {
            Caption = 'A/C No';
            DataClassification = ToBeClassified;
        }
        field(3; EndDate; Date)
        {
            Caption = 'EndDate';
            DataClassification = ToBeClassified;
        }
        field(4; "A/C Name"; Text[100])
        {
            Caption = 'A/C Name';
            DataClassification = ToBeClassified;
        }
        field(5; "Saving Product"; Code[30])
        {
            Caption = 'Saving Product';
            DataClassification = ToBeClassified;
        }
        field(6; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
        field(7; "Least Balance"; Decimal)
        {
            Caption = 'Least Balance';
            DataClassification = ToBeClassified;
        }
        field(8; "Interest Rate"; Decimal)
        {
            Caption = 'Interest Rate';
            DataClassification = ToBeClassified;
        }
        field(9; "Product Name"; Text[100])
        {
            Caption = 'Product Name';
            DataClassification = ToBeClassified;
        }
        field(10; "Batch No"; Text[100])
        {
            Caption = 'Batch No';
            DataClassification = ToBeClassified;
        }
        field(39; Blocked; Enum "Vendor Blocked")
        {
            Caption = 'Blocked';
        }
        field(40; "Old Interest Amount"; Decimal)
        {
            Caption = 'Old Interest Amount';
            DataClassification = ToBeClassified;
        }
        field(41; Type; Enum "FOSA Interest Type")
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Header No", "A/C No", EndDate)
        {
            Clustered = true;
        }
    }
}
