
Page 50347 "Loans Statistics"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Loans;
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
                field("Loan Account"; Rec."Loan Account")
                {
                    ApplicationArea = Basic;
                }
                field(ApplicationDate; Rec."Application Date")
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
                field("Repayment Start Date"; Rec."Repayment Start Date")
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
                field("Interest Calculation Method"; Rec."Interest Calculation Method")
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
                field(OutstandingPenalty; Rec."Outstanding Penalty")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingInsurance; Rec."Outstanding Insurance")
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
                    //DrillDownPageId = "Loan Ledger Entries";
                }
                field("Principal Arrears"; Rec."Principal Arrears")
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
                    //DrillDownPageId = "Loan Ledger Entries";
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
                    //DrillDownPageId = "Loan Ledger Entries";
                }
                field("Debt Collector"; Rec."Debt Collector")
                {
                    ApplicationArea = Basic;
                    //DrillDownPageId = "Loan Ledger Entries";
                }
                field("Debt Collector Name"; Rec."Debt Collector Name")
                {
                    ApplicationArea = Basic;
                    //DrillDownPageId = "Loan Ledger Entries";
                }
            }
        }
        area(factboxes)
        {
            part(Control37; "Loans Statistics FactBox")
            {
                SubPageLink = "Loan No." = field("Loan No.");
            }
        }
    }


    actions
    {
        area(navigation)
        {
            action("UPdate Loan Account")
            {
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    Rec."Loan Account" := Rec."Loan Product Type" + '-' + Rec."Member No.";
                    Rec.Modify();
                end;
            }
            action("Update Loan")
            {
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;
                trigger OnAction()
                var
                    LRec: Record Loans;
                begin

                    LRec.Reset();
                    LRec.SetRange("Loan No.", Rec."Loan No.");
                    if LRec.FindFirst() then
                        Page.Run(Page::"Update Loan", LRec);
                end;
            }
            action("Loan Schedule Report")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Report;

                trigger OnAction()
                Var
                    LoanRec: Record Loans;
                begin

                    LoanRec.Reset;
                    LoanRec.SetRange("Loan No.", Rec."Loan No.");
                    LoanRec.SetRange("Member No.", Rec."Member No.");
                    if LoanRec.FindFirst then
                        Report.Run(Report::"Loan Repay Schedule Full Date", true, false, LoanRec);
                end;
            }
            action("Member Loan Statement")
            {
                ApplicationArea = Basic;
                Image = StyleSheet;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Loans: Record Loans;
                begin
                    Loans.Reset;
                    Loans.SetRange("Loan No.", Rec."Loan No.");
                    if Loans.FindFirst then
                        Report.Run(Report::"Loan Statement", true, false, Loans);
                end;
            }

        }

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

