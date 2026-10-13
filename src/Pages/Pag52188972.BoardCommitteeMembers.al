namespace CentralDB.CentralDB;

page 50674 "Board Committee Members"
{
    ApplicationArea = All;
    Caption = 'Board Committee Members';
    PageType = ListPart;
    SourceTable = "Board Committee Members";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Member No."; Rec."Member No.")
                {
                    ToolTip = 'Specifies the value of the Member No. field.';
                }
                field("Member Name"; Rec."Member Name")
                {
                    ToolTip = 'Specifies the value of the Member Name field.';
                }
            }
        }
    }
}
