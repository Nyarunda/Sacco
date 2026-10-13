namespace CentralDB.CentralDB;

page 50742 "Meeting Attendance List"
{
    ApplicationArea = All;
    Caption = 'Meeting Attendance List';
    PageType = List;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    CardPageId = "Meeting Attendance Header Card";
    SourceTable = "Meeting Attendance Header";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field("Meeting Date"; Rec."Meeting Date")
                {
                    ToolTip = 'Specifies the value of the Meeting Date field.', Comment = '%';
                }
                field("Date Captured"; Rec."Date Captured")
                {
                    ToolTip = 'Specifies the value of the Date Captured field.', Comment = '%';
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    ToolTip = 'Specifies the value of the Date Entered field.', Comment = '%';
                }
                field(Completed; Rec.Completed)
                {
                    ToolTip = 'Specifies the value of the Completed field.', Comment = '%';
                }
                field("Description "; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Captured By"; Rec."Captured By")
                {
                    ToolTip = 'Specifies the value of the Captured By field.', Comment = '%';
                }
            }
        }
    }
}
