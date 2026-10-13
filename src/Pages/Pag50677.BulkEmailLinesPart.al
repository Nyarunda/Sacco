page 51203 "Bulk Email Lines Part"
{
    ApplicationArea = All;
    Caption = 'Bulk Email Lines';
    PageType = ListPart;
    SourceTable = "Bulk Email Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Member No."; Rec."Member No.") { ApplicationArea = All; }
                field("E-Mail"; Rec."E-Mail") { ApplicationArea = All; }
                field("Email Subject"; Rec."Email Subject") { ApplicationArea = All; }
                field("Email Body"; Rec."Email Body") { ApplicationArea = All; }
                field(Status; Rec.Status) { ApplicationArea = All; Editable = false; }
                field("Result Message"; Rec."Result Message") { ApplicationArea = All; Editable = false; }
                field("Sent DateTime"; Rec."Sent DateTime") { ApplicationArea = All; Editable = false; }
            }
        }
    }
}
