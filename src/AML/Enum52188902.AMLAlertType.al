

enum 50692 "AML Alert Type"
{
    Extensible = true;

    value(0; HighValue)
    {
        Caption = 'High Value Transaction';
    }
    value(1; Velocity)
    {
        Caption = 'High Velocity';
    }
    value(2; Structured)
    {
        Caption = 'Structured Transaction';
    }
    value(3; Unusual)
    {
        Caption = 'Unusual Pattern';
    }
    value(4; Threshold)
    {
        Caption = 'Threshold Breach';
    }
    value(5; PEP)
    {
        Caption = 'PEP Related';
    }
    value(6; Dormant)
    {
        Caption = 'Dormant Account Activity';
    }
    value(7; Geographic)
    {
        Caption = 'Geographic Risk';
    }
    value(8; KYC)
    {
        Caption = 'KYC Issue';
    }
    value(9; Multiple)
    {
        Caption = 'Multiple Risk Factors';
    }
}
