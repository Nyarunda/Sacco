Table 50986 "HR Employee Exit Interviews"
{

    fields
    {
        field(1; "Exit Interview No"; Code[10])
        {
        }
        field(2; "Date Of Interview"; Date)
        {
        }
        field(3; "Interview Done By"; Code[20])
        {
            TableRelation = "HR Committees".Code;

            trigger OnValidate()
            begin
                HREmp.Reset;
                HREmp.SetRange(HREmp."No.", "Interview Done By");
                if HREmp.Find('-') then begin
                    IntFullName := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                    "Interviewer Name" := IntFullName;
                end;
            end;
        }
        field(4; "Re Employ In Future"; Boolean)
        {
        }
        field(5; "Reason For Leaving"; Option)
        {
            OptionMembers = " ",Resignation,Dismissal,Retirement,Termination,"Contract Ended","Appointment Revoked",Retrenchment,Personal;
        }
        field(6; "Reason For Leaving (Other)"; Text[150])
        {
        }
        field(7; "Date Of Leaving"; Date)
        {
        }
        field(10; Comment; Text[250])
        {
            Editable = true;
        }
        field(11; "Employee No."; Code[20])
        {
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                HREmp.Reset;
                HREmp.SetRange(HREmp."No.", "Employee No.");
                if HREmp.Find('-') then begin
                    EmpFullName := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                    "Employee Name" := EmpFullName;
                end;
            end;
        }
        field(12; "No Series"; Code[10])
        {
        }
        field(13; "Form Submitted"; Boolean)
        {
        }
        field(14; "Global Dimension 2"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(15; "Employee Name"; Text[50])
        {
        }
        field(16; "Interviewer Name"; Text[50])
        {
        }
        field(17; Closed; Boolean)
        {
        }
        field(18; Status; Option)
        {
            Editable = false;
            OptionCaption = 'New,Pending,Approved';
            OptionMembers = New,Pending,Approved;
        }
        field(19; "What did you enjoy most?"; Text[150])
        {
            Caption = 'What did you enjoy most while working at Maisha Bora Sacco?';
        }
        field(20; "What did you dislike?"; Text[100])
        {
            caption = 'What did you dislike while working at Maisha Bora Sacco?';
        }
        field(21; "Do you think you were equipped"; Boolean)
        {
            Caption = 'Do you think you were equipped with the necessary tools and training to help you succeed in your role?';
        }
        field(22; "If no what was not given?"; Text[150])
        {
            Caption = 'If no what was not given? If yes comment.';
        }
        field(23; "Did your job align to you?"; Text[200])
        {
            Caption = 'Did your job align to your personal interests and were your targets well communicated? Explain';
        }
#pragma warning disable AL0468
        field(24; "How was the working relationship?"; Text[200])
#pragma warning restore AL0468
        {
            Caption = 'How was the working relationship with your manager?';

        }

    }

    keys
    {
        key(Key1; "Exit Interview No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        //GENERATE NEW NUMBER FOR THE DOCUMENT
        if "Exit Interview No" = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Exit Interview Nos");
            "Exit Interview No" := NoSeries.GetNextNo(HRSetup."Exit Interview Nos", WorkDate(), true);
        end;
    end;

    var
        OK: Boolean;
        HREmp: Record Employee;
        HRSetup: Record "HR Setup.";
        NoSeries: Codeunit "No. Series";
        EmpFullName: Text;
        IntFullName: Text;
}

