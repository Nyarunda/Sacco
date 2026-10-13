
Table 50169 Coinage
{
    DrillDownPageID = Coinage;
    LookupPageID = Coinage;

    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = Denominations;

            trigger OnValidate()
            begin
                Description := '';
                Value := 0;

                if Denominations.Get(Code) then begin
                    Description := Denominations.Description;
                    Type := Denominations.Type;
                    Value := Denominations.Value;
                end;
            end;
        }
        field(3; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Note,Coin;
        }
        field(5; Value; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Quantity; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                if Quantity <> 0 then
                    "Total Amount" := Quantity * Value
                else
                    "Total Amount" := 0;
            end;
        }
        field(7; "Total Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                Quantity := "Total Amount" / Value;


                Validate(Quantity);
            end;
        }
    }

    keys
    {
        key(Key1; No, "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Denominations: Record Denominations;
}

