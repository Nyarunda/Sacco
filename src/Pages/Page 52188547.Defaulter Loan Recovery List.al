
Page 50210 "Defaulter Loan Recovery List"
{
    ApplicationArea = Basic;
    CardPageID = "Defaulter Loan Recovery Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Defaulter Loan Recovery";
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
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(LoanNo; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field(DateEntered; Rec."Date Entered")
                {
                    ApplicationArea = Basic;
                }
                field(EnteredBy; Rec."Entered By")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingPrincipal; Rec."Outstanding Principal")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingInterest; Rec."Outstanding Interest")
                {
                    ApplicationArea = Basic;
                }
                field(MemberDeposits; Rec."Member Deposits")
                {
                    ApplicationArea = Basic;
                }
                field(NoSeries; Rec."No. Series")
                {
                    ApplicationArea = Basic;
                }
                field(Recovered; Rec.Recovered)
                {
                    ApplicationArea = Basic;
                }
                field(PostingDate; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field(RecoveryType; Rec."Recovery Type")
                {
                    ApplicationArea = Basic;
                }
                field(RecoverySource; Rec."Recovery Source")
                {
                    ApplicationArea = Basic;
                }
                field(MemberSavings; Rec."Member Savings")
                {
                    ApplicationArea = Basic;
                }
                field(SourceAccount; Rec."Source Account")
                {
                    ApplicationArea = Basic;
                }
                field(AmounttoRecover; Rec."Amount to Recover")
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
        Rec.SetRange("Entered By", UserId);
    end;
}

