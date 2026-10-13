
Page 50229 "Micro Transaction Lines"
{
    PageType = ListPart;
    SourceTable = "Micro Credit Transaction Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(AccountNumber; Rec."Account Number")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(AccountName; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(PassBookCharge; Rec."Pass Book Charge")
                {
                    ApplicationArea = Basic;
                    visible = false;
                }
                field(EntranceFeeCharge; Rec."Entrance Fee Charge")
                {
                    ApplicationArea = Basic;
                    visible = false;
                }

                field(ExpectedDeposits; Rec."Expected Deposits")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(LoanClearance; Rec."Loan Clearance")
                {
                    ApplicationArea = Basic;
                }
                field(ExpectedPenalty; Rec."Expected Penalty")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    visible = false;
                }
                field(ExpectedAppraisalFee; Rec."Expected Appraisal Fee")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    visible = false;
                }
                field(ExpectedInterest; Rec."Expected Interest")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ExpectedPrincipleAmount; Rec."Expected Principle Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Expected Principle Amount';
                    Editable = false;
                    Enabled = true;
                    Visible = true;
                }
                field("FOSA Savings"; Rec."FOSA Savings")
                {
                    ApplicationArea = Basic;
                }
                field(DepositPaid; Rec."Deposit Paid")
                {
                    ApplicationArea = Basic;
                    //Editable = false;
                }
                field(PenaltyPaid; Rec."Penalty Paid")
                {
                    ApplicationArea = Basic;
                    visible = false;
                    //Editable = false;
                }
                field(AppraisalFeePaid; Rec."Appraisal Fee Paid")
                {
                    ApplicationArea = Basic;
                    visible = false;
                    //Editable = false;
                }
                field("Loan Amount Paid"; Rec."Loan Amount Paid")
                {
                    ApplicationArea = Basic;
                    //Editable = false;
                   // visible = false;
                }
                field(PrincipleAmountPaid; Rec."Principle Amount Paid")
                {
                    ApplicationArea = Basic;
                    visible = false;
                    //Editable = false;
                }
                field(OutstandingInterest; Rec."Outstanding Interest")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(OutstandingAppraisal; Rec."Outstanding Appraisal")
                {
                    ApplicationArea = Basic;
                     visible=false;
                    Editable = false;
                }
                field(OutstandingBalance; Rec."Outstanding Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(GroupCode; Rec."Group Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

