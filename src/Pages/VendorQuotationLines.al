page 50519 "Vendor Quotation Lines"
{
    PageType = ListPart;
    SourceTable = "Vendor Quotation Line";
    Caption = 'Lines';
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the purchase line type imported from quotation.';
                }
                field("Item/Service Description"; Rec."Item/Service Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the item or service description.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the item number if applicable.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the quantity.';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unit price.';
                }
                field("Total Price"; Rec."Total Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total price.';
                }
                field("Delivery Timeframe"; Rec."Delivery Timeframe")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the delivery timeframe.';
                }
                field(Availability; Rec.Availability)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the availability.';
                }
            }
        }
    }
}
