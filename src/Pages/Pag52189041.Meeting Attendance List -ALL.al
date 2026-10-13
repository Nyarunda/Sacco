namespace CentralDB.CentralDB;

page 50743 "Meeting Attendance List - ALL"
{
    ApplicationArea = All;
    Caption = 'Meeting Attendance List';
    PageType = List;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    CardPageId = "Meeting Attendance Lines Card";
    SourceTable = "Meeting Attendance Lines";

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("Header No."; Rec."Header No.")
                {
                    ToolTip = 'Specifies the value of the Header No. field.', Comment = '%';
                }
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
                    Editable = false;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ToolTip = 'Specifies the value of the Captured By field.', Comment = '%';
                    Editable = false;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        Rec.SetFilter("Captured By", UserId);
    end;
}
