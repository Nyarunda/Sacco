table 50562 "Member Notifications"
{
    Caption = 'Member Notifications';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Member No."; Code[20])
        {
            Caption = 'Member No.';
            TableRelation = Members."No.";
        }
        field(3; "Title"; Text[100])
        {
            Caption = 'Title';
        }
        field(4; "Content"; Text[2000])
        {
            Caption = 'Content';
        }
        field(5; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
        }
        field(6; "Expiry Date"; DateTime)
        {
            Caption = 'Expiry Date';
        }
        field(7; "Link Text"; Text[50])
        {
            Caption = 'Link Text';
        }
        field(8; "Link URL"; Text[250])
        {
            Caption = 'Link URL';
        }
        field(9; "Is Read"; Boolean)
        {
            Caption = 'Is Read';
            InitValue = false;
        }
        field(10; "Category"; Option)
        {
            Caption = 'Category';
            OptionMembers = "General","Account","Loan","Transaction","System","Important";
        }
        field(11; "Created By"; Code[50])
        {
            Caption = 'Created By';
            TableRelation = "User Setup"."User ID";
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(MemberIndex; "Member No.", "Created Date")
        {
        }
        key(CategoryIndex; "Member No.", "Category", "Created Date")
        {
        }
        key(ReadIndex; "Member No.", "Is Read", "Created Date")
        {
        }
    }

    trigger OnInsert()
    begin
        "Created By" := UserId;
        "Created Date" := CurrentDateTime;

        // Default expiry to 30 days if not specified
        if "Expiry Date" = 0DT then
            "Expiry Date" := CreateDateTime(CalcDate('<+30D>', Today), Time);
    end;

    procedure FormatRelativeDate() RelativeDate: Text
    var
        DateDiff: Integer;
        TimeDiff: Integer;
    begin
        DateDiff := Today - DT2Date("Created Date");
        TimeDiff := Time - DT2Time("Created Date");

        if DateDiff = 0 then begin
            if TimeDiff < 3600000 then begin // Less than an hour (in milliseconds)
                exit(Format(TimeDiff div 60000) + ' minutes ago');
            end else begin
                exit(Format(TimeDiff div 3600000) + ' hours ago');
            end;
        end else if DateDiff = 1 then begin
            exit('Yesterday');
        end else if DateDiff < 7 then begin
            exit(Format(DateDiff) + ' days ago');
        end else begin
            exit(Format("Created Date", 0, '<Month Text,3> <Day>, <Year4>'));
        end;
    end;
}
