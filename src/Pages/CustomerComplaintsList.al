page 50843 "Case List"
{
    PageType = List;
    SourceTable = "Customer Complaints";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Customer Complaint Card";
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

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
                    StyleExpr = RowStyle;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ticket title.';
                    StyleExpr = RowStyle;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer number.';
                    StyleExpr = RowStyle;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer name.';
                    StyleExpr = RowStyle;
                }
              
                field("Case Source"; Rec."Case Source")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how the ticket was created.';
                    StyleExpr = RowStyle;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the priority level of the ticket.';
                    StyleExpr = RowStyle;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the current status of the ticket.';
                    StyleExpr = RowStyle;
                }
                field("Assigned To"; Rec."Assigned To")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who the ticket is assigned to.';
                    StyleExpr = RowStyle;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the department handling the ticket.';
                    StyleExpr = RowStyle;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the ticket was created.';
                    StyleExpr = RowStyle;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the due date for the ticket.';
                    StyleExpr = RowStyle;
                }
                field("SLA Breached"; Rec."SLA Breached")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indicates if the SLA has been breached.';
                    StyleExpr = RowStyle;
                }
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
                Caption = 'New Case';
                Image = New;
                ToolTip = 'Create a new ticket.';

                trigger OnAction()
                begin
                    Page.RunModal(Page::"Customer Complaint Card");
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
                Caption = 'Case Report';
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

    trigger OnAfterGetRecord()
    var
        SaccoSetup: Record "Sacco Setup";
        OverdueDate: Date;
    begin
        // Calculate if case is overdue
        IsOverdue := false;
        IsEscalated := false;
        RowStyle := 'Standard';

        // Check if case is escalated (highest priority - red/unfavorable)
        if Rec.Status = Rec.Status::Escalated then begin
            IsEscalated := true;
            RowStyle := 'Ambiguous';
        end
        // Check if case is overdue (medium priority - orange/attention)
        else if (Rec.Status <> Rec.Status::Closed) and (Rec."Due Date" <> 0D) then begin

            if Rec."Due Date" <= Today then begin
                IsOverdue := true;
                RowStyle := 'Critical';
            end;
        end;
    end;

    var
        IsOverdue: Boolean;
        IsEscalated: Boolean;
        RowStyle: Text;
}