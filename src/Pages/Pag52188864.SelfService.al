page 50566 "Self Service"
{
    Caption = 'Self Service';
    PageType = CardPart;
    SourceTable = "Team Member Cue";

    layout
    {
        area(content)
        {
            cuegroup("Employee Overtime")
            {
                Caption = 'Overtime Application';
                field("Overtime Applications"; Rec."Overtime - Application")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of overtime hours currently applied';

                    trigger OnDrillDown()
                    begin
                        OpenMyOvertimeApplications();
                    end;
                }

            }
            cuegroup("Mid-Month Salary")
            {
                Caption = 'Salary Advance Application';
                field("Salary Advance Application"; Rec."Salary Advance Application")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "PR Salary Advance List";
                    ToolTip = 'Specifies the number of salary Advance currently applied';
                }
            }
            cuegroup("Transport Application")
            {
                Caption = 'Transport Application';
                field("Transport Applications"; Rec."Transport Application")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "HR Trasport Application List";

                }
            }
            cuegroup(Leave)
            {
                field(LeaveApplication; Rec."Leave - Application")
                {
                    ApplicationArea = Basic;
                    DrillDownPageID = "HR Leave Applications List";
                    LookupPageID = "HR Leave Applications List";
                }
                field(LeavePending; Rec."Leave - Pending")
                {
                    ApplicationArea = Basic;
                    DrillDownPageID = "HR Leave Applications List";
                    LookupPageID = "HR Leave Applications List";
                }
                field(LeaveApproved; Rec."Leave - Approved")
                {
                    ApplicationArea = Basic;
                    DrillDownPageID = "HR Leave Applications List";
                    LookupPageID = "HR Leave Applications List";
                }
                field(LeaveRejected; Rec."Leave - Rejected")
                {
                    ApplicationArea = Basic;
                    DrillDownPageID = "HR Leave Applications List";
                    LookupPageID = "HR Leave Applications List";
                }
                field(LeavePlanner; Rec."Leave - Planner")
                {
                    ApplicationArea = Basic;
                    DrillDownPageID = "HR Leave Planner List";
                    LookupPageID = "HR Leave Planner List";
                }
            }

        }
    }



    actions
    {
        area(Processing)
        {

            action("Leave Planner")
            {
                ApplicationArea = Basic;
                Image = Account;
                RunObject = page "HR Leave Planner List";
            }
            action("Leave Balances")
            {
                ApplicationArea = Basic;
                Image = Account;
                trigger OnAction()
                var
                    Employee: Record Employee;
                    UserSetup: Record "User Setup";
                begin
                    UserSetup.get(UserId);

                    Employee.Reset();
                    //Employee.SetRange("Supervisor Code", UserSetup.);
                    Employee.SetRange("User ID", UserSetup."User ID");
                    Employee.SetRange("No.", UserSetup."Staff No");
                    Employee.SetRange("Leave Type Filter", 'ANNUAL');
                    if Employee.FindFirst() then begin
                        Report.Run(Report::"HR Leave Balances", false, false, Employee);
                    end;
                end;
            }

            action("Staff Payslip")
            {
                ApplicationArea = Basic;
                Image = Account;
                trigger OnAction()
                var
                    Employee: Record Employee;
                    usersetup: Record "User Setup";
                begin
                    usersetup.get(UserId);
                    Employee.Reset();
                    Employee.SetRange("User ID", UserId);
                    Employee.SetRange("No.", usersetup."Staff No");
                    if Employee.FindFirst() then begin
                        Report.Run(Report::"Staff Payslip", false, false, Employee);
                    end;
                end;
            }
            action("P9 Report")
            {
                ApplicationArea = Basic;
                Image = Account;
                trigger OnAction()
                var
                    Employee: Record Employee;
                    usersetup: Record "User Setup";
                begin
                    usersetup.get(UserId);
                    Employee.Reset();
                    Employee.SetRange("User ID", UserId);
                    Employee.SetRange("No.", usersetup."Staff No");
                    if Employee.FindFirst() then begin
                        Report.Run(Report::"P9 Report", false, false, Employee);
                    end;
                end;
            }

            action("New P9 Report")
            {
                ApplicationArea = Basic;
                Image = Accounts;
                trigger OnAction()
                var
                    Employee: Record Employee;
                    usersetup: Record "User Setup";
                begin
                    usersetup.get(UserId);
                    Employee.Reset();
                    Employee.SetRange("User ID", UserId);
                    Employee.SetRange("No.", usersetup."Staff No");
                    if Employee.FindFirst() then begin
                        Report.Run(Report::"P9 AA", false, false, Employee);
                    end;
                end;
            }

            action("ClockIn/Out")
            {
                ApplicationArea = Basic;
                image = Timesheet;

                RunObject = page "Clock In/Out List";

            }
            action("HR Leave Schedule")
            {
                ApplicationArea = Basic;
                Caption = 'HR Leave Schedule';
                Image = Calendar;

                trigger OnAction()
                begin
                    Report.RunModal(Report::"HR Leave Schedule", true, false);
                end;

            }
        }
    }

    trigger OnOpenPage()
    begin
        SetMyCueFilters();
    end;

    trigger OnAfterGetRecord()
    begin
        SetMyCueFilters();
    end;

    local procedure SetMyCueFilters()
    begin
        Rec.FilterGroup(50);
        Rec.SetRange("User ID Filter", UserId);
        Rec.FilterGroup(0);
    end;

    local procedure OpenMyOvertimeApplications()
    var
        HROvertimeHeader: Record "HR Overtime Header";
        UserSetup: Record "User Setup";
    begin
        if not UserSetup.Get(UserId) then
            Error('User setup is missing for %1.', UserId);

        UserSetup.TestField("Staff No");

        HROvertimeHeader.FilterGroup(50);
        HROvertimeHeader.SetRange("Staff No.", UserSetup."Staff No");
        HROvertimeHeader.FilterGroup(0);
        Page.Run(Page::"HR Overtime List", HROvertimeHeader);
    end;
}
