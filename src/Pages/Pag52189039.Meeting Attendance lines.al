namespace CentralDB.CentralDB;

page 50741 "Meeting Attendance lines"
{
    ApplicationArea = All;
    Caption = 'Meeting Attendance lines';
    PageType = ListPart;
    DeleteAllowed = false;
    SourceTable = "Meeting Attendance Lines";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Member No"; Rec."Member No")
                {
                    ToolTip = 'Specifies the value of the Member No field.', Comment = '%';
                }
                field("ID No."; Rec."ID No.")
                {
                    ToolTip = 'Specifies the value of the ID No. field.', Comment = '%';
                }
                field("Member Name"; Rec."Member Name")
                {
                    ToolTip = 'Specifies the value of the Member Name field.', Comment = '%';
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ToolTip = 'Specifies the value of the Mobile Phone No. field.', Comment = '%';
                }
                field("Regstration Date"; Rec."Regstration Date")
                {
                    ToolTip = 'Specifies the value of the Regstration Date field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("FOSA Account"; Rec."FOSA Account")
                {
                    ToolTip = 'Specifies the value of the FOSA Account field.', Comment = '%';
                }
                field("Date Attended."; Rec."Date Attended.")
                {
                    ToolTip = 'Specifies the value of the Date Attended field.', Comment = '%';
                }
                field(Attended; Rec.Attended)
                {
                    ToolTip = 'Specifies the value of the Attended field.', Comment = '%';
                }
                field("Ticket No."; Rec."Ticket No.")
                {
                    ToolTip = 'Specifies the value of the Ticket No. field.', Comment = '%';
                }
            }
        }
    }
}
