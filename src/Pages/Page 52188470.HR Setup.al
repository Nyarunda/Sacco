
Page 50133 "HR Setup"
{
    ApplicationArea = Basic;
    PageType = Card;
    SourceTable = "HR Setup.";
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(LeaveApplicationNos; Rec."Leave Application Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(BaseCalendar; Rec."Base Calendar")
                {
                    ApplicationArea = Basic;
                }
                field(DefaultLeavePostingTemplate; Rec."Default Leave Posting Template")
                {
                    ApplicationArea = Basic;
                }
                field(PositiveLeavePostingBatch; Rec."Positive Leave Posting Batch")
                {
                    ApplicationArea = Basic;
                }
                field(NegativeLeavePostingBatch; Rec."Negative Leave Posting Batch")
                {
                    ApplicationArea = Basic;
                }
                field(RetirementAge; Rec."Retirement Age")
                {
                    ApplicationArea = Basic;
                }
                field(LeaveAdministrator; Rec."Leave Administrator")
                {
                    ApplicationArea = Basic;
                }
                field("Leave Notification Email"; Rec."Leave Notification Email")
                {
                    ApplicationArea = Basic;
                }
                field("Opening Hours"; Rec."Opening Hours")
                {
                    ApplicationArea = Basic;
                }
                field("Closing Hours"; Rec."Closing Hours")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

