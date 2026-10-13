Table 51076 "HR Succession Employee"
{

    fields
    {
        field(1; "Staff No."; Code[10])
        {
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                Employee.Reset;
                Employee.SetRange(Employee."No.", "Staff No.");
                if Employee.Find('-') then begin
                    "Staff Names" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    /*
                    "Job ID" := Employee.Position;
                    "Job Title" := Employee."Job Title";
                    "Dimension 1 Code" := Employee."Department Code";
                    "Dimension 1 Description" := Employee."Employee Classification";
                    "Dimension 2 Code" := Employee."Global Dimension 1 Code";
                    "Dimension 2 Description" := Employee."Global Dimension 1 Name";
                    "Date of Join" := Employee."Date Of Join";
                    "ID No." := Employee."ID Number";
                    */
                end;
            end;
        }
        field(2; "Position to Succeed"; Code[10])
        {
            TableRelation = "HR Jobs"."Job ID";

            trigger OnValidate()
            begin
                Jobs.Reset;
                Jobs.SetRange(Jobs."Job ID", "Position to Succeed");
                if Jobs.Find('-') then
                    "Position Description" := Jobs."Job Description";
            end;
        }
        field(3; "Position Description"; Text[50])
        {
        }
        field(4; "Job Title"; Text[50])
        {
        }
        field(5; "Staff Names"; Text[100])
        {
        }
        field(6; "ID No."; Integer)
        {
        }
        field(7; "Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1,';
            //TableRelation = Table349.Field2 where(Field9 = const(1),
            //                                     Field4 = const(0));
        }
        field(8; "Date of Join"; Date)
        {
        }
        field(9; "Succession Date"; Date)
        {
        }
        field(10; Readiness; Code[10])
        {
        }
        field(11; Status; Option)
        {
            OptionMembers = "Not Ready",Ready,Succeeded,"Released from Plan";
        }
        field(12; "Date Marked"; Date)
        {
        }
        field(13; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(14; "Employee Qualifications"; Integer)
        {
            FieldClass = Normal;
        }
        field(15; "Line No.2"; Integer)
        {
        }
        field(16; "Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            //TableRelation = Table349.Field2 where(Field9 = const(2),
            //                                     Field4 = const(0));
        }
        field(17; "Dimension 1 Description"; Text[50])
        {
        }
        field(18; "Dimension 2 Description"; Text[50])
        {
        }
        field(19; "Job ID"; Code[20])
        {
        }
        field(20; "Plan No."; Code[20])
        {
        }
        field(21; "No. Series"; Code[20])
        {
        }
        field(22; "How long if not ready?"; Text[50])
        {
        }
        field(23; Mentor; Code[20])
        {
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                Employee.Reset;
                if Employee.Get(Mentor) then
                    "Mentor Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name"
                else
                    "Mentor Name" := '';
            end;
        }
        field(24; "Mentor Name"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Plan No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if "Plan No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Succession Planning Nos.");
            "Plan No." := NoSeries.GetNextNo(HRSetup."Succession Planning Nos.", WorkDate(), true);
        end;
    end;

    var
        Employee: Record Employee;
        Jobs: Record "HR Jobs";
        HRSetup: Record "HR Setup.";
        NoSeries: Codeunit "No. Series";
}

