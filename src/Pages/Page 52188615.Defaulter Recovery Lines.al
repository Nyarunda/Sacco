
Page 50278 "Defaulter Recovery Lines"
{
    PageType = ListPart;
    SourceTable = "Defaulter Recovery Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(LoanNo; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Type Name"; Rec."Loan Type Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Outstanding Penalty"; Rec."Outstanding Penalty")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(GuarantorMemberNo; Rec."Guarantor Member No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(GuarantorSavingsAccount; Rec."Guarantor Savings Account")
                {
                    ApplicationArea = Basic;
                }
                field(GuarantorName; Rec."Guarantor Name")
                {
                    ApplicationArea = Basic;
                }
                field(WithdrawableSavings; Rec."Withdrawable Savings")
                {
                    ApplicationArea = Basic;
                }

                field("Loan Balance After Offset"; Rec."Loan Balance After Offset")
                {
                    ApplicationArea = Basic;
                }
                field("Committed Loan Balance"; Rec."Committed Loan Balance")
                {
                    ApplicationArea = Basic;
                }
                field(NonWithdrableSavings; Rec."Non-Withdrable Savings")
                {
                    ApplicationArea = Basic;
                }
                field(AmountGuaranteed; Rec."Amount Guaranteed")
                {
                    ApplicationArea = Basic;
                }
                field(LoanAllocation; Rec."Loan Allocation")
                {
                    ApplicationArea = Basic;
                }
                field(AmounttoRecover; Rec."Amount to Recover")
                {
                    ApplicationArea = Basic;
                }
                field("Recovery Method"; Rec."Recovery Method")
                {
                    ApplicationArea = All;
                    Caption = 'Recovery Method';
                    ToolTip = 'Select how this guarantor''s share will be recovered. "Default (Savings)" deducts from their deposit account. "Issue Defaulter Loan" creates a new loan. "Split" lets you specify exact amounts for each.';

                trigger OnValidate()
                begin
                    CurrPage.Update(false);
                end;
            }
            field("Amount from Savings"; Rec."Amount from Savings")
            {
                ApplicationArea = All;
                Caption = 'Amount from Savings';
                ToolTip = 'The portion to deduct directly from the guarantor''s deposit account. Only applicable when Recovery Method is "Split".';
                Visible = IsSplitMethod;
                Editable = IsSplitMethod;
            }

            field("Amount as Loan"; Rec."Amount as Loan")
            {
                ApplicationArea = All;
                Caption = 'Amount as Loan';
                ToolTip = 'The portion to convert into a new defaulter loan for the guarantor. Only applicable when Recovery Method is "Split".';
                Visible = IsSplitMethod;
                Editable = IsSplitMethod;
            }
               field(AmountRecovered; Rec."Amount Recovered")
                {
                    ApplicationArea = Basic;
                }
                field(Installement; Rec.Installement)
                {
                    ApplicationArea = Basic;
                }


            }
        }
    }


    actions
    {
    }

    var

    IsSplitMethod: Boolean;

    trigger OnAfterGetRecord()
    begin
        RefreshSplitVisibility();
    end;

    trigger OnOpenPage()
    begin
        RefreshSplitVisibility();
    end;

    local procedure RefreshSplitVisibility()
    begin
        IsSplitMethod := Rec."Recovery Method" = Rec."Recovery Method"::Split;
    end;
}
