namespace CentralDB.CentralDB;

page 50675 "Loan Documents"
{
    ApplicationArea = All;
    Caption = 'Loan Documents';
    PageType = List;
    SourceTable = "Loan Documents";
    UsageCategory = Lists;

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
