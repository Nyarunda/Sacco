page 50429 "File Management Lines"
{
    Caption = 'File Management Lines';
    PageType = ListPart;
    SourceTable = "File Management Lines";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member No. field.';
                    LookupPageId = "Member Listing";
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member No. field.';
                }
                field("Member Status";Rec."Member Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member No. field.';
                }

                field(Issued; Rec.Issued)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Issued field.';
                }
                field(Received; Rec.Received)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Received field.';
                }
            }
        }
    }
}
