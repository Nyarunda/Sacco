page 50427 "CRM Customer List"
{
    PageType = List;
    SourceTable = "CRM Customer";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'CRM Customers';
    CardPageId = "CRM Customer Card";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(CustomerRepeater)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer number.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer name.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer phone number.';
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer email address.';
                }
                field("Customer Type"; Rec."Customer Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of customer.';
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
                }
            }
        }
        area(FactBoxes)
        {
            part(CustomerStatistics; "Customer Statistics FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }
            part(CustomerTicketsFB; "Customer Tickets FactBox")
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
            action(NewCustomer)
            {
                ApplicationArea = All;
                Caption = 'New Customer';
                Image = New;
                ToolTip = 'Create a new customer record.';

                trigger OnAction()
                begin
                    Page.RunModal(Page::"CRM Customer Card");
                end;
            }
            action(CreateTicket)
            {
                ApplicationArea = All;
                Caption = 'Create Ticket';
                Image = NewDocument;
                ToolTip = 'Create a new ticket for the selected customer.';

                trigger OnAction()
                var
                    TicketHeader: Record "Ticket Header";
                    TicketCard: Page "Ticket Card";
                begin
                    TicketHeader.Init();
                    TicketHeader."Customer No." := Rec."No.";
                    TicketHeader."Customer Name" := Rec.Name;
                    TicketHeader.Insert(true);
                    Commit();

                    TicketCard.SetRecord(TicketHeader);
                    TicketCard.Run();
                end;
            }
            action(ImportCustomers)
            {
                ApplicationArea = All;
                Caption = 'Import Customers';
                Image = Import;
                ToolTip = 'Import customer data from external source.';

                trigger OnAction()
                begin
                    // Add import functionality here
                    Message('Import functionality to be implemented.');
                end;
            }
            action(ImportTicketsFromExcel)
            {
                ApplicationArea = All;
                Caption = 'Import from Excel';
                Image = ImportExcel;
                ToolTip = 'Import customer tickets from Excel file.';

                trigger OnAction()
                var
                    ImportTickets: Codeunit "Import Tickets";
                begin
                    ImportTickets.ImportTicketsFromExcel();
                end;
            }
        }
        area(Navigation)
        {
            action(CustomerTickets)
            {
                ApplicationArea = All;
                Caption = 'Customer Tickets';
                Image = ServiceLines;
                ToolTip = 'View all tickets for this customer.';
                RunObject = page "Ticket List";
                RunPageLink = "Customer No." = field("No.");
                RunPageView = where(Status = filter(<> Closed));
            }
            action(AllCustomerTickets)
            {
                ApplicationArea = All;
                Caption = 'All Tickets';
                Image = History;
                ToolTip = 'View all tickets (including closed) for this customer.';
                RunObject = page "Ticket List";
                RunPageLink = "Customer No." = field("No.");
            }

            action(SendEmail)
            {
                ApplicationArea = All;
                Caption = 'Send Email';
                Image = Email;
                ToolTip = 'Send an email to the customer.';

                trigger OnAction()
                begin
                    if Rec.Email = '' then begin
                        Error('No email address specified for customer %1.', Rec."No.");
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
                ToolTip = 'Send an SMS to the customer.';

                trigger OnAction()
                begin
                    if Rec."Phone No." = '' then begin
                        Error('No phone number specified for customer %1.', Rec."No.");
                        exit;
                    end;
                    // Add SMS functionality here
                    Message('SMS functionality to be implemented for %1.', Rec."Phone No.");
                end;
            }
        }
        area(Reporting)
        {
            action(CustomerReport)
            {
                ApplicationArea = All;
                Caption = 'Customer Report';
                Image = Report;
                ToolTip = 'Generate customer reports.';

                trigger OnAction()
                begin
                    // Add report logic here
                    Message('Customer report functionality to be implemented.');
                end;
            }
            action(CustomerAnalysis)
            {
                ApplicationArea = All;
                Caption = 'Customer Analysis';
                Image = AbsenceCategories;
                ToolTip = 'Analyze customer data and patterns.';

                trigger OnAction()
                begin
                    // Add analysis functionality here
                    Message('Customer analysis functionality to be implemented.');
                end;
            }
        }
    }

    views
    {
        view(ActiveCustomers)
        {
            Caption = 'Active Customers';
            Filters = where("Customer Status" = const(Active));
        }
        view(InactiveCustomers)
        {
            Caption = 'Inactive Customers';
            Filters = where("Customer Status" = const(Inactive));
        }

    }
}