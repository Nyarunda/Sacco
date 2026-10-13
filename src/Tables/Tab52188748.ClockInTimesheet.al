table 50428 "ClockIn Timesheet"
{
    Caption = 'ClockIn Timesheet';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; "Entered By"; Text[100])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                UserSetup: Record "User setup";
                Emp: record Employee;
            begin
                if UserSetup.get("Entered By") then begin
                    "Staff No" := UserSetup."Staff No";
                    Emp.get("Staff No");
                    "Staff Name" := Emp.FullName();

                end;
            end;
        }
        field(3; "Staff No"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Staff Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "clockIn"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "ClockIn Time" := Time;
                week := DATE2DWY("Working Date", 2);

            end;
        }
        field(6; "ClockIn Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Clock Out"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "Clock Out Time" := Time;
                Hours := "Clock Out Time" - "ClockIn Time";

            end;
        }
        field(8; "Clock Out Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Working Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Hours; Duration)
        {
            DataClassification = ToBeClassified;
        }
        field(11; Week; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Staff No", "Working Date")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        "Entered By" := UserId;
        Validate("Entered By");
        "Working Date" := Today;
    end;

}
