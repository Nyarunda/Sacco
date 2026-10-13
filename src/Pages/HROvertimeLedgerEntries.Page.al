Page 51098 "HR Overtime Ledger Entries"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HR Overtime Ledger Entries";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(EntryNo; Rec."Entry No.")
                {
                    ApplicationArea = Basic;
                }
                field(StaffNo; Rec."Staff No.")
                {
                    ApplicationArea = Basic;
                }
                field(StaffName; Rec."Staff Name")
                {
                    ApplicationArea = Basic;
                }
                field(DocumentNo; Rec."Document No.")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(DateApproved; Rec."Date Approved")
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

