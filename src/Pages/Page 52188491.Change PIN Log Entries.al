
Page 50154 "Change PIN Log Entries"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Sky PIN Change Log";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(AccountName; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(ChangedBy; Rec."Changed By")
                {
                    ApplicationArea = Basic;
                }
                field(FieldModified; Rec."Field Modified")
                {
                    ApplicationArea = Basic;
                }
                field(OldValue; Rec."Old Value")
                {
                    ApplicationArea = Basic;
                }
                field(NewValue; Rec."New Value")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

