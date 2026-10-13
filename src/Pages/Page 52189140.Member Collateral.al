Page 50996 "Member Collateral"
{
    PageType = List;
    SourceTable = "Loan Collateral Register";
    CardPageID = "Collateral Card";
    Editable = false;
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
                    Caption = 'Collateral No.';
                }
                field(CollateralName; Rec."Collateral Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Collateral Name';
                }
                field(CollateralDetails; Rec."Collateral Details")
                {
                    ApplicationArea = Basic;
                    Caption = 'Collateral Details';
                }
                field(CollateralValue; Rec."Collateral Value")
                {
                    ApplicationArea = Basic;
                    Caption = 'Collateral Value';
                }
                field(CollateralLimit; Rec."Collateral Limit")
                {
                    ApplicationArea = Basic;
                    Caption = 'Collateral Limit';
                }
                field(ChargedValue; Rec."Charged Value")
                {
                    ApplicationArea = Basic;
                    Caption = 'Charged Value';
                }
                field(MemberAllocation; MemberAllocation)
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Allocation';
                }
                field(CommittedAmount; CommittedAmount)
                {
                    ApplicationArea = Basic;
                    Caption = 'Committed Amount';
                }
                field(FreeShares; FreeShares)
                {
                    ApplicationArea = Basic;
                    Caption = 'Free Shares';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CalcCollateralAvailability();
    end;

    local procedure CalcCollateralAvailability()
    var
        CollateralAllocation: Record "Collateral Allocation";
        LoanSecurity: Record "Loan Security";
        HasAllocation: Boolean;
    begin
        MemberAllocation := 0;
        CommittedAmount := 0;
        FreeShares := 0;

        if Rec."Account No." = '' then
            exit;

        CollateralAllocation.Reset();
        CollateralAllocation.SetRange("Collateral No.", Rec."No.");
        CollateralAllocation.SetRange("Member No.", Rec."Account No.");
        if CollateralAllocation.FindFirst() then begin
            MemberAllocation := CollateralAllocation."Collateral Allocation";
            HasAllocation := true;
        end;

        LoanSecurity.Reset();
        LoanSecurity.SetRange("Collateral Reg. No.", Rec."No.");
        LoanSecurity.SetRange("Member No", Rec."Account No.");
        LoanSecurity.SetRange("Guarantor Type", LoanSecurity."Guarantor Type"::Collateral);
        LoanSecurity.SetRange(Substituted, false);
        if LoanSecurity.FindSet() then
            repeat
                CommittedAmount += LoanSecurity."Current Committed";
            until LoanSecurity.Next() = 0;

        if not HasAllocation then
            MemberAllocation := Rec."Charged Value";

        FreeShares := MemberAllocation - CommittedAmount;
        if FreeShares < 0 then
            FreeShares := 0;
    end;

    var
        MemberAllocation: Decimal;
        CommittedAmount: Decimal;
        FreeShares: Decimal;
}
