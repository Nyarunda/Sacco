page 50503 "Goods Receipt Note Lines"
{
    PageType = ListPart;
    SourceTable = "Goods Receipt Note Line";
    Caption = 'Lines';
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the item number.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description.';
                }
                field("Quantity Ordered"; Rec."Quantity Ordered")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the quantity ordered.';
                }
                field("Quantity Received"; Rec."Quantity Received")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the quantity received.';
                }
                field("Quantity Accepted"; Rec."Quantity Accepted")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the quantity accepted.';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unit price.';
                }
                field("Total Value"; Rec."Total Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total value.';
                }
                field("Quality Inspection Passed"; Rec."Quality Inspection Passed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if quality inspection passed.';
                }
            }
        }
    }
}
