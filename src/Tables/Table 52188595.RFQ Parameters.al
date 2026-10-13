
Table 50258 "RFQ Parameters"
{

    fields
    {
        field(1; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Quotation Request,Open Tender,Restricted Tender';
            OptionMembers = "Quotation Request","Open Tender","Restricted Tender";
        }
        field(2; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Specification; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Quote Specifications".Code;

            trigger OnValidate()
            begin
                Spec.Reset;
                Spec.SetRange(Spec.Code, Specification);
                if Spec.FindFirst then begin
                    Description := Spec.Description;
                end;
            end;
        }
        field(4; Description; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Line No."; Integer)
        {
            AutoIncrement = false;
            DataClassification = ToBeClassified;
        }
        field(6; Value; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", Specification, "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Spec: Record "Quote Specifications";
}

