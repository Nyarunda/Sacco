table 50496 "Meeting Attendance Header"
{
    Caption = 'Meeting Attendance Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'Code';
            Editable = false;
        }

        field(2; "Date Entered"; Date)
        {
            Caption = 'Date Entered';
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description ';
        }
        field(4; "Meeting Date"; Date)
        {
            Caption = 'Meeting Date';
        }
        field(5; "Captured By"; Code[60])
        {
            Caption = 'Captured By';
            Editable = false;
        }
        field(6; "Date Captured"; Date)
        {
            Caption = 'Date Captured';
            Editable = false;
        }
        field(7; Completed; Boolean)
        {
            Caption = 'Completed';
            Editable = false;
        }
        field(8; Count; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Meeting Attendance Lines" where("Header No." = field("No.")));
        }
        field(65; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(PK; "No.", Description)
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        UserSetup: Record "User Setup";
        MeetingLines: Record "Meeting Attendance Lines";
    begin
        if "No." = '' then begin

            SalesSetup.Get();
            SalesSetup.TestField(SalesSetup."Meeting Attendance");
            "No." := NoSeries.GetNextNo(SalesSetup."Meeting Attendance", WorkDate(), true);
            "Captured By" := UserId;
            "Date Entered" := Today;

            UserSetup.Get(UserId);
            if not UserSetup.Get(UserId) then
                MeetingLines.ErrorInfo();
        end;
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";

}


