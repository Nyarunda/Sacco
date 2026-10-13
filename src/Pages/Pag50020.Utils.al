namespace CentralDB.CentralDB;

using System.Utilities;

page 50020 Utils
{
    ApplicationArea = All;
    Caption = 'Utils';
    PageType = List;
    SourceTable = "Integer";
    UsageCategory = Documents;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Number; Rec.Number)
                {
                    ToolTip = 'Specifies the Excel row number.';
                }
            }
        }
    }
}
