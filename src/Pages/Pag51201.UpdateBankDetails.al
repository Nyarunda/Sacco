page 51201 "Update Bank Details"
{
    Caption = 'Update Bank Details';
    PageType = List;
    SourceTable = "Update Bank Details";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Bank No."; Rec."Bank No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bank No. field.';
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Branch Code field.';
                }
                field(SWIFT; Rec.SWIFT)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SWIFT field.';
                }
                field(Updated; Rec.Updated)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Updated field.';
                }
            }
        }
    }
}
