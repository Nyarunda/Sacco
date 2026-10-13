table 50557 "Member Documents"
{
    Caption = 'Member Documents';
    DataClassification = ToBeClassified;
    LookupPageID = "Application Doc. Setup Card";

    fields
    {
        field(1; "Entry No."; Integer)
        {
        }
        field(2; "Document Type"; Option)
        {
            OptionCaption = ' ,Savings,Loans';
            OptionMembers = " ",Savings,Loans;
        }
        field(3; "Document No."; Code[10])
        {
            TableRelation = "Application Document Setup";

            trigger OnValidate()
            var
                ApplicationDocumentSetup: Record "Application Document Setup";
            begin
                IF ApplicationDocumentSetup.GET("Document No.") THEN BEGIN
                    "Document Type" := ApplicationDocumentSetup."Document Type";
                    Description := ApplicationDocumentSetup.Description;
                    "Single Party/Multiple" := ApplicationDocumentSetup."Single Party/Multiple";
                END;
            end;
        }
        field(4; Description; Text[250])
        {
            Editable = false;
        }
        field(5; "Single Party/Multiple"; Option)
        {
            OptionCaption = 'Single,Multiple,Business';
            OptionMembers = Single,Multiple,Business;
        }
        field(6; "Reference No."; Code[20])
        {
        }
        field(7; "Product ID"; Code[20])
        {
            Editable = false;
            TableRelation = "Product Setup";
        }
        field(8; "Product Name"; Text[100])
        {
            Editable = false;
        }
        field(12; Provided; Boolean)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Reference No.", "Product ID", "Document No.")
        {
        }
    }

    fieldgroups
    {
    }
}

