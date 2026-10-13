Table 51084 "HR Appraisal Company Target"
{
    DrillDownPageID = "HR Appraisal Company Target";
    LookupPageID = "HR Appraisal Company Target";

    fields
    {
        field(1; "Code"; Code[100])
        {
        }
        field(2; Description; Text[250])
        {
        }
        field(3; Score; Decimal)
        {

            trigger OnValidate()
            begin
                /*
                HRAppraisalRating.RESET;
                HRAppraisalRating.SETRANGE(HRAppraisalRating.Score,Score);
                IF HRAppraisalRating.FIND('-') THEN
                  BEGIN
                    ERROR('You cannot have two appraisal ratings with the same score');
                  END;
                */

            end;
        }
        field(4; Recommendations; Text[20])
        {
        }
        field(5; "Description 2"; Text[20])
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; Description, Score)
        {
        }
    }

    fieldgroups
    {
    }

    var
}

