
enum 50002 "Ticket Type"
{
    Extensible = true;
    value(0; General) { Caption = 'General'; }
    value(1; Technical) { Caption = 'Technical'; }
    value(2; Functional) { Caption = 'Functional'; }
}


enum 50100 "Escalation Source Type"
{
    Extensible = true;
    Caption = 'Escalation Source Type';

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; "Sales Order")
    {
        Caption = 'Sales Order';
    }
    value(2; "Purchase Order")
    {
        Caption = 'Purchase Order';
    }
    value(3; "Service Order")
    {
        Caption = 'Service Order';
    }
    value(4; "Support Case")
    {
        Caption = 'Support Case';
    }
    value(5; "Opportunity")
    {
        Caption = 'Opportunity';
    }
    value(6; "Quote")
    {
        Caption = 'Quote';
    }
    value(7; "Customer Issue")
    {
        Caption = 'Customer Issue';
    }
    value(8; "Task")
    {
        Caption = 'Task';
    }
}

enum 50101 "Escalation Priority"
{
    Extensible = true;
    Caption = 'Escalation Priority';

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; "Low")
    {
        Caption = 'Low';
    }
    value(2; "Normal")
    {
        Caption = 'Normal';
    }
    value(3; "High")
    {
        Caption = 'High';
    }
    value(4; "Critical")
    {
        Caption = 'Critical';
    }
    value(5; "Emergency")
    {
        Caption = 'Emergency';
    }
}

enum 50102 "Escalation Trigger Type"
{
    Extensible = true;
    Caption = 'Escalation Trigger Type';

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; "Time Based")
    {
        Caption = 'Time Based';
    }
    value(2; "Status Change")
    {
        Caption = 'Status Change';
    }
    value(3; "Amount Threshold")
    {
        Caption = 'Amount Threshold';
    }
    value(4; "Overdue")
    {
        Caption = 'Overdue';
    }
    value(5; "No Response")
    {
        Caption = 'No Response';
    }
    value(6; "Manual")
    {
        Caption = 'Manual';
    }
}

enum 50103 "Time Unit"
{
    Extensible = true;
    Caption = 'Time Unit';

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; "Minutes")
    {
        Caption = 'Minutes';
    }
    value(2; "Hours")
    {
        Caption = 'Hours';
    }
    value(3; "Days")
    {
        Caption = 'Days';
    }
    value(4; "Weeks")
    {
        Caption = 'Weeks';
    }
    value(5; "Months")
    {
        Caption = 'Months';
    }
}



// Escalation Status Enum
enum 50104 "Escalation Status"
{
    Extensible = true;
    Caption = 'Escalation Status';

    value(0; "Open")
    {
        Caption = 'Open';
    }
    value(1; "In Progress")
    {
        Caption = 'In Progress';
    }
    value(2; "Resolved")
    {
        Caption = 'Resolved';
    }
    value(3; "Cancelled")
    {
        Caption = 'Cancelled';
    }
}

