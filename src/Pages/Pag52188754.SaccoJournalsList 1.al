page 50436 "Sacco Journals List"
{
    Caption = 'Sacco Journals List';
    PageType = List;
    SourceTable = "Sacco Journal Header";
    SourceTableView = Where(Posted = const(False));
    CardPageId = "Sacco Journal Card";


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Captured By field.';
                }
                field("Posting Type"; Rec."Posting Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Type field.';
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted field.';
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Posted field.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("Time"; Rec."Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time field.';
                }
            }
        }
    }



    trigger OnOpenPage()
    var
    begin
        Rec.SetRange("Captured By", UserId);
    end;
}
