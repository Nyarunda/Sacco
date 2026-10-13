#pragma warning disable AL0432
TableExtension 50208 SecurityGroupMemberExt extends "Security Group Member Buffer"
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on ""User Group Code"(Field 1)".

        field(50046; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
            TableRelation = Company;
        }
        field(50050; Type; Option)
        {
            CalcFormula = lookup("Security Group Buffer".Type where(Code = field("Security Group Code")));
            FieldClass = FlowField;
            OptionMembers = " ","File Movement";
        }
        field(50051; Supervisor; Code[50])
        {
            TableRelation = "User Setup";
        }
    }
}

