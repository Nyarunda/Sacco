enum 50603 "Share Order Status"
{
    Extensible = true;

    value(0; Open)
    {
        Caption = 'Open';
    }

    value(1; "Partially Matched")
    {
        Caption = 'Partially Matched';
    }

    value(2; Completed)
    {
        Caption = 'Completed';
    }

    value(3; Cancelled)
    {
        Caption = 'Cancelled';
    }
    value(4; "Active")
    {
        Caption = 'Active';
    }
}
