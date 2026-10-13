namespace CentralDB.CentralDB;

page 50676 "General Loan Documents"
{
    ApplicationArea = All;
    Caption = 'General Loan Documents';
    PageType = List;
    SourceTable = "General Loan Documents";

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
            }
        }
    }
}
