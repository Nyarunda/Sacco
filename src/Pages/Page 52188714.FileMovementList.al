Page 50377 "File Movement - To Issue"
{
    CardPageID = "File Movement Card - To Issue";
    DeleteAllowed = false;
    Editable = true;
    PageType = List;
    SourceTable = "File Movement";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(MovementDate; Rec."Movement Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Overdue Date"; Rec."Overdue Date")
                {

                    ApplicationArea = Basic;
                    Editable = true;
                }

                field(CurrentLocation; Rec."Current Location")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(CurrentName; Rec."Current Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(CurrentUser; Rec."Current User")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Select; Rec.Select)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(EntryType; Rec."Entry Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(RequestLocation; Rec."Request Location")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(RequestLocationName; Rec."Request Location Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(RequestedBy; Rec."Requested By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
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

    trigger OnOpenPage()
    begin

        Rec.SetRange("Status", Rec.Status::"To Be Issued");
        Rec.SetRange("Entry Type", Rec."Entry Type"::"File Issue");
        Rec.SetRange("Current User", UserId);
    end;

}

