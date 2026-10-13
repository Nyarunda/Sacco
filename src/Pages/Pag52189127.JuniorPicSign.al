namespace UnitedWomen.UnitedWomen;

page 50829 "Junior Pic & Sign"
{
    Caption = 'Picture & Signature';
    PageType = CardPart;
    SourceTable = "Junior Images";

    layout
    {
        area(Content)
        {

            group(Picture_)
            {
                field("."; Rec.Picture)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Caption = '.';
                }
            }

            group(Signature_)
            {
                field(".."; Rec.Signature)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Caption = '..';
                }

            }

        }
    }

    trigger OnModifyRecord(): Boolean
    begin
        Error('Modifications to Picture or Signature are not allowed.');
    end;
}

