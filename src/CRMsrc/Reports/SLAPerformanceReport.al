report 50001 "SLA Performance Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    //Caption = 'SLA Performance Report';

    dataset
    {
        dataitem(SLASetup; "SLA Setup")
        {
            column(TicketType; "Ticket Type")
            {
                IncludeCaption = true;
            }

            column(Priority; Priority)
            {
                IncludeCaption = true;
            }

            column(ResponseTimeHours; "Response Time (Hours)")
            {
                IncludeCaption = true;
            }

            column(TotalTickets; TotalTickets)
            {
                //Caption = 'Total Tickets';
            }

            column(TicketsMetSLA; TicketsMetSLA)
            {
                //Caption = 'Tickets Met SLA';
            }

            column(TicketsBreachedSLA; TicketsBreachedSLA)
            {
                //Caption = 'Tickets Breached SLA';
            }

            column(SLACompliancePerc; SLACompliancePerc)
            {
                DecimalPlaces = 2 : 2;
            }

            column(AvgResolutionHours; AvgResolutionHours)
            {

                DecimalPlaces = 2 : 2;
            }

            trigger OnAfterGetRecord()
            var
                TicketHeader: Record "Ticket Header";
            begin
                TicketHeader.SetRange("Ticket Type", "Ticket Type");
                TicketHeader.SetRange(Priority, Priority);
                TicketHeader.SetFilter(Status, '%1|%2', TicketHeader.Status::Resolved, TicketHeader.Status::Closed);
                TicketHeader.SetRange("Created Date", StartDate, EndDate);

                TotalTickets := TicketHeader.Count();

                TicketHeader.SetRange("SLA Breached", false);
                TicketsMetSLA := TicketHeader.Count();

                TicketsBreachedSLA := TotalTickets - TicketsMetSLA;

                if TotalTickets > 0 then
                    SLACompliancePerc := (TicketsMetSLA / TotalTickets) * 100
                else
                    SLACompliancePerc := 0;

                TicketHeader.SetRange("SLA Breached");
                //TicketHeader.CalcSums("Resolution Hours");
                //if TotalTickets > 0 then
                //  AvgResolutionHours := TicketHeader."Resolution Hours" / TotalTickets
                //else
                //  AvgResolutionHours := 0;
            end;
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
                    //Caption = 'Date Filter';

                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                        //Caption = 'Start Date';
                    }

                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        //Caption = 'End Date';
                    }
                }
            }
        }
    }

    var
        StartDate, EndDate : Date;
        TotalTickets, TicketsMetSLA, TicketsBreachedSLA : Integer;
        SLACompliancePerc, AvgResolutionHours : Decimal;

    trigger OnInitReport()
    begin
        StartDate := CalcDate('<-1M>', Today());
        EndDate := Today();
    end;
}