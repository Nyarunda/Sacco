page 51205 "Bulk Email Header List"
{
    ApplicationArea = All;
    Caption = 'Bulk Email Header List';
    CardPageID = "Bulk Email Header";
    Editable = false;
    PageType = List;
    DeleteAllowed = false;
    SourceTable = "Bulk Email Header";
    SourceTableView = where("Email Status" = filter(<> Sent));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No) { ApplicationArea = All; }
                field("Email Subject"; Rec."Email Subject") { ApplicationArea = All; }
                field("Email Type"; Rec."Email Type") { ApplicationArea = All; }
                field("Date Entered"; Rec."Date Entered") { ApplicationArea = All; }
                field("Entered By"; Rec."Entered By") { ApplicationArea = All; }
                field("Email Status"; Rec."Email Status") { ApplicationArea = All; }
                field(Entries; Rec.Entries) { ApplicationArea = All; }
                field(Attachments; Rec.Attachments) { ApplicationArea = All; }
            }
        }
    }
}
