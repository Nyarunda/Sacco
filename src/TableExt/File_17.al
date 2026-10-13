
TableExtension 50187 tableextension50013 extends "Human Resources Setup"
{
    fields
    {
        field(50001; "Intern Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50002; "Contract Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
}

