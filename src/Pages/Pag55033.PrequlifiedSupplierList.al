page 55033 "Prequlified Supplier List"
{
    ApplicationArea = All;
    Caption = 'Prequlified Supplier List';
    PageType = List;
    SourceTable = "Prequlified Suppliers";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Prequals)
            {
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                }
                field("Category Code"; Rec."Category Code")
                {
                    ApplicationArea = All;
                }
                field("Prequalification Date"; Rec."Prequalification Date")
                {
                    ApplicationArea = All;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = All;
                }
                field("Compliance Status"; Rec."Compliance Status")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
