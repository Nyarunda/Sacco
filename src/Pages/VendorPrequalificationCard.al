page 50099 "Vendor Prequal Card"
{
    PageType = Card;
    SourceTable = "Prequlified Suppliers";
    Caption = 'Vendor Prequalification Card';

    layout
{
        area(Content)
        {
            group(General)
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
                field("Document Reference"; Rec."Document Reference")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

