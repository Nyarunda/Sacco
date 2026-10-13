Table 51041 "HR OSInvestigation"
{
    DrillDownPageID = "HR OSInvestigation List";
    LookupPageID = "HR OSInvestigation List";

    fields
    {
        field(1; "Investigation No"; Code[10])
        {

            trigger OnValidate()
            begin
                if "Investigation No" <> xRec."Investigation No" then begin
                    HrSetup.Get;
                    NoSeries.TestManual(HrSetup."Investigation Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Incident No"; Code[10])
        {
            TableRelation = "HR OSIncident"."Incident No";

            trigger OnValidate()
            begin
                OSIncident.Reset;
                OSIncident.SetRange(OSIncident."Incident No", "Incident No");
                if OSIncident.Find('-') then begin
                    "Incident Description" := OSIncident."Incident Description";
                    "Date of Incident" := OSIncident."Date of Incident";
                    "Location Name" := OSIncident."Location Name";
                    // Status:=OSIncident.Status;
                end;
            end;
        }
        field(3; "Incident Description"; Text[100])
        {
        }
        field(4; "Date of Incident"; Date)
        {
        }
        field(5; "Location Name"; Text[100])
        {
        }
        field(6; Status; Option)
        {
            OptionCaption = 'Reported Investigation,Assigned Investigation,Investigation,Inspection,Closed';
            OptionMembers = "Reported Investigation","Assigned Investigation",Investigation,Inspection,Closed;
        }
        field(7; "Person Investigating"; Text[100])
        {

            trigger OnValidate()
            begin

                //IF CONFIRM('Are you sure you have assigned the person responsible for investigating?',TRUE,FALSE)THEN BEGIN
                Status := Status::"Assigned Investigation";
                Modify;
                "Date of Assigning" := Today;
                //END
            end;
        }
        field(8; "Date of Assigning"; Date)
        {
        }
        field(9; "No. Series"; Code[20])
        {
        }
        field(10; Cause; Text[50])
        {
        }
        field(11; "Resolution/Recommendation"; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Investigation No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if "Investigation No" = '' then begin
            HrSetup.Get;
            HrSetup.TestField("Investigation Nos.");
            "Investigation No" := NoSeries.GetNextNo(HrSetup."Investigation Nos.", WorkDate(), true);
        end;
    end;

    var
        OSIncident: Record "HR OSIncident";
        HrSetup: Record "HR Setup.";
        NoSeries: Codeunit "No. Series";
}

