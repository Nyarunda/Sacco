Table 50992 "HR Company Target Line"
{

    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Appraisal No"; Code[50])
        {
            TableRelation = "HR Individual Targets Header"."Appraisal No";
        }
        field(3; "Perspective Code"; Integer)
        {
            TableRelation = "HR Perspectives Setup"."Perspective No";

            trigger OnValidate()
            begin
                CalcFields("Perspective Description");
            end;
        }
        field(4; "Perspective Description"; Text[250])
        {
            CalcFormula = lookup("HR Perspectives Setup".Description where("Perspective No" = field("Perspective Code")));
            FieldClass = FlowField;
        }
        field(5; "Targeted Score"; Decimal)
        {
        }
        field(6; "Perspective type"; Option)
        {
            CalcFormula = lookup("HR Perspectives Setup"."Perspective type" where("Perspective No" = field("Perspective Code")));
            FieldClass = FlowField;
            OptionCaption = ' ,Service Delivery,Financial Stewardship,Training and Development,Customer and Sales';
            OptionMembers = " ","Service Delivery","Financial Stewardship","Training and Development","Customer and Sales";
        }
        field(7; "Achieved Score"; Decimal)
        {
        }
        field(8; "Unachieved Targets"; Decimal)
        {
        }
        field(9; Comments; Text[250])
        {
        }
        field(10; "Review Line Reference"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Line No", "Appraisal No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

