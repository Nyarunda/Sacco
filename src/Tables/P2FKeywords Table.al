Table 50573 "P2F Keywords"
{

    fields
    {
        field(1; Keyword; Text[50])
        {
            NotBlank = true;
        }
        field(2; "Product Code"; Code[20])
        {
            TableRelation = "Product Setup"."Product ID";
        }
        field(3; "Destination Type"; Option)
        {
            CalcFormula = lookup("Product Setup"."Product Class" where("Product ID" = field("Product code")));
            FieldClass = FlowField;
            OptionMembers = " ",Loan,Savings;
        }
        field(4; "Product Name"; Text[30])
        {
            CalcFormula = lookup("Product Setup".Description where("Product ID" = field("Product code")));
            FieldClass = FlowField;
        }

        field(6; Purpose; Option)
        {
            OptionCaption = ' ,Mid Salary,End Salary,Mid Pension,End Pension,Mid Allowance,End Allowance';
            OptionMembers = " ","Mid Salary","End Salary","Mid Pension","End Pension","Mid Allowance","End Allowance";
        }
    }

    keys
    {
        key(Key1; Keyword)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

