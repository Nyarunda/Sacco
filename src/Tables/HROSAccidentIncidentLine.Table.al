Table 51034 "HR OSAccident Incident Line"
{

    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Incident No"; Code[10])
        {
        }
        field(3; "Investigation No."; Code[10])
        {
            TableRelation = "HR OSInvestigation"."Investigation No";

            trigger OnValidate()
            begin
                SafetyC.Reset;
                OAcc.Reset;
                OAcc.SetRange(OAcc."Accident No", "Investigation No.");
                if OAcc.Find('-') then begin
                    Incident := OAcc.Description;
                end;
                //get all safety rules from safety setup

                SafetyC.Reset;
                SafetyC.SetRange(SafetyC."Accident No", "Investigation No.");
                SafetyC.SetRange(SafetyC."Incident No", "Incident No");
                if SafetyC.Find('-') then begin
                    SafetyC.DeleteAll;
                end;

                SafetyR.Reset;
                SafetyR.SetRange(SafetyR."Accident No.", "Investigation No.");
                if SafetyR.Find('-') then begin
                    repeat
                        SafetyC.Init;
                        SafetyC.SafetyNo := SafetyR."Safety No";
                        SafetyC."Safety Rules" := SafetyR."Safety Rules";
                        SafetyC."Accident No" := SafetyR."Accident No.";
                        SafetyC."Incident No" := "Incident No";
                        SafetyC.Insert;
                    until SafetyR.Next = 0;
                end;
            end;
        }
        field(4; Cause; Text[100])
        {
        }
        field(5; "Cause No"; Code[10])
        {

            trigger OnValidate()
            begin
                OAccsub.Reset;
                OAccsub.SetRange(OAccsub.Code, "Cause No");
                if OAccsub.Find('-') then begin
                    Cause := OAccsub.Description;
                end;
            end;
        }
        field(6; "Resolution/Recommendation"; Text[200])
        {
        }
        field(7; Incident; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Line No", "Investigation No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        OAcc: Record "HR OSAccident";
        OAccsub: Record "HR OSAccident Line";
        SafetyC: Record "HR OSSafety Checklist";
        SafetyR: Record "HR OSSafety Rules";
        LineNo: Integer;
}

