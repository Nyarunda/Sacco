page 50545 "Posted Acc Transfer List"
{
    ApplicationArea = Basic;
    CardPageID = "Account Transfer Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Account Transfers";
    UsageCategory = History;
    SourceTableView = where(Posted = const(true));
    // UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                }
                field(TransactionDate; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = basic;
                    Caption = 'Particular';
                }
                field("Total Debits"; Rec."Total Debits")
                {
                    ApplicationArea = basic;
                    Caption = 'Amount';
                }

                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(CreatedBy; Rec."Created By")
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

