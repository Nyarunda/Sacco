Table 51106 "HR Staff  Induction"
{

    fields
    {
        field(1; "Induction Code"; Code[30])
        {
        }
        field(2; "Participant Code"; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Hr.Get("Participant Code") then
                    "Participant Name" := Hr."First Name" + ' ' + Hr."Middle Name" + ' ' + Hr."Last Name";
            end;
        }
        field(3; "Participant Name"; Text[60])
        {
        }
        field(5; From; Date)
        {
        }
        field(6; "To Date"; Date)
        {
        }
        field(7; Duration; Option)
        {
            OptionCaption = ' ,Days,Week,Months,Years';
            OptionMembers = " ",Days,Week,Months,Years;
        }
        field(8; "Days Attended"; Decimal)
        {
        }
        field(9; Depatment; Code[10])
        {
        }
        field(10; "Induction Status"; Option)
        {
            OptionMembers = "Not done",Done;
        }
    }

    keys
    {
        key(Key1; "Induction Code", "Participant Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Hr: Record Employee;
}

