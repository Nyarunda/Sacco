
page 50002 "Ticket Comments SubPage"
{
    PageType = ListPart;
    SourceTable = "Ticket Comment";
    AutoSplitKey = true;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Comment"; Rec."Comment") { ApplicationArea = All; }
                field("Created By"; Rec."Created By") { ApplicationArea = All; }
                field("Created DateTime"; Rec."Created DateTime") { ApplicationArea = All; }
            }
        }
    }
}
