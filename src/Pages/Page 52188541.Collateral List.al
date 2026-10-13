
Page 50204 "Collateral List"
{
    ApplicationArea = Basic;
    CardPageID = "Collateral Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Loan Collateral Register";
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
                field(LoanNo; LoanNo)
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan No.';
                    Editable = false;
                }
                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(AccountName; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Name"; Rec."Collateral Name")
                {
                }
                field(Collateral; Rec.Collateral)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec."Collateral Details")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Value"; Rec."Collateral Value")
                {
                    ApplicationArea = Basic;
                }
                field("Re-Opened By"; Rec."Re-Opened By")
                {
                    ApplicationArea = Basic;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                }
                field("Date Captured"; Rec."Date Captured")
                {
                    ApplicationArea = Basic;
                }
                field("Date Collected"; Rec."Date Collected")
                {
                    ApplicationArea = basic;
                    Caption = 'Date Collected/Discharged';
                }
                field("Discharged By"; Rec."Discharged By")
                {
                    ApplicationArea = Basic;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        LoanNo := GetCollateralLoanNos();
    end;

    local procedure GetCollateralLoanNos(): Text[250]
    var
        LoanSecurity: Record "Loan Security";
        LoanNos: Text[250];
    begin
        LoanSecurity.Reset();
        LoanSecurity.SetRange("Collateral Reg. No.", Rec."No.");
        LoanSecurity.SetRange("Guarantor Type", LoanSecurity."Guarantor Type"::Collateral);
        LoanSecurity.SetRange(Substituted, false);
        if LoanSecurity.FindSet() then
            repeat
                if LoanSecurity."Loan No." <> '' then
                    if LoanNos = '' then
                        LoanNos := LoanSecurity."Loan No."
                    else
                        if StrLen(LoanNos) + StrLen(LoanSecurity."Loan No.") + 2 <= MaxStrLen(LoanNos) then
                            LoanNos += ', ' + LoanSecurity."Loan No.";
            until LoanSecurity.Next() = 0;

        exit(LoanNos);
    end;

    var
        LoanNo: Text[250];
}
