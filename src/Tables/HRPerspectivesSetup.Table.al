Table 51085 "HR Perspectives Setup"
{

    fields
    {
        field(1; "Perspective No"; Integer)
        {
            AutoIncrement = true;
            MaxValue = 4;
        }
        field(2; Description; Text[250])
        {
        }
        field(3; "Perspective type"; Option)
        {
            OptionCaption = ' ,Internal Service Delivery,Financial Stewardship,Training and Development,Customer Sales';
            OptionMembers = " ","Internal Service Delivery","Financial Stewardship","Training and Development","Customer Sales";
        }
        field(4; myCount; Integer)
        {
            CalcFormula = count("HR Perspectives Setup");
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Perspective type", "Perspective No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        CalcFields(myCount);
        if myCount >= 4 then Error('You can only have 4 perspectives');
    end;
}

