Page 50954 "HR Transport Requisition List"
{
    CardPageID = "HR Staff Transport Requisition";
    PageType = List;
    SourceTable = "HR Transport Requisition Head";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(TransportRequestNo; Rec."Transport Request No")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(EmployeeNo; Rec."Employee No")
                {
                    ApplicationArea = Basic;
                }
                field(DepartureDate; Rec."Departure Date")
                {
                    ApplicationArea = Basic;
                }
                field(ReturnDate; Rec."Return Date")
                {
                    ApplicationArea = Basic;
                }
                field(From; Rec.From)
                {
                    ApplicationArea = Basic;
                }
                field(Destination; Rec.Destination)
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Style = Strong;
                    StyleExpr = true;
                }
            }
        }
    }

    actions
    {
    }
}

