page 50455 "Member Details FactBox"
{
    Caption = 'Member Details FactBox';
    PageType = CardPart;
    SourceTable = "Member Images";

    layout
    {
        area(content)
        {
            group(PictureAndSignature)
            {
                Caption = 'Picture & Signature';

                field("No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    Caption = 'Member No: ';
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = All;
                }
                field(Signature; Rec.Signature)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
