namespace UnitedWomen.UnitedWomen;

enum 50131 "Case Source"
{
    Extensible = true;
    value(0; Email) { Caption = 'Email'; }
    value(1; Phone) { Caption = 'Phone'; }
    value(2; WalkIn) { Caption = 'Walk-In'; }
    value(3; "Mobile App") { Caption = 'Mobile App'; }
    value(4; "Web Portal") { Caption = 'Web Portal'; }
    value(5; ATM) { Caption = 'ATM'; }
    value(6; "Social Media") { Caption = 'Social Media'; }
    value(7; SMS) { Caption = 'SMS'; }
    value(8; Branch) { Caption = 'Branch'; }
    value(9; "Customer Care") { Caption = 'Customer Care'; }
}
enum 50130 "Case Priority"
{
    Extensible = true;
    value(0; Low) { Caption = 'Low'; }
    value(1; Medium) { Caption = 'Medium'; }
    value(2; High) { Caption = 'High'; }
    value(3; Urgent) { Caption = 'Urgent'; }
    value(4; Critical) { Caption = 'Critical'; }
}
enum 50132 "Case Status"
{
    Extensible = true;
    value(0; Open) { Caption = 'Open'; }
    value(1; InProgress) { Caption = 'In Progress'; }
    value(2; Resolved) { Caption = 'Resolved'; }
    value(3; Closed) { Caption = 'Closed'; }
    value(4; Cancelled) { Caption = 'Cancelled'; }
    value(5; Assigned) { Caption = 'Assigned'; }
    value(6; Escalated) { Caption = 'Escalated'; }
    value(7; "Pending Customer") { Caption = 'Pending Customer'; }
    value(8; "Pending Approval") { Caption = 'Pending Approval'; }
}
