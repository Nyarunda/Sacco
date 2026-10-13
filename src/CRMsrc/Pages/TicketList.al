page 50407 "Ticket List"
{
    PageType = List;
    SourceTable = "Ticket Header";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Tickets';
    CardPageId = "Ticket Card";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(TicketRepeater)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ticket number.';
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ticket title.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer number.';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer name.';
                }
                field("Ticket Type"; Rec."Ticket Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of ticket.';
                }
                field("Ticket Source"; Rec."Ticket Source")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how the ticket was created.';
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the priority level of the ticket.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the current status of the ticket.';
                }
                field("Assigned To"; Rec."Assigned To")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who the ticket is assigned to.';
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the department handling the ticket.';
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the ticket was created.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the due date for the ticket.';
                }
                field("SLA Breached"; Rec."SLA Breached")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indicates if the SLA has been breached.';
                }
            }
        }
        area(FactBoxes)
        {
            part(TicketDetails; "Ticket Statistics FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(NewTicket)
            {
                ApplicationArea = All;
                Caption = 'New Ticket';
                Image = New;
                ToolTip = 'Create a new ticket.';

                trigger OnAction()
                begin
                    Page.RunModal(Page::"Ticket Card");
                end;
            }
            action(AssignTicket)
            {
                ApplicationArea = All;
                Caption = 'Assign';
                Image = Allocate;
                ToolTip = 'Assign the ticket to a user.';

                trigger OnAction()
                begin
                    // Add assignment logic here
                    Message('Assignment functionality to be implemented.');
                end;
            }
        }
        area(Navigation)
        {
            action(Customer)
            {
                ApplicationArea = All;
                Caption = 'Customer';
                Image = Customer;
                ToolTip = 'View customer details.';
                RunObject = page "CRM Customer Card";
                RunPageLink = "No." = field("Customer No.");
            }
        }
        area(Reporting)
        {
            action(TicketReport)
            {
                ApplicationArea = All;
                Caption = 'Ticket Report';
                Image = Report;
                ToolTip = 'Generate ticket reports.';

                trigger OnAction()
                begin
                    // Add report logic here
                    Message('Report functionality to be implemented.');
                end;
            }
        }
    }

    views
    {
        view(OpenTickets)
        {
            Caption = 'Open Tickets';
            Filters = where(Status = filter(<> Closed));
        }
        view(HighPriority)
        {
            Caption = 'High Priority';
            Filters = where(Priority = const(High));
        }
        view(SLABreached)
        {
            Caption = 'SLA Breached';
            Filters = where("SLA Breached" = const(true));
        }
        view(MyTickets)
        {
            Caption = 'My Tickets';
            Filters = where("Assigned To" = field("Assigned To"));
        }
    }
}