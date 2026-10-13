page 50454 "HR Trasport Application List"
{
    ApplicationArea = All;
    Caption = 'HR Trasport Application List';
    PageType = List;
    SourceTable = "HR Transport Application";
    CardPageId = "HR Tranport Application Card";
    UsageCategory = Lists;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee No field.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field("Purpose "; Rec."Purpose")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Purpose  field.';
                }
                field(Vehicle; Rec.Vehicle)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vehicle field.';
                }
            }
        }
    }
}
