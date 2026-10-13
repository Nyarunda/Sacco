page 50576 "FOSA Interest Lines"
{
    Caption = 'FOSA Interest Lines';
    PageType = ListPart;
    SourceTable = "FOSA Interest Lines";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Batch No"; Rec."Batch No")
                {
                    ApplicationArea = Basic;
                }
                field("Header No"; Rec."Header No")
                {
                    ApplicationArea = Basic;
                }
                field("A/C No"; Rec."A/C No")
                {
                    ApplicationArea = Basic;
                }
                field("A/C Name"; Rec."A/C Name")
                {
                    ApplicationArea = Basic;
                }
                field(EndDate; Rec.EndDate)
                {
                    ApplicationArea = Basic;
                }
                field("Product Name"; Rec."Product Name")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    Caption = 'Interest Amount';
                }
                field("Least Balance"; Rec."Least Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Rate"; Rec."Interest Rate")
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


