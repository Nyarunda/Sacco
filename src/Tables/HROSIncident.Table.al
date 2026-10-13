Table 51033 "HR OSIncident"
{
    DataCaptionFields = "Incident No", "Incident Description";
    DrillDownPageID = "HR OSIncident List";
    LookupPageID = "HR OSIncident List";

    fields
    {
        field(1; "Incident No"; Code[10])
        {

            trigger OnValidate()
            begin

                if "Incident No" <> xRec."Incident No" then begin
                    HrSetup.Get;
                    NoSeries.TestManual(HrSetup."Incident Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Incident Description"; Text[100])
        {
        }
        field(3; Address; Code[10])
        {
        }
        field(4; "Date of Birth"; Date)
        {
        }
        field(5; "Job Title"; Code[30])
        {
        }
        field(6; "Home Phone No."; Code[10])
        {
        }
        field(7; Section; Option)
        {
            OptionCaption = ' ,Contractor,Trainee,Pupil/Student,Member of Public,Employee';
            OptionMembers = " ",Contractor,Trainee,"Pupil/Student","Member of Public",Employee;
        }
        field(8; "Type of Incident"; Option)
        {
            OptionCaption = ' ,Fatality,Dangerous Occurence,Major Injury,Disease,Minor Injury';
            OptionMembers = " ",Fatality,"Dangerous Occurence","Major Injury",Disease,"Minor Injury";
        }
        field(9; "Location Name"; Text[100])
        {
        }
        field(10; "Part of Body Affected"; Code[10])
        {
        }
        field(11; "Date of Incident"; Date)
        {
        }
        field(12; Time; DateTime)
        {
        }
        field(13; "Date Notification Received"; Date)
        {
        }
        field(14; "First Witness Name"; Text[100])
        {
        }
        field(15; "First Witness Address"; Code[10])
        {
        }
        field(16; "Second Witness Name"; Text[100])
        {
        }
        field(17; "Second Witness Address"; Code[10])
        {
        }
        field(18; "First Aid Given"; Boolean)
        {
        }
        field(19; "Taken Home"; Boolean)
        {
        }
        field(20; "Return to Work on same day"; Boolean)
        {
        }
        field(21; "Went Absent"; Boolean)
        {
        }
        field(22; "Taken to Hospital"; Boolean)
        {
        }
        field(23; Admitted; Boolean)
        {
        }
        field(24; "No. Series"; Code[10])
        {
        }
        field(25; "Employee No"; Code[10])
        {
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                /*
                 HREmp.RESET;
                 HREmp.SETRANGE(HREmp."No.","Employee No");
                 IF HREmp.FIND('-') THEN BEGIN
                "Injured Person":=HREmp."First Name"+' '+HREmp."Middle Name"+' '+HREmp."Last Name";
                Address:=HREmp."Postal Address";
                "Date of Birth":=HREmp."Date Of Birth";
                "Job Title":=HREmp."Job Title";
                "Home Phone No.":=HREmp."Home Phone Number";
                
                END;
                */

            end;
        }
        field(26; Status; Option)
        {
            OptionCaption = 'Open,Investigation,Inspection,Cancelled,Closed';
            OptionMembers = Open,Investigation,Inspection,Cancelled,Closed;
        }
        field(27; "User ID"; Code[200])
        {
        }
    }

    keys
    {
        key(Key1; "Incident No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Incident No", "Incident Description")
        {
        }
    }

    trigger OnInsert()
    begin
        if "Incident No" = '' then begin
            HrSetup.Get;
            HrSetup.TestField("Incident Nos.");
            "Incident No" := NoSeries.GetNextNo(HrSetup."Incident Nos.", WorkDate(), true);
        end;

        "User ID" := UserId;
    end;

    var
        HrSetup: Record "HR Setup.";
        NoSeries: Codeunit "No. Series";
        HREmp: Record Employee;
}

