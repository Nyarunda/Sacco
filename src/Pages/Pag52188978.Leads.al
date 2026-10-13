namespace CentralDB.CentralDB;

page 50680 Leads
{
    ApplicationArea = All;
    Caption = 'Leads';
    PageType = List;
    DeleteAllowed = false;
    InsertAllowed = false;
    SourceTable = Leads;
    UsageCategory = Tasks;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Date Joined"; Rec."Date Joined")
                {
                    ToolTip = 'Specifies the value of the Date Joined field.', Comment = '%';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("First Name"; Rec."First Name")
                {
                    ToolTip = 'Specifies the value of the First Name field.', Comment = '%';
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field.', Comment = '%';
                }
                field("Introducer Phone"; Rec."Introducer Phone")
                {
                    ToolTip = 'Specifies the value of the Gender field.', Comment = '%';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ToolTip = 'Specifies the value of the Last Name field.', Comment = '%';
                }
                field(Location; Rec.Location)
                {
                    ToolTip = 'Specifies the value of the Location field.', Comment = '%';
                }
                field("Mobile No."; Rec."Mobile No.")
                {
                    ToolTip = 'Specifies the value of the Mobile No. field.', Comment = '%';
                }
            }
        }
    }
}
