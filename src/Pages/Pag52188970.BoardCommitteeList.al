namespace CentralDB.CentralDB;

page 50672 "Board Committee List"
{
    ApplicationArea = All;
    Caption = 'Board Committee List';
    PageType = List;
    SourceTable = "Board Committees";
    CardPageId = "Board Committee Card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Approval Sequence"; Rec."Approval Sequence")
                {
                    ToolTip = 'Specifies the value of the Approval Sequence field.';
                }
            }
        }
    }
}
