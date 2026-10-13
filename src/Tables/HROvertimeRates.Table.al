Table 51126 "HR Overtime Rates"
{

    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Extra Hours Rate"; Decimal)
        {
        }
        field(3; "Holiday/Sunday Hours Rate"; Decimal)
        {
            Caption = 'Holiday/Weekends Rate';
        }
        field(4; "WeekDay Hours Rate"; Decimal)
        {
        }
        field(5; "Conversion Type"; Option)
        {
            OptionCaption = ' ,Convert to Pay,Convert to Leave';
            OptionMembers = " ","Convert to Pay","Convert to Leave";
        }
    }

    keys
    {
        key(Key1; "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

