page 50431 "Support Personnel List"
{
    PageType = List;
    SourceTable = "Support Personnel";
    ApplicationArea = All;
    Caption = 'Support Personnel';
    CardPageId = "Support Personnel Card";
    Editable = false;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(SPersonnel)
            {
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique code for the support personnel.';
                }
                field("Name"; Rec."Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the support personnel.';
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
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the department code.';
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the department name.';
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the job title.';
                }
                field("Experience Level"; Rec."Experience Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the experience level.';
                }
                field("Active"; Rec."Active")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the personnel is active.';
                    Style = Favorable;
                    StyleExpr = Rec."Active";
                }
                field("Current Tickets"; Rec."Current Tickets")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows the number of currently assigned tickets.';
                    DrillDownPageId = "Ticket List";

                    trigger OnDrillDown()
                    var
                        TicketHeader: Record "Ticket Header";
                    begin
                        TicketHeader.SetRange("Assigned To", Rec."User ID");
                        TicketHeader.SetFilter("Status", '<>%1', TicketHeader."Status"::"Closed");
                        Page.Run(Page::"Ticket List", TicketHeader);
                    end;
                }
                field("Max Concurrent Tickets"; Rec."Max Concurrent Tickets")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the maximum number of concurrent tickets.';
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
                field(Availability; Rec.GetAvailability())
                {
                    ApplicationArea = All;
                    Caption = 'Availability';
                    ToolTip = 'Shows the current availability status.';
                    StyleExpr = AvailabilityStyle;
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
        }
        */
    }

    actions
    {
        area(Processing)
        {
            group(Personnel)
            {
                Caption = 'Personnel';

                action(NewPersonnel)
                {
                    ApplicationArea = All;
                    Caption = 'New';
                    Image = New;
                    ToolTip = 'Create a new support personnel record.';
                    RunObject = page "Support Personnel Card";
                    RunPageMode = Create;
                }
                action(EditPersonnel)
                {
                    ApplicationArea = All;
                    Caption = 'Edit';
                    Image = Edit;
                    ToolTip = 'Edit the selected support personnel record.';

                    trigger OnAction()
                    begin
                        Page.Run(Page::"Support Personnel Card", Rec);
                    end;
                }
                action(DeactivatePersonnel)
                {
                    ApplicationArea = All;
                    Caption = 'Deactivate';
                    Image = DeactivateDiscounts;
                    ToolTip = 'Deactivate the selected personnel.';
                    Enabled = Rec."Active";

                    trigger OnAction()
                    begin
                        if Confirm('Do you want to deactivate %1?', false, Rec."Name") then begin
                            Rec."Active" := false;
                            Rec.Modify();
                            Message('%1 has been deactivated.', Rec."Name");
                            CurrPage.Update();
                        end;
                    end;
                }
                action(ActivatePersonnel)
                {
                    ApplicationArea = All;
                    Caption = 'Activate';
                    Image = Approval;
                    ToolTip = 'Activate the selected personnel.';
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
            }

            group(View)
            {
                Caption = 'View';

                action(ShowActive)
                {
                    ApplicationArea = All;
                    Caption = 'Show Active Only';
                    Image = Filter;
                    ToolTip = 'Show only active personnel.';

                    trigger OnAction()
                    begin
                        Rec.SetRange("Active", true);
                        CurrPage.Update();
                    end;
                }
                action(ShowAll)
                {
                    ApplicationArea = All;
                    Caption = 'Show All';
                    Image = ClearFilter;
                    ToolTip = 'Show all personnel.';

                    trigger OnAction()
                    begin
                        Rec.SetRange("Active");
                        CurrPage.Update();
                    end;
                }
                action(ShowAvailable)
                {
                    ApplicationArea = All;
                    Caption = 'Show Available';
                    Image = FilterLines;
                    ToolTip = 'Show only available personnel.';

                    trigger OnAction()
                    var
                        SupportPersonnel: Record "Support Personnel";
                    begin
                        SupportPersonnel.SetRange("Active", true);
                        if SupportPersonnel.FindSet() then
                            repeat
                                SupportPersonnel.CalcFields("Current Tickets");
                                if SupportPersonnel."Current Tickets" >= SupportPersonnel."Max Concurrent Tickets" then
                                    SupportPersonnel.Mark(true);
                            until SupportPersonnel.Next() = 0;

                        SupportPersonnel.MarkedOnly(true);
                        CurrPage.SetTableView(SupportPersonnel);
                        CurrPage.Update();
                    end;
                }
            }

            group(Tickets)
            {
                Caption = 'Tickets';

                action(AssignedTickets)
                {
                    ApplicationArea = All;
                    Caption = 'Assigned Tickets';
                    Image = TaskList;
                    ToolTip = 'View tickets assigned to this personnel.';

                    trigger OnAction()
                    var
                        TicketHeader: Record "Ticket Header";
                    begin
                        TicketHeader.SetRange("Assigned To", Rec."User ID");
                        Page.Run(Page::"Ticket List", TicketHeader);
                    end;
                }
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
            }
        }

        area(Reporting)
        {
            action(PersonnelReport)
            {
                ApplicationArea = All;
                Caption = 'Personnel Report';
                Image = Report;
                ToolTip = 'Generate a report of support personnel.';

                trigger OnAction()
                begin
                    Message('Personnel report functionality to be implemented.');
                end;
            }
            action(WorkloadReport)
            {
                ApplicationArea = All;
                Caption = 'Workload Report';
                Image = Report2;
                ToolTip = 'Generate a workload analysis report.';

                trigger OnAction()
                begin
                    Message('Workload report functionality to be implemented.');
                end;
            }
        }
    }

    var
        AvailabilityStyle: Text;

    trigger OnAfterGetRecord()
    begin
        SetAvailabilityStyle();
    end;

    local procedure SetAvailabilityStyle()
    var
        Availability: Text;
    begin
        Availability := Rec.GetAvailability();
        case Availability of
            'Available':
                AvailabilityStyle := 'Favorable';
            'At Capacity', 'Inactive':
                AvailabilityStyle := 'Unfavorable';
            'Off Shift':
                AvailabilityStyle := 'Ambiguous';
            else
                AvailabilityStyle := 'Standard';
        end;
    end;
}