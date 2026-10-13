namespace UnitedWomen.UnitedWomen;

page 50841 "Posted Partial Loan Disb. List"
{
    ApplicationArea = All;
    Caption = 'Posted Partial Loan Disb. List';
    PageType = List;
    SourceTable = "Partial Loans Disb. Header";
    CardPageId = "Partial Disb. Card";
    SourceTableView = where(posted = filter(true));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No field.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the value of the Document Date field.';
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ToolTip = 'Specifies the value of the Loan No. field.', Comment = '%';
                }
                field("Member No."; Rec."Member No.")
                {
                    ToolTip = 'Specifies the value of the Member No. field.', Comment = '%';
                }
                field("Member Name"; Rec."Member Name")
                {
                    ToolTip = 'Specifies the member name for this posted partial disbursement.';
                }
                field(AmountDisbursed; AmountDisbursed)
                {
                    ApplicationArea = All;
                    Caption = 'Amount Disbursed';
                    DecimalPlaces = 2 : 2;
                    ToolTip = 'Shows the amount disbursed on this posted partial disbursement.';
                }
                field(TotalLoanApplied; TotalLoanApplied)
                {
                    ApplicationArea = All;
                    Caption = 'Total Loan Applied';
                    DecimalPlaces = 2 : 2;
                    ToolTip = 'Shows the approved loan amount for this loan.';
                }
                field(TotalAmountDisbursed; TotalAmountDisbursed)
                {
                    ApplicationArea = All;
                    Caption = 'Total Amount Disbursed';
                    DecimalPlaces = 2 : 2;
                    ToolTip = 'Shows the total posted partial disbursement amount for this loan, excluding reversed partial disbursements.';
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.', Comment = '%';
                }
                field(Reversed; Rec.Reversed)
                {
                    ToolTip = 'Shows whether the related credit ledger entry for this partial disbursement has been reversed.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Captured By"; Rec."Captured By")
                {
                    ToolTip = 'Specifies the value of the Captured By field.';
                }
                field(Reason; Rec.Reason)
                {
                    ToolTip = 'Specifies the value of the Reason field.';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        UpdateDisbursementTotals();
    end;

    var
        AmountDisbursed: Decimal;
        TotalLoanApplied: Decimal;
        TotalAmountDisbursed: Decimal;

    local procedure UpdateDisbursementTotals()
    var
        CurrentPartialDisbLine: Record "Partial Loans Disb. Lines";
    begin
        Clear(AmountDisbursed);
        Clear(TotalLoanApplied);
        Clear(TotalAmountDisbursed);

        CurrentPartialDisbLine.Reset();
        CurrentPartialDisbLine.SetRange("Header No.", Rec."No.");
        CurrentPartialDisbLine.SetRange("Loan No.", Rec."Loan No.");
        if CurrentPartialDisbLine.FindSet() then
            repeat
                AmountDisbursed += CurrentPartialDisbLine."Amount to Disbuse";
                TotalAmountDisbursed += CurrentPartialDisbLine."Disbused Amount" + CurrentPartialDisbLine."Amount to Disbuse";
                if CurrentPartialDisbLine."Approved Amount" > TotalLoanApplied then
                    TotalLoanApplied := CurrentPartialDisbLine."Approved Amount";
            until CurrentPartialDisbLine.Next() = 0;
    end;
}
