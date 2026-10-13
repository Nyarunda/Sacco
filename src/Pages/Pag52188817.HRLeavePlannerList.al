page 50550 "HR Leave Planner List"
{
    ApplicationArea = All;
    Caption = 'HR Leave Planner List';
    PageType = List;
    SourceTable = "HR Leave Planner Header";
    UsageCategory = Lists;
    Editable = false;
    DeleteAllowed = false;
    CardPageId = "HR Leave Planner Header";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Supervisor; Rec.Supervisor)
                {
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetRange("Created By", UserId);
    end;
}
