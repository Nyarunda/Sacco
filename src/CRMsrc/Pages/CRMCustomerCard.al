page 50426 "CRM Customer Card"
{
    PageType = Card;
    SourceTable = "CRM Customer";
    ApplicationArea = All;
    Caption = 'CRM Customer Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General Information';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer number.';


                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer name.';
                    ShowMandatory = true;
                }
                field("Customer Type"; Rec."Customer Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of customer (Regular, VIP, etc.).';
                }
                field("Customer Status"; Rec."Customer Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the current status of the customer.';
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the customer was registered.';
                    Editable = false;
                }
            }

            group(Contact)
            {
                Caption = 'Contact Information';

                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer phone number.';
                    ExtendedDatatype = PhoneNo;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer email address.';
                    ExtendedDatatype = EMail;
                }
            }

            group(CustomerStatistics)
            {
                Caption = 'Statistics Overview';
                Visible = Rec."No." <> '';

                field(TotalTickets; TotalTicketsCount)
                {
                    ApplicationArea = All;
                    Caption = 'Total Tickets';
                    ToolTip = 'Total number of tickets created for this customer.';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        ShowCustomerTickets(false);
                    end;
                }
                field(OpenTickets; OpenTicketsCount)
                {
                    ApplicationArea = All;
                    Caption = 'Open Tickets';
                    ToolTip = 'Number of open tickets for this customer.';
                    Editable = false;
                    Style = Attention;
                    StyleExpr = OpenTicketsCount > 3;

                    trigger OnDrillDown()
                    begin
                        ShowCustomerTickets(true);
                    end;
                }
                field(AvgResolutionTime; AvgResolutionHours)
                {
                    ApplicationArea = All;
                    Caption = 'Avg Resolution (Hours)';
                    ToolTip = 'Average resolution time for this customer tickets.';
                    Editable = false;
                    DecimalPlaces = 1 : 1;
                }
                field(LastTicketDate; LastTicketDate)
                {
                    ApplicationArea = All;
                    Caption = 'Last Ticket Date';
                    ToolTip = 'When the last ticket was created for this customer.';
                    Editable = false;
                }
            }
        }

        area(FactBoxes)
        {
            part(CustomerStatisticsFB; "Customer Statistics FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }
            part(RecentTickets; "Customer Tickets FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Customer No." = field("No.");
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

                action(CreateTicket)
                {
                    ApplicationArea = All;
                    Caption = 'Create Ticket';
                    Image = NewDocument;
                    ToolTip = 'Create a new ticket for this customer.';

                    trigger OnAction()
                    var
                        TicketHeader: Record "Ticket Header";
                        TicketCard: Page "Ticket Card";
                    begin
                        Rec.TestField("No.");
                        Rec.TestField(Name);

                        TicketHeader.Init();
                        TicketHeader."Customer No." := Rec."No.";
                        TicketHeader."Customer Name" := Rec.Name;
                        TicketHeader.Insert(true);
                        Commit();

                        TicketCard.SetRecord(TicketHeader);
                        TicketCard.Run();

                        CurrPage.Update();
                    end;
                }
                action(UpdateStatus)
                {
                    ApplicationArea = All;
                    Caption = 'Update Status';
                    Image = UpdateDescription;
                    ToolTip = 'Update customer status (Active/Inactive).';

                    trigger OnAction()
                    begin
                        if Rec."Customer Status" = Rec."Customer Status"::Active then begin
                            if Confirm('Do you want to mark this customer as Inactive?') then begin
                                Rec."Customer Status" := Rec."Customer Status"::Inactive;
                                Rec.Modify();
                                Message('Customer status updated to Inactive.');
                            end;
                        end else begin
                            if Confirm('Do you want to mark this customer as Active?') then begin
                                Rec."Customer Status" := Rec."Customer Status"::Active;
                                Rec.Modify();
                                Message('Customer status updated to Active.');
                            end;
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
                    ToolTip = 'Send an email to this customer.';
                    Enabled = Rec.Email <> '';

                    trigger OnAction()
                    begin
                        if Rec.Email = '' then begin
                            Error('No email address specified for this customer.');
                            exit;
                        end;
                        // Add email functionality here
                        Message('Email functionality to be implemented for %1.', Rec.Email);
                    end;
                }
                action(SendSMS)
                {
                    ApplicationArea = All;
                    Caption = 'Send SMS';
                    Image = ExportMessage;
                    ToolTip = 'Send an SMS to this customer.';
                    Enabled = Rec."Phone No." <> '';

                    trigger OnAction()
                    begin
                        if Rec."Phone No." = '' then begin
                            Error('No phone number specified for this customer.');
                            exit;
                        end;
                        // Add SMS functionality here
                        Message('SMS functionality to be implemented for %1.', Rec."Phone No.");
                    end;
                }
                action(CallCustomer)
                {
                    ApplicationArea = All;
                    Caption = 'Call Customer';
                    Image = Calls;
                    ToolTip = 'Initiate a call to this customer.';
                    Enabled = Rec."Phone No." <> '';

                    trigger OnAction()
                    begin
                        if Rec."Phone No." = '' then begin
                            Error('No phone number specified for this customer.');
                            exit;
                        end;
                        // Add call functionality here
                        Message('Call functionality to be implemented for %1.', Rec."Phone No.");
                    end;
                }
            }
        }

        area(Navigation)
        {
            action(CustomerTickets)
            {
                ApplicationArea = All;
                Caption = 'Customer Tickets';
                Image = ServiceLines;
                ToolTip = 'View all open tickets for this customer.';

                trigger OnAction()
                begin
                    ShowCustomerTickets(true);
                end;
            }
            action(AllTickets)
            {
                ApplicationArea = All;
                Caption = 'All Tickets';
                Image = History;
                ToolTip = 'View all tickets (including closed) for this customer.';

                trigger OnAction()
                begin
                    ShowCustomerTickets(false);
                end;
            }
            action(CustomerHistory)
            {
                ApplicationArea = All;
                Caption = 'Customer History';
                Image = History;
                ToolTip = 'View customer interaction history.';

                trigger OnAction()
                begin
                    // Add history functionality here
                    Message('Customer history functionality to be implemented.');
                end;
            }
        }

        area(Reporting)
        {
            action(CustomerSummary)
            {
                ApplicationArea = All;
                Caption = 'Customer Summary';
                Image = Report;
                ToolTip = 'Print customer summary report.';

                trigger OnAction()
                begin
                    // Add report functionality here
                    Message('Customer summary report to be implemented.');
                end;
            }
            action(TicketAnalysis)
            {
                ApplicationArea = All;
                Caption = 'Ticket Analysis';
                Image = AnalysisView;
                ToolTip = 'Analyze customer ticket patterns.';

                trigger OnAction()
                begin
                    // Add analysis functionality here
                    Message('Ticket analysis functionality to be implemented.');
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateStatistics();
    end;

    trigger OnAfterGetRecord()
    begin
        UpdateStatistics();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Registration Date" := Today;
        Rec."Customer Status" := Rec."Customer Status"::Active;
    end;

    local procedure UpdateStatistics()
    var
        TicketHeader: Record "Ticket Header";
        TotalResolutionHours: Integer;
        ResolvedTickets: Integer;
    begin
        if Rec."No." = '' then begin
            TotalTicketsCount := 0;
            OpenTicketsCount := 0;
            AvgResolutionHours := 0;
            LastTicketDate := 0D;
            exit;
        end;

        // Count total tickets
        TicketHeader.SetRange("Customer No.", Rec."No.");
        TotalTicketsCount := TicketHeader.Count;

        // Count open tickets
        TicketHeader.SetFilter(Status, '<>%1', TicketHeader.Status::Closed);
        OpenTicketsCount := TicketHeader.Count;

        // Calculate average resolution time
        TicketHeader.Reset();
        TicketHeader.SetRange("Customer No.", Rec."No.");
        TicketHeader.SetFilter("Resolution Hours", '>0');
        if TicketHeader.FindSet() then begin
            repeat
                TotalResolutionHours += TicketHeader."Resolution Hours";
                ResolvedTickets += 1;
            until TicketHeader.Next() = 0;

            if ResolvedTickets > 0 then
                AvgResolutionHours := TotalResolutionHours / ResolvedTickets;
        end;

        // Get last ticket date
        TicketHeader.Reset();
        TicketHeader.SetRange("Customer No.", Rec."No.");
        TicketHeader.SetCurrentKey("Created Date");
        TicketHeader.Ascending(false);
        if TicketHeader.FindFirst() then
            LastTicketDate := TicketHeader."Created Date";
    end;

    local procedure ShowCustomerTickets(OpenOnly: Boolean)
    var
        TicketHeader: Record "Ticket Header";
        TicketList: Page "Ticket List";
    begin
        TicketHeader.SetRange("Customer No.", Rec."No.");
        if OpenOnly then
            TicketHeader.SetFilter(Status, '<>%1', TicketHeader.Status::Closed);

        TicketList.SetTableView(TicketHeader);
        TicketList.Run();
    end;

    var
        TotalTicketsCount: Integer;
        OpenTicketsCount: Integer;
        AvgResolutionHours: Decimal;
        LastTicketDate: Date;
}