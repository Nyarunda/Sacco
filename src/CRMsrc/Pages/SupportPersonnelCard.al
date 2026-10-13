page 50430 "Support Personnel Card"
{
    PageType = Card;
    SourceTable = "Support Personnel";
    ApplicationArea = All;
    Caption = 'Support Personnel Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General Information';

                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique code for the support personnel.';
                    ShowMandatory = true;


                }
                field("Name"; Rec."Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the support personnel.';
                    ShowMandatory = true;
                }
                field("Email"; Rec."Email")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the email address.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the phone number.';
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the job title.';
                }
                field("Active"; Rec."Active")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the personnel is active.';
                    Style = Favorable;
                    StyleExpr = Rec."Active";
                }
                field("Hire Date"; Rec."Hire Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the hire date.';
                }
            }

            group(Department)
            {
                Caption = 'Department & Management';

                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the department code.';

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the department name.';
                }
                field("Manager Code"; Rec."Manager Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the manager code.';

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Manager Name"; Rec."Manager Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the manager name.';
                }
            }

            group(Skills)
            {
                Caption = 'Skills & Experience';

                field("Experience Level"; Rec."Experience Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the experience level.';
                }
                field("Skill Set"; Rec."Skill Set")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the skill set and expertise areas.';
                    MultiLine = true;
                }
            }

            group(Schedule)
            {
                Caption = 'Schedule & Availability';

                field("Shift Start Time"; Rec."Shift Start Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the shift start time.';
                }
                field("Shift End Time"; Rec."Shift End Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the shift end time.';
                }
                field("Time Zone"; Rec."Time Zone")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the time zone.';
                }
                field("Max Concurrent Tickets"; Rec."Max Concurrent Tickets")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the maximum number of concurrent tickets.';
                }
            }

            group(Statistics)
            {
                Caption = 'Performance Statistics';

                field("Current Tickets"; Rec."Current Tickets")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows the number of currently assigned tickets.';
                    DrillDownPageId = "Ticket List";
                    Style = Attention;
                    StyleExpr = (Rec."Current Tickets" >= Rec."Max Concurrent Tickets");

                    trigger OnDrillDown()
                    var
                        TicketHeader: Record "Ticket Header";
                    begin
                        TicketHeader.SetRange("Assigned To", Rec."User ID");
                        TicketHeader.SetFilter("Status", '<>%1', TicketHeader."Status"::"Closed");
                        Page.Run(Page::"Ticket List", TicketHeader);
                    end;
                }
                field("Total Tickets Resolved"; Rec."Total Tickets Resolved")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows the total number of tickets resolved.';
                    DrillDownPageId = "Ticket List";

                    trigger OnDrillDown()
                    var
                        TicketHeader: Record "Ticket Header";
                    begin
                        TicketHeader.SetRange("Assigned To", Rec."User ID");
                        TicketHeader.SetRange("Status", TicketHeader."Status"::"Resolved");
                        Page.Run(Page::"Ticket List", TicketHeader);
                    end;
                }
                field("Average Resolution Time"; Rec."Average Resolution Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows the average resolution time in hours.';
                }
                field(Availability; Rec.GetAvailability())
                {
                    ApplicationArea = All;
                    Caption = 'Current Availability';
                    ToolTip = 'Shows the current availability status.';
                    StyleExpr = AvailabilityStyle;
                    Editable = false;
                }
            }

            group(Audit)
            {
                Caption = 'Audit Information';
                Visible = ShowAuditInfo;

                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows when the record was created.';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows who created the record.';
                }
                field("Last Modified Date"; Rec."Last Modified Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows when the record was last modified.';
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows who last modified the record.';
                }
            }
        }

        /*
        area(FactBoxes)
        {
            part(PersonnelStatistics; "Personnel Statistics FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Code" = field("Code");
            }
            part(AssignedTickets; "Assigned Tickets FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Assigned To" = field("Code");
            }
        }
        */
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
                    Caption = 'Assign Ticket';
                    Image = Allocate;
                    ToolTip = 'Assign a ticket to this personnel.';


                    trigger OnAction()
                    begin
                        Message('Ticket assignment functionality to be implemented.');
                        // This could open a ticket selection page
                    end;
                }
                action(ViewTickets)
                {
                    ApplicationArea = All;
                    Caption = 'View Assigned Tickets';
                    Image = TaskList;
                    ToolTip = 'View all tickets assigned to this personnel.';

                    trigger OnAction()
                    var
                        TicketHeader: Record "Ticket Header";
                    begin
                        TicketHeader.SetRange("Assigned To", Rec."User ID");
                        Page.Run(Page::"Ticket List", TicketHeader);
                    end;
                }
                action(CalculateStats)
                {
                    ApplicationArea = All;
                    Caption = 'Recalculate Statistics';
                    Image = Calculate;
                    ToolTip = 'Recalculate performance statistics.';

                    trigger OnAction()
                    begin
                        // Add logic to recalculate average resolution time
                        Message('Statistics recalculation functionality to be implemented.');
                        CurrPage.Update();
                    end;
                }
            }

            group(Status)
            {
                Caption = 'Status';

                action(Activate)
                {
                    ApplicationArea = All;
                    Caption = 'Activate';
                    Image = Approval;
                    ToolTip = 'Activate this personnel.';
                    Enabled = not Rec."Active";

                    trigger OnAction()
                    begin
                        if Confirm('Do you want to activate %1?', false, Rec."Name") then begin
                            Rec."Active" := true;
                            Rec.Modify();
                            Message('%1 has been activated.', Rec."Name");
                            CurrPage.Update();
                        end;
                    end;
                }
                action(Deactivate)
                {
                    ApplicationArea = All;
                    Caption = 'Deactivate';
                    Image = DeactivateDiscounts;
                    ToolTip = 'Deactivate this personnel.';
                    Enabled = Rec."Active";

                    trigger OnAction()
                    begin
                        if Confirm('Do you want to deactivate %1?\\This will prevent new ticket assignments.', false, Rec."Name") then begin
                            Rec."Active" := false;
                            Rec.Modify();
                            Message('%1 has been deactivated.', Rec."Name");
                            CurrPage.Update();
                        end;
                    end;
                }
            }
        }

        area(Navigation)
        {
            action(Manager)
            {
                ApplicationArea = All;
                Caption = 'Manager';
                Image = Employee;
                ToolTip = 'View the manager details.';
                Enabled = Rec."Manager Code" <> '';
                RunObject = page "Support Personnel Card";
                RunPageLink = "User ID" = field("Manager Code");
            }
            action(CRMDepartment)
            {
                ApplicationArea = All;
                Caption = 'Department';
                Image = Departments;
                ToolTip = 'View department details.';
                Enabled = Rec."Department Code" <> '';
                //RunObject = page "Department Card";
                //RunPageLink = "Code" = field("Department Code");
            }
        }

        area(Reporting)
        {
            action(PersonnelCard)
            {
                ApplicationArea = All;
                Caption = 'Print Personnel Card';
                Image = Print;
                ToolTip = 'Print the personnel card.';

                trigger OnAction()
                begin
                    Message('Print functionality to be implemented.');
                end;
            }
            action(PerformanceReport)
            {
                ApplicationArea = All;
                Caption = 'Performance Report';
                Image = Report;
                ToolTip = 'Generate a performance report for this personnel.';

                trigger OnAction()
                begin
                    Message('Performance report functionality to be implemented.');
                end;
            }
        }
    }

    var
        AvailabilityStyle: Text;
        ShowAuditInfo: Boolean;

    /*
    trigger OnAfterGetRecord()
    begin
        SetAvailabilityStyle();
    end;

    trigger On
    */
}
