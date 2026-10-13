Page 50417 "Sky Staggered Header Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Transaction Charges";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control5; "Sky Staggered Charges")
            {
                //SubPageLink = "No." = field(Code);
            }
        }
    }

    actions
    {
    }
}

