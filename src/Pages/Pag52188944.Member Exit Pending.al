page 50646 "Member Exit Pending"
{
    ApplicationArea = All;
    Caption = 'Member Exit Pending';
    CardPageID = "Member Exit Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Member Exit";
    SourceTableView = where(Status = const(Pending));
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
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field(ClosureType; Rec."Closure Type")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                }
                field(MemberName; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field(ClosingDate; Rec."Closing Date")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(TotalPenalty; Rec."Total Penalty")
                {
                    ApplicationArea = Basic;
                }
                field(TotalAppraisal; Rec."Total Appraisal")
                {
                    ApplicationArea = Basic;
                }
                field(TotalInterest; Rec."Total Interest")
                {
                    ApplicationArea = Basic;
                }
                field(TotalPrincipal; Rec."Total Principal")
                {
                    ApplicationArea = Basic;
                }
                field(TotalLoanOutstanding; Rec."Total Loan Outstanding")
                {
                    ApplicationArea = Basic;
                }
                field(ShareCapital; Rec."Share Capital")
                {
                    ApplicationArea = Basic;
                }
                field(WithdrawableSavings; Rec."Withdrawable Savings")
                {
                    ApplicationArea = Basic;
                }
                field(NonWithdrawableSavings; Rec."Non-Withdrawable Savings")
                {
                    ApplicationArea = Basic;
                }
                field(TermSavings; Rec."Term Savings")
                {
                    ApplicationArea = Basic;
                }
                field(TotalSavings; Rec."Total Savings")
                {
                    ApplicationArea = Basic;
                }
                field(TotalRefundable; Rec."Total Refundable")
                {
                    ApplicationArea = Basic;
                }
                field(ExitCharge; Rec."Exit Charge")
                {
                    ApplicationArea = Basic;
                }
                field(DutyonExitCharge; Rec."Duty on Exit Charge")
                {
                    ApplicationArea = Basic;
                }
                field(TotalCharges; Rec."Total Charges")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                }
                field(EnteredBy; Rec."Entered By")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(TransferAccount; Rec."Transfer Account")
                {
                    ApplicationArea = Basic;
                }
                field(TransferAccountName; Rec."Transfer Account Name")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        //SetRange("Entered By", UserId);
    end;
}

