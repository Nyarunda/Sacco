page 50643 "Approved Receipts List"
{
    ApplicationArea = All;
    Caption = 'Approved Receipt List';
    CardPageID = "Receipt Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Receipt Header";
    SourceTableView = where(Posted = const(false), Status = const(Approved));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; Rec."Customer No.")
                {
                    ApplicationArea = Basic;
                }
                field(MemberName; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("External Document No"; Rec."External Document No")
                {
                    ApplicationArea = Basic;
                }

                field(PostingDate; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Narration)
                {
                    ApplicationArea = Basic;
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic;
                }
                field(DatePosted; Rec."Date Posted")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(AmountRecieved; Rec."Amount Recieved")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = Basic;
                }
                field(payrollandstaffNo; Rec.payrollandstaffNo)
                {
                }

            }
        }
    }

    actions
    {
    }
}

