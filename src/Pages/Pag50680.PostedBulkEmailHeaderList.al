page 51206 "Posted Bulk Email Header List"
{
    ApplicationArea = All;
    Caption = 'Posted Bulk Email Header List';
    CardPageID = "Bulk Email Header";
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Bulk Email Header";
    SourceTableView = where("Email Status" = const(Sent));
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
                field("Status Date"; Rec."Status Date") { ApplicationArea = All; }
                field("Status By"; Rec."Status By") { ApplicationArea = All; }
                field(Entries; Rec.Entries) { ApplicationArea = All; }
            }
        }
    }
}
