page 50408 "Ticket Card"
{
    PageType = Card;
    SourceTable = "Ticket Header";
    ApplicationArea = All;
    Caption = 'Ticket Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

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

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer name.';
                    Editable = false;
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
            }

            group(Assignment)
            {
                Caption = 'Assignment';

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
            }

            group(Dates)
            {
                Caption = 'Dates & Times';

                field("Created DateTime"; Rec."Created DateTime")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the ticket was created.';
                    Editable = false;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the creation date.';
                    Editable = false;
                }
                field("Created Time"; Rec."Created Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the creation time.';
                    Editable = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the due date for the ticket.';
                }
                field("Due Time"; Rec."Due Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the due time for the ticket.';
                }
                field("Resolved Date"; Rec."Resolved Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the ticket was resolved.';
                    Editable = false;
                }
                field("Resolved DateTime"; Rec."Resolved DateTime")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the resolution date and time.';
                    Editable = false;
                }
                field("Resolution Hours"; Rec."Resolution Hours")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the hours taken to resolve the ticket.';
                    Editable = false;
                }
            }

            group(SLA)
            {
                Caption = 'SLA Information';

                field("SLA Breached"; Rec."SLA Breached")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indicates if the SLA has been breached.';
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = Rec."SLA Breached";
                }
            }

            group(Description)
            {
                Caption = 'Description';

                field(DescriptionField; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the detailed description of the ticket.';
                    MultiLine = true;
                    ShowCaption = false;
                }
            }
        }

        area(FactBoxes)
        {
            part(CustomerDetails; "Customer Details FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("Customer No.");
            }
            part(TicketStatistics; "Ticket Statistics FactBox")
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
            group(Functions)
            {
                Caption = 'Functions';

                action(AssignTicket)
                {
                    ApplicationArea = All;
                    Caption = 'Assign';
                    Image = Allocate;
                    ToolTip = 'Assign the ticket to a user or department.';

                    trigger OnAction()
                    var
                        TicketAssignmentPage: Page "Ticket Assignment";
                        TicketHeaderRec: Record "Ticket Header";
                    begin
                        // Initialize the assignment page with current ticket data
                        TicketHeaderRec := Rec;
                        TicketAssignmentPage.SetTicket(TicketHeaderRec);

                        // Run the assignment dialog
                        if TicketAssignmentPage.RunModal() = Action::OK then begin
                            // Get the updated assignment information
                            TicketAssignmentPage.GetAssignment(TicketHeaderRec);

                            // Update the current record with new assignment
                            Rec."Assigned To" := TicketHeaderRec."Assigned To";
                            Rec."Department Code" := TicketHeaderRec."Department Code";

                            // Save the changes
                            if Rec.Modify() then begin
                                Message('Ticket has been successfully assigned to %1 in department %2.',
                                    Rec."Assigned To", Rec."Department Code");
                                CurrPage.Update();
                            end else
                                Error('Failed to update ticket assignment.');
                        end;
                    end;
                }
                action(EscalateTicket)
                {
                    ApplicationArea = All;
                    Caption = 'Escalate';
                    Image = UpdateUnitCost;
                    ToolTip = 'Escalate the ticket to higher priority or management.';

                    trigger OnAction()
                    begin
                        // Add escalation logic here
                        Message('Escalation functionality to be implemented.');
                    end;
                }
                action(ResolveTicket)
                {
                    ApplicationArea = All;
                    Caption = 'Resolve';
                    Image = Approve;
                    ToolTip = 'Mark the ticket as resolved.';

                    trigger OnAction()
                    begin
                        if Confirm('Do you want to mark this ticket as resolved?') then begin
                            Rec."Resolved Date" := Today;
                            Rec."Resolved DateTime" := CurrentDateTime;
                            // Add logic to calculate resolution hours
                            Rec.Modify();
                            Message('Ticket has been marked as resolved.');
                        end;
                    end;
                }
                action(CloseTicket)
                {
                    ApplicationArea = All;
                    Caption = 'Close';
                    Image = Close;
                    ToolTip = 'Close the ticket.';

                    trigger OnAction()
                    begin
                        if Confirm('Do you want to close this ticket?') then begin
                            // Add logic to close ticket
                            Message('Ticket has been closed.');
                        end;
                    end;
                }
            }

            group(Communication)
            {
                Caption = 'Communication';

                action(SendEmail)
                {
                    ApplicationArea = All;
                    Caption = 'Send Email';
                    Image = Email;
                    ToolTip = 'Send an email regarding this ticket.';

                    trigger OnAction()
                    begin
                        // Add email functionality here
                        Message('Email functionality to be implemented.');
                    end;
                }
                action(SendSMS)
                {
                    ApplicationArea = All;
                    Caption = 'Send SMS';
                    Image = ExportMessage;
                    ToolTip = 'Send an SMS regarding this ticket.';

                    trigger OnAction()
                    begin
                        // Add SMS functionality here
                        Message('SMS functionality to be implemented.');
                    end;
                }
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
            action(TicketHistory)
            {
                ApplicationArea = All;
                Caption = 'Ticket History';
                Image = History;
                ToolTip = 'View the history of this ticket.';

                trigger OnAction()
                begin
                    // Add history functionality here
                    Message('History functionality to be implemented.');
                end;
            }
        }

        area(Reporting)
        {
            action(PrintTicket)
            {
                ApplicationArea = All;
                Caption = 'Print Ticket';
                Image = Print;
                ToolTip = 'Print the ticket details.';

                trigger OnAction()
                begin
                    // Add print functionality here
                    Message('Print functionality to be implemented.');
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        // Set default values for new records
        Rec."Created Date" := Today;
        Rec."Created DateTime" := CurrentDateTime;
        Rec."Created Time" := Time;
    end;
}