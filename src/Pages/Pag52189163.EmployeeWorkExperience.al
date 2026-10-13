page 50865 "Employee Work Experience"
{
    Caption = 'Work Experience';
    PageType = ListPart;
    SourceTable = "Employee Work Experience";
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Organization Name"; Rec."Organization Name")
                {
                    ApplicationArea = All;
                }
                field("Position Held"; Rec."Position Held")
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Period Description"; Rec."Period Description")
                {
                    ApplicationArea = All;
                    Caption = 'Period';
                }
            }
        }
    }
}
