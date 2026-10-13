pageextension 50134 "Self Service ext" extends "Team Member Activities"
{
    layout
    {
        addbefore("Current Time Sheet")
        {

            cuegroup("Employee Overtime")
            {
                Caption = 'Overtime Application';
                field("Overtime Applications"; Rec."Overtime - Application")
                {
                    //TableRelation = "HR Overtime Header" where(Status = const(Open));
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of overtime hours currently applied';

                    trigger OnDrillDown()
                    begin
                        OpenMyOvertimeApplications();
                    end;
                }
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
