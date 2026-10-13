page 50632 "Cheque Dispatch Card"
{
    ApplicationArea = All;
    Caption = 'Cheque Dispatch Card';
    PageType = Card;
    SourceTable = "Cheque Dispatch";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("Captured By"; Rec."Captured By")
                {
                    ToolTip = 'Specifies the value of the Captured By field.';
                }
                field("Payee Name"; Rec."Payee Name")
                {
                    ToolTip = 'Specifies the value of the Payee Name field.';
                }
                field("Cheque Number"; Rec."Cheque Number")
                {
                    ToolTip = 'Specifies the value of the Cheque Number field.';
                }
                field(Purpose; Rec.Purpose)
                {
                    ToolTip = 'Specifies the value of the Purpose field.';
                }
                field("Dispatch Method"; Rec."Dispatch Method")
                {
                    ToolTip = 'Specifies the value of the Dispatch Method field.';
                }
                field("Dispatch Date"; Rec."Dispatch Date")
                {
                    ToolTip = 'Specifies the value of the Dispatch Date field.';
                }
                field("Collected By"; Rec."Collected By")
                {
                    ToolTip = 'Specifies the value of the Collected By field.';
                }
                field("Collector ID"; Rec."Collector ID")
                {
                    ToolTip = 'Specifies the value of the Collector ID field.';
                }
                field("Collector Mobile No."; Rec."Collector Mobile No.")
                {
                    ToolTip = 'Specifies the value of the Collector Mobile No. field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }
}
