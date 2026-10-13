
page 50403 "Customer Tickets FactBox"
{
    PageType = ListPart;
    SourceTable = "Ticket Header";
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.") { ApplicationArea = All; }
                field("Title"; Rec.Title) { ApplicationArea = All; }
                field(Status; Rec.Status) { ApplicationArea = All; }
            }
        }
    }
}
