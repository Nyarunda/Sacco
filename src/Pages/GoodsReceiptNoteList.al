page 50522 "Goods Receipt Note List"
{
    PageType = List;
    SourceTable = "Goods Receipt Note Header";
    Caption = 'Goods Receipt Note List';
    CardPageId = "Goods Receipt Note Card";

    layout
    {
        area(Content)
        {
            repeater(GRNs)
            {
                field("GRN No."; Rec."GRN No.")
                {
                    ApplicationArea = All;
                }
                field("LPO No."; Rec."LPO No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

