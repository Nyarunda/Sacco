

enum 50693 "AML Status"
{
    Extensible = true;

    value(0; Open)
    {
        Caption = 'Open';
    }
    value(1; InvestigationPending)
    {
        Caption = 'Investigation Pending';
    }
    value(2; UnderReview)
    {
        Caption = 'Under Review';
    }
    value(3; EscalatedToManagement)
    {
        Caption = 'Escalated to Management';
    }
    value(4; ReportedToAuthorities)
    {
        Caption = 'Reported to Authorities';
    }
    value(5; FalsePositive)
    {
        Caption = 'False Positive';
    }
    value(6; Cleared)
    {
        Caption = 'Cleared';
    }
    value(7; Closed)
    {
        Caption = 'Closed';
    }
}
