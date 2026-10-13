page 50420 "Tickets API"
{
    APIVersion = 'v1.0';
    APIPublisher = 'YourCompany';
    APIGroup = 'crm';
    EntityCaption = 'Ticket';
    EntitySetCaption = 'Tickets';
    EntityName = 'Ticket';
    EntitySetName = 'Tickets';
    PageType = API;
    SourceTable = "Ticket Header";
    DelayedInsert = true;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(id; Rec.SystemId)
                {
                    Caption = 'Id';
                    Editable = false;
                }

                field(number; Rec."No.")
                {
                    Caption = 'Number';
                }

                field(customerNumber; Rec."Customer No.")
                {
                    Caption = 'Customer Number';
                }

                field(title; Rec.Title)
                {
                    Caption = 'Title';
                }

                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }

                field(ticketType; Rec."Ticket Type")
                {
                    Caption = 'Ticket Type';
                }

                /*
                field(source; Rec.Source)
                {
                    Caption = 'Source';
                }
                */

                field(priority; Rec.Priority)
                {
                    Caption = 'Priority';
                }

                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }

                field(assignedTo; Rec."Assigned To")
                {
                    Caption = 'Assigned To';
                }

                field(createdDate; Rec."Created Date")
                {
                    Caption = 'Created Date';
                    Editable = false;
                }

                field(dueDate; Rec."Due Date")
                {
                    Caption = 'Due Date';
                }

                field(resolvedDate; Rec."Resolved Date")
                {
                    Caption = 'Resolved Date';
                    Editable = false;
                }

                field(resolutionHours; Rec."Resolution Hours")
                {
                    Caption = 'Resolution Hours';
                    Editable = false;
                }

                field(slaBreached; Rec."SLA Breached")
                {
                    Caption = 'SLA Breached';
                    Editable = false;
                }
            }
        }
    }
}