namespace CentralDB.CentralDB;

page 50740 "Meeting Attendance Header Card"
{
    ApplicationArea = All;
    Caption = 'Meeting Attendance Header Card';
    PageType = Card;
    DeleteAllowed = false;
    SourceTable = "Meeting Attendance Header";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field("Meeting Date"; Rec."Meeting Date")
                {
                    ToolTip = 'Specifies the value of the Meeting Date field.', Comment = '%';
                }
                field(Completed; Rec.Completed)
                {
                    ToolTip = 'Specifies the value of the Completed field.', Comment = '%';
                }
                field("Date Captured"; Rec."Date Captured")
                {
                    ToolTip = 'Specifies the value of the Date Captured field.', Comment = '%';
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    ToolTip = 'Specifies the value of the Date Entered field.', Comment = '%';
                }
                field("Description "; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(Count; Rec.Count)
                {
                    ToolTip = 'Specifies the value of the Count field.', Comment = '%';
                }
            }
            part(Control1000000012; "Meeting Attendance lines")
            {
                SubPageLink = "Header No." = field("No.");
            }
        }
    }
    actions
    {
        area(Reporting)
        {
            action("Mark As Completed")
            {
                ApplicationArea = All;
                Caption = 'Mark As Completed', comment = 'NLB="YourLanguageCaption"';
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;

                trigger OnAction()
                var
                begin

                    Rec.Completed := true;
                    Rec.Modify();

                    Message('Effected');
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        if Rec.Completed then
            CurrPage.Editable := false;
    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        if Rec.Completed then
            CurrPage.Editable := false;
    end;

}

