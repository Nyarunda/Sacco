page 50633 "Cheque Dispatch List"
{
    ApplicationArea = All;
    Caption = 'Cheque Dispatch List';
    CardPageId = "Cheque Dispatch Card";
    PageType = List;
    SourceTable = "Cheque Dispatch";
    DeleteAllowed = false;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Payee Name"; Rec."Payee Name")
                {
                    ToolTip = 'Specifies the value of the Payee Name field.';
                }
                field("Dispatch Date"; Rec."Dispatch Date")
                {
                    ToolTip = 'Specifies the value of the Dispatch Date field.';
                }
                field(Purpose; Rec.Purpose)
                {
                    ToolTip = 'Specifies the value of the Purpose field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }
}
