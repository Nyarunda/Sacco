page 50461 "Member Change Log"
{
    Caption = 'Member Change Log';
    PageType = ListPart;
    SourceTable = "Member Change Log";
    SourceTableView = sorting("Log No.") order(descending);
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Field Name"; Rec."Field Name")
                {
                    ApplicationArea = All;
                }
                field("Previous Value"; Rec."Previous Value")
                {
                    ApplicationArea = All;
                    Style = Attention;
                }
                field("New Value"; Rec."New Value")
                {
                    ApplicationArea = All;
                    Style = Favorable;
                }
                field("Reason For Change"; Rec."Reason For Change")
                {
                    ApplicationArea = All;
                    Style = Ambiguous;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Member Change No"; Rec."Member Change No")
                {
                    ApplicationArea = All;
                }
                field("Date Changed"; Rec."Date Changed")
                {
                    ApplicationArea = All;
                }
                field("Time Changed"; Rec."Time Changed")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
