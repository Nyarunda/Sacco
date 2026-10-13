enum 50164 "TransUnion Account Status"
{
    // TransUnion Kenya Account Status Codes

    Extensible = true;
    Caption = 'TransUnion Account Status';

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; A)
    {
        Caption = 'A - Active/Current';
    }
    value(2; B)
    {
        Caption = 'B - Closed/Paid';
    }
    value(3; C)
    {
        Caption = 'C - Closed/Written Off';
    }
    value(4; D)
    {
        Caption = 'D - Delinquent 1-30 days';
    }
    value(5; E)
    {
        Caption = 'E - Delinquent 31-60 days';
    }
    value(6; F)
    {
        Caption = 'F - Delinquent 61-90 days';
    }
    value(7; G)
    {
        Caption = 'G - Delinquent 91-120 days';
    }
    value(8; H)
    {
        Caption = 'H - Delinquent 121-180 days';
    }
    value(9; J)
    {
        Caption = 'J - Delinquent 181+ days';
    }
    value(10; K)
    {
        Caption = 'K - Restructured/Rescheduled';
    }
    value(11; L)
    {
        Caption = 'L - Legal Action';
    }
    value(12; M)
    {
        Caption = 'M - Matured';
    }
    value(13; N)
    {
        Caption = 'N - New Account';
    }
    value(14; P)
    {
        Caption = 'P - Performing';
    }
}