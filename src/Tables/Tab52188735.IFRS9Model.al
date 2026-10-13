table 50398 "IFRS-9 Model"
{
    Caption = 'IFRS-9 Model';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Stage; Integer)
        {
            Caption = 'Stage';
            DataClassification = ToBeClassified;
        }
        field(2; PD; Decimal)
        {
            Caption = 'PD';
            DataClassification = ToBeClassified;
        }
        field(3; LGD; Decimal)
        {
            Caption = 'LGD';
            DataClassification = ToBeClassified;
        }
        field(4; "IFRS Stage"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Stage 1","Stage 2","Stage 3";
        }
        field(5; "No. Of Loans"; Integer)
        {
            CalcFormula = count("Sasra Categorization" where("IFRS Stage" = field("IFRS Stage")));
            FieldClass = FlowField;
        }
        field(6; "Total Outstanding Balance"; Decimal)
        {
            CalcFormula = Sum("Sasra Categorization"."Total Outstanding Balance" where("IFRS Stage" = field("IFRS Stage")));
            FieldClass = FlowField;
        }
        field(7; "Total ECL"; Decimal)
        {
            CalcFormula = Sum("Sasra Categorization".ECL where("IFRS Stage" = field("IFRS Stage")));
            FieldClass = FlowField;
        }
        field(8; "As At"; Date)
        {
            CalcFormula = lookup("Sasra Categorization"."As At" where("IFRS Stage" = field("IFRS Stage")));
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(PK; Stage)
        {
            Clustered = true;
        }
    }
}
