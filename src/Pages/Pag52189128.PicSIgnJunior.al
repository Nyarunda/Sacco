namespace UnitedWomen.UnitedWomen;

page 50830 "Pic & SIgn Junior"
{
    ApplicationArea = All;
    Caption = 'Pic & SIgn Junior';
    PageType = Card;
    SourceTable = "Member Accounts Application";
    
     layout
    {
        area(content)
        {
            group(General)
            {
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = Basic;
                }
                field(Signature; Rec.Signature)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}
