page 50505 "LPO/LSO Lines"
{
    PageType = ListPart;
    SourceTable = "LPO/LSO Line";
    Caption = 'Lines';
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
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
                field("Delivery Date"; Rec."Delivery Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the delivery date.';
                }
                field(Terms; Rec.Terms)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the terms.';
                }
            }
        }
    }
}
