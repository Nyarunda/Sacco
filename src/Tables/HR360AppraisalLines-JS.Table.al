Table 51083 "HR 360 Appraisal Lines - JS"
{
    DrillDownPageID = "HR 360 Appraisal Lines - JS";
    LookupPageID = "HR 360 Appraisal Lines - JS";

    fields
    {
        field(1; "Assign To"; Code[20])
        {

            trigger OnValidate()
            begin
                "Assigned To" := ' ';
                Jobs.Reset;
                Jobs.SetRange(Jobs."Job ID", "Assign To");
                if Jobs.Find('-') then
                    "Assigned To" := Jobs."Job Description";
            end;
        }
        field(2; "Code"; Code[20])
        {
            NotBlank = false;

        }
        field(3; "Line No."; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(4; "Categorize As"; Option)
        {
            OptionCaption = ' ,Employee''s Subordinates,Employee''s Peers,External Sources,Job Specific,Self Evaluation';
            OptionMembers = " ","Employee's Subordinates","Employee's Peers","External Sources","Job Specific","Self Evaluation";
        }
        field(5; "Sub Category"; Option)
        {
            OptionCaption = ' ,Objectives,Core Responsibilities / Duties,Attendance & Punctuality,Communication,Cooperation,Planning & Organization,Quality,Team Work,Sales Skills,Leadership,Performance Coaching';
            OptionMembers = " ",Objectives,"Core Responsibilities / Duties","Attendance & Punctuality",Communication,Cooperation,"Planning & Organization",Quality,"Team Work","Sales Skills",Leadership,"Performance Coaching";
        }
        field(6; Description; Text[250])
        {
            NotBlank = false;
        }
        field(7; "Include in Evaluation Form"; Boolean)
        {
        }
        field(8; "External Source Type"; Option)
        {
            OptionCaption = ' ,Vendor,Customer';
            OptionMembers = " ",Vendor,Customer;
        }
        field(9; "External Source Code"; Code[20])
        {
            TableRelation = if ("External Source Type" = const(Customer)) Customer."No."
            else
            if ("External Source Type" = const(Vendor)) Vendor."No.";
        }
        field(10; "External Source Name"; Text[100])
        {
            FieldClass = Normal;
        }
        field(11; "Assigned To"; Text[100])
        {
            Editable = false;
        }
        field(12; Blocked; Boolean)
        {
        }
        field(13; "Appraisal Period"; Code[20])
        {
            TableRelation = "HR Lookup Values".Code where(Type = filter("Appraisal Period"),
                                                           Closed = const(false));
        }
        field(14; "Unit of Measure"; Code[20])
        {
            //TableRelation = "Table5220".Field1;
        }
        field(50000; "Appraisal No"; Code[30])
        {
            TableRelation = "HR Appraisal Header"."Appraisal No";
        }
        field(50002; "Employee No"; Code[20])
        {
            NotBlank = true;
            TableRelation = Employee."No.";
        }
    }

    keys
    {
        key(Key1; "Line No.", "Appraisal No", "Appraisal Period", "Employee No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Jobs: Record "HR Jobs";
}

