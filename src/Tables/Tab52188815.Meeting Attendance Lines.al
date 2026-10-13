table 50497 "Meeting Attendance Lines"
{
    Caption = 'Meeting Attendance Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Header No."; Code[20])
        {
            Caption = 'Header No.';
            TableRelation = "Meeting Attendance Header"."No." where(Completed = const(false));
            Editable = false;

        }
        field(2; "Member No"; Code[20])
        {
            Caption = 'Member No';
            TableRelation = Members;
            trigger OnValidate()
            var
                myInt: Integer;
                Mem: Record Members;
            begin
                "ID No." := '';
                Attended := false;
                "Member Name" := '';
                "Mobile Phone No." := '';
                "Regstration Date" := 0D;


                Mem.Reset();
                Mem.SetRange("No.", "Member No");
                if Mem.FindFirst() then begin
                    "Member Name" := Mem.Name;
                    "ID No." := Mem."ID No.";
                    "Mobile Phone No." := Mem."Mobile Phone No.";
                    "Regstration Date" := Mem."Registration Date";
                    Status := Mem."Member Status";
                    Rights();
                end;
            end;
        }
        field(3; "ID No."; Code[15])
        {
            trigger OnValidate()
            var
                myInt: Integer;
                Mem: Record Members;
            begin
                "ID No." := '';
                Attended := false;
                "Member Name" := '';
                "Mobile Phone No." := '';
                "Regstration Date" := 0D;
                //"Date Attended." := 0DT;

                Mem.Reset();
                Mem.SetRange("ID No.", "ID No.");
                if Mem.FindFirst() then begin
                    "Member Name" := Mem.Name;
                    "Member No" := Mem."Member No.";
                    "Mobile Phone No." := Mem."Mobile Phone No.";
                    "Regstration Date" := Mem."Registration Date";
                    Status := Mem."Member Status";
                end;
            end;
        }
        field(4; "Member Name"; Text[100])
        {
            Caption = 'Member Name';
            Editable = false;
        }
        field(5; "Mobile Phone No."; Text[20])
        {
            Caption = 'Mobile Phone No.';
            Editable = false;
        }
        field(6; "Regstration Date"; Date)
        {
            Caption = 'Regstration Date';
            Editable = false;
        }
        field(7; "FOSA Account"; Code[20])
        {
            Caption = 'FOSA Account';
            FieldClass = FlowField;
            CalcFormula = lookup("Savings Accounts"."No." where("Member No." = field("Member No"), "Product Category" = filter("Ordinary Savings")));
            Editable = false;
        }
        field(9; "Date Attended."; DateTime)
        {
            Editable = false;
        }
        field(10; "Captured By"; Code[100])
        {
            Editable = false;
        }
        field(20; Attended; Boolean)
        {
            Caption = 'Attended';
        }
        field(21; "Ticket No."; Code[20])
        {
            Caption = 'Ticket No';
        }
        field(22; Status; Enum "Member Status Enum")
        {
            Caption = 'Status';
            Editable = false;
        }
        field(23; Reason; Text[100])
        {
            Caption = 'Ticket No';
        }
    }
    keys
    {
        key(PK; "Header No.", "Member No")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        MHeader: Record "Meeting Attendance Header";
    begin
        MHeader.Reset();
        MHeader.SetRange(Completed, false);
        if MHeader.FindFirst() then
            "Header No." := MHeader."No."
        else
            Error('No Open Meeting at the Moment')
    end;

    procedure Rights()
    var
        UserSetup: Record "User Setup";
    begin
        "Date Attended." := CurrentDateTime;
        "Captured By" := userid;

        UserSetup.Get(UserId);
        if not UserSetup."Capture AGM" then
            ErrorInfo();
    end;

    procedure ErrorInfo()
    begin
        Error('You do not have rights to capture AGM attendance.');
    end;
}
