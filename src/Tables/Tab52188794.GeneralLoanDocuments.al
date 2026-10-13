table 50476 "General Loan Documents"
{
    Caption = 'General Loan Documents';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
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
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
