
Page 50233 "Standing Order Register"
{
    ApplicationArea = Basic;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Standing Order Register.";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(DateProcessed; Rec."Date Processed")
                {
                    ApplicationArea = Basic;
                }
                field(DocumentNo; Rec."Document No.")
                {
                    ApplicationArea = Basic;
                }
                field(NoSeries; Rec."No. Series")
                {
                    ApplicationArea = Basic;
                }
                field(SourceAccountNo; Rec."Source Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(SourceAccountName; Rec."Source Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field(StaffPayrollNo; Rec."Staff/Payroll No.")
                {
                    ApplicationArea = Basic;
                }
                field(AllowPartialDeduction; Rec."Allow Partial Deduction")
                {
                    ApplicationArea = Basic;
                }
                field(DeductionStatus; Rec."Deduction Status")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(AmountDeducted; Rec."Amount Deducted")
                {
                    ApplicationArea = Basic;
                }
                field(EffectiveStartDate; Rec."Effective/Start Date")
                {
                    ApplicationArea = Basic;
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = Basic;
                }
                field(Frequency; Rec.Frequency)
                {
                    ApplicationArea = Basic;
                }
                field(EndDate; Rec."End Date")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                }
                field(EFT; Rec.EFT)
                {
                    ApplicationArea = Basic;
                }
                field(TransferedtoEFT; Rec."Transfered to EFT")
                {
                    ApplicationArea = Basic;
                }
                field(StandingOrderNo; Rec."Standing Order No.")
                {
                    ApplicationArea = Basic;
                }
                field(DestinationAccountType; Rec."Destination Account Type")
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

