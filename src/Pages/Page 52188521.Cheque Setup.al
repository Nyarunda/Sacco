
Page 50184 "Cheque Setup"
{
    PageType = List;
    SourceTable = "Cheque Set Up_";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ChequeCode; Rec."Cheque Code")
                {
                    ApplicationArea = Basic;
                }
                field(NumberOfLeaf; Rec."Number Of Leaf")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
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

