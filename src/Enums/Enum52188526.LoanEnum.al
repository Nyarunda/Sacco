enum 50189 "Interest Calc. Method Enum"
{
    Extensible = true;

    value(0; "")
    {
    }
    value(1; Amortised)
    {
    }
    value(2; "Reducing Balance")
    {
    }
    value(3; "Straight Line")
    {
    }
    value(4; "Reducing Flat")
    {
    }
    value(5; "Zero Interest")
    {
    }
}


enum 50190 "Repayment Frequency Enum"
{
    Extensible = true;

    value(0; "Daily")
    {
    }
    value(1; Weekly)
    {
    }
    value(2; "Monthly")
    {
    }
    value(3; "Quarterly")
    {
    }
    value(4; "Tri-Annual")
    {
    }
    value(5; "Bi-Annual")
    {
    }
    value(6; "Yearly")
    {
    }
    value(7; "Bonus")
    {
    }
}


enum 50191 "Team Enum"
{
    Extensible = true;

    value(0; "Salary")
    {
    }
    value(1; Milk)
    {
    }
    value(2; "Tea")
    {
    }
    value(3; "Staff Salary")
    {
    }
    value(4; "Check Off")
    {
    }
    value(5; "Cash")
    {
    }
    value(6; "Cheque")
    {
    }
}

enum 50094 "Guarantor Recovery Method"
{
    Extensible = false;

    value(0; Default) { Caption = 'Default (Savings)'; }
    value(1; Savings) { Caption = 'Deduct from Savings'; }
    value(2; Loan) { Caption = 'Issue Defaulter Loan'; }
    value(3; Split) { Caption = 'Split (Savings + Loan)'; }
}
