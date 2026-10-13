Table 55012 "Next of Kin BOSA"
{

    fields
    {
        field(2; Name; Text[50])
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                Name := UpperCase(Name);
            end;
        }
        field(3; Relationship; Text[30])
        {
            //TableRelation = "Relationship Types".Description;
        }
        field(4; Beneficiary; Boolean)
        {
        }
        field(5; "Date of Birth"; Date)
        {
        }
        field(6; Address; Text[150])
        {
        }
        field(7; Telephone; Code[20])
        {
        }
        field(8; Fax; Code[10])
        {
        }
        field(9; Email; Text[30])
        {
        }
        field(10; "Account No"; Code[20])
        {
        }
        field(11; "ID No."; Code[20])
        {
        }
        field(12; "%Allocation"; Decimal)
        {

            trigger OnValidate()
            begin
                //IF Type<>Type::"Benevolent Beneficiary" THEN
                //ERROR( 'Only Nominee Qualify for allocation');
            end;
        }
        field(13; "New Upload"; Boolean)
        {
        }
        field(14; Type; Option)
        {
            OptionCaption = 'Next of Kin,Spouse,Nominee';
            OptionMembers = "Next of Kin",Spouse,"Benevolent Beneficiary";
        }
    }

    keys
    {
        key(Key1; "Account No", Name)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

