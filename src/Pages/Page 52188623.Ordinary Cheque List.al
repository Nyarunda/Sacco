
Page 50286 "Ordinary Cheque List"
{
    PageType = List;
    SourceTable = "Ordinary Cheque Register";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(OrdinaryChequeNo; Rec."Ordinary Cheque No.")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

