page 50671 "Vote Transfer List."
{
    ApplicationArea = All;
    CardPageID = "Vote Transfer";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Vote Transfer";
    SourceTableView = WHERE(Posted = CONST(false));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("Source Vote"; Rec."Source Vote")
                {
                }
                field("Source Vote Name"; Rec."Source Vote Name")
                {
                }
                field("Destination Vote"; Rec."Destination Vote")
                {
                }
                field("Destination Vote Name"; Rec."Destination Vote Name")
                {
                }
                field("Budget Name"; Rec."Budget Name")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Source Dimmension 1"; Rec."Source Dimmension 1")
                {
                }
                field("Destination Dimmension 1"; Rec."Destination Dimmension 1")
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field("Raised By"; Rec."Raised By")
                {
                }
                field("Raised Date"; Rec."Raised Date")
                {
                }
                field("Approved By"; Rec."Approved By")
                {
                }
                field("Source Dimension 2"; Rec."Source Dimension 2")
                {
                }
                field("Destination Dimension 2"; Rec."Destination Dimension 2")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

