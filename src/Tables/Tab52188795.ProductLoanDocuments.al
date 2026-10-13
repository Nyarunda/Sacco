table 50477 "Product Loan Documents"
{
    Caption = 'Product Loan Documents';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Product; Code[20])
        {
            Caption = 'Product';
            TableRelation = "Product Setup";
        }
        field(2; "Code"; Code[20])
        {
            Caption = 'Code';
            TableRelation = "Loan Documents";
            trigger OnValidate()
            var
                Doc: Record "Loan Documents";
            begin
                Description := '';
                if Doc.Get(Code) then
                    Description := Doc.Description;
            end;
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
        }
    }
    keys
    {
        key(PK; Product, Code)
        {
            Clustered = true;
        }
    }
}
