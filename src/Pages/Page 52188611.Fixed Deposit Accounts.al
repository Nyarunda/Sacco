
Page 50274 "Fixed Deposit Accounts"
{
    ApplicationArea = Basic;
    CardPageID = "Fixed Deposit Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Fixed Deposit Accounts";
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
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                }
                field(FixedAccountNo; Rec."Fixed Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field("KRA PIN"; Rec."KRA PIN")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(SavingsAccountBalance; Rec."Savings Account Balance")
                {
                    ApplicationArea = Basic;
                }
                field(FixedAccountBalance; Rec."Fixed Account Balance")
                {
                    ApplicationArea = Basic;
                }
                field(FDStatus; Rec."FD Status")
                {
                    ApplicationArea = Basic;
                }
                field(FDType; Rec."FD Type")
                {
                    ApplicationArea = Basic;
                }
                field(FDDuration; Rec."FD Duration")
                {
                    ApplicationArea = Basic;
                }
                field(FDStartDate; Rec."FD Start Date")
                {
                    ApplicationArea = Basic;
                }
                field(FDMaturityDate; Rec."FD Maturity Date")
                {
                    ApplicationArea = Basic;
                }
                field(ApprovalStatus; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                }
                field(FDMaturityInstructions; Rec."FD Maturity Instructions")
                {
                    ApplicationArea = Basic;
                }
                field(FDAmount; Rec."FD Amount")
                {
                    ApplicationArea = Basic;
                }
                field(PaymentFrequency; Rec."Payment Frequency")
                {
                    ApplicationArea = Basic;
                }
                field(MonthlyInterest; Rec."Monthly Interest")
                {
                    ApplicationArea = Basic;
                }
                field(TotalExpectedInterest; Rec."Total Expected Interest")
                {
                    ApplicationArea = Basic;
                }
                field(TotalInterestEarned; Rec."Total Interest Earned")
                {
                    ApplicationArea = Basic;
                }
                field(FD; Rec.FD)
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