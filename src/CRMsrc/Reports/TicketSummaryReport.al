report 50000 "Ticket Summary Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Ticket Summary Report';

    dataset
    {
        dataitem(TicketHeader; "Ticket Header")
        {
            RequestFilterFields = "Created Date", Status, "Assigned To", "Department Code";

            column(No; "No.")
            {
                IncludeCaption = true;
            }

            column(Title; Title)
            {
                IncludeCaption = true;
            }

            column(CustomerNo; "Customer No.")
            {
                IncludeCaption = true;
            }

            column(CustomerName; "Customer Name")
            {
                IncludeCaption = true;
            }

            column(TicketType; "Ticket Type")
            {
                IncludeCaption = true;
            }

            column(Priority; Priority)
            {
                IncludeCaption = true;
            }

            column(Status; Status)
            {
                IncludeCaption = true;
            }

            column(AssignedTo; "Assigned To")
            {
                IncludeCaption = true;
            }

            column(CreatedDate; "Created Date")
            {
                IncludeCaption = true;
            }

            column(DueDate; "Due Date")
            {
                IncludeCaption = true;
            }

            column(ResolvedDate; "Resolved Date")
            {
                IncludeCaption = true;
            }

            column(ResolutionHours; "Resolution Hours")
            {
                IncludeCaption = true;
            }

            column(SLABreached; "SLA Breached")
            {
                IncludeCaption = true;
            }
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(ShowResolved; ShowResolvedTickets)
                    {
                        ApplicationArea = All;
                        Caption = 'Include Resolved Tickets';
                        ToolTip = 'Include resolved tickets in the report.';
                    }

                    field(ShowClosed; ShowClosedTickets)
                    {
                        ApplicationArea = All;
                        Caption = 'Include Closed Tickets';
                        ToolTip = 'Include closed tickets in the report.';
                    }
                }
            }
        }
    }

    var
        ShowResolvedTickets: Boolean;
        ShowClosedTickets: Boolean;

    trigger OnPreReport()
    begin
        if not ShowResolvedTickets then
            TicketHeader.SetFilter(Status, '<>%1', TicketHeader.Status::Resolved);

        if not ShowClosedTickets then
            TicketHeader.SetFilter(Status, '<>%1', TicketHeader.Status::Closed);
    end;
}