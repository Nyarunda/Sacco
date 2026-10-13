page 50551 "HR Leave Planner Line"
{
    Caption = 'Leave Planner Line';
    PageType = ListPart;
    SourceTable = "HR Leave Planner Lines";
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    Style = StrongAccent;
                }
                field("No of Days"; Rec."No of Days")
                {
                    ApplicationArea = All;
                    Style = Favorable;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    Style = Attention;
                }
                field("Return Date"; Rec."Return Date")
                {
                    ApplicationArea = All;
                    Style = Ambiguous;
                }
                field("Intended Purpose"; Rec."Intended Purpose")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
