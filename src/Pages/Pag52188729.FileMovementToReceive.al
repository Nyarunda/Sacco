page 50392 "File Movement - To Receive"
{
    CardPageID = "File Movement Card - To Rec.";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    DelayedInsert=false;
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
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(MemberName; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
            }
        }
    }


    actions
    {

    }






    trigger OnOpenPage()
    begin
        Rec.SetRange("Status", Rec.Status::"To Be Received");
        Rec.SetRange("Requested By", UserId);
    end;


}
