Table 51028 "HR Non Working Days & Dates"
{

    fields
    {
        field(1; Date; Date)
        {
            trigger OnValidate()
            var
                CalenderLine: Record "HR Leave Calendar Lines.";
            begin
                CalenderLine.SetRange(Date, Date);
                if not CalenderLine.FindFirst() then begin
                    if CalenderLine.FindLast() then
                        CalenderLine.Modify();
                    exit;
                end;

                if CalenderLine."Non Working" then
                    Error('This date is already setup as non working day in the calendar [%1]', CalenderLine.Code);
            end;
        }
        field(2; Reason; Text[100])
        {
        }
        field(3; Recurring; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; Date)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

