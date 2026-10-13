page 50435 "File Movement Log"
{
    ApplicationArea = All;
    Caption = 'File Movement Log';
    PageType = List;
    SourceTable = "File Movement Log";
    UsageCategory = History;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member No. field.';
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member Name field.';
                }
                field("Source Location"; Rec."Source Location")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Source Location field.';
                }
                field("Source Name"; Rec."Source Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Source Name field.';
                }
                field("Source User"; Rec."Source User")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Source User field.';
                }
                field("Current Location"; Rec."Current Location")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Current Location field.';
                }
                field("Current Name"; Rec."Current Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Current Name field.';
                }
                field("Current User"; Rec."Current User")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Current User field.';
                }
                field("Movement Date"; Rec."Movement Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Movement Date field.';
                }
                field("File Movement Reference"; Rec."File Movement Reference")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the File Movement Reference field.';
                }
                field("Expected Return Date"; Rec."Expected Return Date")
                {
                    ApplicationArea = All;
                }
                field("Date Returned"; Rec."Date Returned")
                {
                    ApplicationArea = All;
                }
                /*field(Returned; Returned)
                {
                    ApplicationArea = all;
                } */
            }
        }
    }
}
