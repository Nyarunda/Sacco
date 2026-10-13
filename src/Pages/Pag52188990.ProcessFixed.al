namespace CentralDB.CentralDB;

page 50692 "Process Fixed"
{
    ApplicationArea = All;
    Caption = 'Process Bank Fixed';
    PageType = List;
    SourceTable = "Process Bank FD";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Select; Rec.Select)
                {
                    ToolTip = 'Specifies the value of the Select field.', Comment = '%';
                }
                field("FD No."; Rec."FD No.")
                {
                    ToolTip = 'Specifies the value of the FD No. field.', Comment = '%';
                }

                field("FD Type"; Rec."FD Type")
                {
                    ToolTip = 'Specifies the value of the FD Type field.', Comment = '%';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field.', Comment = '%';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field(Processed; Rec.Processed)
                {
                    ToolTip = 'Specifies the value of the Processed field.', Comment = '%';
                }
            }
        }
    }

}
