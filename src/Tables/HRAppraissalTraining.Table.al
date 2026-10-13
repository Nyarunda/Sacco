Table 51074 "HR Appraissal Training"
{

    fields
    {
        field(1; "No."; Code[30])
        {
        }
        field(2; "Employee No."; Code[30])
        {
            TableRelation = Employee;

            trigger OnLookup()
            begin
                HREmployees.Reset;
                SetRange("Employee No.", HREmployees."No.");
                if HREmployees.FindFirst then begin
                    "Performance Gap" := HREmployees."First Name";
                end;
            end;
        }
        field(3; "Performance Gap"; Text[100])
        {
        }
        field(4; "Appraisal No."; Code[30])
        {
        }
        field(5; "Appraiser Name"; Text[100])
        {
        }
        field(6; "Appraissal Period"; Code[30])
        {
        }
        field(7; "Training Required"; Text[250])
        {
        }
        field(8; Region; Code[30])
        {
        }
        field(9; Department; Code[30])
        {
        }
        field(10; "Responsibility Center"; Code[30])
        {
        }
        field(11; Status; Option)
        {
            OptionMembers = New,"Pending Approval",Approved;
        }
        field(12; "No Series"; Code[30])
        {
        }
        field(13; "User ID"; Code[30])
        {
        }
        field(50000; "Expected Performance"; Text[250])
        {
        }
        field(50001; "Time Frame"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //No. Series
        if "No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Appraisal Appeal Nos");
            "No." := NoSeries.GetNextNo(HRSetup."Appraisal Appeal Nos", WorkDate(), true);
        end;

        HREmployees.Reset;
        HREmployees.SetRange(HREmployees."User ID", UserId);
        if HREmployees.Find('-') then begin
            "Performance Gap" := HREmployees."First Name" + ' ' + HREmployees."Middle Name" + ' ' + HREmployees."Last Name";
            "Employee No." := HREmployees."No.";
            "User ID" := HREmployees."User ID";
            Region := HREmployees."Global Dimension 1 Code";
            Department := HREmployees."Global Dimension 2 Code";
            //"Responsibility Center" := HREmployees."Responsibility Center";
        end;
    end;

    var
        HREmployees: Record Employee;
        HRSetup: Record "HR Setup.";
        NoSeries: Codeunit "No. Series";
}

