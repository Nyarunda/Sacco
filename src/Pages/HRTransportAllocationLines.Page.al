Page 50949 "HR Transport Allocation Lines"
{
    PageType = ListPart;
    SourceTable = "HR Transport Allocation Lines";
    //SourceTableView = sorting("Allocation No","Requisition No");

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                field(RequisitionNo; Rec."Requisition No")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeNo; Rec."Employee No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(PassengersFullName; Rec."Passenger's Full Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(From; Rec.From)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Destination; Rec.Destination)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

