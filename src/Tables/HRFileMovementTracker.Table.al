Table 51121 "HR File Movement Tracker"
{
    //DrillDownPageID = UnknownPage39004274;
    //LookupPageID = UnknownPage39004274;

    fields
    {
        field(1; "File Number"; Code[20])
        {
            //TableRelation = Table18.Field1;
        }
        field(2; "File Type"; Option)
        {
            OptionCaption = ' ,Loans,Refunds,Withdrawals - Resignation,Dividends,Examination';
            OptionMembers = " ",Loans,Refunds,"Withdrawals - Resignation",Dividends,Examination;
        }
        field(3; "File Name"; Code[50])
        {
        }
        field(4; Remarks; Text[50])
        {
        }
        field(5; Status; Option)
        {
            OptionCaption = 'Being Processed,Approved,Dispatched';
            OptionMembers = "Being Processed",Approved,Dispatched;
        }
        field(6; "Current Location"; Boolean)
        {
        }
        field(7; "Date/Time In"; DateTime)
        {
        }
        field(8; "Date/Time Out"; DateTime)
        {
        }
        field(9; "Sent By"; Code[20])
        {
        }
        field(10; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(11; Description; Text[50])
        {
        }
        field(12; Station; Code[50])
        {
        }
        field(13; "Received By"; Code[30])
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "File Number", "File Type", "Entry No.", "File Name")
        {
            Clustered = true;
        }
        key(Key3; "File Number", "Current Location")
        {
        }
    }

    fieldgroups
    {
    }
}

