
page 50004 "Ticket Assignment"
{
    PageType = StandardDialog;
    SourceTable = "Ticket Header";
    layout
    {
        area(Content)
        {
            group(Assignment)
            {
                field("Assigned To"; Rec."Assigned To") { ApplicationArea = All; }
                field("Department Code"; Rec."Department Code") { ApplicationArea = All; }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(OK) { ApplicationArea = All; trigger OnAction() begin CurrPage.Close(); end; }
        }
    }
    procedure SetTicket(var TicketHeader: Record "Ticket Header")
    begin
        Rec := TicketHeader;
    end;

    procedure GetAssignment(var TicketHeader: Record "Ticket Header")
    begin
        TicketHeader := Rec;
    end;
}
