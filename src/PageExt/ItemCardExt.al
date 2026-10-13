pageextension 50500 "Item Card Ext" extends "Item Card"
{
    layout
    {
        addafter("Item Category Code")
        {
            group(Procurement)
            {
                Caption = 'Procurement';
                field("Store Location"; Rec."Store Location")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the default store location for this item.';
                }
                field("Stock Tracking Enabled"; Rec."Stock Tracking Enabled")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if stock tracking is enabled for this item.';
                }
                field("Procurement Category"; Rec."Procurement Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the procurement category for this item.';
                }
            }
        }
    }
}
