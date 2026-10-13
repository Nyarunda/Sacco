Page 50555 "SpotCash Agency Transactions"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Spotcash Agency Transactions";

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
                field(TransactionDate; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field(requestid; Rec.request_id)
                {
                    ApplicationArea = Basic;
                }
                field(ReferenceNo; Rec."Reference No.")
                {
                    ApplicationArea = Basic;
                }
                field(accountnumber; Rec.account_number)
                {
                    ApplicationArea = Basic;
                }
                field(description; Rec.description)
                {
                    ApplicationArea = Basic;
                }
                field(amount; Rec.amount)
                {
                    ApplicationArea = Basic;
                }
                field(craccount; Rec.cr_account)
                {
                    ApplicationArea = Basic;
                }
                field(TransactionType; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(NeedsChange; Rec."Needs Change")
                {
                    ApplicationArea = Basic;
                }
                field(LoanNo; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field(InterestPaid; Rec."Interest Paid")
                {
                    ApplicationArea = Basic;
                }
                field(PrincipalPaid; Rec."Principal Paid")
                {
                    ApplicationArea = Basic;
                }
                field(PostedBy; Rec."Posted By")
                {
                    ApplicationArea = Basic;
                }
                field(DatePosted; Rec."Date Posted")
                {
                    ApplicationArea = Basic;
                }
                field(phoneno; Rec.phone_no)
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                }
                field(Failed; Rec.Failed)
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

