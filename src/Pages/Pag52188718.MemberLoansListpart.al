page 50414 "Member Loans Listpart"
{
    Caption = 'Member Loans Listpart';
    PageType = ListPart;
    SourceTable = Loans;

    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTableView = where("Total Outstanding Balance" = filter(<> 0));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(LoanNo; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field(ApplicationDate; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                field("Product Name"; Rec."Loan Product Type Name")
                {
                    ApplicationArea = Basic;
                }
                field(ApprovedAmount; Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Installments; Rec.Installments)
                {
                    ApplicationArea = Basic;
                }
                field(AnnualInterest; Rec."Annual Interest %")
                {
                    ApplicationArea = Basic;
                }
                field(DisbursementDate; Rec."Disbursement Date")
                {
                    ApplicationArea = Basic;
                }
                field(CompletionDate; Rec."Completion Date")
                {
                    ApplicationArea = Basic;
                }
                field(RecoveryMode; Rec."Repay Mode")
                {
                    ApplicationArea = Basic;
                }
                field(RequestedAmount; Rec."Requested Amount")
                {
                    ApplicationArea = Basic;
                }
                field(LoanPrincipleRepayment; Rec."Loan Principle Repayment")
                {
                    ApplicationArea = Basic;
                }
                field(LoanInterestRepayment; Rec."Loan Interest Repayment")
                {
                    ApplicationArea = Basic;
                }
                field(Repayment; Rec.Repayment)
                {
                    ApplicationArea = Basic;
                }
                field(LoansCategorySASRA; Rec."Loans Category-SASRA")
                {
                    ApplicationArea = Basic;
                }
                field(LoansCategorySACCO; Rec."Loans Category-SACCO")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingPenalty; Rec."Outstanding Penalty")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingAppraisal; Rec."Outstanding Appraisal")
                {
                    ApplicationArea = Basic;
                }
                field(InterestDue; Rec."Interest Due")
                {
                    ApplicationArea = Basic;
                }
                field(InterestPaid; Rec."Interest Paid")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingInterest; Rec."Outstanding Interest")
                {
                    ApplicationArea = Basic;
                }
                field(TotalArrears; Rec."Total Arrears")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingPrincipal; Rec."Outstanding Principal")
                {
                    ApplicationArea = Basic;
                }
                field(LastPrincipalPayDate; Rec."Last Principal Pay Date")
                {
                    ApplicationArea = Basic;
                }
                field(LastPayDate; Rec."Last Pay Date")
                {
                    ApplicationArea = Basic;
                }
                field(TotalOutstandingBalance; Rec."Total Outstanding Balance")
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
        TotaBill := (Rec."Total Arrears" + Rec."Outstanding Interest") - Rec.Repayment;
        if TotaBill < 0 then
            TotaBill := 0;
        /*
        IF "Outstanding Balance" = 0 THEN
            IF "Outstanding Appraisal" = 0 THEN
                IF "Outstanding Penalty" = 0 THEN
                    IF "Outstanding Interest" = 0 THEN
        
        */

    end;

    var
        TotaBill: Decimal;
}

