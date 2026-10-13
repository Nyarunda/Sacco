Page 50543 "Sky Agent Transactions"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Sky Agents Transactions";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(TransactionID; Rec."Transaction ID")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionDate; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionTime; Rec."Transaction Time")
                {
                    ApplicationArea = Basic;
                }
                field(MemberAccount; Rec."Member Account")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field(AgentCode; Rec."Agent Code")
                {
                    ApplicationArea = Basic;
                }
                field(PaybillMemberID; Rec."Paybill Member ID")
                {
                    ApplicationArea = Basic;
                }
                field(VendorCommission; Rec."Vendor Commission")
                {
                    ApplicationArea = Basic;
                }
                field(SaccoFee; Rec."Sacco Fee")
                {
                    ApplicationArea = Basic;
                }
                field(AgentCommisionAccount; Rec."Agent Commision Account")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(NeedsChange; Rec."Needs Change")
                {
                    ApplicationArea = Basic;
                }
                field(AgentAccountNumber; Rec."Agent Account Number")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(DatePosted; Rec."Date Posted")
                {
                    ApplicationArea = Basic;
                }
                field(TimePosted; Rec."Time Posted")
                {
                    ApplicationArea = Basic;
                }
                field(PostedBy; Rec."Posted By")
                {
                    ApplicationArea = Basic;
                }
                field(OldTransactionDate; Rec."Old Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = Basic;
                }
                field(DateReversed; Rec."Date Reversed")
                {
                    ApplicationArea = Basic;
                }
                field(TimeReversed; Rec."Time Reversed")
                {
                    ApplicationArea = Basic;
                }
                field(ReversedBy; Rec."Reversed By")
                {
                    ApplicationArea = Basic;
                }
                field(ReversalID; Rec."Reversal ID")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionType; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionName; Rec."Transaction Name")
                {
                    ApplicationArea = Basic;
                }
                field(SessionID; Rec."Session ID")
                {
                    ApplicationArea = Basic;
                }
                field(LoanNo; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field(Keyword; Rec.Keyword)
                {
                    ApplicationArea = Basic;
                }
                field(MobileNo; Rec."Mobile No.")
                {
                    ApplicationArea = Basic;
                }
                field(StatementMaxRows; Rec."Statement Max Rows")
                {
                    ApplicationArea = Basic;
                }
                field(StatementStartDate; Rec."Statement Start Date")
                {
                    ApplicationArea = Basic;
                }
                field(StatementEndDate; Rec."Statement End Date")
                {
                    ApplicationArea = Basic;
                }
                field(AccounttoCheck; Rec."Account to Check")
                {
                    ApplicationArea = Basic;
                }
                field(ChangedBy; Rec."Changed By")
                {
                    ApplicationArea = Basic;
                }
                field(DateChanged; Rec."Date Changed")
                {
                    ApplicationArea = Basic;
                }
                field(DebitAccountType; Rec."Debit Account Type")
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

