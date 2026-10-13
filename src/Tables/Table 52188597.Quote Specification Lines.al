
Table 50260 "Quote Specification Lines"
{

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Header"."No." where("Document Type" = const(Quote));
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Leave Calendar."."Calendar Code";

            trigger OnValidate()
            begin
                QuoteSpec.Get(Code);
                "Max Score" := QuoteSpec."Value/Weight";
                Description := QuoteSpec.Description;
            end;
        }
        field(4; Description; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Score; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Score > "Max Score" then
                    Error('The score can not be graeter than the max score specified');
            end;
        }
        field(6; "Request No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "RFQ Header"."No." where(Status = const(Released));
        }
        field(7; "Request Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Setup."."Leave Application Nos.";
        }
        field(8; Type; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Type No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Type Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Max Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Temp Total Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Vendor No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Assigned Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Vendor Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.", "Code", "Request No.", "Request Line No.", Score)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        QuoteSpec: Record "Quote Specifications";
}

