
page 50252 "Picture & Signature"
{
    PageType = CardPart;
    SourceTable = "Member Images";

    layout
    {
        area(content)
        {
            group(Picture_)
            {
                field("."; Rec.Picture)
                {
                    ApplicationArea = Basic;
                    Caption = '.';
                    Editable = false; 
                }
            }
            group(Signature_)
            {
                field(".."; Rec.Signature)
                {
                    ApplicationArea = Basic;
                    Caption = '..';
                    Editable = false; // Prevent editing
                }
            }
        }
    }

    actions
    {
    }

    trigger OnModifyRecord(): Boolean
    begin
        Error('Modifications to Picture or Signature are not allowed.');
    end;
}
