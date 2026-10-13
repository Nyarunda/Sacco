Table 50982 "HR Succession Job Rotation"
{

    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Plan No."; Code[20])
        {
            TableRelation = "HR Succession Employee"."Plan No.";
        }
        field(3; "Job ID"; Code[20])
        {
            TableRelation = "HR Jobs"."Job ID";

            trigger OnValidate()
            begin

                Jobs.Reset;
                if Jobs.Get("Job ID") then
                    "Job Title" := Jobs."Job Description" else
                    "Job Title" := ' ';
            end;
        }
        field(4; "Job Title"; Text[50])
        {
        }
        field(5; Duration; Text[50])
        {
        }
        field(6; "Competency Acquired"; Text[100])
        {
        }
        field(7; From; Date)
        {

            trigger OnValidate()
            begin
                if "Up to" <> 0D
                then
                    Duration := Dates.DetermineAge(From, "Up to")
                else
                    Duration := ' ';
            end;
        }
        field(8; "Up to"; Date)
        {

            trigger OnValidate()
            begin
                if From <> 0D
                then
                    Duration := Dates.DetermineAge(From, "Up to")
                else
                    Duration := ' ';
            end;
        }
    }

    keys
    {
        key(Key1; "Line No.", "Plan No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Jobs: Record "HR Jobs";
        Dates: Codeunit "HR Codeunit.";
}

