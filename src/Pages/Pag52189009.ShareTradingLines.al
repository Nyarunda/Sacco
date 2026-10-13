namespace CentralDB.CentralDB;

page 50711 "Share Trading Lines"
{
    ApplicationArea = All;
    Caption = 'Share Trading Lines';
    PageType = ListPart;
    SourceTable = "Share Transfer Lines";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Source Account Type"; Rec."Source Account Type")
                {
                    ToolTip = 'Specifies the value of the Source Account Type field.', Comment = '%';
                }
                field("Source Account No."; Rec."Source Account No.")
                {
                    ToolTip = 'Specifies the value of the Source Account No. field.', Comment = '%';
                }
                field("Source Account Name"; Rec."Source Account Name")
                {
                    ToolTip = 'Specifies the value of the Source Account Name field.', Comment = '%';
                }
                field("Available Balance"; Rec."Available Balance")
                {
                    ToolTip = 'Specifies the value of the Available Balance field.', Comment = '%';
                }
                field("Source Amount"; Rec."Source Amount")
                {
                    ToolTip = 'Specifies the value of the Source Amount field.', Comment = '%';
                }
                field("Destination Account Type"; Rec."Destination Account Type")
                {
                    ToolTip = 'Specifies the value of the Destination Account Type field.', Comment = '%';
                }
                field("Destination Account No."; Rec."Destination Account No.")
                {
                    ToolTip = 'Specifies the value of the Destination Account No. field.', Comment = '%';
                }
                field("Destination Account Name"; Rec."Destination Account Name")
                {
                    ToolTip = 'Specifies the value of the Destination Account Name field.', Comment = '%';
                }
                field("Destination Balance"; Rec."Destination Balance")
                {
                    ToolTip = 'Specifies the value of the Destination Balance field.', Comment = '%';
                }

            }
        }

    }
}
