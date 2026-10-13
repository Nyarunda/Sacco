page 50402 "Ticket Statistics FactBox"
{
    PageType = CardPart;
    SourceTable = "Ticket Header";
    Caption = 'Ticket Statistics';

    layout
    {
        area(Content)
        {
            group(CurrentTicket)
            {
                Caption = 'Current Ticket';

                field("Days Open"; DaysOpen)
                {
                    ApplicationArea = All;
                    Caption = 'Days Open';
                    ToolTip = 'Shows how many days this ticket has been open.';
                    Editable = false;
                    Style = Attention;
                    StyleExpr = DaysOpen > 7;
                }

                field("Hours to Resolution"; HoursToResolution)
                {
                    ApplicationArea = All;
                    Caption = 'Hours to Resolution';
                    ToolTip = 'Shows hours taken to resolve or current hours open.';
                    Editable = false;
                }

                field("SLA Status"; SLAStatusText)
                {
                    ApplicationArea = All;
                    Caption = 'SLA Status';
                    ToolTip = 'Shows the current SLA status of this ticket.';
                    Editable = false;
                    Style = Favorable;
                    StyleExpr = not Rec."SLA Breached";
                }
            }

            group(CustomerStats)
            {
                Caption = 'Customer Statistics';

                field("Customer Total Tickets"; CustomerTotalTickets)
                {
                    ApplicationArea = All;
                    Caption = 'Total Tickets';
                    ToolTip = 'Total number of tickets for this customer.';
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        TicketList: Page "Ticket List";
                        TicketHeader: Record "Ticket Header";
                    begin
                        if Rec."Customer No." <> '' then begin
                            TicketHeader.SetRange("Customer No.", Rec."Customer No.");
                            TicketList.SetTableView(TicketHeader);
                            TicketList.Run();
                        end;
                    end;
                }

                field("Customer Open Tickets"; CustomerOpenTickets)
                {
                    ApplicationArea = All;
                    Caption = 'Open Tickets';
                    ToolTip = 'Number of open tickets for this customer.';
                    Editable = false;
                    Style = Attention;
                    StyleExpr = CustomerOpenTickets > 3;

                    trigger OnDrillDown()
                    var
                        TicketList: Page "Ticket List";
                        TicketHeader: Record "Ticket Header";
                    begin
                        if Rec."Customer No." <> '' then begin
                            TicketHeader.SetRange("Customer No.", Rec."Customer No.");
                            TicketHeader.SetFilter(Status, '<>%1', TicketHeader.Status::Closed);
                            TicketList.SetTableView(TicketHeader);
                            TicketList.Run();
                        end;
                    end;
                }

                field("Customer Avg Resolution"; CustomerAvgResolution)
                {
                    ApplicationArea = All;
                    Caption = 'Avg Resolution (Hours)';
                    ToolTip = 'Average resolution time for this customer tickets.';
                    Editable = false;
                    DecimalPlaces = 1 : 1;
                }

                field("Customer SLA Breach Rate"; CustomerSLABreachRate)
                {
                    ApplicationArea = All;
                    Caption = 'SLA Breach Rate (%)';
                    ToolTip = 'Percentage of tickets that breached SLA for this customer.';
                    Editable = false;
                    DecimalPlaces = 1 : 1;
                    Style = Unfavorable;
                    StyleExpr = CustomerSLABreachRate > 20;
                }
            }

            group(SystemStats)
            {
                Caption = 'System Statistics';

                field("Total Open Tickets"; TotalOpenTickets)
                {
                    ApplicationArea = All;
                    Caption = 'Total Open';
                    ToolTip = 'Total number of open tickets in the system.';
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        TicketList: Page "Ticket List";
                        TicketHeader: Record "Ticket Header";
                    begin
                        TicketHeader.SetFilter(Status, '<>%1', TicketHeader.Status::Closed);
                        TicketList.SetTableView(TicketHeader);
                        TicketList.Run();
                    end;
                }

                field("High Priority Open"; HighPriorityOpen)
                {
                    ApplicationArea = All;
                    Caption = 'High Priority Open';
                    ToolTip = 'Number of high priority open tickets.';
                    Editable = false;
                    Style = Attention;
                    StyleExpr = HighPriorityOpen > 0;

                    trigger OnDrillDown()
                    var
                        TicketList: Page "Ticket List";
                        TicketHeader: Record "Ticket Header";
                    begin
                        TicketHeader.SetRange(Priority, TicketHeader.Priority::High);
                        TicketHeader.SetFilter(Status, '<>%1', TicketHeader.Status::Closed);
                        TicketList.SetTableView(TicketHeader);
                        TicketList.Run();
                    end;
                }

                field("SLA Breached Today"; SLABreachedToday)
                {
                    ApplicationArea = All;
                    Caption = 'SLA Breached Today';
                    ToolTip = 'Number of tickets that breached SLA today.';
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = SLABreachedToday > 0;
                }

                field("My Open Tickets"; MyOpenTickets)
                {
                    ApplicationArea = All;
                    Caption = 'My Open Tickets';
                    ToolTip = 'Number of tickets assigned to current user.';
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        TicketList: Page "Ticket List";
                        TicketHeader: Record "Ticket Header";
                    begin
                        TicketHeader.SetRange("Assigned To", UserId);
                        TicketHeader.SetFilter(Status, '<>%1', TicketHeader.Status::Closed);
                        TicketList.SetTableView(TicketHeader);
                        TicketList.Run();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CalculateStatistics();
    end;

    trigger OnAfterGetRecord()
    begin
        CalculateStatistics();
    end;

    local procedure CalculateStatistics()
    var
        TicketHeader: Record "Ticket Header";
        Customer: Record "CRM Customer";
        TotalCustomerTickets: Integer;
        ResolvedCustomerTickets: Integer;
        TotalResolutionHours: Integer;
    begin
        // Current Ticket Statistics
        if Rec."Created Date" <> 0D then
            DaysOpen := Today - Rec."Created Date"
        else
            DaysOpen := 0;

        if (Rec."Resolved DateTime" <> 0DT) and (Rec."Created DateTime" <> 0DT) then
            HoursToResolution := Round((Rec."Resolved DateTime" - Rec."Created DateTime") / 3600000, 1)
        else if Rec."Created DateTime" <> 0DT then
            HoursToResolution := Round((CurrentDateTime - Rec."Created DateTime") / 3600000, 1)
        else
            HoursToResolution := 0;

        if Rec."SLA Breached" then
            SLAStatusText := 'BREACHED'
        else
            SLAStatusText := 'On Track';

        // Customer Statistics
        if Rec."Customer No." <> '' then begin
            TicketHeader.SetRange("Customer No.", Rec."Customer No.");
            CustomerTotalTickets := TicketHeader.Count;

            TicketHeader.SetFilter(Status, '<>%1', TicketHeader.Status::Closed);
            CustomerOpenTickets := TicketHeader.Count;

            // Calculate average resolution time
            TicketHeader.Reset();
            TicketHeader.SetRange("Customer No.", Rec."Customer No.");
            TicketHeader.SetFilter("Resolution Hours", '>0');
            if TicketHeader.FindSet() then begin
                TotalResolutionHours := 0;
                ResolvedCustomerTickets := 0;
                repeat
                    TotalResolutionHours += TicketHeader."Resolution Hours";
                    ResolvedCustomerTickets += 1;
                until TicketHeader.Next() = 0;

                if ResolvedCustomerTickets > 0 then
                    CustomerAvgResolution := TotalResolutionHours / ResolvedCustomerTickets;
            end;

            // Calculate SLA breach rate
            TicketHeader.Reset();
            TicketHeader.SetRange("Customer No.", Rec."Customer No.");
            TotalCustomerTickets := TicketHeader.Count;
            TicketHeader.SetRange("SLA Breached", true);
            if TotalCustomerTickets > 0 then
                CustomerSLABreachRate := (TicketHeader.Count / TotalCustomerTickets) * 100;
        end else begin
            CustomerTotalTickets := 0;
            CustomerOpenTickets := 0;
            CustomerAvgResolution := 0;
            CustomerSLABreachRate := 0;
        end;

        // System Statistics
        TicketHeader.Reset();
        TicketHeader.SetFilter(Status, '<>%1', TicketHeader.Status::Closed);
        TotalOpenTickets := TicketHeader.Count;

        TicketHeader.SetRange(Priority, TicketHeader.Priority::High);
        HighPriorityOpen := TicketHeader.Count;

        TicketHeader.Reset();
        TicketHeader.SetRange("SLA Breached", true);
        TicketHeader.SetRange("Created Date", Today);
        SLABreachedToday := TicketHeader.Count;

        TicketHeader.Reset();
        TicketHeader.SetRange("Assigned To", UserId);
        TicketHeader.SetFilter(Status, '<>%1', TicketHeader.Status::Closed);
        MyOpenTickets := TicketHeader.Count;
    end;

    var
        DaysOpen: Integer;
        HoursToResolution: Decimal;
        SLAStatusText: Text[20];
        CustomerTotalTickets: Integer;
        CustomerOpenTickets: Integer;
        CustomerAvgResolution: Decimal;
        CustomerSLABreachRate: Decimal;
        TotalOpenTickets: Integer;
        HighPriorityOpen: Integer;
        SLABreachedToday: Integer;
        MyOpenTickets: Integer;
}