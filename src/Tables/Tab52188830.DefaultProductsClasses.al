table 50532 "Default Products Classes"
{
    Caption = 'Default Products Classes';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Class; Code[10])
        {
            Caption = 'Class';
        }
        field(2; "Product ID"; Code[10])
        {
            Caption = 'Product ID';
            TableRelation = "Product Setup" where("Product Class" = const(Savings));
            trigger OnValidate()
            var
                Psetup: Record "Product Setup";
            begin
                Psetup.Get("Product ID");
                Description := Psetup.Description;
            end;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
            Editable = false;
        }
    }
    keys
    {
        key(PK; Class, "Product ID")
        {
            Clustered = true;
        }
    }
}
